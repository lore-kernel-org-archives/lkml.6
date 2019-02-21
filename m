Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548342084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRBY/IU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfBUBDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:03:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44299 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBUBDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:03:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id c4so8162670pls.11;
        Wed, 20 Feb 2019 17:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fX5lDMwjodCprOzdzhSKvUSF4n4+hIb+niLlnQ9OeKo=;
        b=lRBY/IU7WsBSrcphwbe6e3B8XZj20VdIIfNiVOcHPIvKalQtGl3q84NDmkjQd4azS+
         FbcjrdXQmpZ7/WQA+6HqZYJpYIzBUadnxZjHnAP+T2hYzqvVgtr3OcbTJUcjbqpHAiTi
         1JmEXc5d4k1V4cb3mCG2T0M5NzboLNNpOYyKbcKmwFmCChO2M88iLlccXlL6DNw9RQqZ
         J2id0yl6iSG76nBrWQWul9MflyTaAMw/eq3g1Fh9kxtxA+Mm1MrxC6KeDPjsU8oApFgS
         rQpAVPZwC/hDMdTPCxxJZZfyq8gOnkT0GeyT0ZoiXaZysEFYI0Mb8w3po0ftqZt1Jt+e
         PXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fX5lDMwjodCprOzdzhSKvUSF4n4+hIb+niLlnQ9OeKo=;
        b=VeiXQtL35/F7Cw4It1X3crmxNlg4q8ri6wnEAtp4BQhXWwK3NWfokvso2QRqAEcycc
         HM4tF1AL50NH41yp0Z75drENfbDP4SnL2vAMHXvnKWHt58pQIF7HFC1Bf55R7m1Pbz6o
         NNyJdvEmmISGpHpe4DghxN3YpB5A9r/MEZBE7y875sElHJ+NDVL2RLjg6kbmrNNjXFwX
         viFfi3Yl7hzxCffypG5z8IOIHKFPUjuyqWvxv3IlFg/V5b5LEa8Z9zZT7odoim1wHvuM
         P9xlJE8tDVOllzkOyvsD5wTdKj2hkn5k9x9r7exVRngUvO6uL7yUXVfPP4yVqTETeuVm
         jU8g==
X-Gm-Message-State: AHQUAuYjm2+nJNmV2rU5ZUdVmmW6Rp75akD9INob/jxYGtMIUdsC/Llb
        TNeq52OGXAOYHZVOisFbVwk=
X-Google-Smtp-Source: AHgI3IaZCRxuP8L+aMl6njyUESwTH2Bjr5v0umsSDtSPlGG72sSPBa8XYpjjgsizTpUXqOh1b9Kt/w==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr39549510plo.194.1550711009409;
        Wed, 20 Feb 2019 17:03:29 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id z67sm14883787pfi.152.2019.02.20.17.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 17:03:28 -0800 (PST)
Date:   Wed, 20 Feb 2019 17:03:26 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 4/4] arm64: dts: imx: add i.MX8QXP thermal support
Message-ID: <20190221010324.GD31479@localhost.localdomain>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
 <1550645332-2907-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550645332-2907-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 06:53:58AM +0000, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V6:
> 	- add fallback compatible string "fsl,imx-sc-thermal" according to i.MX SC thermal driver
> 	  update.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4c3dd95..24b03d6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -116,6 +117,12 @@
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +			tsens-num = <1>;
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> @@ -443,4 +450,25 @@
>  			power-domains = <&pd IMX_SC_R_GPIO_7>;
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens 0>;
> +			imx,sensor-resource-id = <355>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";

Please add your cooling maps for a passive trip point.

> +				};
> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 
