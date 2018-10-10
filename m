Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EFC2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rE2KReM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EFC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeJKEnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:43:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46003 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeJKEnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:43:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so3234194pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yykrxpRV78qYBMeciCEpmSX4PlMFziSN3/u/DsL14co=;
        b=rE2KReM8SKUmjyZ5+iZ8QevgmS68Nu9hgs7Xfhq8ajnE5v6wX34L176CXOfWMjcad6
         2nuo2FxQAMG1ke3ZXJWW0c+79jMnN4TRWsQtD/NcDyOO78Ekj8vp7yaE2qT/iS7hrfSn
         N8f9w8JP9bVQ+lWS9dyyMb8jcTfklE2KDdoUIYGx3ssQEuBPZ+4Zwceif/hbSXdnQA7z
         Rc3zlijkY2kPVxBiSg8uyjTCSEd4DtCLd1ImUiUGe8q+7YFbopWlsKeyLCs4v5SGWhSI
         JLSt+DH5td1ycoEEPcfsjMOx/H0T3VXX3QOs2Lpogc66mETuDaMhTviFrkIo6N8hAj4f
         Z+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yykrxpRV78qYBMeciCEpmSX4PlMFziSN3/u/DsL14co=;
        b=e6DXOf9OL2HpxKvvT6sRks3WDBbtrlk4C6a2amNlo8lCK6o8dDTiviXXxjEaEhI2br
         n+9PeYTqxuHVGBOFnuLZGAr5YZzIwG/ef6shk0buDOd/irtL9DcToPswVWo7thPZWhC/
         6OZxF8l9qQi2kWcGR3uhpBrrPWF1mYCLM1iMH1hnpn70A0yTCM/O72e1dqkykEyPgRfM
         5IC4KQUwGCG0ggrKUux1wjWcFQveLO9HFCQ8G8AzEbpLUl9S7p+a9oJjKyp1V+2b4/yV
         bqUibBgf0EUIvKBWCPMdkiHZkTzpfyFrBm0qcJTMSaKAIkImTOuRLM7SOjdw/GCA8FZ+
         t6Fw==
X-Gm-Message-State: ABuFfoh6885yhTLOi4Tp7CP5dNNAjeLh3CkR3pKzQ0pe53/sLaciYU4m
        ympOblRDViQ/OKrWEGoJqz5Hiw==
X-Google-Smtp-Source: ACcGV60QU7HSKuii+89okZz3B5J5c/4uT+5OM2/bpbJgOJRXFQyIfLo83fDraQEaO7f3V0yKyBk0XQ==
X-Received: by 2002:a62:939d:: with SMTP id r29-v6mr36555578pfk.55.1539206365920;
        Wed, 10 Oct 2018 14:19:25 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b62-v6sm36621902pfa.159.2018.10.10.14.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:19:25 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:19:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181009230352.GE9307@redhat.com>
Message-ID: <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
References: <20180925120326.24392-2-mhocko@kernel.org> <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com> <20181005073854.GB6931@suse.de> <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com> <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de> <20181009122745.GN8528@dhcp22.suse.cz> <20181009130034.GD6931@suse.de> <20181009142510.GU8528@dhcp22.suse.cz> <20181009230352.GE9307@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018, Andrea Arcangeli wrote:

> I think "madvise vs mbind" is more an issue of "no-permission vs
> permission" required. And if the processes ends up swapping out all
> other process with their memory already allocated in the node, I think
> some permission is correct to be required, in which case an mbind
> looks a better fit. MPOL_PREFERRED also looks a first candidate for
> investigation as it's already not black and white and allows spillover
> and may already do the right thing in fact if set on top of
> MADV_HUGEPAGE.
> 

We would never want to thrash the local node for hugepages because there 
is no guarantee that any swapping is useful.  On COMPACT_SKIPPED due to 
low memory, we have very clear evidence that pageblocks are already 
sufficiently fragmented by unmovable pages such that compaction itself, 
even with abundant free memory, fails to free an entire pageblock due to 
the allocator's preference to fragment pageblocks of fallback migratetypes 
over returning remote free memory.

As I've stated, we do not want to reclaim pointlessly when compaction is 
unable to access the freed memory or there is no guarantee it can free an 
entire pageblock.  Doing so allows thrashing of the local node, or remote 
nodes if __GFP_THISNODE is removed, and the hugepage still cannot be 
allocated.  If this proposed mbind() that requires permissions is geared 
to me as the user, I'm afraid the details of what leads to the thrashing 
are not well understood because I certainly would never use this.
