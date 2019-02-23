Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44868C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0596620665
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFl/S5dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfBWVkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:40:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfBWVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:40:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so2715124plp.0;
        Sat, 23 Feb 2019 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/cw/i+biX0xbzs1U/A5+Hg2bR0HgcIHCETYcKZn9BA=;
        b=aFl/S5dY7FViy+Ul4JqGXxC/tKj4PKPMkAgPMZlX1+vQ7Bx7GL4EsxdRN5mOqknwBJ
         odxExLrlyV+/7zi1/Jwa2z+yEtt0nYxD8ebBMmbAkkvAp7YDn+BLd5EM9VWlWOLD93IZ
         nZ3op9eUN743CljmOLuJzInlYvSs3Hzvyjx6KP0ytWFUaKMcfjEs7RmAWjA3TZEOZq/K
         LQj+U0yUvZdA2i+yBDSiqfKe1j1ZsJuM8fU7X9kRA2lw5Ty5rA9RFpRxzTAUueMw8Jkq
         udZ0FD/0ZGXlDSpRXjbmt07ccj67bacfoQbRg+ltzC0pH/hRktGvMHOJpqKry4GLkBbk
         hRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/cw/i+biX0xbzs1U/A5+Hg2bR0HgcIHCETYcKZn9BA=;
        b=NZlMiXFAMYGaF60YWcxYDe9dJq/QV1VDF29sJuePN5kDKjcD0a8cQkJOHb2L5ea23A
         0wRZNx+ujLfEZKoVqw3jkVrOzbprQnVTJk2/SzaEV9y1Y2gNqnougV1HZvaLLeiYbsRB
         YW1fpGjEsoMG72abj9VC6Kw1Y5tcDvWgj1CzzvN6I3v/HKgbFIkXOPt5JfCHlc5RDLyh
         iT5dRLe7CQPyGyNBeO5UOp9BK4EDcp18YXZcwO7xVDrDssCxQaXWBDV1ECJGM0YDcLD8
         bEqbdpu/gEs0rcpI2vFEuXzno/CJoM/XSSNlf2amaKj55muwE5M069pnx8Gt5nKJlsLY
         Ka4A==
X-Gm-Message-State: AHQUAuZk3pr8iWV38ud5uOvWja1f9YpgS3RXSJUpv1ZgzmwhOx3RoZBP
        Tcf/EhHUaNpbihpOp2AY6Xs=
X-Google-Smtp-Source: AHgI3IYH1OXM8cGDa7ACH/eSL++QXZuFZ8mCW7sMC0Dm+XCrMzSDtUsZJ9QzSHtf7Z9sT6X8lndJQQ==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr11281442plc.108.1550958016031;
        Sat, 23 Feb 2019 13:40:16 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id q28sm6734443pgl.35.2019.02.23.13.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 13:40:15 -0800 (PST)
Date:   Sat, 23 Feb 2019 13:40:19 -0800
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
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190223214018.GC1472@localhost.localdomain>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <20190223213759.GA1472@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223213759.GA1472@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 01:38:00PM -0800, Eduardo Valentin wrote:
> On Thu, Feb 21, 2019 at 06:38:30AM +0000, Anson Huang wrote:
> > NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> > system controller, the system controller is in charge of system
> > power, clock and thermal sensors etc. management, Linux kernel
> > has to communicate with system controller via MU (message unit)
> > IPC to get temperature from thermal sensors, this patch adds
> > binding doc for i.MX system controller thermal driver.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since V7:
> >         - remove unused property "tsens-num";
> >         - improve the compatible description;
> >         - update examples according to latest dts file.
> > ---
> >  .../devicetree/bindings/arm/freescale/fsl,scu.txt     | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > index 72d481c..d89147e 100644
> > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > @@ -122,6 +122,19 @@ RTC bindings based on SCU Message Protocol
> >  Required properties:
> >  - compatible: should be "fsl,imx8qxp-sc-rtc";
> >  
> > +Thermal bindings based on SCU Message Protocol
> > +------------------------------------------------------------
> > +
> > +Required properties:
> > +- compatible:			Should be :
> > +				  "fsl,imx8qxp-sc-thermal"
> > +				followed by "fsl,imx-sc-thermal";
> > +
> > +- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
> > +				for a description.
> > +
> > +- imx,sensor-resource-id: 	Property array to specify each thermal zone's sensor resource ID.
> 
> If this is an array...
> 
> > +
> >  Example (imx8qxp):
> >  -------------
> >  lsio_mu1: mailbox@5d1c0000 {
> > @@ -168,6 +181,12 @@ firmware {
> >  		rtc: rtc {
> >  			compatible = "fsl,imx8qxp-sc-rtc";
> >  		};
> > +
> > +		tsens: thermal-sensor {
> > +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> > +			#thermal-sensor-cells = <0>;
> > +			imx,sensor-resource-id = <IMX_SC_R_SYSTEM>;
> 
> then this example should have an array, to be better express how this is
> supposed to work. Can you please resend this with an array instead?

I mean this could be one example of an array with more than one element.

> 
> > +		};
> >  	};
> >  };
> >  
> > -- 
> > 2.7.4
> > 
