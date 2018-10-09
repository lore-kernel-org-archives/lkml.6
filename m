Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B1C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C4213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="T4axNBYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09C4213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJIUVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:21:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34402 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:21:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so828048pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bqbn54rjw//b2QRHCIjUQx2Ghefp44UA3koJ2X+R9VY=;
        b=T4axNBYxVG+lL/3jodkn0emz/GyacesB+nF7GLj3VBqC3ueKWVbDq73mOiYrqI4tDl
         prQoscbt/8nwUivrdcSRbndANwNgT8dXau6ry3JrzzFRyMTd3pcY9mpd7OaC0NCmyWWH
         UolNxTKbmqiw+YNM0SaQ2IRYFRqOJRpcprWmQYMSMlVpLZiJivpPoqS6Wm5+MLGfOuYG
         pn9NVcZWLngi0NUfa2agZuKLyI4PjLR192vW2tBp+UeFyP73RqsfZz6d6ra7XWeZKm7S
         YEqwtEr5JHmcUmVihvNAEJ5WcYaJYXFdlRlp5ObnHBRiqbW/rwXluB9dF+T3P18GOQt+
         An8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqbn54rjw//b2QRHCIjUQx2Ghefp44UA3koJ2X+R9VY=;
        b=e9+Um4GPk1f5QwXwWY1ay0PuZc5nZ6CKy9nNo9QAJnDMIFPgvIb01zH35ELvf027xa
         Hr5+T3JTcZjxNa+o1YpOyZ8cvE1KCmm8TLBRne4ZkiHUecjMiJbeWH/xs1XR0+L0XUY7
         +zk5j3S1caoP2qkhZUn+T3QDbX5Ys39ttOHKmW9odSzsBK0Xj0dFXHMQzVPts7+aSJAS
         86S7CzfZiVf1E0OOQOs1le+EXz5lKXLarAPaV8LAUR1/ajeoe8NqZgTwvc2WP1f6zt8H
         LKySNoVXQQZdiBqt1UsCBnpfdCkiNSKVTRKpfUjT+3BtIoZ3lbMkEattLPZb/fZsNoC0
         u4vQ==
X-Gm-Message-State: ABuFfoj7sNO0O+pdsjQS7QZnzBk45ak53yF+0gwt2ugFZ++V8bCq4mY6
        2lGQHJVg+UmDN/yGZ3FVqJd0UA==
X-Google-Smtp-Source: ACcGV63My7fFBov6+roUAoK+C+5HDh93rFvg3K/6N7dso/VKrHZIafQvFzE9My5Wm47dEZjsyjO0qA==
X-Received: by 2002:a62:475c:: with SMTP id u89-v6mr3099557pfa.212.1539090266943;
        Tue, 09 Oct 2018 06:04:26 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id h14-v6sm23125920pfn.80.2018.10.09.06.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 06:04:25 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 2531530002C; Tue,  9 Oct 2018 16:04:21 +0300 (+03)
Date:   Tue, 9 Oct 2018 16:04:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, zi.yan@cs.rutgers.edu, will.deacon@arm.com
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
Message-ID: <20181009130421.bmus632ocurn275u@kshutemo-mobl1>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 09:28:58AM +0530, Anshuman Khandual wrote:
> A normal mapped THP page at PMD level should be correctly differentiated
> from a PMD migration entry while walking the page table. A mapped THP would
> additionally check positive for pmd_present() along with pmd_trans_huge()
> as compared to a PMD migration entry. This just adds a new conditional test
> differentiating the two while walking the page table.
> 
> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
> exclusive which makes the current conditional block work for both mapped
> and migration entries. This is not same with arm64 where pmd_trans_huge()
> returns positive for both mapped and migration entries. Could some one
> please explain why pmd_trans_huge() has to return false for migration
> entries which just install swap bits and its still a PMD ?

I guess it's just a design choice. Any reason why arm64 cannot do the
same?

> Nonetheless pmd_present() seems to be a better check to distinguish
> between mapped and (non-mapped non-present) migration entries without
> any ambiguity.

Can we instead reverse order of check:

if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
	pvmw->ptl = pmd_lock(mm, pvmw->pmd);
	if (!pmd_present(*pvmw->pmd)) {
		...
	} else if (likely(pmd_trans_huge(*pvmw->pmd))) {
		...
	} else {
		...
	}
...

This should cover both imeplementations of pmd_trans_huge().

-- 
 Kirill A. Shutemov
