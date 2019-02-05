Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24910C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD08217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef+Wgfgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfBEX0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:26:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44872 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBEX0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:26:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so2075493pgk.11;
        Tue, 05 Feb 2019 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qdr9kE+Ua9rD1rJcCsH9S2vBNKcQzDhWBqHVHGgVElc=;
        b=ef+WgfgdhYbBcvjjPQRg8ze4GhuOWMEi4vsMT7mk/1IulgcJL/tEC72/cqatd7k8SZ
         +OUTyrJwS4fWJVHpazh9oqwpOWLUVgsR+cwrKB3nLjFm6RNTT5tRsgbaz/GQRgsniQiY
         Mw9K/yGN5bZasuebVJTOP//qr6heVgw8vs0tPvPlDAIBb9ngjGBopIOjdi6PAb9/i0M9
         g6J/q9F1WvdL6h0t4IJArBs5mKng939AajSNG4pyfpYDLjzuvN10Q87MfurCol/X0hkM
         JcqfqXFpiYnEPcQmnXeqtA22+DKgjDtbEe1Bsis2tp8/EnXdOqOa2VAZiuzcOqaX7lg7
         0pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qdr9kE+Ua9rD1rJcCsH9S2vBNKcQzDhWBqHVHGgVElc=;
        b=cD0sjw68BzQgXnSIBZciZ87wFYFOyCCRc5b7Tmg5thIph8uejQy3EcIdDPsAUgN+jA
         EaHGUcY6TQctgB6GAVKIBXG4cdOLuzEWbSkhh7Wd9SsZ2ijysi3FfpZde1dScIIvlCKz
         rziyW1j4n2WT4xdgGU+YxtmsePnmchgaf0HhVZbJ/4PsxifaUdFOC6hmE22MqBQHLYOe
         eQJlR8wSarKEJmO3JppmcyTyIqwlmf9xUbDIHJf4KRw66Vs/iMOUlrNR/S05G9P6KvA4
         DLOSoVFxLW/y212Lkc3vrVZwjSewI4PdFXz0HJWNXPnMdqjwlvK6YNZvQRHLKcPZoehP
         N1CA==
X-Gm-Message-State: AHQUAuauOCkMkIC+cto8OskGYACLaf5yONOtik4BqXQ+MoHpvTw/40UN
        6+kaqHPFXES+N9vBVQe5oAU=
X-Google-Smtp-Source: AHgI3IYmuTElStvKhKLSWYNPk+6rKd7zVvXeCXhj53EDtfXJO2SmtR4E8q6xTo/pydGLwqQqGsSr2w==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr6826814pgs.214.1549409183130;
        Tue, 05 Feb 2019 15:26:23 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id m3sm8160872pff.173.2019.02.05.15.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:26:22 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:26:19 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Message-ID: <20190205232618.GB4423@localhost.localdomain>
References: <1545296609-20477-1-git-send-email-Anson.Huang@nxp.com>
 <1545296609-20477-3-git-send-email-Anson.Huang@nxp.com>
 <20181225224336.GA8220@localhost.localdomain>
 <DB3PR0402MB39168B078828CC18D4F0D3A8F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167BBE4EE90887ABE9B668F5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB391650D6288E9108B74DAA17F5980@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB391650D6288E9108B74DAA17F5980@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:54:30AM +0000, Anson Huang wrote:
> Hi, Eduardo
> 
> Best Regards!
> Anson Huang

Taking a look

