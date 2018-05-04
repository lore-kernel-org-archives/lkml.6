Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525455957; cv=none;
        d=google.com; s=arc-20160816;
        b=UJyQs3/K039kIiD+CQD/m3E6nmpwDkVtedKZmio+VWbYQsTz5TH0KlQlUDQDLRbEWB
         m0qFRbXKy9AtfSPFVaAsg+t10559nkyphWc+67PsR0OR/vwUo99OjvKnpfohvqu0Ln+A
         sZGhIMDlL4u00afdl4Mt7EduUn3THsmk6leEzcFzu2KWu6Oha+Q44+rPqkpApFkohPYc
         qVb7AMH8TOg2Tq/mrn5UlRmHd43IZEmmO8JrRMsv3RMwPlK02WfnadQw+jUg0i4bRlxL
         uKed7kRxSaPlTQjuEo0hvV4JzqIb8q1PbzYDhH60nNJRIReM2oF8Rxf8BzhDXk9b0LHs
         8UWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=S0ehx2BqhWMEyXgpw34Rs+VBSEXLMFywfqmRjlI3oyw=;
        b=X+4EIEAmR3vZB1NFuc3j+mooSqk0pz8VCb1v6JkDDiNhWIwfy6UjJpPWN5T696Q8BC
         +IlpFkw3Z2BFqn2VxsgZc58psk8tpUhN1WZjlmg1lrGCSIJ2axXmcj/x9F6N+uH98fwW
         axRULiYG9PX8rs+ilqv7fNXniFbr4r1+jkIgxWphrURF8GW8Sn9SaEpAJtvZ3zh9DVQL
         sPe1yw6To8aas+HyS3zoZUyq1pOdTAKB7lPHEBSWAT6NZ1teu5jAvErt7JBEuEpLOElZ
         EraV37CiBT7iO+g/ulacD5bo5PwvszVe6rJEk8d5W9eSZxlJcmr3VAZLUxjsyRFUIJL2
         IXeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PNwgIQL9;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PNwgIQL9;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoHfj49BQH0Zkvwa/qc09qa3BkfJ191bs4BpMqPU5T9H8XzHq/0/BJkYr/kRLzluLGgV1ba/g==
Date: Fri, 4 May 2018 10:45:53 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: andy.gross@linaro.org, broonie@kernel.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	robh+dt@kernel.org, bgoswami@codeaurora.org,
	gregkh@linuxfoundation.org, david.brown@linaro.org,
	mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org,
	tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v7 02/24] soc: qcom: Add APR bus driver
Message-ID: <20180504174553.GT18510@minitux>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501120820.11016-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263608472013493?=
X-GMAIL-MSGID: =?utf-8?q?1599556505921981978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 01 May 05:07 PDT 2018, Srinivas Kandagatla wrote:

