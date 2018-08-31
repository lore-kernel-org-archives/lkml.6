Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF361C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FB920837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIoiAIfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FB920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeHaRRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:17:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeHaRRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:17:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so11136827wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5H/wnIhN29h3I7TtS7DBvm4OggXK9Nx9NYHKcAcmBM=;
        b=HIoiAIflPXJ7qpZtn91Qf70jW+3Ddkz8H/6rkkHthJsN9VVxSImSpzg9bXt/rWjYcW
         OVRNK8YS+1ezcUU17pMEnVsMxjEpmq26KCzcuYmcOzM2NZRn5E1QtPik8mM+cXUxMHjQ
         3vfj9w6OcCe4QTFn5B3mGUYY8Gwp4v4F97Tqox+huWNeNGGbLec0LSP+vmsrhNR4Lmcy
         V8CMkhLbMZozpQn/ehtmYMknemXKQ+vf3pNsvZOTc9OzwNJ8YDFipkYv5KiYfVG7vmGf
         0VTkDITdu+7q2OAyvqFrgy6HmHJHSMovHsFpvmJ6950phfk70+szRdFQw0/rdhsfgAm8
         hW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5H/wnIhN29h3I7TtS7DBvm4OggXK9Nx9NYHKcAcmBM=;
        b=YzLrkmqwcZX84eP1ztX9NhWwmOQLvqfaX4J2/A0WsiNF+ij5HcmDGxzK9603IT9VB0
         v0rRkZXgCe4/ns3EJDCvOoalRhq+6X12RqycNKtQ8DAVFNjL7CzhjymB0qPHRpVAiaa0
         95gVKgNaQ2FLQZ95tTgFcb0fCy5Wk9E1oJ8gM0Fyz6mIgpUw3/fUlIp5DrQ2h5LBGM7m
         f+6GfYOu2DrNoMR8KeKHv2SF5whpnsuYuokqcCtCmuXji1zRPTYSEYRuxlMCJmH1peqa
         sJgEs8gyyPjTWYDLsl5roOzsc/pzeqWKHFhN86r0iJvQ2vPAthsezUC/OT8L77yPF13p
         pHaw==
X-Gm-Message-State: APzg51Cbowdoasw8+Bo5kDIJikk62CTBLbU084zpCoVj4vY74nvq1vSc
        ScU9oW8d2OO6hl3yAexIrc4=
X-Google-Smtp-Source: ANB0VdaUkX1pGZLRIJ+AuHvEaaNPycFJIfVYuCS3WZBt/W6X1ySlXLkGPOJyS2p1eldlViRZhdXV9g==
X-Received: by 2002:adf:9281:: with SMTP id 1-v6mr11461933wrn.69.1535720996922;
        Fri, 31 Aug 2018 06:09:56 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id l12-v6sm12086054wrv.29.2018.08.31.06.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 06:09:56 -0700 (PDT)
Subject: Re: [PATCH] regulator: da9063: fix DT probing with constraints
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20180831123402.9494-1-p.zabel@pengutronix.de>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5f3b9c9c-27ae-cfc3-07df-04c01c313ddd@gmail.com>
Date:   Fri, 31 Aug 2018 15:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180831123402.9494-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 02:34 PM, Philipp Zabel wrote:
> Commit 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
> reordered the da9063_regulator_info[] array, but not the DA9063_ID_*
> regulator ids and not the da9063_matches[] array, because ids are used
> as indices in the array initializer. This mismatch between regulator id
> and da9063_regulator_info[] array index causes the driver probe to fail
> because constraints from DT are not applied to the correct regulator:
> 
>   da9063 0-0058: Device detected (chip-ID: 0x61, var-ID: 0x50)
>   DA9063_BMEM: Bringing 900000uV into 3300000-3300000uV
>   DA9063_LDO9: Bringing 3300000uV into 2500000-2500000uV
>   DA9063_LDO1: Bringing 900000uV into 3300000-3300000uV
>   DA9063_LDO1: failed to apply 3300000-3300000uV constraint(-22)
> 
> This patch reorders the DA9063_ID_* as apparently intended, and with
> them the entries in the da90630_matches[] array.
> 
> Fixes: 1c892e38ce59 ("regulator: da9063: Handle less LDOs on DA9063L")
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>

Thanks

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

> ---
>  include/linux/mfd/da9063/pdata.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
> index 8a125701ef7b..50bed4f89c1a 100644
> --- a/include/linux/mfd/da9063/pdata.h
> +++ b/include/linux/mfd/da9063/pdata.h
> @@ -21,7 +21,7 @@
>  /*
>   * Regulator configuration
>   */
> -/* DA9063 regulator IDs */
> +/* DA9063 and DA9063L regulator IDs */
>  enum {
>  	/* BUCKs */
>  	DA9063_ID_BCORE1,
> @@ -37,18 +37,20 @@ enum {
>  	DA9063_ID_BMEM_BIO_MERGED,
>  	/* When two BUCKs are merged, they cannot be reused separately */
>  
> -	/* LDOs */
> +	/* LDOs on both DA9063 and DA9063L */
> +	DA9063_ID_LDO3,
> +	DA9063_ID_LDO7,
> +	DA9063_ID_LDO8,
> +	DA9063_ID_LDO9,
> +	DA9063_ID_LDO11,
> +
> +	/* DA9063-only LDOs */
>  	DA9063_ID_LDO1,
>  	DA9063_ID_LDO2,
> -	DA9063_ID_LDO3,
>  	DA9063_ID_LDO4,
>  	DA9063_ID_LDO5,
>  	DA9063_ID_LDO6,
> -	DA9063_ID_LDO7,
> -	DA9063_ID_LDO8,
> -	DA9063_ID_LDO9,
>  	DA9063_ID_LDO10,
> -	DA9063_ID_LDO11,
>  };
>  
>  /* Regulators platform data */
> 


-- 
Best regards,
Marek Vasut
