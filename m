Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AB8JxZroznPyzZbwN8goSkbm6UZ4+IBrbrrdDyQpUnSR/BAmbK2ohucS5egdC7EGKAspX5gKFQdB
ARC-Seal: i=1; a=rsa-sha256; t=1526305192; cv=none;
        d=google.com; s=arc-20160816;
        b=ZNqJVYOZ33YR2/3jVi1OyogJ/KeDz6GW+tIRD8iC7qwy5all8Guwpe44RCmla1J/Lr
         skNgDeSb3dmaWDu+fJGZWLx5uLwdbcRfL/ZVPWzS3VGyAsrdr1kkgxbgDTwIsPoxplAo
         SVGyD2CtDrAmnq3qGWenf8xf9QP2ADcQm9BZvW59uF6e8ZJygDtDXs0M6zz/AkAfWvV8
         VjX5MWFzjTXWqWn5emOR0kagIzWXQ7CQMKbCd7AhaRxsXG7d2QcmeXpULgWDgwFk5uIo
         O3PSwZdtWtHqcWiZql7DySUNDOqkupZNgPXu2aeRIgqs0EwloEuuDwMEqUR7G7Wd5b4Z
         4CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=e3OMRMa4AYf1LhkoHiQtQvylpzEOMhNzLZmSsFhfNDk=;
        b=WF0ohjVMZwnHNCcsWFudSq1Kgd4Poq9pjsdoTwicH35AaNKu2ZD+jIor6b95LKQXYg
         aVcPUEBIZ2eydMeEgNmK+lOFarxajFglK+G3uZeIJbM2Z/g00m+erAW9R8wZ/Z8fJbb5
         CjX2z+Sp7z8pMWn1rnco3BPillOzAR0hobLZRTKU2sydxdUGHMZL2QA26ACYUEcnqGAB
         IdmzRBjQ2YBGcG8/xA0q5V/LrLXhknLnkI/Hgn1ylFMALcd34rd59JRkqFqgMosEWF1D
         W/GJCHLtuTefpG+uoWNq/iyqO0ccH1ae2xvBOizE57k7jpDaFlWdfDFiIW5rmWxPsZlK
         6fHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=vjmMbYcm;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.0.87 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=vjmMbYcm;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.0.87 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Nipun Gupta <nipun.gupta@nxp.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>
CC: "hch@lst.de" <hch@lst.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Thread-Topic: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Thread-Index: AQHT3hJvQleVKzMAW0qSPwbA0z2ep6QvVagA
Date: Mon, 14 May 2018 13:39:50 +0000
Message-ID: <5AF9916E.8000504@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3864;7:NLZrhbviMNullw7ln7fkt2oZ7Px2dLtKuUGPWCzSuY4fJgdQW+R5LPbGzGx+xwOsP/dD6B3KE3HnNr0+1awIjmrekr9hx7cwTLlH+XPbzoMPys4ln0m3mfyXM7z9ZPuKr/lsPjcT49dJTSPIX+IBTP6jJBkhGGnqawCqGWS+beUtyE10T8kjj8iVgJmu6Cf0l3eTndIu3BcnZ8RU8FiC/0a82lffDvK+LXaOgpniGyIIqubUU6zVpHAbO2p4oI5R
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3864;
x-ms-traffictypediagnostic: AM6PR0402MB3864:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-microsoft-antispam-prvs: <AM6PR0402MB3864B4A6D84B06963CDEFEAFEC9C0@AM6PR0402MB3864.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM6PR0402MB3864;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3864;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(54094003)(6116002)(5660300001)(105586002)(6486002)(5250100002)(2501003)(229853002)(97736004)(106356001)(14454004)(7416002)(305945005)(7736002)(81156014)(6436002)(81166006)(8676002)(6512007)(25786009)(86362001)(80316001)(54906003)(3846002)(39060400002)(110136005)(2201001)(59896002)(6246003)(6506007)(446003)(53546011)(478600001)(87266011)(8936002)(2906002)(44832011)(316002)(102836004)(99286004)(11346002)(4326008)(26005)(486006)(53936002)(2616005)(476003)(68736007)(3280700002)(66066001)(3660700001)(65816011)(36756003)(76176011)(33656002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3864;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: r0ee4lt8YRCYBQ3dtEAXPzPCfR+VssfrKvVMx3fS+3Y3yel30LLBo/7sHjPJO0XEUKlEd1ilSTA4rH3pf0LuE6GUwaI16/lwNuxypf5xDNoGr/sF2OLWVxZjCe53eQGf+VgqklLPerqeP5++HQikh96+RlbeodPfIl3ifrwB45v9GJaMpqrLxFUqjDOxG9vD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <03F01C290B624D4B87A4DE017A3CA11B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5728b3a9-2536-4f03-9314-08d5b9a02a7d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5728b3a9-2536-4f03-9314-08d5b9a02a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 13:39:50.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3864
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894785673525346?=
X-GMAIL-MSGID: =?utf-8?q?1600446993882041086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Nipun,

On 04/27/2018 01:27 PM, Nipun Gupta wrote:
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-=
bus.c
> index 5d8266c..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, str=
uct kobj_uevent_env *env)
>   	return 0;
>   }
>
> +static int fsl_mc_dma_configure(struct device *dev)
> +{
> +	struct device *dma_dev =3D dev;
> +
> +	while (dev_is_fsl_mc(dma_dev))
> +		dma_dev =3D dma_dev->parent;
> +
> +	return of_dma_configure(dev, dma_dev->of_node, 0);
> +}
> +
>   static ssize_t modalias_show(struct device *dev, struct device_attribut=
e *attr,
>   			     char *buf)
>   {
> @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type =3D {
>   	.name =3D "fsl-mc",
>   	.match =3D fsl_mc_bus_match,
>   	.uevent =3D fsl_mc_bus_uevent,
> +	.dma_configure  =3D fsl_mc_dma_configure,
>   	.dev_groups =3D fsl_mc_dev_groups,
>   };
>   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_des=
c,
>   		mc_dev->icid =3D parent_mc_dev->icid;
>   		mc_dev->dma_mask =3D FSL_MC_DEFAULT_DMA_MASK;
>   		mc_dev->dev.dma_mask =3D &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask =3D mc_dev->dma_mask;

This change seems a bit unrelated to the patch subject. I wonder if it=20
makes sense to split it it in a distinct patch.

---
Best Regards, Laurentiu=
