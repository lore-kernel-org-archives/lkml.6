Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E060BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE96213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8fbf/Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE96213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeLETY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:24:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33596 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLETY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:24:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so9476421pgu.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BYXV+v8uiFHLUJ6Xt6MGtAMgoujWEEDwcTLx+odsbaY=;
        b=I8fbf/QtHlx1X+ETOhES3o8WeA3LXoHf8VN3wEmDrRCj8Ry3ZGtaMIOf+smqL4VQag
         bsRqi4yN17xujPgdAnOio+UYIpUAnSKN/W8+HwQ66opQnodiUVbxA1j4irWhlf/aoa8H
         LXyJ5Qt/RLxriUxknF7TB9q+IGYWRqfGw1/TyAu0e7eHoBfdfYH8gKMSKL9AVdHpt9IS
         3FsvkZeIlawLMojUX6SMrm8Na1Cw1c/vt0XcN1WOd0yRkLLn0GtACzh/N69gEaLqetWK
         TLw9EmMr8hbLWLS3dQTOC7Z5Kg9Iw8FJMDnfdNFaaRAyEzCfVu0gvhKSPR31dVGe3sYg
         CfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BYXV+v8uiFHLUJ6Xt6MGtAMgoujWEEDwcTLx+odsbaY=;
        b=T8LpVkyt6oy5kEqeW1M/iq2D5HVztPvJyQeE97RRimcX7XlKERUfmkmV9G3wFEDKaJ
         FmY9ki7BUNe/MNJ4RVxJSAth0Napo2RmXzv+TBBFHZZwzTvCHab/9ngaubY/KE/wlXKY
         eFaiZRbLw1voKw1NNmiJ8+LFrnMspP5wG2eyYbWesH3xD3qVoua5MZzKU89ne3meoU21
         nvJJv92BK3UrAbBAN3pmNLwpt44KyvyEmhiqyPoo0HwOXIqHJm26SmG+9tG4KfdvfT2q
         45wkpyX4XBlRQgTdTW3n5CbRFFrUdL5R2xlkp7dKlU6THgvmK7jC0Ip61dvinGt5MKhG
         Z+Og==
X-Gm-Message-State: AA+aEWYFmAXSOxelb3gwMrGVTaNDoV1RM37IaIC9NGj1GXuNy7oHR6TT
        W7ZGYxllO/X7pNeW+rmO+/6vpg==
X-Google-Smtp-Source: AFSGD/UKhq4hqrJywsqvqxscdXSNUegTvtFvAHsVkI2iE0LcAV0lG7l0sO4VGiFePmUSDoRYGIhDIA==
X-Received: by 2002:a63:a002:: with SMTP id r2mr21188997pge.212.1544037895725;
        Wed, 05 Dec 2018 11:24:55 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v89sm31729585pfk.12.2018.12.05.11.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:24:54 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:24:53 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 1/2 for-4.20] mm, thp: restore node-local hugepage
 allocations
In-Reply-To: <20181205073434.GT1286@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812051120550.240991@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <alpine.DEB.2.21.1812031545560.161134@chino.kir.corp.google.com> <20181204073535.GV31738@dhcp22.suse.cz> <alpine.DEB.2.21.1812041355100.157466@chino.kir.corp.google.com>
 <20181205073434.GT1286@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Michal Hocko wrote:

> > > At minimum do not remove the cleanup part which consolidates the gfp
> > > hadnling to a single place. There is no real reason to have the
> > > __GFP_THISNODE ugliness outside of alloc_hugepage_direct_gfpmask.
> > > 
> > 
> > The __GFP_THISNODE usage is still confined to 
> > alloc_hugepage_direct_gfpmask() for the thp fault path, we no longer set 
> > it in alloc_pages_vma() as done before the cleanup.
> 
> Why should be new_page any different?
> 

To match alloc_new_node_page() which does it correctly and does not change 
the behavior of mbind() that the cleanup did, which used 
alloc_hugepage_vma() to get the __GFP_THISNODE behavior.  If there is a 
reason mbind() is somehow different wrt allocating hugepages locally, I 
think that should be a separate patch, but the goal of this patch is to 
revert all the behavioral change that caused hugepages to be allocated 
remotely.
