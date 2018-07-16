Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A168208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0wHEERE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A168208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeGPJ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:56:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36370 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbeGPJ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:56:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so73523864oie.3;
        Mon, 16 Jul 2018 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dFljKCa7Yi6TufXVKfP+wZra5lNPHm/87cPR2Oc3sZs=;
        b=O0wHEEREX4ITP7kE/g15CQjd1eylwPXxMP1ZnBqLwQo4PZDf+V5eZcX/ozs8htcBSF
         5QW63DukS9CUd0mqeS5vddZEKvo5AOG1jIfD/Y6ngHTvj2yK7IQFOFXIetBQCdaDls9I
         t7Vz7sc40S8yHkbTgnKS7r2/mwGaGwLIYEl34znLjqMLo2N1d/z+XTMNByUATcGpNHfv
         W1wTxbRIA6fQ62v3x/rRLih7nb3+ytpc2j4ow1nJImynqUN9Hen+PQzGqofoeYNAu0Pv
         FEDTagKGYjybOfesk4oR/izKbp9zBNYQwCWl47qNNGCmPBAypGqEp8+oPSedKnZIuqBY
         D7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dFljKCa7Yi6TufXVKfP+wZra5lNPHm/87cPR2Oc3sZs=;
        b=YOGuIFASjD45o9bc07XQAT+t6wWLUyr7BS6J1R2sRTu9Zjb46HS44mULSMkanLCc2h
         7ombgv9ZGOCkE64lA8EdcbFNxqAhpV+GR6D9/7IstqTzulR5dI66+f9r1nNASEF6aaRl
         h0Ah5L+3TdZdNY/jyyVJJ/GP/+T0X5vH6FPAyw6MCSyhHn2FZlg4/BEiTQ5LUFvlQEpS
         mjRV5hMt6496EDOTet5BYG4Dg9GtVj4dDG4QnN8Qf4oMSsOCnhTDSrsJJuTteBY7pCgr
         AywAfQkO521+293FYDTMMC7AGaD6HONvn+fmoJ8xsu49xFsinACwAMXA2mk6oC/XTU9T
         PLTQ==
X-Gm-Message-State: AOUpUlE6MbtWNN98dnw7aTkAY0CVDkHPUVrTKOlvDIwSFDOz2d25wz5y
        0nVdKAtAbIoA/15pbK16vx1qWwJBDFwnpuC9Z2Og
X-Google-Smtp-Source: AAOMgpeFl8RAOcUmEPEZmlLpRjY/ThVHoZEMn4YdaNkB+YUfKWMWu6fFmDFObiT/ccfdWIe129he+IYwL5m3rAysE6Y=
X-Received: by 2002:aca:d9c5:: with SMTP id q188-v6mr16029478oig.239.1531733369941;
 Mon, 16 Jul 2018 02:29:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:761e:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 02:29:29
 -0700 (PDT)
In-Reply-To: <20180713210920.3648-7-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com> <20180713210920.3648-7-wsa+renesas@sang-engineering.com>
From:   Ulrich Hecht <ulrich.hecht@gmail.com>
Date:   Mon, 16 Jul 2018 11:29:29 +0200
Message-ID: <CAO3366ySBBKpz1fpZ8orLTVF-tU+Gw3A7CiqaJWtmyGiU6kdYA@mail.gmail.com>
Subject: Re: [PATCH/RFT 6/6] i2c: recovery: remove bogus check if SDA GPIO is
 set to output
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:09 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This check did not work as intended. I2C is open drain, so this function
> will likely always have presented the GPIO as input because
> gpiod_get_direction doesn't know about open drain states. Remove this
> check for now. We can add it again once we know how to get more precise
> information about the GPIO.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 301285c54603..7c5f012f561c 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -261,9 +261,7 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
>                 bri->set_scl = set_scl_gpio_value;
>                 if (bri->sda_gpiod) {
>                         bri->get_sda = get_sda_gpio_value;
> -                       /* FIXME: add proper flag instead of '0' once available */
> -                       if (gpiod_get_direction(bri->sda_gpiod) == 0)
> -                               bri->set_sda = set_sda_gpio_value;
> +                       bri->set_sda = set_sda_gpio_value;
>                 }
>                 return;
>         }
> --
> 2.11.0
>

Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

CU
Uli
