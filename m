Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB2C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE51208A4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1Ghqk+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE51208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeGGPZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:25:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43951 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbeGGPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:25:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so10672052pfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xoLWt/Jl0TufGXINCr+Bvp/s18sxDEbZ3bBIN6IoBU=;
        b=e1Ghqk+yd3agrABCrismcjwh+Vk42aw+HPMT00qFFEdUhIauQhfLba+ZvV4S2Fs+n5
         LHjzjhbM2uHVoZMR1RagNH3sKs5efnS99tAievoQ3XLwQv/pKbmE1+CNAdNKsSBitRcD
         r7kA5grVkaz6xJDpYqXkSbXqNKTcjVjemZVbX+f7xloupnnHsk+VQa5etNPwFrtwQ84J
         i4ozQGKPHICpyaXRAKY33+hnRGtczTICppF2nBU8THauTBrX+tM9PzsHM77IyAp1fLt8
         97PQSrTi+C3lcbnbAiqNv9igryysRW7da397sguxjaPdX001yP+wmnxqqWMnrTUdMeeC
         i9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xoLWt/Jl0TufGXINCr+Bvp/s18sxDEbZ3bBIN6IoBU=;
        b=pcN4qItDOl2RLQB2Wn2+gEM2kiTUXnH/hcfbVAuHYYwWK5eiHKFbenHicwWj6PMvkE
         jhIJ9MnO/The0nCZfDVQQtCl7N9pds9qT/THmp7BSKK/JwpiRgvHW3rMhp+8dAaNzPfQ
         PEPyzO8mTXBlO/Zen+ahGxvrZDVebKO1NRa+4O6bucDhJcyyG+3Dfk4bshK2Zhc9/GGd
         Udzlm+TG5ngKMA1jgrmJpJPUMHxytfm9BYGmA45NH61GtxnSfiieAyVnM0a+cPSJFixD
         SJxDcMQvNQoZQBzfv5UDssa7rq+hwDOyvtJ9zfdVTn9dkbw4HK5CKOvrlQoQTun5qBh1
         SV4w==
X-Gm-Message-State: APt69E17VvkRL5oanof37gCxUNZIjspkj2x2ioRuVeKpbMcY+qZ32TCw
        4fK+OYSOS0NmhDZVM/8z0jbdtg==
X-Google-Smtp-Source: AAOMgpdN0HkV+zUxxoeCwBQKWgTEEm9vceDw63qvnSXs0BvGnoEbBGN5tHak7XZgoO1krjucwl7olA==
X-Received: by 2002:a62:a6db:: with SMTP id r88-v6mr14675041pfl.60.1530977145662;
        Sat, 07 Jul 2018 08:25:45 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (ppp121-45-208-163.bras1.cbr2.internode.on.net. [121.45.208.163])
        by smtp.gmail.com with ESMTPSA id d65-v6sm22016789pfj.20.2018.07.07.08.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 08:25:44 -0700 (PDT)
Date:   Sun, 8 Jul 2018 01:25:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel-team <kernel-team@fb.com>
Subject: Re: mm,tlb: revert 4647706ebeee?
Message-ID: <20180708012538.51b2c672@roar.ozlabs.ibm.com>
In-Reply-To: <1530896635.5350.25.camel@surriel.com>
References: <1530896635.5350.25.camel@surriel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018 13:03:55 -0400
Rik van Riel <riel@surriel.com> wrote:

> Hello,
> 
> It looks like last summer, there were 2 sets of patches
> in flight to fix the issue of simultaneous mprotect/madvise
> calls unmapping PTEs, and some pages not being flushed from
> the TLB before returning to userspace.
> 
> Minchan posted these patches:
> 56236a59556c ("mm: refactor TLB gathering API")
> 99baac21e458 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")
> 
> Around the same time, Mel posted:
> 4647706ebeee ("mm: always flush VMA ranges affected by zap_page_range")
> 
> They both appear to solve the same bug.
> 
> Only one of the two solutions is needed.
> 
> However, 4647706ebeee appears to introduce extra TLB
> flushes - one per VMA, instead of one over the entire
> range unmapped, and also extra flushes when there are
> no simultaneous unmappers of the same mm.
> 
> For that reason, it seems like we should revert
> 4647706ebeee and keep only Minchan's solution in
> the kernel.
> 
> Am I overlooking any reason why we should not revert
> 4647706ebeee?

Yes I think so. Discussed here recently:

https://marc.info/?l=linux-mm&m=152878780528037&w=2

Actually we realized that powerpc does not implement the mmu
gather flushing quite right so it needs a fix before this
revert. But I propose the revert for next merge window.

Thanks,
Nick
