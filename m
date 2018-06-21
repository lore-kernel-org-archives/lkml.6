Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ACBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48EE208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tefjaqiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48EE208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeFUP1y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:27:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39899 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933114AbeFUP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:27:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id t2-v6so4918109lfd.6;
        Thu, 21 Jun 2018 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8dwTNHNqerDcaI9W+uVpUxbKTZ/QR7xb4AwfA/KGcjc=;
        b=Tefjaqiza4vwbUphZNVwXH7XFiM7QT+Lq55jXE/syWpid0u12UhICkeSx0SndFn/8y
         yqp5NRVSwEV8lhz0KUuWoAVWI17WQZROBHVS+fNULFwvD3SFI1OjaitPgIwYMC3tfH+N
         fTJzUW0C+2jQf9Wh+NV5+GJ7I3KwqJ7a56SXRpd59s8ekLMHOQXV3qAA7FGu3BohrzBP
         m8xFNsattH/NDcmW1pih6Uf0UfK/jOzBRqG9C0fhs8ye752Ev1jPnfqh6e4NwSP5Fu+5
         SWijswIrQu9282sqXPgohQd7cboaFnKs4UFD/h/ngvkHBmLzOZEOiH+HwGaxycuFk0K8
         Y9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8dwTNHNqerDcaI9W+uVpUxbKTZ/QR7xb4AwfA/KGcjc=;
        b=qhYDg8Ge8wpN76kPT7Eicdx9F6QxOobD6AkPjoMLP0UcClKfJ5xjf/bqc3rgkoZnaM
         OTIvxJGOLOPsRLxfuoWnsxddVZ1UlfY/s6OVfVVPVV61rLcKSBagpH2ttmRdPZE6pVof
         0qtQeEGG7B/YcCEnYyk+h5EJSzl7Q9OhO/FXNBCGc4rblbFAn4Yx0fHccMmhTsSTzGah
         QzJryYItqh9jdFIX4zCmE28SeSPTX5gtOyysR0zJhgPbev5kdp1BbCsX0FKvd6dyjen5
         kspYbJbmZpdP4nMf1Uu5R6uyIGrHjN0pHaDTuTLPKO7/QZUjO2EbZLbOVoAcVCnbWCdt
         ZdNg==
X-Gm-Message-State: APt69E2psU00KWFXfGlVJnh2ic5bAP3QRA650YZzww6YqgUopadEvcD2
        ndyPZ+MDhANoG16JAcnClyHF8zf0
X-Google-Smtp-Source: ADUXVKKsdUlXW5eAOdN9IiO1yxAL8i6tVWlRDacMpgeAkxS8DVu+urtW5J2Loq3OhCFqNbg97LRfkQ==
X-Received: by 2002:a19:6801:: with SMTP id d1-v6mr1687452lfc.138.1529594871479;
        Thu, 21 Jun 2018 08:27:51 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id n84-v6sm1007548lfi.19.2018.06.21.08.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 08:27:50 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fix copy-paste error in dspi_probe
References: <20180621132209.GA27215@embeddedor.com>
Date:   Thu, 21 Jun 2018 17:27:49 +0200
In-Reply-To: <20180621132209.GA27215@embeddedor.com> (Gustavo A. R. Silva's
        message of "Thu, 21 Jun 2018 08:22:09 -0500")
Message-ID: <878t78i2h6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> It seems that the proper structure field to use in this particular
> case is *regmap_pushr* instead of regmap.
>
> Addresses-Coverity-ID: 1470126 ("Copy-paste error")
> Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode registers")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 1f85dcd..ff7456b 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1066,7 +1066,7 @@ static int dspi_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"failed to init pushr regmap: %ld\n",
>  				PTR_ERR(dspi->regmap_pushr));
> -			ret = PTR_ERR(dspi->regmap);
> +			ret = PTR_ERR(dspi->regmap_pushr);
>  			goto out_master_put;
>  		}
>  	}

Acked-by: Esben Haabendal <eha@deif.com>

