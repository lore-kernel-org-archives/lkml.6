Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F67520657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547583140;
	bh=QByceuS3N7ruaiEC6SocC7co6eJljX8rR5YzRl2JAtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WltCARODb9b5HMV/+UopY5M0HuVDwA3ds2mOfqaKlyyJI7pckKscPxfWcE8/p38DS
	 h6Rv5MfTSiZtNgHbQZ2U94BJGZp0+rEqzzUiN73zNpQnu6RMuKO+qCP4h1CGcJCjiy
	 h+Il1vSBSl2JpOHnPWXzmsSp20icik12iHtcRy3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbfAOUMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:12:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41961 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732752AbfAOUMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:12:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so3142700oii.8;
        Tue, 15 Jan 2019 12:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Oo0yDiKlwDpBMxgdXBAyphrmV6UFJofSxQQoWi6bsMo=;
        b=chieqy4GDFZcDQeX556Z3FvOiA+UxVBheYW6hvFtgRHAHmrgSx5NI3bB5rnLBEP7Bw
         Hefwpw8IoexJKzDC/IfEtNh+/epikN8wxQtCx91cNrrzqXHQmX49+GqefGcvMCH9Fln3
         beQSB/6rWNAWbOCvvJt9QmXZZeYoPP46CohRewxRM309yur/AhkAKUHJ07mFL3KhZ4mX
         1QIJI48YaXtprX5+J1RIwEZLDmEK4ea3OjE8qWG12zEfJkaDebiGwuFjnNpt1ojYjb4g
         6l/aZKWe1wwFPnchItT420xO39YW163EpBOiSEYC8393Jg8l3eUEenS7XLM/koULiLoz
         AFAg==
X-Gm-Message-State: AJcUukdC1GmJskRw5PDMbOYLhqWx05OcYqnV5CFt/QFWu52P62GhmMnO
        Uz6+BXD733a06ct49jB1Ig==
X-Google-Smtp-Source: ALg8bN4Fd70PWZsf7kOAXtOqt/WAeoM01C2gZjvvv0bphBoEttFMAKWCwxUFFuS2Z7VErYbwYQTDYw==
X-Received: by 2002:aca:b184:: with SMTP id a126mr2940293oif.187.1547583136717;
        Tue, 15 Jan 2019 12:12:16 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id c9sm1730816otp.24.2019.01.15.12.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:12:15 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:12:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH shawn/for-next v4 2/2] ARM: dts: imx: Add Y Soft IOTA
 Draco,  Hydra and Ursa boards
Message-ID: <20190115201215.GA32682@bogus>
References: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
 <1547562139-64730-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547562139-64730-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 14:22:45 +0000, =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= wrote:
> These are i.MX6S/DL based SBCs embedded in various Y Soft products.
> All share the same board design but have slightly different HW
> configuration.
> 
> Ursa
> - i.MX6S SoC, 512MB RAM DDR3, 4GB eMMC, microSD
> - parallel WVGA 7" LCD with touch panel
> - 1x Eth (QCA8334 switch)
> - USB OTG
> - USB host (micro-B)
> 
> Draco
> - i.MX6S SoC, 512MB RAM DDR3, 4GB eMMC, microSD
> - parallel WVGA 7" LCD with touch panel
> - 2x Eth (QCA8334 switch)
> - USB OTG
> - USB host (micro-B)
> - RGB LED (I2C LP5562)
> - 3.5mm audio jack + codec (LM49350)
> 
> Hydra
> - i.MX6DL SoC, 2GB RAM DDR3, 4GB eMMC, microSD
> - I2C OLED display, capacitive matrix keys
> - 2x Eth (QCA8334 switch)
> - USB OTG
> - RGB LED (I2C LP5562)
> - 3.5mm audio jack + codec (LM49350)
> - HDMI
> - miniPCIe slot
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes since v3:
>  - Do not abbreviate regulator word in node names. (Shawn)
>  - Sort fixed regulator nodes alphabetically.
>  - Sort pmic regulator childe nodes alphabetically.
>  - Use newline between properties and child node in switch node. (Shawn)
>  - Sort i2c bus child nodes in order of unit-address. (Shawn)
>  - Rename PWM pinctl label to be consistent with node name. (Shawn)
> 
> Changes since v2:
>  - Remove cpus {/delete-node/ cpu@1;}; node from i.MX6Solo based board. (Fabio)
>  - Use "device_type = "memory";" in memory nodes. (Fabio)
>  - Use GPIO_ACTIVE_LOW for fec phy-reset-gpios. (Fabio)
>  - Use "-" in node names. (Rob)
>  - Remove label from led-controller node. (Rob)
>  
> Changes since v1:
>  - Enable HDMI on Hydra board.
>  - Move regulators to the root node and remove simple-bus property. (Rob)
>  - Remove reg and unit-address property from regulators. (Rob)
>  - Use correct names for led-controller and pmic node. (Rob)
>  - Use wakeup-source instead of deprecated enable-sdio-wakeup. (Shawn)
> 
>  arch/arm/boot/dts/Makefile                 |   3 +
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 595 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6dl-yapp4-draco.dts   |  58 +++
>  arch/arm/boot/dts/imx6dl-yapp4-hydra.dts   |  50 +++
>  arch/arm/boot/dts/imx6dl-yapp4-ursa.dts    |  54 +++
>  5 files changed, 760 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-draco.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
>  create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
