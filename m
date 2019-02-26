Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CAC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C6221841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="j7BI8t9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBZNwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:52:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41603 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfBZNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:52:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so6247008pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 05:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lLK3BfRxB+qG/aPDalW8MkM3Flr+0berjH+y6Qs1Co4=;
        b=j7BI8t9wmBNjRxMmV65x2O7XXA+jv1wklMcOpP7+aNgJlnbw1zPeSxFQgpNtoX+ZQI
         eFiIM9jI3sNGzA5n+wH4wuWRC/q/55iO+ZiS1yyE9iPZHjuvooh5aY65vllpzR2Lhd1w
         1o+hEWiT6fXCAXIEA2kZtlt7BqYXmoB0rghGS6otU5i5zZWL0nqH+6lJkvGSlNnlM2j6
         32Lddsc15Z787TELQglsClmm9TuUA1tSuHxRQPvHqbg8eZOhkBeJJUc0Rex09C6qMTk7
         Nd+Sq9tSgm9rKrF8IXOhPCyuQbaLbyewkMjixgzPKefrg0wP0+hjAGxwzymwqHK2/Z3T
         NKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lLK3BfRxB+qG/aPDalW8MkM3Flr+0berjH+y6Qs1Co4=;
        b=ZeX6o61zotE/wDXuSRAXZSibSBfBTRj1x48MIiKx1GDh+HRHuUY9+61hLOMkZsvNwp
         sGmS4BgTjwiVGhtLOF7EMTVh4x7+VEIrd4YyZfVLSnDf+dlEgBOx9BhXDgyPSITUd7u0
         pYT/7nyiVLoNTKYwQTUbq02nSKxhuR47tY1K5GOlRFCNzEGlMTtboaf1WaHUSiWxlnmX
         vwXgwybE5WyzFCrYpVBltukvwDzsHhXR35Vt59HrsTGQqKUEP1zoQDFxJbRKk77Tiiq+
         bOkbcf2DVqpvUDQtewyEAKhpmpAedy2DJYCrr0s3xGhBVMN4BOqbI/8iZPZmG9f4GBj1
         R2EA==
X-Gm-Message-State: AHQUAuZ6l/ZdtQ65R4H6EzI2CuUv1NFTBoeHe0WTCpzO8IWU/fw+rKS0
        RSaVheN+0qmHRyFfWufxkQKdsA==
X-Google-Smtp-Source: AHgI3IZd3zVBbQWjyMgY+Z7Oz13Tb3/AGplZ85+WwAk1xAZ1FVZY2VVm5+hCThgyvG4lEVLuRwnWFQ==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr24504308pga.66.1551189120787;
        Tue, 26 Feb 2019 05:52:00 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id c18sm3626873pfo.44.2019.02.26.05.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 05:52:00 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B569930064D; Tue, 26 Feb 2019 16:51:56 +0300 (+03)
Date:   Tue, 26 Feb 2019 16:51:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        hughd@google.com, mhocko@kernel.org
Subject: Re: [PATCH] mm: hwpoison: fix thp split handing in
 soft_offline_in_use_page()
Message-ID: <20190226135156.mifspmbdyr6m3hff@kshutemo-mobl1>
References: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 07:18:00PM +0800, zhong jiang wrote:
> From: zhongjiang <zhongjiang@huawei.com>
> 
> When soft_offline_in_use_page() runs on a thp tail page after pmd is plit,

s/plit/split/

> we trigger the following VM_BUG_ON_PAGE():
> 
> Memory failure: 0x3755ff: non anonymous thp
> __get_any_page: 0x3755ff: unknown zero refcount page type 2fffff80000000
> Soft offlining pfn 0x34d805 at process virtual address 0x20fff000
> page:ffffea000d360140 count:0 mapcount:0 mapping:0000000000000000 index:0x1
> flags: 0x2fffff80000000()
> raw: 002fffff80000000 ffffea000d360108 ffffea000d360188 0000000000000000
> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> ------------[ cut here ]------------
> kernel BUG at ./include/linux/mm.h:519!
> 
> soft_offline_in_use_page() passed refcount and page lock from tail page to
> head page, which is not needed because we can pass any subpage to
> split_huge_page().

I don't see a description of what is going wrong and why change will fixed
it. From the description, it appears as it's cosmetic-only change.

Please elaborate.

-- 
 Kirill A. Shutemov
