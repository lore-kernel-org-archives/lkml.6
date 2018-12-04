Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12324C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC91F2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xr+/4Vh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC91F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLDV4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:56:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46670 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:56:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so8945765ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=T3hfv6FpUqEoVwGjwWdOhSB9qy2IPh/BtoONAW4ywjQ=;
        b=Xr+/4Vh7vxZX9SK3thA3PPXBK2DN5KSRF0au3wH+h3OMDsKwTv/Ust14NDAlNIl8b9
         qauRcakbkUfSm/miM4s/4UfUZKlIREzWZ4Y6vggIrLz0lVyqNwB+VqM++PbbPaax5v/1
         DU+i3jvvctcMiXPG6XL28ynOELhvOnMxCAkItoYFfczdBsdnFBgmasw0r+eDG3lHUk+y
         LCnDNU7dLIK8Xw4upeIe3zLz0lTlyCCjikSpIz9yRbJnMWa5TenHy9d98q6MhNaqxiy1
         vaREUcqHG/DU/DY1kbXslf0FUvAFfvWPL/ClAV06+ih+Z5+/t/4os41dlwV362ocz3tC
         OVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=T3hfv6FpUqEoVwGjwWdOhSB9qy2IPh/BtoONAW4ywjQ=;
        b=bSyeM9cHfYhmnqUe1/INUtGyvtkxzF6aRrPXae2ddKIo12Xvt+m20zJqQn8UD3y2lG
         W8jY2I368uUOHOU7n8vF31GSOJLYxqSZ/PpIDC7+X5CjaEeBT3jPpsO/iucaqiLvzQGq
         J8vHODXan9aB7PkbkqSERUWrEBdyRzK5jcFpBIrrVcSeQBadcsBZ04NsGC8rALCihbB2
         F7ekximMAE+moCoLasz2mRvPKdNnTz8SqR4v1iJLjaOdoElSO7oAmevM3yAl7sOubjb8
         JI76xuwhmGYHVEKGQ6saOl9rNhUz/P5UIE8UKM5VpGy+NOQ14F2dn8LgSLaOkOhoDUvF
         PNpA==
X-Gm-Message-State: AA+aEWZnjt/zEVHtf96+s3zXRsej/niUCLMct7BiIIAcSWiQJEzFMG/P
        8QEhqiMVUgIV67UmD+A6UYfK1w==
X-Google-Smtp-Source: AFSGD/Wg1C6NjDVVM3czm/Bm+3759n91ArqLBMItTeiFYTSn86CG5chke+rqL4o98bwAc+yykT9NOQ==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr22115570plo.205.1543960593115;
        Tue, 04 Dec 2018 13:56:33 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p6sm22704218pfn.53.2018.12.04.13.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:56:31 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:56:30 -0800 (PST)
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
In-Reply-To: <20181204073535.GV31738@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812041355100.157466@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <alpine.DEB.2.21.1812031545560.161134@chino.kir.corp.google.com> <20181204073535.GV31738@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Michal Hocko wrote:

> > This is a full revert of ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
> > MADV_HUGEPAGE mappings") and a partial revert of 89c83fb539f9 ("mm, thp:
> > consolidate THP gfp handling into alloc_hugepage_direct_gfpmask").
> > 
> > By not setting __GFP_THISNODE, applications can allocate remote hugepages
> > when the local node is fragmented or low on memory when either the thp
> > defrag setting is "always" or the vma has been madvised with
> > MADV_HUGEPAGE.
> > 
> > Remote access to hugepages often has much higher latency than local pages
> > of the native page size.  On Haswell, ac5b2c18911f was shown to have a
> > 13.9% access regression after this commit for binaries that remap their
> > text segment to be backed by transparent hugepages.
> > 
> > The intent of ac5b2c18911f is to address an issue where a local node is
> > low on memory or fragmented such that a hugepage cannot be allocated.  In
> > every scenario where this was described as a fix, there is abundant and
> > unfragmented remote memory available to allocate from, even with a greater
> > access latency.
> > 
> > If remote memory is also low or fragmented, not setting __GFP_THISNODE was
> > also measured on Haswell to have a 40% regression in allocation latency.
> > 
> > Restore __GFP_THISNODE for thp allocations.
> > 
> > Fixes: ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings")
> > Fixes: 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask")
> 
> At minimum do not remove the cleanup part which consolidates the gfp
> hadnling to a single place. There is no real reason to have the
> __GFP_THISNODE ugliness outside of alloc_hugepage_direct_gfpmask.
> 

The __GFP_THISNODE usage is still confined to 
alloc_hugepage_direct_gfpmask() for the thp fault path, we no longer set 
it in alloc_pages_vma() as done before the cleanup.
