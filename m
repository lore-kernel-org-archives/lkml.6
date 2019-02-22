Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA87AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DEC20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfBVITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:19:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43700 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725855AbfBVITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:19:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1M8DA0j025606;
        Fri, 22 Feb 2019 09:19:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qpc75hd5j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Feb 2019 09:19:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C63538;
        Fri, 22 Feb 2019 08:19:26 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB5AA285B;
        Fri, 22 Feb 2019 08:19:25 +0000 (GMT)
Received: from [10.201.23.162] (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Feb
 2019 09:19:24 +0100
Subject: Re: [PATCH] rpmsg: add clock API redirection driver
To:     Xiang Xiao <xiaoxiang781216@gmail.com>,
        Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <wendy.liang@xilinx.com>, Kumar Gala <kumar.gala@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yanlin Zhu <zhuyanlin@pinecone.net>
References: <1550345867-25762-1-git-send-email-xiaoxiang@xiaomi.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <2d174b98-fd88-cdd7-b7a6-96c544953db9@st.com>
Date:   Fri, 22 Feb 2019 09:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550345867-25762-1-git-send-email-xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiang

On 2/16/19 8:37 PM, Xiang Xiao wrote:
> From: Yanlin Zhu <zhuyanlin@pinecone.net>
> 
> which could redirect clk API from remote to the kernel
> 
> Signed-off-by: Yanlin Zhu <zhuyanlin@pinecone.net>
> ---
>  drivers/rpmsg/Kconfig     |  10 ++
>  drivers/rpmsg/Makefile    |   1 +
>  drivers/rpmsg/rpmsg_clk.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 295 insertions(+)
>  create mode 100644 drivers/rpmsg/rpmsg_clk.c
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index 13ead55..ed04cb9 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -15,6 +15,16 @@ config RPMSG_CHAR
>  	  in /dev. They make it possible for user-space programs to send and
>  	  receive rpmsg packets.
>  
> +config RPMSG_CLK
> +	tristate "RPMSG clock API redirection"
> +	depends on COMMON_CLK
> +	depends on RPMSG
> +	help
> +	  Say Y here to redirect clock API from the remote processor.
> +	  With this driver, the remote processor could:
> +	  1.Reuse the clock driver in the kernel side, or
> +	  2.Form a hybrid(kernel plus RTOS) clock tree.
> +
>  config RPMSG_SYSLOG
>  	tristate "RPMSG syslog redirection"
>  	depends on RPMSG
> diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
> index bfd22df..0d777b1 100644
> --- a/drivers/rpmsg/Makefile
> +++ b/drivers/rpmsg/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
>  obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
> +obj-$(CONFIG_RPMSG_CLK)		+= rpmsg_clk.o
>  obj-$(CONFIG_RPMSG_SYSLOG)	+= rpmsg_syslog.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
> diff --git a/drivers/rpmsg/rpmsg_clk.c b/drivers/rpmsg/rpmsg_clk.c
> new file mode 100644
> index 0000000..0ec0241
> --- /dev/null
> +++ b/drivers/rpmsg/rpmsg_clk.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Pinecone Inc.
> + *
> + * redirect clk API from remote to the kernel.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/rpmsg.h>
> +
> +#define RPMSG_CLK_ENABLE	0
> +#define RPMSG_CLK_DISABLE	1
> +#define RPMSG_CLK_SETRATE	2
> +#define RPMSG_CLK_SETPHASE	3
> +#define RPMSG_CLK_GETPHASE	4
> +#define RPMSG_CLK_GETRATE	5
> +#define RPMSG_CLK_ROUNDRATE	6
> +#define RPMSG_CLK_ISENABLED	7
> +
> +struct rpmsg_clk_header {
> +	u32			command;
> +	u32			response;
> +	s64			result;
> +	u64			cookie;
> +} __packed;
> +
> +struct rpmsg_clk_enable {
> +	struct rpmsg_clk_header	header;
> +	char			name[0];
> +} __packed;
> +
> +#define rpmsg_clk_disable	rpmsg_clk_enable
> +#define rpmsg_clk_isenabled	rpmsg_clk_enable
> +
> +struct rpmsg_clk_setrate {
> +	struct rpmsg_clk_header	header;
> +	u64			rate;
> +	char			name[0];
> +} __packed;
> +
> +#define rpmsg_clk_getrate	rpmsg_clk_enable
> +#define rpmsg_clk_roundrate	rpmsg_clk_setrate
> +
> +struct rpmsg_clk_setphase {
> +	struct rpmsg_clk_header	header;
> +	u32			degrees;
> +	char			name[0];
> +} __packed;
> +
> +#define rpmsg_clk_getphase	rpmsg_clk_enable
> +
> +struct rpmsg_clk_res {
> +	struct clk		*clk;
> +	atomic_t		count;
> +};
> +
> +static void rpmsg_clk_release(struct device *dev, void *res)
> +{
> +	struct rpmsg_clk_res *clkres = res;
> +	int count = atomic_read(&clkres->count);
> +
> +	while (count-- > 0)
> +		clk_disable_unprepare(clkres->clk);
> +
> +	clk_put(clkres->clk);
> +}
> +
> +static int rpmsg_clk_match(struct device *dev, void *res, void *data)
> +{
> +	struct rpmsg_clk_res *clkres = res;
> +
> +	return !strcmp(__clk_get_name(clkres->clk), data);
> +}
> +
> +static struct rpmsg_clk_res *
> +rpmsg_clk_get_res(struct rpmsg_device *rpdev, const char *name)
> +{
> +	struct rpmsg_clk_res *clkres;
> +	struct clk *clk;
> +
> +	clkres = devres_find(&rpdev->dev, rpmsg_clk_release,
> +			     rpmsg_clk_match, (void *)name);
> +	if (clkres)
> +		return clkres;
> +
> +	clkres = devres_alloc(rpmsg_clk_release, sizeof(*clkres), GFP_KERNEL);
> +	if (!clkres)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clk = clk_get(&rpdev->dev, name);
> +	if (IS_ERR(clk)) {
> +		devres_free(clkres);
> +		return ERR_CAST(clk);
> +	}
> +
> +	clkres->clk = clk;
> +	devres_add(&rpdev->dev, clkres);
> +
> +	return clkres;
> +}
> +
> +static int rpmsg_clk_enable_handler(struct rpmsg_device *rpdev,
> +				    void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_enable *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres)) {
> +		msg->header.result = clk_prepare_enable(clkres->clk);
> +		if (msg->header.result >= 0)
> +			atomic_inc(&clkres->count);
> +	} else {
> +		msg->header.result = PTR_ERR(clkres);
> +	}
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static int rpmsg_clk_disable_handler(struct rpmsg_device *rpdev,
> +				     void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_disable *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres)) {
> +		msg->header.result = 0;
> +		if (atomic_dec_return(&clkres->count) >= 0)
> +			clk_disable_unprepare(clkres->clk);
> +		else
> +			atomic_inc(&clkres->count);
> +	} else {
> +		msg->header.result = PTR_ERR(clkres);
> +	}
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static int rpmsg_clk_getrate_handler(struct rpmsg_device *rpdev,
> +				     void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_getrate *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres))
> +		msg->header.result = clk_get_rate(clkres->clk);
> +	else
> +		msg->header.result = PTR_ERR(clkres);
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static int rpmsg_clk_roundrate_handler(struct rpmsg_device *rpdev,
> +				       void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_roundrate *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres))
> +		msg->header.result = clk_round_rate(clkres->clk, msg->rate);
> +	else
> +		msg->header.result = PTR_ERR(clkres);
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static int rpmsg_clk_setrate_handler(struct rpmsg_device *rpdev,
> +				     void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_setrate *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres))
> +		msg->header.result = clk_set_rate(clkres->clk, msg->rate);
> +	else
> +		msg->header.result = PTR_ERR(clkres);
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static int rpmsg_clk_setphase_handler(struct rpmsg_device *rpdev,
> +				      void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_setphase *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres))
> +		msg->header.result = clk_set_phase(clkres->clk, msg->degrees);
> +	else
> +		msg->header.result = PTR_ERR(clkres);
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static int rpmsg_clk_getphase_handler(struct rpmsg_device *rpdev,
> +				      void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_getphase *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres))
> +		msg->header.result = clk_get_phase(clkres->clk);
> +	else
> +		msg->header.result = PTR_ERR(clkres);
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static int rpmsg_clk_isenabled_handler(struct rpmsg_device *rpdev,
> +				       void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_isenabled *msg = data;
> +	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
> +
> +	if (!IS_ERR(clkres))
> +		msg->header.result = __clk_is_enabled(clkres->clk);
> +	else
> +		msg->header.result = PTR_ERR(clkres);
> +
> +	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
> +}
> +
> +static const rpmsg_rx_cb_t rpmsg_clk_handler[] = {
> +	[RPMSG_CLK_ENABLE]    = rpmsg_clk_enable_handler,
> +	[RPMSG_CLK_DISABLE]   = rpmsg_clk_disable_handler,
> +	[RPMSG_CLK_SETRATE]   = rpmsg_clk_setrate_handler,
> +	[RPMSG_CLK_SETPHASE]  = rpmsg_clk_setphase_handler,
> +	[RPMSG_CLK_GETPHASE]  = rpmsg_clk_getphase_handler,
> +	[RPMSG_CLK_GETRATE]   = rpmsg_clk_getrate_handler,
> +	[RPMSG_CLK_ROUNDRATE] = rpmsg_clk_roundrate_handler,
> +	[RPMSG_CLK_ISENABLED] = rpmsg_clk_isenabled_handler,
> +};
> +
> +static int rpmsg_clk_callback(struct rpmsg_device *rpdev,
> +			      void *data, int len, void *priv, u32 src)
> +{
> +	struct rpmsg_clk_header *hdr = data;
> +	u32 cmd = hdr->command;
> +	int ret = -EINVAL;
> +
> +	if (cmd < ARRAY_SIZE(rpmsg_clk_handler)) {
> +		hdr->response = 1;
> +		ret = rpmsg_clk_handler[cmd](rpdev, data, len, priv, src);
> +	} else {
> +		dev_err(&rpdev->dev, "invalid command %u\n", cmd);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rpmsg_clk_probe(struct rpmsg_device *rpdev)
> +{
> +	return 0;
> +}
> +
> +static void rpmsg_clk_remove(struct rpmsg_device *rpdev)
> +{
> +}
> +
> +static const struct rpmsg_device_id rpmsg_clk_id_table[] = {
> +	{ .name = "rpmsg-clk" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_clk_id_table);
> +
> +static struct rpmsg_driver rpmsg_clk_driver = {
> +	.drv = {
> +		.name	= "rpmsg_clk",
> +		.owner	= THIS_MODULE,
> +	},
> +
> +	.id_table	= rpmsg_clk_id_table,
> +	.probe		= rpmsg_clk_probe,
> +	.callback	= rpmsg_clk_callback,
> +	.remove		= rpmsg_clk_remove,
> +};
> +
> +module_rpmsg_driver(rpmsg_clk_driver);
> +
> +MODULE_ALIAS("rpmsg:rpmsg_clk");
> +MODULE_AUTHOR("Yanlin Zhu <zhuyanlin@xiaomi.com>");
> +MODULE_DESCRIPTION("rpmsg clock API redirection driver");
> +MODULE_LICENSE("GPL v2");
> 

This is similar to the resource manager we proposed several months ago.
we proposed a generic solution for the clock but also the other
resources managed by Linux for the remote processor (regulators, GPIO,...)

Please have a look here
patch:
https://patchwork.kernel.org/project/linux-remoteproc/list/?submitter=92421
overview document:
http://openamp.github.io/docs/mca/remoteproc-resource-manager-overview.pdf


Regards
Arnaud
