Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17FFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D572080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcNgZvq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D572080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbeKTIhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:37:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33886 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbeKTIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:37:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so15244454plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=x18zujgfCKPt3T5ACkYo8+FKF7H3NMDCTuUkJ/syaNs=;
        b=VcNgZvq7pV7RWUGxMq60xdZzFKYXEGZh5GSnzr5KOZbm57SP3DWhNJ8le8PAVyvIXp
         yHY4bkcTj4dVPZZgUWCpVTD8L1olJ5cuQiY7Mtgh+AnGvSmUtdTc77U2fB0AaUdRRCq1
         b8kll4LiQg7uZfSxlMv/fhb2O4aShkkk1qisgia5ikz+yvjy3JmfaoglIN9FRbLvNX5x
         3uVVvbcQhsf2Iu8Id6QGnJknSRjXaYLICROUwFZ9NP5yqCB3ppKX4Oqq75gHCPOj6iXi
         L3Kqks0bXe6fUo/cbagRSq8O5Xg3Y44ezoHudYBtw+HQGwgWqCHhBG+xokCTq8jnul8B
         s6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=x18zujgfCKPt3T5ACkYo8+FKF7H3NMDCTuUkJ/syaNs=;
        b=W0Pg7RCTppRj4Uhi1gkL9v1jq101OBslJnvNKo1Y7lquI2qSVIOcAq1yixtYYHbmVT
         eFjREJNjrq3tcrsj1xlbcy2iin4+qn04basKx5hGnKyLUvEk2uFcys4Hul0ejyNcXHs/
         HujTX34hVvDYSvlMOImRVDi610E7FrfA2gTdJnMncL0oenlFAp6q6GY06t4v3hgNrGL9
         NCMtr1dyKWuzWj8WZln+02dJ4G3+x9ZqpTt/oOJmIAa74l2mMWXLowOspglybDmFg6yw
         MM2pAcf59MoJSG+uQ0kfZ2UwsJMx5HwohvMMRjcVcEADwDflE2HOmDEGfnRQ9rjmyKhd
         rItA==
X-Gm-Message-State: AA+aEWZaCjgM5AFcv6z24r4RGWPWt1fiN3nwP7kSWxtRBouDsYvZ59aE
        fFqeya6iP803HFAerCF7RRGdpX1pZeQ=
X-Google-Smtp-Source: AFSGD/XnR2gfdShGgBhwGtHHx1nOciIZyN1xH07gfx0CEBb41tGSV4vNh6DXCDD6450kTnCtd9TY0A==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr3182911pld.147.1542665496347;
        Mon, 19 Nov 2018 14:11:36 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id y11-v6sm6444597pfk.70.2018.11.19.14.11.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 14:11:35 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:11:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Zhao <yuzhao@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix swap offset when replacing shmem page
In-Reply-To: <20181119010924.177177-1-yuzhao@google.com>
Message-ID: <alpine.LSU.2.11.1811191343280.17359@eggly.anvils>
References: <20181119004719.156411-1-yuzhao@google.com> <20181119010924.177177-1-yuzhao@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018, Yu Zhao wrote:

> We used to have a single swap address space with swp_entry_t.val
> as its radix tree index. This is not the case anymore. Now Each
> swp_type() has its own address space and should use swp_offset()
> as radix tree index.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

This fix is a great find, thank you! But completely mis-described!
And could you do a smaller patch, keeping swap_index, that can go to
stable without getting into trouble with the recent xarrifications?

Fixes: bde05d1ccd51 ("shmem: replace page if mapping excludes its zone")
Cc: stable@vger.kernel.org # 3.5+

Seems shmem_replace_page() has been wrong since the day I wrote it:
good enough to work on swap "type" 0, which is all most people ever use
(especially those few who need shmem_replace_page() at all), but broken
once there are any non-0 swp_type bits set in the higher order bits.

> ---
>  mm/shmem.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d44991ea5ed4..685faa3e0191 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1509,11 +1509,13 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
>  {
>  	struct page *oldpage, *newpage;
>  	struct address_space *swap_mapping;
> -	pgoff_t swap_index;
> +	swp_entry_t entry;

Please keep swap_index as well as adding entry.

>  	int error;
>  
> +	VM_BUG_ON(!PageSwapCache(*pagep));
> +

I'd prefer you to drop that, it has no bearing on this patch;
we used to have it, along with lots of other VM_BUG_ONs in here,
but they outlived their usefulness, and don't need reintroducing -
they didn't help at all to prevent the actual bug you've found.

>  	oldpage = *pagep;
> -	swap_index = page_private(oldpage);
> +	entry.val = page_private(oldpage);

entry.val = page_private(oldpage);
swap_index = swp_offset(entry);

>  	swap_mapping = page_mapping(oldpage);
>  
>  	/*
> @@ -1532,7 +1534,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
>  	__SetPageLocked(newpage);
>  	__SetPageSwapBacked(newpage);
>  	SetPageUptodate(newpage);
> -	set_page_private(newpage, swap_index);
> +	set_page_private(newpage, entry.val);

Yes.

>  	SetPageSwapCache(newpage);
>  
>  	/*
> @@ -1540,7 +1542,8 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
>  	 * a nice clean interface for us to replace oldpage by newpage there.
>  	 */
>  	xa_lock_irq(&swap_mapping->i_pages);
> -	error = shmem_replace_entry(swap_mapping, swap_index, oldpage, newpage);
> +	error = shmem_replace_entry(swap_mapping, swp_offset(entry),
> +				    oldpage, newpage);

I'd prefer to omit that hunk, to avoid the xa_lock_irq() in the context;
the patch is just as good if we keep the swap_index variable.

>  	if (!error) {
>  		__inc_node_page_state(newpage, NR_FILE_PAGES);
>  		__dec_node_page_state(oldpage, NR_FILE_PAGES);
> -- 
> 2.19.1.1215.g8438c0b245-goog

Thanks,
Hugh
