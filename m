Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AB8JxZqW+cDVz2UFx3F93hNWgxVTerlJHMAws3ib0sz44d6Sjl+p+TsR15nkhcBe1BLFVSuxly9C
ARC-Seal: i=1; a=rsa-sha256; t=1525253732; cv=none;
        d=google.com; s=arc-20160816;
        b=YnC/wgpL+MNWdTonHl9R3hjOyugF+yStZlAhwtPSRZvuBENsB8gGq96flS6FGrJQR6
         gqyCTr4B+1LrMSHgQblROZNjhm+KOvOnBeBqJu+AS9HCkSgG4qcavWJS970Pz9072ptS
         0hKyNiA6+KkZ88qaz0qAoe1Za8pvvqUkqHK6/lMETiXMMY67ugLn8k7GL7xXa2GNZLun
         24XMMfpLX1o/K09+v/MT6tV/Fgl5ISiUucmo1FLOD0MXcTyh9KwIZBC+/evoCucIKH4A
         M6v/6OlaktPB0IFyz+8nZ2CnbrpDfmDLhkGsY0W241nueQZbEFQt/MdbykF5i0QfYkR8
         7vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4YZa23N9NZDCFLMuLrU+DoIwDALIY4gHDfwpb+JyNCE=;
        b=mLUoxF4x9PfUHyatxOfKfrlhD/Ijw3QrG1CdjdOIMd0oIBymedX6seadW+rBTJcEdw
         +Q1Mx2CsBlrOXlWAIaCivEKzuYwiXWa+W7N2zootXlNG033cSuNxg95kQnjc5Mo/aefY
         izpBSFoWRpyK7JjoloVTQxoz6T65Vdmk3vou8kjUCIBUqpua8dfQ/i2FGRFqft1GmPIu
         d/kh18W5u1KydlAlWssG+rXMXTMfdfAZd9I8ZXUrYD0WyxIumZVdlbYv92TEkTeQTYed
         fDDv5qdu3yg2OBqAGxH31KgPyMpntifi1brCOPumh6VOp7ZbwyMK5LMNnrT2iJ+hT5rT
         LIdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=fIwxjEM1;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.3.69 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=fIwxjEM1;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.3.69 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Nipun Gupta <nipun.gupta@nxp.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Thread-Topic: [PATCH v4 5/6] bus: fsl-mc: supoprt dma configure for devices on
 fsl-mc bus
Thread-Index: AQHT4Ex+5YYdLMW3R0eX+x2r0y1EkKQcMMeA
Date: Wed, 2 May 2018 09:35:27 +0000
Message-ID: <5AE98603.6020007@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1525069641-8523-6-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB1741;7:AExhnjfIn3xsGmeFVgOBPiK5Jul5oS4eKFL97De8TkbTXKjpXAwhlKPGheA0Bp5JpkOs4FeSshUoTzIt5vu0ey2NcW7ycrcNau24SlgOsQvocIIQ8ydP/PsXUUb86mKUNQi/H2UZzD5+3m/mFKcwyYoCoa7V72C+pNXp9TH9P62OVAf8cN0IeBDTSZg/BWR2jsQo9QjgmGJKjyCkwwzH6tbGtvvgDpSDyOzEUPV9uS8JLyhBVm26pg3MwiQbt2PJ
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1741;
x-ms-traffictypediagnostic: VI1PR0401MB1741:
x-microsoft-antispam-prvs: <VI1PR0401MB1741719CAB8066B4033B50A2EC800@VI1PR0401MB1741.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0401MB1741;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB1741;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39380400002)(346002)(39860400002)(396003)(199004)(189003)(76176011)(478600001)(7736002)(476003)(6116002)(3846002)(2501003)(53936002)(229853002)(3660700001)(54906003)(6486002)(3280700002)(102836004)(26005)(86362001)(316002)(486006)(4326008)(80316001)(36756003)(2616005)(5660300001)(110136005)(305945005)(6246003)(2201001)(2906002)(99286004)(33656002)(5250100002)(8676002)(25786009)(11346002)(44832011)(2900100001)(59896002)(6506007)(446003)(81156014)(7416002)(97736004)(6306002)(6512007)(87266011)(966005)(53546011)(65816011)(6436002)(105586002)(106356001)(68736007)(81166006)(39060400002)(8936002)(14454004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1741;H:VI1PR0401MB1856.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6VuW2W+FbxCiDRJToCI43R/cuVVvW/2C6MkiNJEttkQWrBkLMXvek9zEUKF5Z/UoMJsV12AM0p142rfmQEIP7fgrvoNtERHu9eJNmDTJhEvr2PX/Km7WTRfBZRIzRt3t6f/5PErDT2kw1FRcWCas4furh2U2mMIQ1gQ7J/IhKrWV7PZ1A2Npn1G2v5rin5Hs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6ACBC0B225894A4E82D1EEF2EBF86998@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: be6674a9-138a-4f04-e57d-08d5b0100a0d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6674a9-138a-4f04-e57d-08d5b0100a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 09:35:27.6035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1741
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894785673525346?=
X-GMAIL-MSGID: =?utf-8?q?1599344458079826792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Nipun,

On 04/30/2018 09:27 AM, Nipun Gupta wrote:
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---

If my understanding is correct, the kbuild error is triggered by this=20
missing dependency patch:

https://patchwork.kernel.org/patch/10370081/

Apart from that, patch looks good to me, so

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

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
>   		dev_set_msi_domain(&mc_dev->dev,
>   				   dev_get_msi_domain(&parent_mc_dev->dev));
>   	}
> @@ -633,10 +645,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_de=
sc,
>   			goto error_cleanup_dev;
>   	}
>
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>   	/*
>   	 * The device-specific probe callback will get invoked by device_add()
>   	 */
>=
