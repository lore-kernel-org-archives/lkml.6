Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0136FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5D320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxBoom7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfAOSMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:12:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37363 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbfAOSMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:12:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so1568386pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yTa75qfTo7OsUp5FgFmU2/uhxMRAAY1x8rVQwAFMrEc=;
        b=SxBoom7pDV5nKdEGr99a7+iIziZ+7Qfq8RUWoxa+C5HL1k0yfhfXYW4VERy7PFN3Kk
         kHfT2rSWE+Z272DiE0+3SLoshdrZWXKunj3EewdmJqUaqH/sO/I/cUcaZ/D5U9wIwXvC
         vhpKakaKMjw41L4BFfCEjwI3UupId5UnQJQ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yTa75qfTo7OsUp5FgFmU2/uhxMRAAY1x8rVQwAFMrEc=;
        b=eN1xKJioAaExKwDEJsDEMtOO/i7VjjGFERH688pU1+KVqmmaSKxTDUhByQ2UaCK7iv
         eyQY9vXEUhba3Boc7UBqQpugR+R3519CH7wP7aSoVqzfQe5m1EOPdsYQ+pcwT7AG/dBV
         ceU/1qkXGBil73i+QuIHF6v2Bd7R4HkMaKehn3K8vLm/F0WFF7gizBgT0S2lSXgJbpDM
         JLlkdlEBhxLo7nhZyGT4BVgkFzRp371Zp5Zuw2/9mjprWtJrMxMGeGJ0YJ13Lf+F9IeF
         ZRfCprI+0Dne9kUd3WxpL4dJN9DM3MS9mWKhSZmg18BFrrlIJysCExNA+t3GJ+rGUbvn
         HKxQ==
X-Gm-Message-State: AJcUukeb0+CG8AIwGvZ/nu4jjx4y34i1FQpxtbgGU3Snp/6+SKm6DU1d
        ctuBKlge4L9kilXk5JR8v1ke5A==
X-Google-Smtp-Source: ALg8bN4TGvlFDA+d9ln5wr88qVXcPevoXnWNbyN8ka+zE+eDqvTsDXy4tO3r53s3gIuANde1qo08HQ==
X-Received: by 2002:a62:99dd:: with SMTP id t90mr5222845pfk.179.1547575918501;
        Tue, 15 Jan 2019 10:11:58 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y191sm6339771pfg.56.2019.01.15.10.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:11:57 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:11:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     kishon@ti.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/6] phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
Message-ID: <20190115181114.GE28907@builder>
References: <1547483802-5408-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547483802-5408-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 08:36 PST 2019, Jeffrey Hugo wrote:

> MSM8998 contains one QUSB2 PHY which is very similar to the existing
> sdm845 support.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 9177989f..e5e4f36 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -152,6 +152,32 @@ enum qusb2phy_reg_layout {
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
>  };
>  
> +static const unsigned int msm8998_regs_layout[] = {
> +	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
> +	[QUSB2PHY_PLL_STATUS]              = 0x1a0,
> +	[QUSB2PHY_PORT_TUNE1]              = 0x23c,
> +	[QUSB2PHY_PORT_TUNE2]              = 0x240,
> +	[QUSB2PHY_PORT_TUNE3]              = 0x244,
> +	[QUSB2PHY_PORT_TUNE4]              = 0x248,
> +	[QUSB2PHY_PORT_TEST1]              = 0x24c,
> +	[QUSB2PHY_PORT_TEST2]              = 0x250,
> +	[QUSB2PHY_PORT_POWERDOWN]          = 0x210,
> +	[QUSB2PHY_INTR_CTRL]               = 0x22c,
> +};
> +
> +static const struct qusb2_phy_init_tbl msm8998_init_tbl[] = {
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x13),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
> +
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xa5),
> +	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x09),
> +
> +	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
> +};
> +
> +
>  static const unsigned int sdm845_regs_layout[] = {
>  	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>  	[QUSB2PHY_PLL_STATUS]		= 0x1a0,
> @@ -221,6 +247,18 @@ struct qusb2_phy_cfg {
>  	.autoresume_en	 = BIT(3),
>  };
>  
> +static const struct qusb2_phy_cfg msm8998_phy_cfg = {
> +	.tbl            = msm8998_init_tbl,
> +	.tbl_num        = ARRAY_SIZE(msm8998_init_tbl),
> +	.regs           = msm8998_regs_layout,
> +
> +	.disable_ctrl   = POWER_DOWN,
> +	.mask_core_ready = CORE_READY_STATUS,
> +	.has_pll_override = true,
> +	.autoresume_en   = BIT(0),
> +	.update_tune1_with_efuse = true,
> +};
> +
>  static const struct qusb2_phy_cfg sdm845_phy_cfg = {
>  	.tbl		= sdm845_init_tbl,
>  	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl),
> @@ -734,6 +772,9 @@ static int qusb2_phy_exit(struct phy *phy)
>  		.compatible	= "qcom,msm8996-qusb2-phy",
>  		.data		= &msm8996_phy_cfg,
>  	}, {
> +		.compatible	= "qcom,msm8998-qusb2-phy",
> +		.data		= &msm8998_phy_cfg,
> +	}, {
>  		.compatible	= "qcom,sdm845-qusb2-phy",
>  		.data		= &sdm845_phy_cfg,
>  	},
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
