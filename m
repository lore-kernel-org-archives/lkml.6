Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7641CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222D320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+cd3YPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222D320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbeGXMUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41368 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbeGXMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id v22-v6so2684042lfe.8;
        Tue, 24 Jul 2018 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OL0FHnY8MX0kTOXn2ByFJgCCIR3LfOuLzloTJMZDYXU=;
        b=f+cd3YPheXkVcIilRkvioz/X2O3m7Ci/LM4b+oUW+12zQnEFcd+K+x0Ot8sMNLeoX2
         bVLTLBFTj9EK2BVvRQ5IHkFBtdcqiyNZv+nZ9qo6ciw9h2cqzkWGBWp2pWnW8xWvCePI
         sa0Ev5BKGLhRg0AlaSMjkvhwPhBtZenE5Og/SM4K6icfFa9nfqqiyZ1Jbz1rtj1WAAUi
         SRn05kbraBtO466Hh2Ly6S3PLtTypWaJz9iej+jT1ZZWByh7ixc/bDm975RfNr3QCV7P
         gwjgRfJ5qxnM2l2VXhKfNTPmCcnlu2kVDYRHsJuNgnL27t/0AhSe9WHxUixW8js32Hj5
         PMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OL0FHnY8MX0kTOXn2ByFJgCCIR3LfOuLzloTJMZDYXU=;
        b=PRgEdN+OTLw2a9KAL8goa0/tG/DDVTtOeo/38usDSU7QaL3/YavLZs4p6QjVg0aA30
         dD5aNmklte1qsXb82k1jxD9x3CbOPr0JZfhLCff7beKLwN/Wl9zzqgy/jgEzEyBYz+od
         F6m5A3d5G3LK9CttipHtF/PRusbs8pZCTH8kj4zT71aXNrp8Noe51hXXnzy0EaTIrWw4
         IeKXFoR0rrB22Z33tT+tuDqrpxFdnSfKrDPIE3CWwW5sfocS+KGTGAVTk6V3STWSFX9X
         cbmecF9ovl/vqmTis4TCpznt1SxZEv85gVep9Ea3OUvD8PvU6NdW3X6cvr5Co7dM27Q/
         U/ig==
X-Gm-Message-State: AOUpUlEV1aJMjGGs6gj+9VksBaVAf4grIUaiF6evKfTWHjYSw534U09X
        dpOXNSF1/3vwY/6sKWTwmro=
X-Google-Smtp-Source: AAOMgpe11dK7QFToq6eSIee8UwXBDLcjFwD+nfaI9WMip/h2sMPRPJylq/ADDZA9LmRhaUlz4m/0og==
X-Received: by 2002:a19:12df:: with SMTP id 92-v6mr9639324lfs.80.1532430885664;
        Tue, 24 Jul 2018 04:14:45 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id l14-v6sm2258252ljh.91.2018.07.24.04.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 04:14:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] Add support for CPCAP regulators on Tegra devices.
