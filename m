Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857B521939
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="r5QhxR9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbeLVRHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:07:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40960 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388818AbeLVRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:07:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so7915827otk.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K39DZ/tNuiOgoTKEhunBwHj8o6t9D0Ccp0K9bHFYS2I=;
        b=r5QhxR9NGhKbvg+vbeKXtr4hERJgX60w0vPTRquSZQjBlaueHqgEISySE9YGy+PqLL
         I1Jjg3u126vyaa2PNsXsuF1K/edTCfmJpIZZU2QidaY0jKN5G4FotyAxlznyz0bsJ4NH
         14TH+UDjWroSO2J9AnwLZVL4IzweIYc5ia+jcJs0c3HNpbbrtCFzGhBaqQgtzFaYhJ3c
         HViJYjsld+2BK2xNm25nqlZ/x2F4oGvkThJeLCAo56LgjYKuWuVHFtp0jLhMCrvG0V70
         HvwXawN8FJsoKOToH8X9oO1rv5D0LjWVKqIQyTa2F9kJHByygK3k8EIUPqcbG7zmGkJV
         /yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K39DZ/tNuiOgoTKEhunBwHj8o6t9D0Ccp0K9bHFYS2I=;
        b=Od1dM6hL3X8Va5fkqzJjMZ5wVzmFr0ia+5B/AZmQSQaMwVWDnHiKlCi/Lzy5qDS8of
         jAshXlGS7UW24gYGmP7etS2HdcPJGGgxsv/DiEWMVVO4aeac2BJYQ0pvWR4mTtYIGCcD
         RANeBs8hDJsaP1Btpk9YBsEUCUmUgyr86rAzGcv7qiINW5GaTpAIO4jNSZ4VVpgmVR56
         VfFS30ob/0Tn88v3AvkkmL6jnW9MHCoS6Lux/hdC4ZLMzCMAlTXilg55FjCviL7FUzCn
         K1EiisfDc7tXGUBXf4ww7uqlScwYBMD4EmzoLzGAWOjKiDQaPrV7wXb0EWzNoYvN5twe
         yEtQ==
X-Gm-Message-State: AJcUukdYMx31ddvyfYi9X8nYhjQQavoZLgE9snlx1W5w+3O0pNWjpmW9
        eiVzNDtG6tFJRn1+gqtynJZ8Y+tfTb1jwoZyruM=
X-Google-Smtp-Source: ALg8bN7ltVqzELgL3yHYAconL5GJ9Nwk1nwCzH6ms0XRnediWweGNySRMtZjZPlrzXEtKCDnmXhaqcUWp64Ic8lnC98=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr4931145otf.131.1545498442989;
 Sat, 22 Dec 2018 09:07:22 -0800 (PST)
MIME-Version: 1.0
References: <1545392724-6637-1-git-send-email-jianxin.pan@amlogic.com> <1545392724-6637-3-git-send-email-jianxin.pan@amlogic.com>
In-Reply-To: <1545392724-6637-3-git-send-email-jianxin.pan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Dec 2018 18:07:12 +0100
Message-ID: <CAFBinCAeDtu-KTy=4bmAtBY9hGK8rRo=OW70tgEOyRBnQcdz1g@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 2/2] mtd: rawnand: meson: add support for
 Amlogic NAND flash controller
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin, Hi Liang,

On Fri, Dec 21, 2018 at 12:45 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> From: Liang Yang <liang.yang@amlogic.com>
>
> Add initial support for the Amlogic NAND flash controller which found
> in the Meson-GXBB/GXL/AXG SoCs.
>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/mtd/nand/raw/Kconfig      |   10 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/meson_nand.c | 1468 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1479 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/meson_nand.c
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 1a55d3e..d05ff20 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -541,4 +541,14 @@ config MTD_NAND_TEGRA
>           is supported. Extra OOB bytes when using HW ECC are currently
>           not supported.
>
> +config MTD_NAND_MESON
> +       tristate "Support for NAND controller on Amlogic's Meson SoCs"
> +       depends on ARCH_MESON || COMPILE_TEST
> +       depends on COMMON_CLK_AMLOGIC
> +       select COMMON_CLK_REGMAP_MESON
I believe that "depends on COMMON_CLK_AMLOGIC" and "select
COMMON_CLK_REGMAP_MESON" are not necessary:
the driver should build fine without them because it's only
interfacing with the common clock framework.
the common clock framework is enabled by ARCH_MESON and for the
COMPILE_TEST case the common clock framework provides stub
implementations inside the headers.

> +       select MFD_SYSCON
> +       help
> +         Enables support for NAND controller on Amlogic's Meson SoCs.
> +         This controller is found on Meson GXBB, GXL, AXG SoCs.
you are explicitly mentioning GXBB here but you don't add a "GXBB" compatible.
I suggest to shorten this sentence ("This controller is found on Meson
SoCs.") because this driver can also support the 32-bit
Meson8/Meson8b/Meson8m2 SoCs with minor adjustments.


Regards
Martin
