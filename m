Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB45F208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sySiu+Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB45F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH1Cle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:41:34 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46958 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeH1Cle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:41:34 -0400
Received: by mail-io0-f194.google.com with SMTP id y12-v6so485892ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K22r2FiBA5YJhjXLSGyzkq+Iu5yOkbBQd75+2p0U8+E=;
        b=sySiu+NvFueIbO9n/q/gSxgrDW+BuZKVtvhLHDduu2k4Kr8ZYFjP0ntw4ATfN7O3+r
         uDXxcrgZQYPDFf1gvyQrW1fSeLXKkBtVTnuEIrjxiXNPBuZEEn2hLPXz9QsBbOq3R9MS
         Q5eB9OL78rSlsNcqD+uDZfZO2zKakWJz3Cy4QkytAmNT1Mxu7PVS0o9oPw+BaDKU2AXd
         byvYKGZbjS/n5RSoTz2QKgNIdQAtKXLqdIjEU5fRfxXpeRW8743oWn8kqGX4dw/1zL05
         HjYtn0KiPmKvyvBxUFAsPUWiIaFMwMRmTl9kyq0BSs7H9UO2cwQRwV3zZ/bkZGHb/5Kb
         hH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K22r2FiBA5YJhjXLSGyzkq+Iu5yOkbBQd75+2p0U8+E=;
        b=Fw4QFTJr8jT60B/Q32qpAjuMlslZ4kdFvZDmySjHtp/noikR1ai/360BSLJZSUa6VD
         uhKpGjHVrewkMg4xsrBZs3uU92vJUiKJc+6Bt9ZVTl4twKyUCtHUoLkJclmQWS8vyE85
         /8zIA2PXQFwJYCiwUjqjPNXsjFstADHNii/5+HLNhkdCMuPsXWAX7t5W5g1Tit+upZZ6
         YeWdPffbtuaTbtlUnvfa8Ag8owKuJwMzHKCt9FpKFglZoRkv1gz64sQmw6NVQZ3lKqhC
         HBwKLiUiNFhKsmKm4t0FBGulk6+G0QkH3mYaxvE6EJEgGAzVTblsGFzbPUzCrMntnOox
         aXmg==
X-Gm-Message-State: APzg51BulCwOb760AZIckWf8vYOMlOsWGRMODveJpHI2WD/veJsHDR0d
        0tV0olp8ZgZVK8evvboV8nNkolU/7WEDk4KO3lU=
X-Google-Smtp-Source: ANB0VdaxVeP7LaeyqOXFzWSF0huu65nyb2V7vw+zZhHcSPhwNwrIb8/mI24wUR/clb3HRtLPOMqzAWj4h8SMriEqHm4=
X-Received: by 2002:a6b:e05:: with SMTP id 5-v6mr11476291ioo.141.1535410373246;
 Mon, 27 Aug 2018 15:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 27 Aug 2018 15:52:41 -0700
Message-ID: <CAHQ1cqHgQ3C3Sir69Xt9E6QjAr6L5sLzp_te6ZY0yhb-phNXTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: imx: gpc: use A_CORE instread of A7 for more
 i.MX platforms
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 11:46 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> gpcv2 driver is NOT just used on i.MX7D which has Cortex-A7
> cores, but also on i.MX8MQ/i.MX8MM platforms which use Cortex-A53
> cores, so let's use A_CORE instread of A7 to avoid confusion.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks reasonable to me:

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

> ---
>  drivers/soc/imx/gpcv2.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 6ef18cf..0e31465 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -20,14 +20,14 @@
>  #include <linux/regulator/consumer.h>
>  #include <dt-bindings/power/imx7-power.h>
>
> -#define GPC_LPCR_A7_BSC                        0x000
> +#define GPC_LPCR_A_CORE_BSC                    0x000
>
>  #define GPC_PGC_CPU_MAPPING            0x0ec
> -#define USB_HSIC_PHY_A7_DOMAIN         BIT(6)
> -#define USB_OTG2_PHY_A7_DOMAIN         BIT(5)
> -#define USB_OTG1_PHY_A7_DOMAIN         BIT(4)
> -#define PCIE_PHY_A7_DOMAIN             BIT(3)
> -#define MIPI_PHY_A7_DOMAIN             BIT(2)
> +#define USB_HSIC_PHY_A_CORE_DOMAIN             BIT(6)
> +#define USB_OTG2_PHY_A_CORE_DOMAIN             BIT(5)
> +#define USB_OTG1_PHY_A_CORE_DOMAIN             BIT(4)
> +#define PCIE_PHY_A_CORE_DOMAIN         BIT(3)
> +#define MIPI_PHY_A_CORE_DOMAIN         BIT(2)
>
>  #define GPC_PU_PGC_SW_PUP_REQ          0x0f8
>  #define GPC_PU_PGC_SW_PDN_REQ          0x104
> @@ -167,7 +167,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>                 },
>                 .bits  = {
>                         .pxx = MIPI_PHY_SW_Pxx_REQ,
> -                       .map = MIPI_PHY_A7_DOMAIN,
> +                       .map = MIPI_PHY_A_CORE_DOMAIN,
>                 },
>                 .voltage   = 1000000,
>                 .pgc       = PGC_MIPI,
> @@ -179,7 +179,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>                 },
>                 .bits  = {
>                         .pxx = PCIE_PHY_SW_Pxx_REQ,
> -                       .map = PCIE_PHY_A7_DOMAIN,
> +                       .map = PCIE_PHY_A_CORE_DOMAIN,
>                 },
>                 .voltage   = 1000000,
>                 .pgc       = PGC_PCIE,
> @@ -191,7 +191,7 @@ static const struct imx7_pgc_domain imx7_pgc_domains[] = {
>                 },
>                 .bits  = {
>                         .pxx = USB_HSIC_PHY_SW_Pxx_REQ,
> -                       .map = USB_HSIC_PHY_A7_DOMAIN,
> +                       .map = USB_HSIC_PHY_A_CORE_DOMAIN,
>                 },
>                 .voltage   = 1200000,
>                 .pgc       = PGC_USB_HSIC,
> @@ -261,7 +261,7 @@ builtin_platform_driver(imx7_pgc_domain_driver)
>  static int imx_gpcv2_probe(struct platform_device *pdev)
>  {
>         static const struct regmap_range yes_ranges[] = {
> -               regmap_reg_range(GPC_LPCR_A7_BSC,
> +               regmap_reg_range(GPC_LPCR_A_CORE_BSC,
>                                  GPC_M4_PU_PDN_FLG),
>                 regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
>                                  GPC_PGC_SR(PGC_MIPI)),
> --
> 2.7.4
>
