Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9BB20894
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTUnzDY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9BB20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeGXDxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:53:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44430 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeGXDxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:53:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so1750963pgp.11;
        Mon, 23 Jul 2018 19:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2PQiYLdDdeRp/8QszUvPx0PPwB+0WG2v4UDK3qY/Bvk=;
        b=PTUnzDY6EvBiYjA5RIpo6Eq2MiAOGbslJclfjnj3g4RwQOIZA8DkZUuVu5h236t6lO
         DzykJllWFrCbdYZ8OliZBu/AwWEZ+QudEQwsigG2AFZ0NaLNaVBeGplTa956XsAXfgg5
         D4fvO+f1fuu5/5TZbXutvTZ0fUtafrxcgKoUEqhNqaXrWuQEWDvqWgGyXiuvk/rVkiKq
         QTArawC9QI+St3d3DqoVEVuQsKzDQqmNgS1cwatAMPtMcPJeJ/UR29EZrFPDc1iEUnw+
         CijXT1tQ/1xRknYrLoUf54AWhr/shrXQWx8gFJ94Fw58n6lGZZRbhFTLBJhPXOkCE/Dx
         xoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2PQiYLdDdeRp/8QszUvPx0PPwB+0WG2v4UDK3qY/Bvk=;
        b=g5mecDz6HgS1vyn9zH2GmtNMTfon57fXnVyEYcQu09sxrBxyoFe3BjpKa7w2kMS1XG
         eG9ZJUOrI7frp/8ZUWAVzIi1Ln3Q+qYSxTVUDSjK61aObmEvUKBaXUkFxMYB06ppacWd
         /j11AB5LnY4unKNNVhNdGHqDDBQ8S7UsCamX/G6WPQ5Gjr5OOP1DEQebkAe94NOkqFKy
         SdTXkgBKQcRLd9d1PEBGi1lfyOW8QH24atpQq8UNtTXnbc+rUtsInofVLX4Sm6YI5NLD
         rzgGOIiLvmwh8cIq2hxoviqngQx193kMsyepw4gpoo9WR27bLin/uY4jQ8fTnvge9yZJ
         EBVg==
X-Gm-Message-State: AOUpUlH4DXwbUD+nnDY9zfLs+xrb4ztiQe1cor9gSB3RUlLWQdSxmljb
        Obh17gFYUDIAGorEaOiBAbE=
X-Google-Smtp-Source: AAOMgpflcHDDCzhchoiWu55kXmUxx4UUOr5QN5ysTDyXMfgQpUE4eSWGk/3VhQKodlcrz2nQzplzyQ==
X-Received: by 2002:a65:448c:: with SMTP id l12-v6mr14052571pgq.277.1532400545229;
        Mon, 23 Jul 2018 19:49:05 -0700 (PDT)
Received: from localhost ([39.7.53.222])
        by smtp.gmail.com with ESMTPSA id w11-v6sm13350901pgm.82.2018.07.23.19.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 19:49:04 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:52:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] block: zram: Replace GFP_ATOMIC with GFP_KERNEL
Message-ID: <20180724025228.GA558@jagdpanzerIV>
References: <20180723141304.3300-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723141304.3300-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/23/18 22:13), Jia-Ju Bai wrote:
> read_from_bdev_async() and write_to_bdev() are never called in atomic
> context. They call bio_alloc() with GFP_ATOMIC, which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.

[..]

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 0f3fadd71230..b958ed0b8c35 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -450,7 +450,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>  {
>  	struct bio *bio;
>  
> -	bio = bio_alloc(GFP_ATOMIC, 1);
> +	bio = bio_alloc(GFP_KERNEL, 1);
>  	if (!bio)
>  		return -ENOMEM;
>  
> @@ -538,7 +538,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
>  	struct bio *bio;
>  	unsigned long entry;
>  
> -	bio = bio_alloc(GFP_ATOMIC, 1);
> +	bio = bio_alloc(GFP_KERNEL, 1);
>  	if (!bio)
>  		return -ENOMEM;

I think the intent here is different and is not related to atomic
contexts.

Consider the following
  OMM -> swapout -> __zram_bvec_write() -> write_to_bdev() -> bio_alloc(GFP_KERNEL) -> [OOM?]

So maybe we can do a bit better than GFP_ATOMIC (NOIO, etc.), but in general,
I believe, we can't use GFP_KERNEL [at least in write_to_bdev()].

	-ss
