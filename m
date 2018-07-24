Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EDBECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0DF20883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDD0U2Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0DF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbeGXBeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:34:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39871 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388181AbeGXBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:34:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id a134-v6so1750390lfe.6;
        Mon, 23 Jul 2018 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qprzu389haJ/OeK/rxdWxvdJppR42Ud1HODfHJ/X2zk=;
        b=aDD0U2MrtuMyFGmU3TaeOCa4yfCClqeoaLpeuxVRIEyMkHvKlKat/31TjvQdI+3TuG
         W6dzM5EMq1Mx54wjBRTT15UIJ0F2o7GdsxokbXvIZC3ZYgcfL4HScszH6AoPwpneH36o
         VawuTI7N6QjFq6qPTNa9415PL0S0W6B+TfPCK/5rXFVKGNClBJt/jV+3dY1KIwVVBEAQ
         GazgaZIToEzicofcuUxlTwQmw73ohvvoQcaQ2nngTZM9B5NSF1Uzzvl2vTAFtt7BSNt4
         lJcVC9RPfc9k7zMGenjWFYpKC5PQ3QQQk3hV2A+iwGEewFu/WHL7/WRf/oDbFihKMvYG
         KO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qprzu389haJ/OeK/rxdWxvdJppR42Ud1HODfHJ/X2zk=;
        b=joYCK96Hf4o4w+IWyINKr+gPHTttHcYQql4J/HvE1faaGlIj3V+EqaWS2xFWiFgjfx
         0YJaYMHUiuZmICU0/UxiCOLfIgoxyRPdldNGx8h4FXn6hR9Y5iO4fM6qwtJlcPwyBz5T
         ttdqAwqsqPpTYwzfbMkjKemFg8GqzgENCjVqVl4AVuAuSQPjVrNdbQN4yK+pirf8JSJo
         Zy1yGuQRbWYR+iebKwKTypk96aGUBgP/GQqqB7x6+C4ahqKB55K8v8yCZqtAe+U84pdk
         5iNzFTzY1WPwj+Rf2PX7BYkjh4atE8cOfdASEC2h+BY2VL2Ex6LVPQpjPIdFgSv5W/Dt
         JlIw==
X-Gm-Message-State: AOUpUlG9bY+rDwrUNKxGmmfqmGyYTdbHfbWiYSpcSZllwyDEfYXFBlfn
        oKAW7e1hRr1nJhCFOqUnpwv4FT/8
X-Google-Smtp-Source: AAOMgpfpD3wkSKakey2Fcv+ng7bypHBdaTGn1vbWo3HXOnpePLAAgeo9Z9VSES3la4CTa+bAGRRMTQ==
X-Received: by 2002:a19:a417:: with SMTP id q23-v6mr8339218lfc.59.1532392221216;
        Mon, 23 Jul 2018 17:30:21 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id g63-v6sm2046183lji.79.2018.07.23.17.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 17:30:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] Add support for CPCAP regulators on Tegra devices.
Date:   Tue, 24 Jul 2018 03:27:13 +0300
Message-ID: <4588004.Gnq6nbUl2V@dimapc>
In-Reply-To: <20180723193848.32491-3-pgwipeout@gmail.com>
References: <20180723193848.32491-1-pgwipeout@gmail.com> <20180723193848.32491-3-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 July 2018 22:38:48 MSK Peter Geis wrote:
> Added support for the CPCAP power management regulator functions on
> Tegra devices.
> Added sw2_sw4 value tables, which provide power to the Tegra core and
> aux devices.
> Added the Tegra init tables and device tree compatibility match.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../bindings/regulator/cpcap-regulator.txt    |  1 +
>  drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt index
> 675f4437ce92..3e2d33ab1731 100644
> --- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> @@ -4,6 +4,7 @@ Motorola CPCAP PMIC voltage regulators
>  Requires node properties:
>  - "compatible" value one of:
>      "motorola,cpcap-regulator"
> +    "motorola,tegra-cpcap-regulator"
>      "motorola,mapphone-cpcap-regulator"
> 
>  Required regulator properties:
> diff --git a/drivers/regulator/cpcap-regulator.c
> b/drivers/regulator/cpcap-regulator.c index c0b1e04bd90f..cb3774be445d
> 100644
> --- a/drivers/regulator/cpcap-regulator.c
> +++ b/drivers/regulator/cpcap-regulator.c
> @@ -412,6 +412,82 @@ static struct cpcap_regulator omap4_regulators[] = {
>  	{ /* sentinel */ },
>  };
> 
> +static struct cpcap_regulator tegra_regulators[] = {
> +	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
> +		  0, 0, 0, 0, 0, 0),
> +	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
> +		  0xf00, 0x7f, 0, 0x800, 0, 120),
> +	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
> +		  0, 0, 0, 0, 0, 0),
> +	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
> +		  0xf00, 0x7f, 0, 0x900, 0, 100),
> +	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
> +		  0x2a, 0, 0, 0x22, 0, 0),
> +	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
> +		  0, 0, 0, 0, 0, 0),
> +	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
> +		  0x87, 0x30, 4, 0x7, 0, 420),
> +	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
> +		  0x47, 0x10, 4, 0x7, 0, 350),
> +	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
> +		  0x87, 0x30, 4, 0x3, 0, 420),
> +	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
> +		  0x87, 0x30, 4, 0x5, 0, 420),
> +	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
> +		  0x80, 0xf, 0, 0x80, 0, 420),
> +	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
> +		  0x17, 0, 0, 0x2, 0, 0),
> +	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
> +		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
> +		  0x87, 0x38, 3, 0x2, 0, 420),
> +	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
> +		  0x43, 0x18, 3, 0x1, 0, 420),
> +	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
> +		  0xac, 0x2, 1, 0xc, 0, 10),
> +	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
> +		  0x23, 0x8, 3, 0x3, 0, 10),
> +	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
> +		  0x23, 0x8, 3, 0x3, 0, 420),
> +	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
> +		  0x47, 0x10, 4, 0x5, 0, 420),
> +	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
> +		  0x20c, 0xc0, 6, 0x8, 0, 420),
> +	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
> +		  0xffff, vsim_val_tbl,
> +		  0x23, 0x8, 3, 0x3, 0, 420),
> +	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
> +		  0xffff, vsimcard_val_tbl,
> +		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
> +	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
> +		  0x1, 0xc, 2, 0, 0x1, 500),
> +	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
> +		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
> +		  0x11c, 0x40, 6, 0xc, 0, 0),
> +	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
> +		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
> +		  0x16, 0x1, 0, 0x4, 0, 0),
> +	{ /* sentinel */ },
> +};
> +
>  static const struct of_device_id cpcap_regulator_id_table[] = {
>  	{
>  		.compatible = "motorola,cpcap-regulator",
> @@ -420,6 +496,10 @@ static const struct of_device_id
> cpcap_regulator_id_table[] = { .compatible =
> "motorola,mapphone-cpcap-regulator",
>  		.data = omap4_regulators,
>  	},
> +	{
> +		.compatible = "motorola,tegra-cpcap-regulator",
> +		.data = tegra_regulators,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);

Are those cpcap_regulator values really common for all Tegra's? Probably 
better to name the DT compatible like "motorola,xoom-cpcap-regulator" or 
"motorola,mz602-cpcap-regulator".

The DT binding documentation should be updated with the new compatible value 
in the Documentation/devicetree/bindings/regulator/cpcap-regulator.txt



