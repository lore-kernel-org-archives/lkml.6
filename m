Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806FEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F4820989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F4820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeK1If0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:35:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59080 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeK1If0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:35:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 537D3207BC; Tue, 27 Nov 2018 22:36:09 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 237EF20734;
        Tue, 27 Nov 2018 22:35:59 +0100 (CET)
Date:   Tue, 27 Nov 2018 22:35:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/4] rtc: add i.MX system controller RTC support
Message-ID: <20181127213559.GB7569@piout.net>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543311334-8807-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your submission.

On 27/11/2018 09:41:20+0000, Anson Huang wrote:
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 290c173..965725f 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -151,6 +151,7 @@ obj-$(CONFIG_RTC_DRV_SC27XX)	+= rtc-sc27xx.o
>  obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
>  obj-$(CONFIG_RTC_DRV_SIRFSOC)	+= rtc-sirfsoc.o
>  obj-$(CONFIG_RTC_DRV_SNVS)	+= rtc-snvs.o
> +obj-$(CONFIG_RTC_DRV_IMX_SC)	+= rtc-imx-sc.o

This list must be sorted alphabetically.

>  obj-$(CONFIG_RTC_DRV_SPEAR)	+= rtc-spear.o
>  obj-$(CONFIG_RTC_DRV_STARFIRE)	+= rtc-starfire.o
>  obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
> diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
> new file mode 100644
> index 0000000..2466b55
> --- /dev/null
> +++ b/drivers/rtc/rtc-imx-sc.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 NXP.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

As you have the SPDX identifier, I think this boiler plate license text
should be removed.

> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
> +#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
> +
> +struct imx_sc_ipc *rtc_ipc_handle;
> +struct rtc_device *rtc;
> +
> +struct imx_sc_msg_req_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +} __packed;
> +
> +struct imx_sc_msg_resp_timer_get_rtc_time {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 time;
> +} __packed;
> +
> +static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct imx_sc_msg_resp_timer_get_rtc_time *resp;
> +	struct imx_sc_msg_req_timer_get_rtc_time msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_TIMER;
> +	hdr->func = IMX_SC_TIMER_FUNC_GET_RTC_SEC1970;
> +	hdr->size = 1;
> +
> +	ret = imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
> +	if (ret) {
> +		pr_err("read rtc time failed, ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	resp = (struct imx_sc_msg_resp_timer_get_rtc_time *)&msg;
> +	rtc_time_to_tm(resp->time, tm);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops imx_sc_rtc_ops = {
> +	.read_time = imx_sc_rtc_read_time,
> +};
> +
> +static int imx_sc_rtc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = imx_scu_get_handle(&rtc_ipc_handle);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
> +		return ret;
> +	}
> +
> +	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					&imx_sc_rtc_ops, THIS_MODULE);

Please use devm_rtc_allocate_device and rtc_register_device to register
the RTC. If possible, you should also set range_min and range_max. If I
understand the code correctly, this should simply be range_max = U32_MAX;


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
