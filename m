Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E679C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237BF255A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="D+lekMl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237BF255A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeGBHAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:00:12 -0400
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:8864
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752701AbeGBHAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBbhSXlbBlH7ZN3iGnObNOUbCXOPq8f+u8LhbzlY6mk=;
 b=D+lekMl2CEPHn6U3DnlBT4XCd+4BGvySp4+5fzDhcKrMsMkoCRjezxorbbfMV0/vhHjFC8HXW8FfSmuasPkUDHdWH6apOvUFBCgqO0Xr3h/zokQ8Rt50Uq8MLyvfRHDXFjm4PEhNBMjPv49Pc1VTF3iCbUAwGNwOvKV9qVKh9x0=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB5001.namprd02.prod.outlook.com (20.176.114.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Mon, 2 Jul 2018 07:00:00 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 06:59:58 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
Thread-Topic: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
Thread-Index: AQHT+ZKu2RUlGBSwykWWA6e1nxg386R7rnVg
Date:   Mon, 2 Jul 2018 06:59:58 +0000
Message-ID: <DM6PR02MB4361262830FF320B16B8486AC7430@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
In-Reply-To: <20180601102429.16429-1-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB5001;7:iPaoROdLKVcQB+lGlhw0CLceBcgGbazVTS2eGxHbK9CQXY6eBOGvZu53gTbmoJIjuIv4HYHgeOOd7EeD2nxKpU6IAr92u8UGdO0IY+6lnrhtbzDd+Qcm1TBomiUcq8Y92MjlVyuEOK2wJ5fr3RD6Z7ExPmTvqYu7urSI6Sa8CAYcTf8Jr/Mg0V6TiMj0cNidv3P6Bsbv3lPwHQE2xmrdZjTJZieaV3vB6M526unt8Z8o0G7EzyCu95tj3l7HYk1J
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(366004)(13464003)(51914003)(189003)(199004)(76176011)(14454004)(11346002)(476003)(7736002)(486006)(446003)(86362001)(81166006)(5250100002)(6116002)(66066001)(3846002)(81156014)(8676002)(2501003)(8936002)(55236004)(478600001)(55016002)(26005)(25786009)(53546011)(6506007)(33656002)(7696005)(186003)(102836004)(68736007)(9686003)(256004)(14444005)(6246003)(99286004)(5024004)(53936002)(316002)(551934003)(2900100001)(105586002)(4326008)(54906003)(106356001)(110136005)(97736004)(305945005)(74316002)(229853002)(5660300001)(6436002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5001;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 78e1f204-7889-4e7f-baf1-08d5dfe96c99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB5001;
x-ms-traffictypediagnostic: DM6PR02MB5001:
x-microsoft-antispam-prvs: <DM6PR02MB500171F9EB0F09C9410EADFAC7430@DM6PR02MB5001.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB5001;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5001;
x-forefront-prvs: 07215D0470
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J2E/liccphR41Z/+ogPSpTZY9CbvJMWJJq1WDzMub7LRbFdpgl6nw93wWnNrzipUfKv6RVt+4AqvKGSN5S2Kj+K1cEipwH1v5687pTw/H2JTJJ5cYRKtqr/CrtjQsoc9r2/9GeoFtAryq/EvD3fm5CTcTtPIq561KKzU8GSTVC0WA5h40iEtedvMRKu07zCzOyXCnVoPf2FmvzGyukhNVHWnmCr2LTPzQPm/p86YFsKN9PsiQNCqAJqABCCgJAhesjZM/Sp9ZPr477jYPnajjIvWnQlrgOIBby+jOj3QovRrEMZnZcTJnIJnQHxBDyyCYmnUB8PtrT12hfAe7QpfgsEbHx31LA0Fil2JAoLZ8Dc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e1f204-7889-4e7f-baf1-08d5dfe96c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 06:59:58.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@ti.com]
> Sent: Friday, June 1, 2018 3:54 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; vinod.koul@intel.com
> Cc: lars@metafoo.de; michal.simek@xilinx.com; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org;
> dan.j.williams@intel.com; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; linux-arm-kernel@lists.infradead.org
> Subject: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
>=20
> If the DMA supports per descriptor metadata it can implement the attach,
> get_ptr/set_len callbacks.
>=20
> Client drivers must only use either attach or get_ptr/set_len to avoid
> miss configuration.
>=20
> Wrappers are also added for the metadata_ops:
> dmaengine_desc_attach_metadata()
> dmaengine_desc_get_metadata_ptr()
> dmaengine_desc_set_metadata_len()
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
>=20
> since attachments are bouncing back, I send the patch separately
>=20
> Regards,
> Peter
>=20
>  include/linux/dmaengine.h | 50
> +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 51fbb861e84b..ac42ace36aa3 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -491,6 +491,18 @@ struct dmaengine_unmap_data {
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
> @@ -520,6 +532,7 @@ struct dma_async_tx_descriptor {
>  	dma_async_tx_callback_result callback_result;
>  	void *callback_param;
>  	struct dmaengine_unmap_data *unmap;
> +	struct dma_descriptor_metadata_ops *metadata_ops;
>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>  	struct dma_async_tx_descriptor *next;
>  	struct dma_async_tx_descriptor *parent;
> @@ -932,6 +945,43 @@ static inline struct dma_async_tx_descriptor
> *dmaengine_prep_dma_memcpy(
>  						    len, flags);
>  }
>=20
> +static inline int dmaengine_desc_attach_metadata(
> +		struct dma_async_tx_descriptor *desc, void *data, size_t
> len)
> +{
> +	if (!desc)
> +		return 0;
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
> +	if (!desc)
> +		return NULL;
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
> +	if (!desc)
> +		return 0;
> +
> +	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
> +		return -ENOTSUPP;
> +
> +	return desc->metadata_ops->set_len(desc, payload_len);
> +}
> +
Thanks for the RFC patchset. It looks fine to me. We also need to update
documentation. Let's wait for Vinod/Lars feedback.

>  /**
>   * dmaengine_terminate_all() - Terminate all active DMA transfers
>   * @chan: The channel for which to terminate the transfers
> --
> Peter
>=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