> This patch adds support to APR bus (Asynchronous Packet Router) driver.
> APR driver is made as a bus driver so that the apr devices can added removed
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> Acked-by: Andy Gross <andy.gross@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/Kconfig        |   9 +
>  drivers/soc/qcom/Makefile       |   1 +
>  drivers/soc/qcom/apr.c          | 378 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mod_devicetable.h |  11 ++
>  include/linux/soc/qcom/apr.h    | 128 ++++++++++++++
>  5 files changed, 527 insertions(+)
>  create mode 100644 drivers/soc/qcom/apr.c
>  create mode 100644 include/linux/soc/qcom/apr.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 5c4535b545cc..d053f2634c67 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -108,4 +108,13 @@ config QCOM_WCNSS_CTRL
>  	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
>  	  firmware to a newly booted WCNSS chip.
>  
> +config QCOM_APR
> +	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
> +	depends on ARCH_QCOM
> +	depends on RPMSG
> +	help
> +          Enable APR IPC protocol support between
> +          application processor and QDSP6. APR is
> +          used by audio driver to configure QDSP6
> +          ASM, ADM and AFE modules.
>  endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index dcebf2814e6d..39de5dee55d9 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>  obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>  obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
> +obj-$(CONFIG_QCOM_APR) += apr.o
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> new file mode 100644
> index 000000000000..97f3622da535
> --- /dev/null
> +++ b/drivers/soc/qcom/apr.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/spinlock.h>
> +#include <linux/idr.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/soc/qcom/apr.h>
> +#include <linux/rpmsg.h>
> +#include <linux/of.h>
> +
> +struct apr {
> +	struct rpmsg_endpoint *ch;
> +	struct device *dev;
> +	spinlock_t svcs_lock;
> +	struct idr svcs_idr;
> +	int dest_domain_id;
> +};
> +
> +/**
> + * apr_send_pkt() - Send a apr message from apr device
> + *
> + * @adev: Pointer to previously registered apr device.
> + * @pkt: Pointer to apr packet to send
> + *
> + * Return: Will be an negative on packet size on success.
> + */
> +int apr_send_pkt(struct apr_device *adev, struct apr_pkt *pkt)
> +{
> +	struct apr *apr = dev_get_drvdata(adev->dev.parent);
> +	struct apr_hdr *hdr;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&adev->lock, flags);
> +
> +	hdr = &pkt->hdr;
> +	hdr->src_domain = APR_DOMAIN_APPS;
> +	hdr->src_svc = adev->svc_id;
> +	hdr->dest_domain = adev->domain_id;
> +	hdr->dest_svc = adev->svc_id;
> +
> +	ret = rpmsg_trysend(apr->ch, pkt, hdr->pkt_size);
> +	spin_unlock_irqrestore(&adev->lock, flags);
> +
> +	return ret ? ret : hdr->pkt_size;
> +}
> +EXPORT_SYMBOL_GPL(apr_send_pkt);
> +
> +static void apr_dev_release(struct device *dev)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +
> +	kfree(adev);
> +}
> +
> +static int apr_callback(struct rpmsg_device *rpdev, void *buf,
> +				  int len, void *priv, u32 addr)
> +{
> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
> +	uint16_t hdr_size, msg_type, ver, svc_id;
> +	struct apr_device *svc = NULL;
> +	struct apr_driver *adrv = NULL;
> +	struct apr_resp_pkt resp;
> +	struct apr_hdr *hdr;
> +	unsigned long flags;
> +
> +	if (len <= APR_HDR_SIZE) {
> +		dev_err(apr->dev, "APR: Improper apr pkt received:%p %d\n",
> +			buf, len);
> +		return -EINVAL;
> +	}
> +
> +	hdr = buf;
> +	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
> +	if (ver > APR_PKT_VER + 1)
> +		return -EINVAL;
> +
> +	hdr_size = APR_HDR_FIELD_SIZE_BYTES(hdr->hdr_field);
> +	if (hdr_size < APR_HDR_SIZE) {
> +		dev_err(apr->dev, "APR: Wrong hdr size:%d\n", hdr_size);
> +		return -EINVAL;
> +	}
> +
> +	if (hdr->pkt_size < APR_HDR_SIZE || hdr->pkt_size != len) {
> +		dev_err(apr->dev, "APR: Wrong paket size\n");
> +		return -EINVAL;
> +	}
> +
> +	msg_type = APR_HDR_FIELD_MT(hdr->hdr_field);
> +	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
> +		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
> +		return -EINVAL;
> +	}
> +
> +	if (hdr->src_domain >= APR_DOMAIN_MAX ||
> +			hdr->dest_domain >= APR_DOMAIN_MAX ||
> +			hdr->src_svc >= APR_SVC_MAX ||
> +			hdr->dest_svc >= APR_SVC_MAX) {
> +		dev_err(apr->dev, "APR: Wrong APR header\n");
> +		return -EINVAL;
> +	}
> +
> +	svc_id = hdr->dest_svc;
> +	spin_lock_irqsave(&apr->svcs_lock, flags);
> +	svc = idr_find(&apr->svcs_idr, svc_id);
> +	if (svc && svc->dev.driver)
> +		adrv = to_apr_driver(svc->dev.driver);
> +	spin_unlock_irqrestore(&apr->svcs_lock, flags);
> +
> +	if (!adrv) {
> +		dev_err(apr->dev, "APR: service is not registered\n");
> +		return -EINVAL;
> +	}
> +
> +	resp.hdr = *hdr;
> +	resp.payload_size = hdr->pkt_size - hdr_size;
> +
> +	/*
> +	 * NOTE: hdr_size is not same as APR_HDR_SIZE as remote can include
> +	 * optional headers in to apr_hdr which should be ignored
> +	 */
> +	if (resp.payload_size > 0)
> +		resp.payload = buf + hdr_size;
> +
> +	adrv->callback(svc, &resp);
> +
> +	return 0;
> +}
> +
> +static int apr_device_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +	struct apr_driver *adrv = to_apr_driver(drv);
> +	const struct apr_device_id *id = adrv->id_table;
> +
> +	/* Attempt an OF style match first */
> +	if (of_driver_match_device(dev, drv))
> +		return 1;
> +
> +	if (!id)
> +		return 0;
> +
> +	while (id->domain_id != 0 || id->svc_id != 0) {
> +		if (id->domain_id == adev->domain_id &&
> +		    id->svc_id == adev->svc_id)
> +			return 1;
> +		id++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int apr_device_probe(struct device *dev)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +	struct apr_driver *adrv = to_apr_driver(dev->driver);
> +
> +	return adrv->probe(adev);
> +}
> +
> +static int apr_device_remove(struct device *dev)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +	struct apr_driver *adrv;
> +	struct apr *apr = dev_get_drvdata(adev->dev.parent);
> +
> +	if (dev->driver) {
> +		adrv = to_apr_driver(dev->driver);
> +		if (adrv->remove)
> +			adrv->remove(adev);
> +		spin_lock(&apr->svcs_lock);
> +		idr_remove(&apr->svcs_idr, adev->svc_id);
> +		spin_unlock(&apr->svcs_lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int apr_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +	int ret;
> +
> +	ret = of_device_uevent_modalias(dev, env);
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	return add_uevent_var(env, "MODALIAS=apr:%s", adev->name);
> +}
> +
> +struct bus_type aprbus = {
> +	.name		= "aprbus",
> +	.match		= apr_device_match,
> +	.probe		= apr_device_probe,
> +	.uevent		= apr_uevent,
> +	.remove		= apr_device_remove,
> +};
> +EXPORT_SYMBOL_GPL(aprbus);
> +
> +static int apr_add_device(struct device *dev, struct device_node *np,
> +			  const struct apr_device_id *id)
> +{
> +	struct apr *apr = dev_get_drvdata(dev);
> +	struct apr_device *adev = NULL;
> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&adev->lock);
> +
> +	adev->svc_id = id->svc_id;
> +	adev->domain_id = id->domain_id;
> +	adev->version = id->svc_version;
> +	if (np)
> +		strncpy(adev->name, np->name, APR_NAME_SIZE);
> +	else
> +		strncpy(adev->name, id->name, APR_NAME_SIZE);
> +
> +	dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", adev->name,
> +		     id->domain_id, id->svc_id);
> +
> +	adev->dev.bus = &aprbus;
> +	adev->dev.parent = dev;
> +	adev->dev.of_node = np;
> +	adev->dev.release = apr_dev_release;
> +	adev->dev.driver = NULL;
> +
> +	spin_lock(&apr->svcs_lock);
> +	idr_alloc(&apr->svcs_idr, adev, id->svc_id,
> +		  id->svc_id + 1, GFP_ATOMIC);
> +	spin_unlock(&apr->svcs_lock);
> +
> +	dev_info(dev, "Adding APR dev: %s\n", dev_name(&adev->dev));
> +
> +	ret = device_register(&adev->dev);
> +	if (ret) {
> +		dev_err(dev, "device_register failed: %d\n", ret);
> +		put_device(&adev->dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static void of_register_apr_devices(struct device *dev)
> +{
> +	struct apr *apr = dev_get_drvdata(dev);
> +	struct device_node *node;
> +
> +	for_each_child_of_node(dev->of_node, node) {
> +		struct apr_device_id id = { {0} };
> +
> +		if (of_property_read_u32(node, "reg", &id.svc_id))
> +			continue;
> +
> +		id.domain_id = apr->dest_domain_id;
> +
> +		if (apr_add_device(dev, node, &id))
> +			dev_err(dev, "Failed to add apr %d svc\n", id.svc_id);
> +	}
> +}
> +
> +static int apr_probe(struct rpmsg_device *rpdev)
> +{
> +	struct device *dev = &rpdev->dev;
> +	struct apr *apr;
> +	int ret;
> +
> +	apr = devm_kzalloc(dev, sizeof(*apr), GFP_KERNEL);
> +	if (!apr)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32(dev->of_node, "reg", &apr->dest_domain_id);
> +	if (ret) {
> +		dev_err(dev, "APR Domain ID not specified in DT\n");
> +		return ret;
> +	}
> +
> +	dev_set_drvdata(dev, apr);
> +	apr->ch = rpdev->ept;
> +	apr->dev = dev;
> +	spin_lock_init(&apr->svcs_lock);
> +	idr_init(&apr->svcs_idr);
> +	of_register_apr_devices(dev);
> +
> +	return 0;
> +}
> +
> +static int apr_remove_device(struct device *dev, void *null)
> +{
> +	struct apr_device *adev = to_apr_device(dev);
> +
> +	device_unregister(&adev->dev);
> +
> +	return 0;
> +}
> +
> +static void apr_remove(struct rpmsg_device *rpdev)
> +{
> +	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
> +}
> +
> +/*
> + * __apr_driver_register() - Client driver registration with aprbus
> + *
> + * @drv:Client driver to be associated with client-device.
> + * @owner: owning module/driver
> + *
> + * This API will register the client driver with the aprbus
> + * It is called from the driver's module-init function.
> + */
> +int __apr_driver_register(struct apr_driver *drv, struct module *owner)
> +{
> +	drv->driver.bus = &aprbus;
> +	drv->driver.owner = owner;
> +
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(__apr_driver_register);
> +
> +/*
> + * apr_driver_unregister() - Undo effect of apr_driver_register
> + *
> + * @drv: Client driver to be unregistered
> + */
> +void apr_driver_unregister(struct apr_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(apr_driver_unregister);
> +
> +static const struct of_device_id apr_of_match[] = {
> +	{ .compatible = "qcom,apr"},
> +	{ .compatible = "qcom,apr-v2"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, apr_of_match);
> +
> +static struct rpmsg_driver apr_driver = {
> +	.probe = apr_probe,
> +	.remove = apr_remove,
> +	.callback = apr_callback,
> +	.drv = {
> +		.name = "qcom,apr",
> +		.of_match_table = apr_of_match,
> +	},
> +};
> +
> +static int __init apr_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&aprbus);
> +	if (!ret)
> +		ret = register_rpmsg_driver(&apr_driver);
> +	else
> +		bus_unregister(&aprbus);
> +
> +	return ret;
> +}
> +
> +static void __exit apr_exit(void)
> +{
> +	bus_unregister(&aprbus);
> +	unregister_rpmsg_driver(&apr_driver);
> +}
> +
> +subsys_initcall(apr_init);
> +module_exit(apr_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Qualcomm APR Bus");
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 7d361be2e24f..2014bd19f28e 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -471,6 +471,17 @@ struct slim_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +#define APR_NAME_SIZE	32
> +#define APR_MODULE_PREFIX "apr:"
> +
> +struct apr_device_id {
> +	char name[APR_NAME_SIZE];
> +	__u32 domain_id;
> +	__u32 svc_id;
> +	__u32 svc_version;
> +	kernel_ulong_t driver_data;	/* Data private to the driver */
> +};
> +
>  #define SPMI_NAME_SIZE	32
>  #define SPMI_MODULE_PREFIX "spmi:"
>  
> diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
> new file mode 100644
> index 000000000000..c5d52e2cb275
> --- /dev/null
> +++ b/include/linux/soc/qcom/apr.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __QCOM_APR_H_
> +#define __QCOM_APR_H_
> +
> +#include <linux/spinlock.h>
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <dt-bindings/soc/qcom,apr.h>
> +
> +extern struct bus_type aprbus;
> +
> +#define APR_HDR_LEN(hdr_len) ((hdr_len)/4)
> +
> +/*
> + * HEADER field
> + * version:0:3
> + * header_size : 4:7
> + * message_type : 8:9
> + * reserved: 10:15
> + */
> +#define APR_HDR_FIELD(msg_type, hdr_len, ver)\
> +	(((msg_type & 0x3) << 8) | ((hdr_len & 0xF) << 4) | (ver & 0xF))
> +
> +#define APR_HDR_SIZE sizeof(struct apr_hdr)
> +#define APR_SEQ_CMD_HDR_FIELD APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD, \
> +					    APR_HDR_LEN(APR_HDR_SIZE), \
> +					    APR_PKT_VER)
> +/* Version */
> +#define APR_PKT_VER		0x0
> +
> +/* Command and Response Types */
> +#define APR_MSG_TYPE_EVENT	0x0
> +#define APR_MSG_TYPE_CMD_RSP	0x1
> +#define APR_MSG_TYPE_SEQ_CMD	0x2
> +#define APR_MSG_TYPE_NSEQ_CMD	0x3
> +#define APR_MSG_TYPE_MAX	0x04
> +
> +/* APR Basic Response Message */
> +#define APR_BASIC_RSP_RESULT 0x000110E8
> +#define APR_RSP_ACCEPTED     0x000100BE
> +
> +struct aprv2_ibasic_rsp_result_t {
> +	uint32_t opcode;
> +	uint32_t status;
> +};
> +
> +/* hdr field Ver [0:3], Size [4:7], Message type [8:10] */
> +#define APR_HDR_FIELD_VER(h)		(h & 0x000F)
> +#define APR_HDR_FIELD_SIZE(h)		((h & 0x00F0) >> 4)
> +#define APR_HDR_FIELD_SIZE_BYTES(h)	(((h & 0x00F0) >> 4) * 4)
> +#define APR_HDR_FIELD_MT(h)		((h & 0x0300) >> 8)
> +
> +struct apr_hdr {
> +	uint16_t hdr_field;
> +	uint16_t pkt_size;
> +	uint8_t src_svc;
> +	uint8_t src_domain;
> +	uint16_t src_port;
> +	uint8_t dest_svc;
> +	uint8_t dest_domain;
> +	uint16_t dest_port;
> +	uint32_t token;
> +	uint32_t opcode;
> +} __packed;
> +
> +struct apr_pkt {
> +	struct apr_hdr hdr;
> +	uint8_t payload[];
> +};
> +
> +struct apr_resp_pkt {
> +	struct apr_hdr hdr;
> +	void *payload;
> +	int payload_size;
> +};
> +
> +/* Bits 0 to 15 -- Minor version,  Bits 16 to 31 -- Major version */
> +#define APR_SVC_MAJOR_VERSION(v)	((v >> 16) & 0xFF)
> +#define APR_SVC_MINOR_VERSION(v)	(v & 0xFF)
> +
> +struct apr_device {
> +	struct device	dev;
> +	uint16_t	svc_id;
> +	uint16_t	domain_id;
> +	uint32_t	version;
> +	char name[APR_NAME_SIZE];
> +	spinlock_t	lock;
> +	struct list_head node;
> +};
> +
> +#define to_apr_device(d) container_of(d, struct apr_device, dev)
> +
> +struct apr_driver {
> +	int	(*probe)(struct apr_device *sl);
> +	int	(*remove)(struct apr_device *sl);
> +	int	(*callback)(struct apr_device *a,
> +			    struct apr_resp_pkt *d);
> +	struct device_driver		driver;
> +	const struct apr_device_id	*id_table;
> +};
> +
> +#define to_apr_driver(d) container_of(d, struct apr_driver, driver)
> +
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE
> + */
> +#define apr_driver_register(drv) __apr_driver_register(drv, THIS_MODULE)
> +
> +int __apr_driver_register(struct apr_driver *drv, struct module *owner);
> +void apr_driver_unregister(struct apr_driver *drv);
> +
> +/**
> + * module_apr_driver() - Helper macro for registering a aprbus driver
> + * @__aprbus_driver: aprbus_driver struct
> + *
> + * Helper macro for aprbus drivers which do not do anything special in
> + * module init/exit. This eliminates a lot of boilerplate. Each module
> + * may only use this macro once, and calling it replaces module_init()
> + * and module_exit()
> + */
> +#define module_apr_driver(__apr_driver) \
> +	module_driver(__apr_driver, apr_driver_register, \
> +			apr_driver_unregister)
> +
> +int apr_send_pkt(struct apr_device *adev, struct apr_pkt *pkt);
> +
> +#endif /* __QCOM_APR_H_ */
> -- 
> 2.16.2
> 