Date:   Tue, 24 Jul 2018 14:14:43 +0300
Message-ID: <2471666.ni9k6lzQ9Y@dimapc>
In-Reply-To: <e59e552c-fabb-0251-05b5-2361bf273232@gmail.com>
References: <20180723193848.32491-1-pgwipeout@gmail.com> <4588004.Gnq6nbUl2V@dimapc> <e59e552c-fabb-0251-05b5-2361bf273232@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 July 2018 04:57:24 MSK Peter Geis wrote:
> On 07/23/2018 08:27 PM, Dmitry Osipenko wrote:
> > On Monday, 23 July 2018 22:38:48 MSK Peter Geis wrote:
> >> Added support for the CPCAP power management regulator functions on
> >> Tegra devices.
> >> Added sw2_sw4 value tables, which provide power to the Tegra core and
> >> aux devices.
> >> Added the Tegra init tables and device tree compatibility match.
> >> 
> >> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> >> ---
> >> 
> >>   .../bindings/regulator/cpcap-regulator.txt    |  1 +
> >>   drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
> >>   2 files changed, 81 insertions(+)
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> >> b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt index
> >> 675f4437ce92..3e2d33ab1731 100644
> >> --- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> >> +++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> >> @@ -4,6 +4,7 @@ Motorola CPCAP PMIC voltage regulators
> >> 
> >>   Requires node properties:
> >>   
> >>   - "compatible" value one of:
> >>       "motorola,cpcap-regulator"
> >> 
> >> +    "motorola,tegra-cpcap-regulator"
> >> 
> >>       "motorola,mapphone-cpcap-regulator"
> >>   
> >>   Required regulator properties:
> >> diff --git a/drivers/regulator/cpcap-regulator.c
> >> b/drivers/regulator/cpcap-regulator.c index c0b1e04bd90f..cb3774be445d
> >> 100644
> >> --- a/drivers/regulator/cpcap-regulator.c
> >> +++ b/drivers/regulator/cpcap-regulator.c
> >> @@ -412,6 +412,82 @@ static struct cpcap_regulator omap4_regulators[] = {
> >> 
> >>   	{ /* sentinel */ },
> >>   
> >>   };
> >> 
> >> +static struct cpcap_regulator tegra_regulators[] = {
> >> +	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
> >> +		  0, 0, 0, 0, 0, 0),
> >> +	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
> >> +		  0xf00, 0x7f, 0, 0x800, 0, 120),
> >> +	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
> >> +		  0, 0, 0, 0, 0, 0),
> >> +	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
> >> +		  0xf00, 0x7f, 0, 0x900, 0, 100),
> >> +	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
> >> +		  0x2a, 0, 0, 0x22, 0, 0),
> >> +	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
> >> +		  0, 0, 0, 0, 0, 0),
> >> +	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
> >> +		  0x87, 0x30, 4, 0x7, 0, 420),
> >> +	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
> >> +		  0x47, 0x10, 4, 0x7, 0, 350),
> >> +	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
> >> +		  0x87, 0x30, 4, 0x3, 0, 420),
> >> +	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
> >> +		  0x87, 0x30, 4, 0x5, 0, 420),
> >> +	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
> >> +		  0x80, 0xf, 0, 0x80, 0, 420),
> >> +	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
> >> +		  0x17, 0, 0, 0x2, 0, 0),
> >> +	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
> >> +		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
> >> +		  0x87, 0x38, 3, 0x2, 0, 420),
> >> +	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
> >> +		  0x43, 0x18, 3, 0x1, 0, 420),
> >> +	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
> >> +		  0xac, 0x2, 1, 0xc, 0, 10),
> >> +	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
> >> +		  0x23, 0x8, 3, 0x3, 0, 10),
> >> +	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
> >> +		  0x23, 0x8, 3, 0x3, 0, 420),
> >> +	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
> >> +		  0x47, 0x10, 4, 0x5, 0, 420),
> >> +	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
> >> +		  0x20c, 0xc0, 6, 0x8, 0, 420),
> >> +	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
> >> +		  0xffff, vsim_val_tbl,
> >> +		  0x23, 0x8, 3, 0x3, 0, 420),
> >> +	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
> >> +		  0xffff, vsimcard_val_tbl,
> >> +		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
> >> +	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
> >> +		  0x1, 0xc, 2, 0, 0x1, 500),
> >> +	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
> >> +		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
> >> +		  0x11c, 0x40, 6, 0xc, 0, 0),
> >> +	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
> >> +		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
> >> +		  0x16, 0x1, 0, 0x4, 0, 0),
> >> +	{ /* sentinel */ },
> >> +};
> >> +
> >> 
> >>   static const struct of_device_id cpcap_regulator_id_table[] = {
> >>   
> >>   	{
> >>   	
> >>   		.compatible = "motorola,cpcap-regulator",
> >> 
> >> @@ -420,6 +496,10 @@ static const struct of_device_id
> >> cpcap_regulator_id_table[] = { .compatible =
> >> "motorola,mapphone-cpcap-regulator",
> >> 
> >>   		.data = omap4_regulators,
> >>   	
> >>   	},
> >> 
> >> +	{
> >> +		.compatible = "motorola,tegra-cpcap-regulator",
> >> +		.data = tegra_regulators,
> >> +	},
> >> 
> >>   	{},
> >>   
> >>   };
> >>   MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
> > 
> > Are those cpcap_regulator values really common for all Tegra's? Probably
> > better to name the DT compatible like "motorola,xoom-cpcap-regulator" or
> > "motorola,mz602-cpcap-regulator".
> > 
> > The DT binding documentation should be updated with the new compatible
> > value in the
> > Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> I see your point, from my research the only other device that ever
> paired a Tegra with a cpcap was the Atrix 4g, and it has completely
> different values.
> For now I will change the value to "motorola,xoom-cpcap-regulator",
> since these values are common across the entire Xoom line.
> The DT binding documentation was updated as part of this patch, it will
> be adjusted to the new value.

Now I see that you've updated the doc in this patch, thank you.


