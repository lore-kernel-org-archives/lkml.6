Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FABCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC062184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5qQlGIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfBEXnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:43:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45160 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfBEXnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:43:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id j3so102739pfi.12;
        Tue, 05 Feb 2019 15:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bdyu65Ux18DJ7Dq8vMj9lnAoCgXJZcINi1MtHaMXMrk=;
        b=e5qQlGIGhRhyOqMWrJBfLh4AMd7S/Qr5ABkof0ot8ueHE2Fwq2cTwiiplyglSvG2f2
         1ZH8QuLu6FGCgXIGz/r9dGh6yU5jjR+fWaXpqv1hXu5s0UpkYfH+TOjatHflGHEPC6r+
         jr8hTgkJl9mDk8lnspeCA1e5OwYK2JYvaaPgbYdZDcBxcIw7916sVOymT/MgcCh0XGdT
         Y5MCGBP+n7XOmGvz/h6RLrlaG5mpf9ck7noaV6tlN6vprdF2sKgptmy4unrhodJuMEJT
         R/GirZQhDZBPthHB3cV4qaUZ5pXAQuFoXDNjAcoTvz2FCf+B5x79FaPkOtLzOKBR1+O5
         Yy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bdyu65Ux18DJ7Dq8vMj9lnAoCgXJZcINi1MtHaMXMrk=;
        b=HrbaGIvwCl1FwOYBmn5SZ8KmW+pcMdrepebEFt93tbRkSoupTUbBbU8qdduu89RrM8
         TqSuzAFt8+orcbas3xVZmLOT1sSH6NK+4HTZicQZIUj4qlwQy6O52zhA2nHmkhsuZtVL
         h1KW5Ndcg2ug0i9uT0aUF2obz2eg7SDt1zb9ImUAaEGOf7Uliw8uVh7DvmFIuz8MkEIN
         bQI/YnFfgAmq1IX+nmh5K7ColYvYwP0GOdTOsZrg8MeFsZtaL+XFgnJ+k+65hxBTrIKe
         HdG5Nnr/mXZGH6LtKmWXQXmuoc9/sFTd2SlVgsevSXFnUdRO+ve24Fxll0Kuc67zcwbq
         kWbg==
X-Gm-Message-State: AHQUAubNFuPf7y21p+rSlUlbTMAE8EOodge1+SSVx8ibitq3xWwMofgd
        zeojwDXFjqwvHp5vEMoM3G8=
X-Google-Smtp-Source: AHgI3IZtUc7nYYtJNdwgEs6Sejew10m8Hp8gZHxjzaYIRyy8MohmMmWHPNWtQuOphObsI1TjhJVUFg==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr6861455pgf.33.1549410220176;
        Tue, 05 Feb 2019 15:43:40 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id c4sm8157206pfm.151.2019.02.05.15.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:43:39 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:43:36 -0800
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
Message-ID: <20190205234335.GA4768@localhost.localdomain>
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

Yeah, I believe this would be best description for your case. In your
current patch you are abusing a bit of the thermal descriptor. That
sensor cell is to actually help identify the sensor within the device
tree description...

> 459                         thermal-sensors = <&tsens 355>;
> 

when you add 355 that would mean this is sensor 355 of all sensors
handled by your tsens. I would actually even assume that there are at
least 355 sensors in that tsens.

I mean, there is nothing really wrong with that syntactically, but it is
a slightly different usage of that #thermal-sensors-cell.

If you I got your patch right, you need a resource-id to be sent in a
command. For that I would recommend adding a specific property, with the
prefix imx, in it. Something like imx,sensor-resource-id, or something
fits better for you.

> Anson.
> 
