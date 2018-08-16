Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA62C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B710F2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aqDRe11p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B710F2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbeHPQ1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:27:53 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:37729
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727244AbeHPQ1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpFjr9h2RCh3sRYPMnbZ0AZwlbqSrYAGkyq4JB6HOOU=;
 b=aqDRe11pVsezvo65zJDzuEn8zrDOyIV7Sqh6orwovZsZabaoKJFjF55rSfDOmZ8813OGtZ4ZVe5NXvBsUuy6iBEMmymLBbNZQHzYwl4y8jt6GXeaEhSBF+iEnKp8KI0vK6ZHrH9sdYK2rRvhnrXIKsnxFSEM7jXuEGmQQ/Yk654=
Received: from CY4PR0201MB3619.namprd02.prod.outlook.com (52.132.99.26) by
 CY4PR0201MB3395.namprd02.prod.outlook.com (52.132.98.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Thu, 16 Aug 2018 13:29:12 +0000
Received: from CY4PR0201MB3619.namprd02.prod.outlook.com
 ([fe80::89f3:8315:e747:d23a]) by CY4PR0201MB3619.namprd02.prod.outlook.com
 ([fe80::89f3:8315:e747:d23a%3]) with mapi id 15.20.1038.025; Thu, 16 Aug 2018
 13:29:12 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [RFC] dmaengine: Add metadata_ops for dma_async_tx_descriptor
Thread-Topic: [RFC] dmaengine: Add metadata_ops for dma_async_tx_descriptor
Thread-Index: AQHUNIa/aLzeL9Zb/0iQNP+9dl8PvKTCWczQ
Date:   Thu, 16 Aug 2018 13:29:12 +0000
Message-ID: <CY4PR0201MB36192D111C6EE8AC4E86C173C73E0@CY4PR0201MB3619.namprd02.prod.outlook.com>
References: <20180815105704.26498-1-peter.ujfalusi@ti.com>
In-Reply-To: <20180815105704.26498-1-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0201MB3395;6:hxUnPdozFd71Qedib/kDLxCCDpSUY0o8WrsjzdR9R6QMtJTMMDSOl8LjnBm3t4pptY1HA+6gbwyGBtBYDKAQBe4fLr6A9cSSLaSq+bpCm1ngNsM42K7tspamipZHZW83fDC59Gt5HwysNoy5gB/ZzN6O0lM7psXphrHzczFA0l8ss5VykK20DfA7uNSuOb2ywXKxJSU/oyA0oU56oExaMc3J2p7ZOtvg3CYSOAbFn/4JXkxqmtvru+aQYzewXu6OKB5zmLnC6Rc5dK1uSn8S8RRnR4YF0846tB0lAbvIYGqdjBLhBF5c6rt2XH/uNRL1tgI1h0flMFZI5fY9cmr0msBxSxM2Ef1wBP0M8xjQMRu47GnP/R515mXd9h8E/HqT+5bInu/mXdBOwMblzZUYo4UHOWecZ4n0BNdiCTCet8EaWQS57w1Y5MuVLrKZ73K+dN8lBCOqweudnHYp3bhlSQ==;5:q8Wnp03N8YG9bZ8sUxbMSbt5cppQj8oNojZXomitYPdgu5yo540ni4p699vjaTVzK478Z/QvhiqjKI5SSgDofWx3iL+IuftkQ7QBrZ6rIhVbJAvhlXgnvjLmVvwtiSnDdIjdHNVF+o6UTKTeXZAYkBj97zSeQfQTCu18iMBRPfY=;7:p06/DEEtsXjoQi73lM3WE9BXmtsXDUJsjLgAIBClgzrT1OkrDomeL3cVx9DV6IYiywd7NsS+6s2I80KG1qtPDsTbvqk5NbUTLQHhvAolDhy4kYhdtYq1hx1rNY9sYfvtJF1vwMjVHIBbJjfWHYjHixtgPuXU+0aNzHNYQc33yz0tvYbhNEFB79qE+da6soqnExP/llRJhCFXBoJH8yJoX2IfZLMF6OrwXUz8MtyeMWNYRHezHFHmcuXWWVD95ptF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aa093fd1-c00f-4b8c-6f74-08d6037c4104
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR0201MB3395;
x-ms-traffictypediagnostic: CY4PR0201MB3395:
x-microsoft-antispam-prvs: <CY4PR0201MB33950ED86BC294FB3DD2CE90C73E0@CY4PR0201MB3395.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY4PR0201MB3395;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3395;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(366004)(76094002)(13464003)(189003)(199004)(106356001)(2906002)(55016002)(5660300001)(9686003)(305945005)(229853002)(86362001)(2201001)(105586002)(8676002)(6436002)(81166006)(7736002)(14454004)(74316002)(97736004)(81156014)(53936002)(6116002)(3846002)(478600001)(2501003)(33656002)(551934003)(5250100002)(5024004)(6246003)(6506007)(2900100001)(8936002)(102836004)(186003)(99286004)(110136005)(316002)(26005)(54906003)(4326008)(486006)(66066001)(256004)(25786009)(76176011)(476003)(7696005)(68736007)(446003)(11346002)(53546011)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3395;H:CY4PR0201MB3619.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mSAKzltuWvz0CesM0l5OUybfZepBYnv8E9JJZtCFHWJZeBIhlWauO664eGA5rhlutRwdEsn6tLas12Ks5XG89GhcKyCgwaVIBr1IRPe0bTefkEc7FYlOq6etjbQT7ogI0RJIZrhOp/zIebbprmmsGsOIxtUHAK5wlMTfJ2e07nvucBvAm7k8B7hVNsO+1HmsUcPALVOvfK2VnfmaYrl6YBi6RrM8YNwdXVKwv4kj84RHSrmML4W/Ibx0UqpRLEj7OS7pKeqq3UQPE73AT/5yISC9S9fXJPLL6kow4GrVbzPYV3/QFZh8zCLD510UQ1k1lu29CWjwa4w7pDBWsh3f0WrA/G+rXxpefwsQNt6+rb8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa093fd1-c00f-4b8c-6f74-08d6037c4104
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 13:29:12.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Sent: Wednesday, August 15, 2018 4:27 PM
> To: dan.j.williams@intel.com; vkoul@kernel.org
> Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
> lars@metafoo.de; Radhey Shyam Pandey <radheys@xilinx.com>
> Subject: [RFC] dmaengine: Add metadata_ops for dma_async_tx_descriptor
>=20
> The metadata is best described as side band data or parameters traveling
> alongside the data DMAd by the DMA engine. It is data
> which is understood by the peripheral and the peripheral driver only, the
> DMA engine see it only as data block and it is not interpreting it in any
> way.
>=20
> The metadata can be different per descriptor as it is a parameter for the
> data being transferred.
>=20
> If the DMA supports per descriptor metadata it can implement the attach,
> get_ptr/set_len callbacks.
>=20
> Client drivers must only use either attach or get_ptr/set_len to avoid
> miss configuration.
>=20
> Client driver can check if a given metadata mode is supported by the
> channel during probe time with
> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_CLIENT);
> dmaengine_is_metadata_mode_supported(chan,
> DESC_METADATA_EMBEDDED);
>=20
> and based on this information can use either mode.
>=20
> Wrappers are also added for the metadata_ops.
>=20
> To be used in DESC_METADATA_CLIENT mode:
> dmaengine_desc_attach_metadata()
>=20
> To be used in DESC_METADATA_EMBEDDED mode:
> dmaengine_desc_get_metadata_ptr()
> dmaengine_desc_set_metadata_len()
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  include/linux/dmaengine.h | 112
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>=20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 3db833a8c542..2200f8985adf 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -231,6 +231,25 @@ typedef struct { DECLARE_BITMAP(bits,
> DMA_TX_TYPE_END); } dma_cap_mask_t;
>   * @bytes_transferred: byte counter
>   */
>=20
> +/**
> + * enum dma_desc_metadata_mode - per descriptor metadata mode types
> supported
> + * @DESC_METADATA_CLIENT - the metadata buffer is allocated/provided by
> the
> + *  client driver and it is attached (via the dmaengine_desc_attach_meta=
data()
> + *  helper) to the descriptor.
> + * @DESC_METADATA_EMBEDDED - the metadata buffer is
> allocated/managed by the DMA
Just a thought - We can rename it to DESC_METADATA_ENGINE?=20
i.e metadata allocation place - >  dma client/engine.

> + *  driver. The client driver can ask for the pointer, maximum size and =
the
> + *  currently used size of the metadata and can directly updata or read =
it.
/s/updata/update

> + *  dmaengine_desc_get_metadata_ptr() and
> dmaengine_desc_set_metadata_len() is
> + *  provided as helper functions.
It will be helpful if we add description for both DESC_METADATA_EMBEDDED=20
modes i.e DMA_DEV_TO_MEM and MEM_TO_DEV types. I think in DEV_TO_MEM
we don't need to set_metadata_len(). Length will provided by DMA engine.

> + *
> + * Note: the two mode is not compatible and clients must use one mode fo=
r a
> + * descriptor.
> + */
> +enum dma_desc_metadata_mode {
> +	DESC_METADATA_CLIENT =3D (1 << 0),
> +	DESC_METADATA_EMBEDDED =3D (1 << 1),
> +};
> +
>  struct dma_chan_percpu {
>  	/* stats */
>  	unsigned long memcpy_count;
> @@ -494,6 +513,18 @@ struct dmaengine_unmap_data {
>  	dma_addr_t addr[0];
>  };
>=20
> +struct dma_async_tx_descriptor;
> +
> +struct dma_descriptor_metadata_ops {
> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
> +		      size_t len);
> +
> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
> +			 size_t *payload_len, size_t *max_len);
> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
> +		       size_t payload_len);
> +};
> +
>  /**
>   * struct dma_async_tx_descriptor - async transaction descriptor
>   * ---dma generic offload fields---
> @@ -523,6 +554,8 @@ struct dma_async_tx_descriptor {
>  	dma_async_tx_callback_result callback_result;
>  	void *callback_param;
>  	struct dmaengine_unmap_data *unmap;
> +	enum dma_desc_metadata_mode desc_metadata_mode;
> +	struct dma_descriptor_metadata_ops *metadata_ops;
>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>  	struct dma_async_tx_descriptor *next;
>  	struct dma_async_tx_descriptor *parent;
> @@ -685,6 +718,7 @@ struct dma_filter {
>   * @global_node: list_head for global dma_device_list
>   * @filter: information for device/slave to filter function/param mappin=
g
>   * @cap_mask: one or more dma_capability flags
> + * @desc_metadata_modes: supported metadata modes by the DMA device
>   * @max_xor: maximum number of xor sources, 0 if no capability
>   * @max_pq: maximum number of PQ sources and PQ-continue capability
>   * @copy_align: alignment shift for memcpy operations
> @@ -749,6 +783,7 @@ struct dma_device {
>  	struct list_head global_node;
>  	struct dma_filter filter;
>  	dma_cap_mask_t  cap_mask;
> +	enum dma_desc_metadata_mode desc_metadata_modes;
>  	unsigned short max_xor;
>  	unsigned short max_pq;
>  	enum dmaengine_alignment copy_align;
> @@ -935,6 +970,83 @@ static inline struct dma_async_tx_descriptor
> *dmaengine_prep_dma_memcpy(
>  						    len, flags);
>  }
>=20
> +static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan
> *chan,
> +		enum dma_desc_metadata_mode mode)
> +{
> +	return !!(chan->device->desc_metadata_modes & mode);
> +}
> +
> +static inline int _desc_check_and_set_metadata_mode(
> +	struct dma_async_tx_descriptor *desc, enum
> dma_desc_metadata_mode mode)
> +{
> +	/* Make sure that the metadata mode is not mixed */
> +	if (!desc->desc_metadata_mode) {
Minor nit - we can refactor this code to have failure path early.

> +		if (dmaengine_is_metadata_mode_supported(desc->chan,
> mode))
> +			desc->desc_metadata_mode =3D mode;
> +		else
> +			return -ENOTSUPP;
> +	} else if (desc->desc_metadata_mode !=3D mode) {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int dmaengine_desc_attach_metadata(
> +		struct dma_async_tx_descriptor *desc, void *data, size_t len)
> +{
> +	int ret;
> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	ret =3D _desc_check_and_set_metadata_mode(desc,
> DESC_METADATA_CLIENT);
> +	if (ret)
> +		return ret;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
> +		return -ENOTSUPP;
> +
> +	return desc->metadata_ops->attach(desc, data, len);
> +}
> +
> +static inline void *dmaengine_desc_get_metadata_ptr(
> +		struct dma_async_tx_descriptor *desc, size_t *payload_len,
> +		size_t *max_len)
> +{
> +	int ret;
> +
> +	if (!desc)
> +		return ERR_PTR(-EINVAL);
> +
> +	ret =3D _desc_check_and_set_metadata_mode(desc,
> DESC_METADATA_EMBEDDED);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->get_ptr)
> +		return ERR_PTR(-ENOTSUPP);
> +
> +	return desc->metadata_ops->get_ptr(desc, payload_len, max_len);
> +}
> +
> +static inline int dmaengine_desc_set_metadata_len(
> +		struct dma_async_tx_descriptor *desc, size_t payload_len)
> +{
> +	int ret;
> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	ret =3D _desc_check_and_set_metadata_mode(desc,
> DESC_METADATA_EMBEDDED);
> +	if (ret)
> +		return ret;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
> +		return -ENOTSUPP;
> +
> +	return desc->metadata_ops->set_len(desc, payload_len);
> +}
> +
>  /**
>   * dmaengine_terminate_all() - Terminate all active DMA transfers
>   * @chan: The channel for which to terminate the transfers
> --
> Peter
>=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

