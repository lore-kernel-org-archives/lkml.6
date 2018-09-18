Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CFAECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7343A21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZvfXCoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7343A21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeIRVZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:25:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44483 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeIRVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:25:12 -0400
Received: by mail-io1-f67.google.com with SMTP id 75-v6so1946646iou.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=loYmR8xi2ZI4YXOMV9gPrpZIADUK+hdQL3j3v5Sf3jo=;
        b=QZvfXCoYXKaYeHMXJdFGMjKg5krvxjUcGBbB5MzC8ojge1fB1UWRd+XKiALL1mzmOM
         U049GfHQ8Cj0I2FjMyBLdQAueR4eLXcdeP06UCE2SDv/54llz/e9Cw1Dw80+4hXW35/I
         wS76erwqcglLHllem8Ahm/OcsnUEdL0BDOoZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=loYmR8xi2ZI4YXOMV9gPrpZIADUK+hdQL3j3v5Sf3jo=;
        b=H8c3RnaKB8h8btVagS6UMfqIOZ6O0HOObqb+ao+lPnxp7boXeHDADjQZ4UPmGV1ccn
         BEkleLy055Wx2GZ1YY9WXm5TshIxP5dl9IJaQ+ra6aIutCggBW9ZWHkJb60/jbe3fQPJ
         nqGOPQl5dNLPSF5nvUPDdvwcrctrX8xkjnD8ebo4cc8amnVLPFMH6VaycTB0FYxm5H+k
         tbUdsgRx1ajAS+H1U7JBEQieI737oOzAN70+BCz8+eoCabbMjo7jHdrgQP+VgDLz7Xay
         Rltd3VaerqKvmJORuTe2BqJoCfGw1QOEN4DZr4whpUU1/MIDfjohUMdF77UjTTWRpHZ1
         vWUw==
X-Gm-Message-State: APzg51Amzxxta5/C6HQ8GIkc3r77oXjZ4/f7HSDMtvh1Hxc51Hu/aVsN
        bUtjMOd4rbTvUZYZ2fIrx++98ZB6fdI9cJeChBvo3Q==
X-Google-Smtp-Source: ANB0VdaXEQIMskAyYraPcK6BGH6kw7QRy6GOWxGBtj3xDl8kLaaPnt2Rdtj5FY2nY0KxX0SG7C/aBJyT2dg1usaFiVg=
X-Received: by 2002:a6b:ba86:: with SMTP id k128-v6mr24869185iof.170.1537285920786;
 Tue, 18 Sep 2018 08:52:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 08:52:00
 -0700 (PDT)
In-Reply-To: <20180916043825.23247-2-stefan@agner.ch>
References: <20180916043825.23247-1-stefan@agner.ch> <20180916043825.23247-2-stefan@agner.ch>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Sep 2018 08:52:00 -0700
Message-ID: <CAKv+Gu8xkeKb1-ce_hNCcXLrdj+qdi2DsXWPUuAiZQY1Rz+rmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: arm/crc32 - avoid warning when compiling with Clang
To:     Stefan Agner <stefan@agner.ch>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 September 2018 at 21:38, Stefan Agner <stefan@agner.ch> wrote:
> The table id (second) argument to MODULE_DEVICE_TABLE is often
> referenced otherwise. This is not the case for CPU features. This
> leads to a warning when building the kernel with Clang:
>   arch/arm/crypto/crc32-ce-glue.c:239:33: warning: variable
>     'crc32_cpu_feature' is not needed and will not be emitted
>     [-Wunneeded-internal-declaration]
>   static const struct cpu_feature crc32_cpu_feature[] = {
>                                   ^
>
> Avoid warnings by using __maybe_unused, similar to commit 1f318a8bafcf
> ("modules: mark __inittest/__exittest as __maybe_unused").
>
> Fixes: 2a9faf8b7e43 ("crypto: arm/crc32 - enable module autoloading based on CPU feature bits")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/crypto/crc32-ce-glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/crypto/crc32-ce-glue.c b/arch/arm/crypto/crc32-ce-glue.c
> index 96e62ec105d0..cd9e93b46c2d 100644
> --- a/arch/arm/crypto/crc32-ce-glue.c
> +++ b/arch/arm/crypto/crc32-ce-glue.c
> @@ -236,7 +236,7 @@ static void __exit crc32_pmull_mod_exit(void)
>                                   ARRAY_SIZE(crc32_pmull_algs));
>  }
>
> -static const struct cpu_feature crc32_cpu_feature[] = {
> +static const struct cpu_feature __maybe_unused crc32_cpu_feature[] = {
>         { cpu_feature(CRC32) }, { cpu_feature(PMULL) }, { }
>  };
>  MODULE_DEVICE_TABLE(cpu, crc32_cpu_feature);
> --
> 2.19.0
>
