Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CF9206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5YIYZTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CF9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391104AbeKVLNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:13:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42280 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbeKVLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:13:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so7788368pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ADKGYDHn6fLUM+W3Um9nZZcc/gDZN2CQmr/xArmZh2A=;
        b=i5YIYZTIybnReyjAaRthrVbSgSDEkAz5q/AzgQf962JVVBRuK1geeeiUU2WdlxkNit
         jzS5aFG2M6lZW+eVkLB9KTJBnLJoLHE7fnC3gM/gQkCtbyvhaze7gadi9p728P/TSNhr
         7zo3tkLYdrsfKWiv1ur9IpxVto0eEJtDkPHUJKxnlbiTRTbh1tX0vVlBgq2i4gK9fGpL
         TDjlXLem38WBTAs9dToQh5Kz/0mXywUyRocXRSOsxtKHblVDhwXwV8O/bOnkeDqB0rBx
         e4fvUMdyhLLZ0Pu8G4fPMllvSGS5OLR09Ienjzcg3o9nfJPYO+MRxfAj/adOwCW56G+q
         BK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ADKGYDHn6fLUM+W3Um9nZZcc/gDZN2CQmr/xArmZh2A=;
        b=Je/ehu4apGgWjRlkwgs9Fy+C4RO5o13kfL5B6tx8LKhT3YLMR84rc1OyzF2p1CIByj
         6n1RuCarQ7x9q/lTigltEfnkHddoQ2vepwHWanGLAsAKke8Cbai6/uGyYQwIE1ebc21x
         F6sG+6HydqdJx4NDFd5GKVKa9vrvZatahQmI1VEhgTNYx60tThBKUN2QaW3L/8s61ORl
         bs3vqi3Zz2brNniOEuUDJVaxYe07lhGy7W97zifwMWmfJ8ObrzR7V5eTkwZKTE0aeaQw
         oeBGbrK3bzka/Gz4SgMFrsnQyYvzQiuNU/kDC/ZvH4eoziLwE39/H57/y14tOMM3Hna7
         tcrQ==
X-Gm-Message-State: AA+aEWZUws+dNG0zHWA1xHPTaG9VGaJHdEJMIR+kyET3qAVRr4r8KKgk
        g0dMBG6ALhxw4hEBLZLSJzUljA==
X-Google-Smtp-Source: AFSGD/V9e0MKJF6rdHfhijqLbWstdbcJUq7u7/dbad0DbQk87pCZGwfILilim250xJHwZqktHGvFlA==
X-Received: by 2002:a17:902:9a91:: with SMTP id w17-v6mr8632479plp.274.1542847007755;
        Wed, 21 Nov 2018 16:36:47 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id t66sm28256192pfd.54.2018.11.21.16.36.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 16:36:46 -0800 (PST)
Date:   Wed, 21 Nov 2018 16:36:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Zhao <yuzhao@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: use swp_offset as key in shmem_replace_page()
In-Reply-To: <20181121215442.138545-1-yuzhao@google.com>
Message-ID: <alpine.LSU.2.11.1811211634040.5557@eggly.anvils>
References: <20181119010924.177177-1-yuzhao@google.com> <20181121215442.138545-1-yuzhao@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Yu Zhao wrote:

> We changed key of swap cache tree from swp_entry_t.val to
> swp_offset. Need to do so in shmem_replace_page() as well.
> 
> Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks!

> ---
>  mm/shmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d44991ea5ed4..42b70978e814 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1509,11 +1509,13 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
>  {
>  	struct page *oldpage, *newpage;
>  	struct address_space *swap_mapping;
> +	swp_entry_t entry;
>  	pgoff_t swap_index;
>  	int error;
>  
>  	oldpage = *pagep;
> -	swap_index = page_private(oldpage);
> +	entry.val = page_private(oldpage);
> +	swap_index = swp_offset(entry);
>  	swap_mapping = page_mapping(oldpage);
>  
>  	/*
> @@ -1532,7 +1534,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
>  	__SetPageLocked(newpage);
>  	__SetPageSwapBacked(newpage);
>  	SetPageUptodate(newpage);
> -	set_page_private(newpage, swap_index);
> +	set_page_private(newpage, entry.val);
>  	SetPageSwapCache(newpage);
>  
>  	/*
> -- 
> 2.19.1.1215.g8438c0b245-goog