> 
> > -----Original Message-----
> > From: Anson Huang
> > Sent: 2019年1月10日 17:28
> > To: 'Eduardo Valentin' <edubezval@gmail.com>
> > Cc: 'robh+dt@kernel.org' <robh+dt@kernel.org>; 'mark.rutland@arm.com'
> > <mark.rutland@arm.com>; 'catalin.marinas@arm.com'
> > <catalin.marinas@arm.com>; 'will.deacon@arm.com'
> > <will.deacon@arm.com>; 'rui.zhang@intel.com' <rui.zhang@intel.com>;
> > 'daniel.lezcano@linaro.org' <daniel.lezcano@linaro.org>; Aisheng Dong
> > <aisheng.dong@nxp.com>; 's.hauer@pengutronix.de'
> > <s.hauer@pengutronix.de>; 'shawnguo@kernel.org' <shawnguo@kernel.org>;
> > Andy Gross <andy.gross@linaro.org>; 'arnd@arndb.de' <arnd@arndb.de>;
> > 'horms+renesas@verge.net.au' <horms+renesas@verge.net.au>;
> > 'heiko@sntech.de' <heiko@sntech.de>; 'bjorn.andersson@linaro.org'
> > <bjorn.andersson@linaro.org>; 'enric.balletbo@collabora.com'
> > <enric.balletbo@collabora.com>; 'amit.kucheria@linaro.org'
> > <amit.kucheria@linaro.org>; 'ezequiel@collabora.com'
> > <ezequiel@collabora.com>; 'olof@lixom.net' <olof@lixom.net>;
> > 'devicetree@vger.kernel.org' <devicetree@vger.kernel.org>;
> > 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> > 'linux-arm-kernel@lists.infradead.org' <linux-arm-kernel@lists.infradead.org>;
> > 'linux-pm@vger.kernel.org' <linux-pm@vger.kernel.org>; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: RE: [PATCH V5 2/4] thermal: imx_sc: add i.MX system controller
> > thermal support
> > 
> > Hi, Eduardo
> > 
> > Best Regards!
> > Anson Huang
> > 
> > > -----Original Message-----
> > > From: Anson Huang
> > > Sent: 2018年12月26日 11:36
> > > To: 'Eduardo Valentin' <edubezval@gmail.com>
> > > Cc: robh+dt@kernel.org; mark.rutland@arm.com;
> > catalin.marinas@arm.com;
> > > will.deacon@arm.com; rui.zhang@intel.com; daniel.lezcano@linaro.org;
> > > Aisheng Dong <aisheng.dong@nxp.com>; s.hauer@pengutronix.de;
> > > shawnguo@kernel.org; Andy Gross <andy.gross@linaro.org>;
> > > arnd@arndb.de;
> > > horms+renesas@verge.net.au; heiko@sntech.de;
> > > horms+bjorn.andersson@linaro.org;
> > > enric.balletbo@collabora.com; amit.kucheria@linaro.org;
> > > ezequiel@collabora.com; olof@lixom.net; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux-pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > > Subject: RE: [PATCH V5 2/4] thermal: imx_sc: add i.MX system
> > > controller thermal support
> > >
> > > Hi, Eduardo
> > >
> > > Best Regards!
> > > Anson Huang
> > >
> > > > -----Original Message-----
> > > > From: Eduardo Valentin [mailto:edubezval@gmail.com]
> > > > Sent: 2018年12月26日 6:44
> > > > To: Anson Huang <anson.huang@nxp.com>
> > > > Cc: robh+dt@kernel.org; mark.rutland@arm.com;
> > > catalin.marinas@arm.com;
> > > > will.deacon@arm.com; rui.zhang@intel.com; daniel.lezcano@linaro.org;
> > > > Aisheng Dong <aisheng.dong@nxp.com>; s.hauer@pengutronix.de;
> > > > shawnguo@kernel.org; Andy Gross <andy.gross@linaro.org>;
> > > > arnd@arndb.de;
> > > > horms+renesas@verge.net.au; heiko@sntech.de;
> > > > horms+bjorn.andersson@linaro.org;
> > > > enric.balletbo@collabora.com; amit.kucheria@linaro.org;
> > > > ezequiel@collabora.com; olof@lixom.net; devicetree@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux-pm@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH V5 2/4] thermal: imx_sc: add i.MX system
> > > > controller thermal support
> > > >
> > > > On Thu, Dec 20, 2018 at 09:08:32AM +0000, Anson Huang wrote:
> > > > > i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> > > > > inside, the system controller is in charge of controlling power,
> > > > > clock and thermal sensors etc..
> > > > >
> > > > > This patch adds i.MX system controller thermal driver support,
> > > > > Linux kernel has to communicate with system controller via MU
> > > > > (message
> > > > > unit) IPC to get each thermal sensor's temperature, it supports
> > > > > multiple sensors which are passed from device tree, please see the
> > > > > binding doc for details.
> > > > >
> > > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > > ---
> > > > > ChangeLog since V4:
> > > > >     - Add driver dependency on IMX_SCU to avoid compile error when
> > > > IMX_SCU is NOT selected;
> > > > >     - Remove unnecessary of different errors handle for
> > > > imx_scu_get_handle, already included in API.
> > > > > ---
> > > > >  drivers/thermal/Kconfig          |  11 +++
> > > > >  drivers/thermal/Makefile         |   1 +
> > > > >  drivers/thermal/imx_sc_thermal.c | 200
> > > > > +++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 212 insertions(+)  create mode 100644
> > > > > drivers/thermal/imx_sc_thermal.c
> > > > >
> > > > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > > > index 0e69edc..8d4601d 100644
> > > > > --- a/drivers/thermal/Kconfig
> > > > > +++ b/drivers/thermal/Kconfig
> > > > > @@ -222,6 +222,17 @@ config IMX_THERMAL
> > > > >  	  cpufreq is used as the cooling device to throttle CPUs when the
> > > > >  	  passive trip is crossed.
> > > > >
> > > > > +config IMX_SC_THERMAL
> > > > > +	tristate "Temperature sensor driver for NXP i.MX SoCs with
> > > > > +System
> > > > Controller"
> > > > > +	depends on (ARCH_MXC && IMX_SCU) || COMPILE_TEST
> > > > > +	depends on OF
> > > > > +	help
> > > > > +	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX
> > > > > +SoCs
> > > > with
> > > > > +	  system controller inside, Linux kernel has to communicate with
> > system
> > > > > +	  controller via MU (message unit) IPC to get temperature from
> > thermal
> > > > > +	  sensor. It supports one critical trip point and one
> > > > > +	  passive trip point for each thermal sensor.
> > > > > +
> > > > >  config MAX77620_THERMAL
> > > > >  	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
> > > > >  	depends on MFD_MAX77620
> > > > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > > > index 610344e..1b13f6a 100644
> > > > > --- a/drivers/thermal/Makefile
> > > > > +++ b/drivers/thermal/Makefile
> > > > > @@ -41,6 +41,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+=
> > > > db8500_thermal.o
> > > > >  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> > > > >  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
> > > > >  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> > > > > +obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
> > > > >  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
> > > > >  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
> > > > >  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> > > > > diff --git a/drivers/thermal/imx_sc_thermal.c
> > > > > b/drivers/thermal/imx_sc_thermal.c
> > > > > new file mode 100644
> > > > > index 0000000..1030a31
> > > > > --- /dev/null
> > > > > +++ b/drivers/thermal/imx_sc_thermal.c
> > > > > @@ -0,0 +1,200 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Copyright 2018 NXP.
> > > > > + */
> > > > > +
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/firmware/imx/sci.h> #include <linux/module.h>
> > > > > +#include <linux/of.h> #include <linux/of_device.h> #include
> > > > > +<linux/platform_device.h> #include <linux/slab.h> #include
> > > > > +<linux/thermal.h>
> > > > > +
> > > > > +#include "thermal_core.h"
> > > > > +
> > > > > +#define IMX_SC_MISC_FUNC_GET_TEMP	13
> > > > > +#define IMX_SC_C_TEMP			0
> > > > > +
> > > > > +static struct imx_sc_ipc *thermal_ipc_handle;
> > > > > +
> > > > > +struct imx_sc_sensor {
> > > > > +	struct thermal_zone_device *tzd;
> > > > > +	u32 resource_id;
> > > > > +};
> > > > > +
> > > > > +struct imx_sc_thermal_data {
> > > > > +	struct imx_sc_sensor *sensor;
> > > > > +};
> > > > > +
> > > > > +struct req_get_temp {
> > > > > +	u16 resource_id;
> > > > > +	u8 type;
> > > > > +} __packed;
> > > > > +
> > > > > +struct resp_get_temp {
> > > > > +	u16 celsius;
> > > > > +	u8 tenths;
> > > > > +} __packed;
> > > > > +
> > > > > +struct imx_sc_msg_misc_get_temp {
> > > > > +	struct imx_sc_rpc_msg hdr;
> > > > > +	union {
> > > > > +		struct req_get_temp req;
> > > > > +		struct resp_get_temp resp;
> > > > > +	} data;
> > > > > +} __packed;
> > > > > +
> > > > > +static int imx_sc_thermal_get_temp(void *data, int *temp) {
> > > > > +	struct imx_sc_msg_misc_get_temp msg;
> > > > > +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > > > > +	struct imx_sc_sensor *sensor = data;
> > > > > +	int ret;
> > > > > +
> > > > > +	msg.data.req.resource_id = sensor->resource_id;
> > > > > +	msg.data.req.type = IMX_SC_C_TEMP;
> > > > > +
> > > > > +	hdr->ver = IMX_SC_RPC_VERSION;
> > > > > +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> > > > > +	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
> > > > > +	hdr->size = 2;
> > > > > +
> > > > > +	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> > > > > +	if (ret) {
> > > > > +		pr_err("read temp sensor %d failed, ret %d\n",
> > > > > +			sensor->resource_id, ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths *
> > > > > +100;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
> > > > > +	.get_temp = imx_sc_thermal_get_temp, };
> > > > > +
> > > > > +static int imx_sc_thermal_register_sensor(struct platform_device *pdev,
> > > > > +					  struct imx_sc_sensor *sensor) {
> > > > > +	struct thermal_zone_device *tzd;
> > > > > +
> > > > > +	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> > > > > +						   sensor->resource_id,
> > > > > +						   sensor,
> > > > > +						   &imx_sc_thermal_ops);
> > > > > +	if (IS_ERR(tzd)) {
> > > > > +		dev_err(&pdev->dev, "failed to register sensor: %d\n",
> > > > > +			sensor->resource_id);
> > > > > +		return PTR_ERR(tzd);
> > > > > +	}
> > > > > +
> > > > > +	sensor->tzd = tzd;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int imx_sc_thermal_get_sensor_id(struct device_node
> > > > > +*sensor_np, u32 *id) {
> > > > > +	struct of_phandle_args sensor_specs;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> > > > > +			"#thermal-sensor-cells",
> > > > > +			0, &sensor_specs);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	if (sensor_specs.args_count >= 1) {
> > > > > +		*id = sensor_specs.args[0];
> > > > > +		WARN(sensor_specs.args_count > 1,
> > > > > +				"%pOFn: too many cells in sensor specifier %d\n",
> > > > > +				sensor_specs.np, sensor_specs.args_count);
> > > > > +	} else {
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > >
> > > > So, there should be no need for doing a search of sensor ids. In
> > > > fact, if the amount of sensors or the type of sensors supported changes, i.e.
> > > > the sensor ids are do not match, you should have a different
> > > > compatible,
> > > IMO.
> > >
> > > So do you mean I can just read the sensor id (actually it is our SoC's
> > > resource id) from the DTB file's each child node of thermal_zones?
> > > Then I can skip the search of sensor ids, just add a sensor id
> > > property and read it out during thermal driver probe? Yes, this looks like
> > easier, is my understanding correct?
> > > If yes, I can do it in next version. Thanks.
> > >
> > > Anson
> > 
> > Can you be more detail about the search of sensor ids? For this SoC, there will
> > be more
> > sensors(thermal-zone) added later, like DDR controller thermal sensor and
> > pmic sensor etc., they will use same compatible, and in the
> > imx_sc_thermal_get_sensor_id(), it just read out the sensor id from the dtb's
> > each thermal zone's " thermal-sensors " property, I did NOT see any search
> > here, thanks!
> > 
> > Anson.
> 
> I can remove the imx_sc_thermal_get_sensor_id() in the patch, and add below property in dts, then
> just read out the resource id using of_property_read_u32(), then we can save the sensor id search function
> in the driver, but need to add a property in dts, is this what you mean?
> 
> .probe:
> -               ret = imx_sc_thermal_get_sensor_id(sensor_np, &sensor->resource_id);
> -               if (ret < 0) {
> +               if (of_property_read_u32(sensor_np, "sensor-resource-id",
> +                       &sensor->resource_id)) {
> 
> dts:
> 454         thermal_zones: thermal-zones {
> 455                 cpu-thermal0 {
> 456                         polling-delay-passive = <250>;
> 457                         polling-delay = <2000>;
> 458 +                         sensor-resource-id = <355>;
> 459                         thermal-sensors = <&tsens 355>;
> 
> Anson.
> 
> > 
> > >
> > > >
> > > > > +static int imx_sc_thermal_probe(struct platform_device *pdev) {
> > > > > +	struct device_node *np = pdev->dev.of_node;
> > > > > +	struct device_node *sensor_np = NULL;
> > > > > +	struct imx_sc_thermal_data *data;
> > > > > +	struct imx_sc_sensor *sensors;
> > > > > +	u32 sensor_num;
> > > > > +	int ret, i;
> > > > > +
> > > > > +	ret = imx_scu_get_handle(&thermal_ipc_handle);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > > > > +	if (!data)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	ret = of_property_read_u32(np, "tsens-num", &sensor_num);
> > > > > +	if (ret || !sensor_num) {
> > > > > +		dev_err(&pdev->dev, "failed to get valid temp sensor
> > number!\n");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	sensors = devm_kzalloc(&pdev->dev, sizeof(*data->sensor) *
> > sensor_num,
> > > > > +			       GFP_KERNEL);
> > > > > +	if (!sensors)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	data->sensor = sensors;
> > > > > +
> > > > > +	np = of_find_node_by_name(NULL, "thermal-zones");
> > > > > +	if (!np)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	for (i = 0; i < sensor_num; i++) {
> > > > > +		struct imx_sc_sensor *sensor = &data->sensor[i];
> > > > > +
> > > > > +		sensor_np = of_get_next_child(np, sensor_np);
> > > > > +		ret = imx_sc_thermal_get_sensor_id(sensor_np,
> > > > &sensor->resource_id);
> > > > > +		if (ret < 0) {
> > > > > +			dev_err(&pdev->dev,
> > > > > +				"failed to get valid sensor resource id: %d\n",
> > > > > +				ret);
> > > > > +			break;
> > > > > +		}
> > > > > +
> > > > > +		ret = imx_sc_thermal_register_sensor(pdev, sensor);
> > > > > +		if (ret) {
> > > > > +			dev_err(&pdev->dev, "failed to register thermal
> > sensor: %d\n",
> > > > > +				ret);
> > > > > +			break;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	of_node_put(np);
> > > > > +	of_node_put(sensor_np);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id imx_sc_thermal_table[] = {
> > > > > +	{ .compatible = "fsl,imx8qxp-sc-thermal", },
> > > > > +	{}
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
> > > > > +
> > > > > +static struct platform_driver imx_sc_thermal_driver = {
> > > > > +		.probe = imx_sc_thermal_probe,
> > > > > +		.driver = {
> > > > > +			.name = "imx-sc-thermal",
> > > > > +			.of_match_table = imx_sc_thermal_table,
> > > > > +		},
> > > > > +};
> > > > > +module_platform_driver(imx_sc_thermal_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> > > > > +MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system
> > > > > +controller"); MODULE_LICENSE("GPL v2");
> > > > > --
> > > > > 2.7.4
> > > > >
