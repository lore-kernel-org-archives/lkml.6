Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E195C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5CB2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP8eM7+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5CB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeK2Prk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:47:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38468 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeK2Prj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:47:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so396248pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 20:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vpFpi2C1xQcO1wuISdOwgPeCbQoVQRzfglbiW4d+cyU=;
        b=VP8eM7+XR/dwJT4tZdUhdJl5ImapR9u9ZPAZX3KZm9EnHJ+7mFhUQDZn/9kMJmu1/t
         HRa9cIRDuxluH3bzx5szoF/tC82dvc9kCzfSJZjsRQRr++qnXZYwyUoYg8hUgR0Pq8Ld
         Pnxw542xxqaY9l8ag077ubsuOyKY7+ZBpDhEfw9ekAVr8SHK/XctZkqFkeh4b1arpmmT
         BEyC8BDfWXCpnaN1ehGevaSyJzlP1+60sYZsK2MdmsNHSFyXV9eIT1JhUJkiwpBBDjAu
         o9leiYBhsEvrEqvrfou4DM9HZwCY9THMfjYlTMCGM6RnHb0EdxyX63zn8HKb7CdsaEGA
         dqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vpFpi2C1xQcO1wuISdOwgPeCbQoVQRzfglbiW4d+cyU=;
        b=uO4uKvpfUu47BVFHMQcpubhuAYGE2YYU6Xc+yoCSnUSuHflUob4HlLukDAlQ6VHb6l
         GSdx4ZHP/tT0jMTUMT61X5vtKRXgKnN4ya5iICnrduc4TSPJgP/2fyXi3iMNeylqYJo6
         MMg/snoSIMDDufiw8R/rgt/rdZhz6yBbTUL742ERxtfp/rcIzvjGS7BBfg6zeK/H0DZU
         tjxSK4PQb9UgUG1+9o8W7TxU9TdbpXxOy98c9DrBtq6ywtjnLOpbs9+ipgcV2+0v+dKN
         YIYf2+KieRlZ7dE0KBkI13DiK694i49tR//WLZqKBuLo61xUWwQACqdFjYsd8NcJ4Ekl
         wMJA==
X-Gm-Message-State: AA+aEWZDe9RDzwkAvaZ3dUxsQfUQ4cGAKy5+8kXmFwuyeNvwYUYhrHEB
        /3XYp+0xT//ol0885O9MvPE=
X-Google-Smtp-Source: AFSGD/WP5JU0hk95JjqrqByzS7JZsRs96fTiLeMSNjZzqGTu4Vm2TNIUVsVrwIdgsYCNRl/F+AoTdQ==
X-Received: by 2002:a62:824c:: with SMTP id w73mr30353pfd.150.1543466618233;
        Wed, 28 Nov 2018 20:43:38 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id n23-v6sm1081941pfg.84.2018.11.28.20.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 20:43:37 -0800 (PST)
Date:   Thu, 29 Nov 2018 13:43:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/7] lib/lzo: separate lzo-rle from lzo
Message-ID: <20181129044333.GH6379@jagdpanzerIV>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
 <20181127161913.23863-8-dave.rodgman@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127161913.23863-8-dave.rodgman@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 16:19), Dave Rodgman wrote:
>  Documentation/lzo.txt         |  12 ++-
>  crypto/Makefile               |   2 +-
>  crypto/lzo-rle.c              | 175 ++++++++++++++++++++++++++++++++++++++++++
>  crypto/tcrypt.c               |   4 +-
>  drivers/block/zram/zcomp.c    |   1 +
>  drivers/block/zram/zram_drv.c |   2 +-
>  include/linux/lzo.h           |   4 +
>  lib/lzo/lzo1x_compress.c      |  42 +++++++---
>  lib/lzo/lzodefs.h             |   3 +-
>  9 files changed, 227 insertions(+), 18 deletions(-)
>  create mode 100644 crypto/lzo-rle.c

[..]

> +static struct crypto_alg alg = {
> +	.cra_name		= "lzo-rle",
> +	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
> +	.cra_ctxsize		= sizeof(struct lzorle_ctx),
> +	.cra_module		= THIS_MODULE,
> +	.cra_init		= lzorle_init,
> +	.cra_exit		= lzorle_exit,
> +	.cra_u			= { .compress = {
> +	.coa_compress		= lzorle_compress,
> +	.coa_decompress		= lzorle_decompress } }
> +};

A nitpick:
  indentation for .compress assignment is a bit confusing, maybe.


[..]
> +++ b/drivers/block/zram/zcomp.c
> @@ -20,6 +20,7 @@
>  
>  static const char * const backends[] = {
>  	"lzo",
> +	"lzo-rle",
>  #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
>  	"lz4",
>  #endif

[..]

> +++ b/drivers/block/zram/zram_drv.c
> @@ -41,7 +41,7 @@ static DEFINE_IDR(zram_index_idr);
>  static DEFINE_MUTEX(zram_index_mutex);
>  
>  static int zram_major;
> -static const char *default_compressor = "lzo";
> +static const char *default_compressor = "lzo-rle";

OK, so it's not just "separate lzo-rle", it's also "switch zram to
a new compression algorithm by default". I'd say that usually I'd
expect this to be separate patches.

	-ss
