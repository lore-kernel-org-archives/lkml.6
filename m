Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B93CC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A357820652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gNrBWse4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A357820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeJCEHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:07:31 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34749 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJCEHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:07:31 -0400
Received: by mail-it1-f196.google.com with SMTP id l127-v6so8124767ith.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4ap5xnw/Zoor7/nsNjcXjVJpa+iVw4/VcmHx2WK8Rw=;
        b=gNrBWse4ITlD3YOEhRzreM1LjXk4nvyEuu5GUaVL3X4LqOCkeRkNdCNoj9JWx3SNix
         JEROTj5YoMAiVrxkAzJU9wHTtlhqbbot1c+2o1x7xUDt3QybYm35Newr0fz7VnkLlFCJ
         fMgdbJcdOdwMq4dEtvNevSSYcvp8P8YVwSAjuzkNjCPvd6um3gDpp1lNipjzUF+8Yeol
         89crzldtCjfQ2s+LfJdxAgqxqlF1jOWUd8jnDibSOOdKeRXdw6h4AT37y1bhaeSavMUr
         2YXjBSKuNe00ZwOULGa1GY4iOZ277FRgk7YriZlJaeyHUCxBxwfYROAIHpiJIfO2jWi2
         UJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4ap5xnw/Zoor7/nsNjcXjVJpa+iVw4/VcmHx2WK8Rw=;
        b=QitTJc3LzMsGS1W6aKF4r3R6ByfZytFOxJ6V+aXx65sPDjzS2MTas1MU6erJG7CkAd
         isvsc9zF7a1H/HKpLx452lTgp8RuERNP4mmcW9mdbuFBedpqHEnkg2MXZy4kt4JVfVLK
         4zJp0MtAcaYnCgBgUG7+gdzfBV2C6MYjQTro/iA77nRhTnN4T7nRVjiKPr76xyZVmCoG
         ar0klSFtO4CX1Mi4EC16JnqfYN6+g9yAqVXL3I8jngROHOkn62sR28zAEJojXXkQCO7T
         m7dzvm6/MEzIIriBtXSyESvB4M7P58TV8O/KCIzI46UtD950IHo7T4Uf3g9ph0ELdcrd
         UO0A==
X-Gm-Message-State: ABuFfohCtAScNSqQzmmfS3WVFqW8CsRaOOBJHjLnQAbrXTAFZ2z51hS/
        au27wDO8QFKcWYf5+8YPxPutX1Pj8ixkKUPFFRq0nd1w
X-Google-Smtp-Source: ACcGV61shk2BrbblKbFxHiSjrYxC9c2NwW2Qekb7iGaUG4h9mNR5BetJgWZge4k6lKYj7IgnU/QAQsJDJTLEO1Hcktc=
X-Received: by 2002:a02:9b46:: with SMTP id g6-v6mr13780832jal.136.1538515331027;
 Tue, 02 Oct 2018 14:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181002211016.2638186-1-arnd@arndb.de>
In-Reply-To: <20181002211016.2638186-1-arnd@arndb.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Oct 2018 23:22:00 +0200
Message-ID: <CAMRc=MfOMp5qpZLBBLKHTrziBBV2kD1ZMv7OD4E3M85G=G++bQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: lpc18xx_eeprom: remove an unused variable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        rdunlap@infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 pa=C5=BA 2018 o 23:10 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> drivers/nvmem/lpc18xx_eeprom.c: In function 'lpc18xx_eeprom_remove':
> drivers/nvmem/lpc18xx_eeprom.c:258:6: error: unused variable 'ret' [-Werr=
or=3Dunused-variable]
>
> Fixes: 226014d13fa5 ("nvmem: lpc18xx_eeprom: use devm_nvmem_register()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/nvmem/lpc18xx_eeprom.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eepro=
m.c
> index b42dbaddb419..66cff1e2147a 100644
> --- a/drivers/nvmem/lpc18xx_eeprom.c
> +++ b/drivers/nvmem/lpc18xx_eeprom.c
> @@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_devic=
e *pdev)
>  static int lpc18xx_eeprom_remove(struct platform_device *pdev)
>  {
>         struct lpc18xx_eeprom_dev *eeprom =3D platform_get_drvdata(pdev);
> -       int ret;
>
>         clk_disable_unprepare(eeprom->clk);
>
> --
> 2.18.0
>

Hi Arnd,

I had already sent a fix for that with you in Cc:
https://lkml.org/lkml/2018/10/2/439

Best regards,
Bartosz
