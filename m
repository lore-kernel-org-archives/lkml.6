Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497AFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F252493D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dBuHxUGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F252493D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933730AbeFVWKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:10:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42415 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeFVWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:10:41 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so4072676pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QOpBfd6WbJYYUbUtAgySrcMekdEEwRXGbrDW4hUOvmE=;
        b=dBuHxUGGGaU+srF78Oiiv6lSlMrIQSdLWz0P13iiGqA1LXSvyVYQKhyaJPoN/YpzrT
         lN4n+g632XPb15myxENSTPqV7pmd6HYJskBk+pSxfo/dLjyMWSdv8BInz9bIkaeDRbEc
         fWtjqv3XLBsHfHSgQGzPyceZtxGnhlh6L0iGFUvJb0QbP+qK88Z6qmbBLHw+nuG3fpfM
         0zuRmz5x6njVHQJOdSpzpphGxBG+smuQE4hMNsGql6R/xQnefJrmOlRX1wfURd95h+A7
         yVTD5iG1bp3q8Ao4JzPoPvfr7LZOyvkp8LUXGCCcRq6eCg8lXTZERutyOJ+DVlz4f+gD
         XwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOpBfd6WbJYYUbUtAgySrcMekdEEwRXGbrDW4hUOvmE=;
        b=GNYL9+BP9AY+yue2SaJCT6tH8nj7i2FpuLp2bPNJQe7k53VfS+TpZPw0JQuXr4rAy5
         XJjoGvnNvmkLxLsFzRidHm4WT3x/3CRrne8lsBUkNzKoUAmUwsRdwPMtRgoJ06BWQHdM
         sneFq0QMiYeuImoPVlvSi/N+6MMNU5aKT6smCUTfclgiesj8hAR/t72htGRPqPPo4jIc
         JxETQTQh7P8VmGvjos0RxiafchtzXH+yqriXhHqyJN8PTcc5qL0W7R7laKOGu47hyT/P
         /TVYUCQtn7ZktTZWTfh5A6rG+yVJiJi/toAbtIxgnf6TNo9sr6TbaaCIUKA8CvaC6rBa
         SfQQ==
X-Gm-Message-State: APt69E3PzCWRjXxBSDlT+wNsPEETX9lcXGBLoXbA6s4abI8YjSJxm36Z
        ebrL2OxHsp2gRFfhc7/kTWtqLg==
X-Google-Smtp-Source: ADUXVKKflGWwTm2SXODp9G7ZJXaxMWWk4HVuITzgRL+Ld4rQ0/l++SGdQfrOD3QJ0YCu7PENJ/yURQ==
X-Received: by 2002:a17:902:5a09:: with SMTP id q9-v6mr3280213pli.300.1529705441114;
        Fri, 22 Jun 2018 15:10:41 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id q82-v6sm18144127pfg.170.2018.06.22.15.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 15:10:40 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id CA3F0300610; Sat, 23 Jun 2018 01:10:36 +0300 (+03)
Date:   Sat, 23 Jun 2018 01:10:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] mm: thp: register mm for khugepaged when merging vma
 for shmem
Message-ID: <20180622221036.va5vmdcnxny3fhxu@kshutemo-mobl1>
References: <1529697791-6950-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529697791-6950-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 04:03:11AM +0800, Yang Shi wrote:
> When merging anonymous page vma, if the size of vma can fit in at least
> one hugepage, the mm will be registered for khugepaged for collapsing
> THP in the future.
> 
> But, it skips shmem vma. Doing so for shmem too, but not file-private
> mapping, when merging vma in order to increase the odd to collapse
> hugepage by khugepaged.
> 
> hugepage_vma_check() sounds like a good fit to do the check. And, moved
> the definition of it before khugepaged_enter_vma_merge() to suppress
> build error.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
