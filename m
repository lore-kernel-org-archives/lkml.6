Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1DD2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKY7Njzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfBTBE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:04:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41923 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTBE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:04:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so2695803pfn.8;
        Tue, 19 Feb 2019 17:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3ZatgbslWh4ZRWSPeM65DfU1uUxzDxa2WM38Pde0f8M=;
        b=JKY7NjzxmmmwjXBtAbEG1wVIxgX3uyHt8sa9KP9xhWTK2cDqGOBdk63V1pTs1gqg99
         N/17cAhnnjL+ebvmanfrQI9xgk0QXwsVGpnY8GtlxFmw8hDONMiz62HuxPDTDmPJHqG4
         Hl6sMjb0zdl9EOVeCBKrd40qorUR31Fs3D7g/N4JeObvhl8Q7BfscvtrKOPyfdOKsMY+
         54HiGSVH2bSzb6tKKZKpYGuPHWV28wjCJAFCZNGrXb1s+kMdq2dP29YmW/aBrN57YCQp
         Cypy1bK3SkEHIxrsgawrq047MoCrFJqwHW3nOGzBK+ylKh7kMLivYGVw4XmG0xdCS3mO
         7mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3ZatgbslWh4ZRWSPeM65DfU1uUxzDxa2WM38Pde0f8M=;
        b=jGCk5/7CNdmnszMHnuAUdmrv2oR/dAHb86YBTUpO6fZ+Bh8zvKVPi1/GOYs+wUu9Fh
         kT8lknQHcirTehjHfJLjl9bm0H11soAwGNXjhNKhRn4f2g4Stqno4kipp0def10qbYZ1
         bRRcbgRv5Btg4b++fMcsgJbL475IXsh7N4zPS13cQrfbdp3S8rE3p2ecMDo7Cu7wihII
         Xuls4UtVoDvrh5pC1EHsGo7gIdq9lLf2qnJy4sYwqaW05+1EmMf8mdZpc+2D5xznnTU1
         Wk0aE/T2JfTs5FkXvNPdd3JM9RhgO1UK5Mu39ALq22JqYXuV01WYFTZ+xrh4zef5EIKw
         lZLA==
X-Gm-Message-State: AHQUAub/9qP0xnIKVWqiw/U5MN7eySxMuLIBIo0dUuc4Fp8/wMtUXSe7
        ro0j2/DH44QzKH9mRBw6bsc=
X-Google-Smtp-Source: AHgI3Ia3h477b1FPZi1FCXxPPpanfwhs6S16Cw8o1G6os5t8YZ6w9ay8hF+ZT9MIYnjqm1Arf5jbVQ==
X-Received: by 2002:a62:4bd5:: with SMTP id d82mr31546603pfj.85.1550624666269;
        Tue, 19 Feb 2019 17:04:26 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id p6sm35095810pgd.69.2019.02.19.17.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:04:24 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:04:22 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190220010420.GA2811@localhost.localdomain>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB39165EFE027405873E8AB4ECF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C9B1A6F0E4C6352BA43CF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916C9B1A6F0E4C6352BA43CF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 07:20:58AM +0000, Anson Huang wrote:
> Ping...

I will take a look on this.

> 
> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > From: Anson Huang
> > Sent: 2019年2月13日 13:36
> > To: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > catalin.marinas@arm.com; will.deacon@arm.com; rui.zhang@intel.com;
> > edubezval@gmail.com; daniel.lezcano@linaro.org; Aisheng Dong
> > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel Baluta
> > <daniel.baluta@nxp.com>; horms+renesas@verge.net.au; Andy Gross
> > <andy.gross@linaro.org>; heiko@sntech.de; arnd@arndb.de;
> > maxime.ripard@bootlin.com; jagan@amarulasolutions.com;
> > bjorn.andersson@linaro.org; enric.balletbo@collabora.com;
> > marc.w.gonzalez@free.fr; olof@lixom.net; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > pm@vger.kernel.org
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: RE: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
> > 
> > Gental ping...
> > 
> > Best Regards!
> > Anson Huang
> > 
> > > -----Original Message-----
> > > From: Anson Huang
> > > Sent: 2019年2月7日 17:53
> > > To: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > > catalin.marinas@arm.com; will.deacon@arm.com; rui.zhang@intel.com;
> > > edubezval@gmail.com; daniel.lezcano@linaro.org; Aisheng Dong
> > > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel Baluta
> > > <daniel.baluta@nxp.com>; horms+renesas@verge.net.au; Andy Gross
> > > <andy.gross@linaro.org>; heiko@sntech.de; arnd@arndb.de;
> > > maxime.ripard@bootlin.com; jagan@amarulasolutions.com;
> > > bjorn.andersson@linaro.org; enric.balletbo@collabora.com;
> > > marc.w.gonzalez@free.fr; olof@lixom.net; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux- pm@vger.kernel.org
> > > Cc: dl-linux-imx <linux-imx@nxp.com>
> > > Subject: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
> > >
> > > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> > > controller, the system controller is in charge of system power, clock
> > > and thermal sensors etc. management, Linux kernel has to communicate
> > > with system controller via MU (message unit) IPC to get temperature
> > > from thermal sensors, this patch adds binding doc for i.MX system
> > > controller thermal driver.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > ChangeLog since V5:
> > > 	- add "imx,sensor-resource-id" in each thermal zone to pass resource
> > > ID for thermal driver.
> > > ---
> > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt    | 20
> > > ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > index 72d481c..4b79751 100644
> > > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > @@ -122,6 +122,20 @@ RTC bindings based on SCU Message Protocol
> > > Required properties:
> > >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> > >
> > > +Thermal bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible : Must be "fsl,imx8qxp-sc-thermal";
> > > +- tsens-num : Total number of thermal sensors supported;
> > > +- #thermal-sensor-cells : Should be 1. See
> > > +
> > > Documentation/devicetree/bindings/thermal/thermal.txt
> > > +			  for a description.
> > > +- imx,sensor-resource-id : This property should be defined in each
> > > +thermal
> > > zone
> > > +			   of thermal-zones node, it passes each thermal
> > > zone's
> > > +			   resource id for thermal driver to get temperature
> > > via
> > > +			   SCU IPC.
> > > +
> > >  Example (imx8qxp):
> > >  -------------
> > >  lsio_mu1: mailbox@5d1c0000 {
> > > @@ -168,6 +182,12 @@ firmware {
> > >  		rtc: rtc {
> > >  			compatible = "fsl,imx8qxp-sc-rtc";
> > >  		};
> > > +
> > > +		tsens: thermal-sensor {
> > > +			compatible = "fsl,imx8qxp-sc-thermal";
> > > +			tsens-num = <1>;
> > > +			#thermal-sensor-cells = <1>;
> > > +		};
> > >  	};
> > >  };
> > >
> > > --
> > > 2.7.4
> 
