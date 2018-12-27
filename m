Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179692148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln51Lwqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeL0C0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:26:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35575 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbeL0C03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:26:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so8202547pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZVJF33WWtZ08jZQnJ9EkbvdmFLn3TdWvwfbT+MtXAk=;
        b=ln51LwqhK7Lj6BmYqOXrOmUO9PpjZlHI0BceupfESszb43Giryq9C5iRNrLkTKDEiD
         uYm17I5dUDTAo/jSJ1LtHyNIyESaHBWByNrn1RACuUOyBliYK9V6chl1OTflc10nne8C
         j97uxMLn7C0IldsPsbg8BNs2f+/PdoGiKx75q68M0RaJ4e5MibXA8zflkx5XuGuuOT/+
         0r9vZ6JY5FkIIiNEdsw9Tx7GQ4aed8bYKd9D7jSbjijlTqIxV/dYoyqgeeLGVrXnbW6Y
         JK/tXwXAKjBY11W9nBvtO3GLJY1FDHANgNJ5qW+32UP8d4KVzqv3PQ/HIQhFacTtcXiK
         lh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZVJF33WWtZ08jZQnJ9EkbvdmFLn3TdWvwfbT+MtXAk=;
        b=fYbsRdA1IyVwlXPqfutrv/k8M0nXL4dTduizFu+ICDSvQzyR/VP6t3FUVltJQrtRcG
         uDmJo1dY71ymTpj0EtgjyJ7wxvn6ahr10H+nvC4RdizAaNm5zTNrA6mgKbVvSdlVo8j0
         QVznpdTK/VjswtEyuejlSolgIMuGtvpiWyu3GBD3493oVJMTT0nXMUecuUTMtl6QlXI4
         9hC530IKSs7oGwzgEezzxUIlJWVQwoXvs0/jYXYHz6Cr+BP8zojDaNgKHx04LrxnT+VD
         P56VFIRSnFs6Ze0c3TiAdOHtOPw+Yf5V1CnAWFJ1PXOSUbsBseNxUWowGkRQQQpaJ1a2
         /4Zg==
X-Gm-Message-State: AJcUukfqqVwNsQX4cyZTH1k36ARZaGXJptZMjMdhmeIHBJGn0e8HFZ3T
        jol/JEsPRIkzr7hY9/ZrOJg=
X-Google-Smtp-Source: ALg8bN4cm2VM7lxtuioeoAKo5AZ+V7dSsQcHMNUGNt7Fp4POKLVqdBRGmwKsEwOrnBn9OLEU4D/RBQ==
X-Received: by 2002:a63:8c2:: with SMTP id 185mr21406815pgi.26.1545877588692;
        Wed, 26 Dec 2018 18:26:28 -0800 (PST)
Received: from localhost ([110.70.51.196])
        by smtp.gmail.com with ESMTPSA id b4sm41144670pgq.65.2018.12.26.18.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 18:26:27 -0800 (PST)
Date:   Thu, 27 Dec 2018 11:26:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        joaodias@google.com, srnvs@google.com
Subject: Re: [PATCH] zram: idle writeback fixes and cleanup
Message-ID: <20181227022624.GA30091@jagdpanzerIV>
References: <20181224033529.19450-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224033529.19450-1-minchan@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/24/18 12:35), Minchan Kim wrote:
[..]
> @@ -645,10 +680,13 @@ static ssize_t writeback_store(struct device *dev,
>  		bvec.bv_len = PAGE_SIZE;
>  		bvec.bv_offset = 0;
>  
> -		if (zram->stop_writeback) {
> +		spin_lock(&zram->wb_limit_lock);
> +		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
> +			spin_unlock(&zram->wb_limit_lock);
>  			ret = -EIO;
>  			break;
>  		}
> +		spin_unlock(&zram->wb_limit_lock);
[..]
> @@ -732,11 +771,10 @@ static ssize_t writeback_store(struct device *dev,
>  		zram_set_element(zram, index, blk_idx);
>  		blk_idx = 0;
>  		atomic64_inc(&zram->stats.pages_stored);
> -		if (atomic64_add_unless(&zram->stats.bd_wb_limit,
> -					-1 << (PAGE_SHIFT - 12), 0)) {
> -			if (atomic64_read(&zram->stats.bd_wb_limit) == 0)
> -				zram->stop_writeback = true;
> -		}
> +		spin_lock(&zram->wb_limit_lock);
> +		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> +			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
> +		spin_unlock(&zram->wb_limit_lock);

Do we really need ->wb_limit_lock spinlock? We kinda punch it twice
in this loop. If someone clears ->wb_limit_enable somewhere in between
then the worst thing to happen is that we will just write extra page
to the backing device; not a very big deal to me. Am I missing
something?

	-ss
