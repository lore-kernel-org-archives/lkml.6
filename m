Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AAAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A112120989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545240595;
	bh=ORf/96WIcD53eV26FlBOV3ScZqeM1coLDDhBwArsRik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJZ8vRr+Xs1TINEUx4YkjmsBxL/YYEaQZFIpfb4Jl2CJksEdhepe5g5TAgw1pypv5
	 C1tUqD/nqd73XkC6p5X7xsDFB7usPnOyurEchUcG/IixDf2YtH1uTxcKN52afLpGTm
	 eoq0HAl1jdnuV3oa/TkWypuNusbSB7jA9JS4dvAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeLSR3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:29:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38185 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbeLSR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:29:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id a77so2254494oii.5;
        Wed, 19 Dec 2018 09:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T0DVSq/1hvO/ebMwFX3HnvvUWzoOCaU5z2Zk7sXIwOM=;
        b=mUwIK/Lf+JgumRu6sLBHhyo3aQmxs2P8YcYUXj/UsX018E+cuE2OMhKbDeLPKGr6Y6
         8GF2e1UNb6nyEK5XRy96CeFZO8RxKVbDXck9rFQW+OcUspp15apYUez1iiCcgefuDtED
         8fqUxv+yVWgwO81dg8v8g6d4b88y/UnY4aP+0MSYaBB6NeTLkdf0HKzJNDqos7WpfgX+
         4RdvKCDpXxK5cYinacQ+qySwtxH3lu5G3PuaJLIdEQD9nacHR5o6/VlU0g78OHaMLFgy
         7vkTkU1Rr+Mvmj0QszniF2l3ae+udw0/pOoydKKGjmTk86h7LMhWvTg90ywzKmghJKTn
         zhbw==
X-Gm-Message-State: AA+aEWbwStarMM3qyL5GYNsv00lA8QfjfE5Cs899b9UtSlRUch8YBUjr
        kAsvTiuImJdUXzjZwhkJnw==
X-Google-Smtp-Source: AFSGD/WlKy4reQukSCKNHYDgTGIKBFk+nhKqBnuumq04wCLrycFK2bsBgG+xrOzhX+2DnXJRwO5Kig==
X-Received: by 2002:aca:58d7:: with SMTP id m206mr1703563oib.140.1545240590805;
        Wed, 19 Dec 2018 09:29:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 30sm9325529ots.52.2018.12.19.09.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:29:50 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:29:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] ARM: mxs: =?iso-8859-1?Q?c?=
 =?iso-8859-1?Q?fa10036=3A_Fixup_OLED=A0display?= reset polarity
Message-ID: <20181219172949.GA7680@bogus>
References: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
 <1543935806-94880-5-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543935806-94880-5-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:03:40PM +0000, Vokáč Michal wrote:
> There was a bug in reset signal generation in ssd1307fb OLED driver.
> The display needs an active-low reset signal but the driver produced
> the correct sequence only if the GPIO used for reset was specified as
> GPIO_ACTIVE_HIGH.
> 
> Now as the OLED driver is fixed it is also necessarry to implement
> a fixup for all current users of the old DT ABI. There is only one
> in-tree user and that is the Crystalfontz CFA-10036 board. In case
> this board is booting and GPIO_ACTIVE_HIGH is used for reset we
> override it to GPIO_ACTIVE_LOW.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  arch/arm/mach-mxs/mach-mxs.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 1c6062d..23c260c 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -21,6 +21,7 @@
>  #include <linux/reboot.h>
>  #include <linux/micrel_phy.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -268,9 +269,53 @@ static void __init apx4devkit_init(void)
>  					   apx4devkit_phy_fixup);
>  }
>  
> +#define OLED_RESET_GPIO_LEN	3
> +#define OLED_RESET_GPIO_SIZE	(OLED_RESET_GPIO_LEN * sizeof(u32))
> +
> +static void __init crystalfontz_oled_reset_fixup(void)
> +{
> +	struct property *newgpio;
> +	struct device_node *np;
> +	u32 *gpiospec;
> +	int i, ret;
> +
> +	np = of_find_compatible_node(NULL, NULL, "solomon,ssd1306fb-i2c");
> +	if (!np)
> +		return;
> +
> +	newgpio = kzalloc(sizeof(*newgpio) + OLED_RESET_GPIO_SIZE, GFP_KERNEL);
> +	if (!newgpio)
> +		return;
> +
> +	newgpio->value = newgpio + 1;
> +	newgpio->length = OLED_RESET_GPIO_SIZE;
> +	newgpio->name = kstrdup("reset-gpios", GFP_KERNEL);
> +	if (!newgpio->name) {
> +		kfree(newgpio);
> +		return;
> +	}
> +
> +	gpiospec = newgpio->value;
> +	for (i = 0; i < OLED_RESET_GPIO_LEN; i++) {
> +		ret = of_property_read_u32_index(np, "reset-gpios", i,
> +						 &gpiospec[i]);

Don't we have a helper to read the whole array?

Otherwise, for the series:

Reviewed-by: Rob Herring <robh@kernel.org>

> +		if (ret) {
> +			kfree(newgpio);
> +			return;
> +		}
> +	}
> +
> +	if (!(gpiospec[2] & OF_GPIO_ACTIVE_LOW)) {
> +		gpiospec[2] |= OF_GPIO_ACTIVE_LOW;
> +		cpu_to_be32_array(gpiospec, gpiospec, OLED_RESET_GPIO_LEN);
> +		of_update_property(np, newgpio);
> +	}
> +}
> +
>  static void __init crystalfontz_init(void)
>  {
>  	update_fec_mac_prop(OUI_CRYSTALFONTZ);
> +	crystalfontz_oled_reset_fixup();
>  }
>  
>  static void __init duckbill_init(void)
> -- 
> 2.1.4
> 
