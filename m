Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031ACC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F66204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wHyELPHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F66204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbeKGVhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:37:51 -0500
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:2593
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbeKGVhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWQsnMcp+9llxfmKQKD6IKc1ehlxBAIZzDMhYmkPNPw=;
 b=wHyELPHdnqDJIpxqjYLjANF8d6e3e/COcTTMFuu1T84GQ7UlZHzYS/SHhiFbVw9Hb2cbpXyuP5wJEM0QdRE4w/luMnlhBw4WymhUZyUmRfRXXIi9dU9oZy9r4sWT+wokjs2+tOmvk5tBTB0vCJ8QnbNz+RQVxUqXpm38RHUmx8s=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2751.eurprd04.prod.outlook.com (10.175.22.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 12:07:40 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3%6]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 12:07:40 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Youri Querry <youri.querry_1@nxp.com>
Subject: Re: [PATCH v1 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Topic: [PATCH v1 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Index: AQHUcI+CI7M4OPexAEu1FDf5Bamt4w==
Date:   Wed, 7 Nov 2018 12:07:40 +0000
Message-ID: <VI1PR0402MB3485275B1CB9D52F5E902D2398C40@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
 <1540931418-10697-2-git-send-email-roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2751;6:SS1gOHf3nLWjcR8kcWh+kkfyPUf5zpNAfwXu1DA9LmB/2dSZCgw5qrtdX7ni545xaOMyZN/xrVCd9lg+xi75LZf+1V6RLlWXqlejvliX/BznKCN1l3Shyzs8MAjKqutNkjg4UtpdSXf430g09aO9lnbmqrUwBPR/Xy7y57VPTU0ziqdYRSfhsY2m+m+lfa1dxpmPEDxnVd/bZHyAXzgdSSjIkGHkh1hBGiYvVAe3nDdinANjQS+F/KvWdmPmLsGXrP4vf8LML9YDrVLL1jjRcNoq3PeGdBhpqMuAIotnzMCI/j6bcMIz7UqWjDff6ycHYUKhXNpqEpqp4iHquyy768E1QG3XqhPXAh6DljPSnCPxsNhrwp6+kG7lJMtDuuOxlIXim8EAxKht7O8/6XX8pa1xUj8OcD4guCCu3NRHNFeWO+4DxJVkAucJjbVO/+JG1Utat1zeqtZ+nq9gLj5NQw==;5:9YjN7uxEQqsRWTpeLHD0XdyPvumALuGezfICRjw3kfD1pw0uOqC5pDox5hbp/y4V/R44aQxfy6ILkzTMnraXMYp4mtFB56xpOahbWbF9b5Enko93b3wUgshqeZwARc3nZCnmPZR0FJ53usiB57nnQtbOwsjeK8KwGQnWW8Fvwbw=;7:5/nP9DwsUxrzwjkUGDObyDVA6ZKYr9UHQy30vpnHBmduMPZtvcPCuEDvpsz841LUPeyl2AG1eI2y648HIU9qViwys+viAt5dQMnz+7szoFu1tlUXIBh5ViHfqNEKD/J0l353fQxctl9iDKfSKywwHg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 59307d23-debd-45e9-071c-08d644a99dbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2751;
x-ms-traffictypediagnostic: VI1PR0402MB2751:
x-microsoft-antispam-prvs: <VI1PR0402MB2751556F522CA026DC58AFD298C40@VI1PR0402MB2751.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227817650892897)(275809806118684)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2751;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2751;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(44832011)(9686003)(110136005)(66066001)(53936002)(478600001)(97736004)(2900100001)(14454004)(6116002)(3846002)(316002)(476003)(68736007)(486006)(25786009)(55016002)(81166006)(2501003)(33656002)(8936002)(2201001)(81156014)(86362001)(39060400002)(8676002)(6246003)(575784001)(102836004)(7736002)(7696005)(4326008)(256004)(53546011)(6506007)(76176011)(14444005)(2906002)(105586002)(99286004)(6436002)(74316002)(186003)(71200400001)(106356001)(5660300001)(446003)(71190400001)(229853002)(305945005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2751;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9Lu63InRbCaSHIZKrfdhCULOmp6kSi5On6saGxTlUKXUbb/kweyU52SxsYNlKf+6PSvTFlv73D3crc6Y86WgzQ7rW+6YHKEnbb45wEO0dE0Px+GOwJBuOF+eBUcPmgoGK6vpTL5HemUGmMiCQ4vfPOtNrD7Ou+mxjzkbbkX6qy8qUMKpA9uvERLYtNJ1olt9cbh9xitcwW+SzqbGHMLGW1MGMj8F7GMTausWEX/0cW2yzA0BYMj5FRWPxgxmi8iu8iYmPU5tvBUZHJJZOhiKbfpNxjfAQq/pNS6NuRLLsxh58BgZPsOfjWCzj98739RAwwaC/kRvbEA3dXbg+6P6qTg8ixqMh7kjEJ0SYnRv3T4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59307d23-debd-45e9-071c-08d644a99dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 12:07:40.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 10:31 PM, Roy Pledge wrote:=0A=
> Starting with v5 of NXP QBMan devices the hardware supports using=0A=
> regular cacheable/shareable memory as the backing store for the=0A=
> portals.=0A=
> =0A=
> This patch adds support for the new portal mode by switching to=0A=
> use the DPRC get object region v2 command which returns both=0A=
> a base address and offset for the portal memory. The new portal=0A=
> region is identified as shareable through the addition of a new=0A=
> flag.=0A=
> =0A=
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
> ---=0A=
>  drivers/bus/fsl-mc/dprc.c           |  3 ++-=0A=
>  drivers/bus/fsl-mc/fsl-mc-bus.c     | 14 ++++++++++++--=0A=
>  drivers/bus/fsl-mc/fsl-mc-private.h | 17 ++++++++++++++---=0A=
>  3 files changed, 28 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c=0A=
> index 1c3f621..bde856d 100644=0A=
> --- a/drivers/bus/fsl-mc/dprc.c=0A=
> +++ b/drivers/bus/fsl-mc/dprc.c=0A=
> @@ -461,8 +461,9 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,=0A=
>  =0A=
>  	/* retrieve response parameters */=0A=
>  	rsp_params =3D (struct dprc_rsp_get_obj_region *)cmd.params;=0A=
> -	region_desc->base_offset =3D le64_to_cpu(rsp_params->base_addr);=0A=
> +	region_desc->base_offset =3D le64_to_cpu(rsp_params->base_offset);=0A=
>  	region_desc->size =3D le32_to_cpu(rsp_params->size);=0A=
> +	region_desc->base_address =3D le64_to_cpu(rsp_params->base_addr);=0A=
>  =0A=
>  	return 0;=0A=
>  }=0A=
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-=
bus.c=0A=
> index f0404c6..25ad422 100644=0A=
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c=0A=
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c=0A=
> @@ -487,10 +487,18 @@ static int fsl_mc_device_get_mmio_regions(struct fs=
l_mc_device *mc_dev,=0A=
>  				"dprc_get_obj_region() failed: %d\n", error);=0A=
>  			goto error_cleanup_regions;=0A=
>  		}=0A=
> -=0A=
> -		error =3D translate_mc_addr(mc_dev, mc_region_type,=0A=
> +		/* Older MC only returned region offset and no base address=0A=
Nitpick: comment style is not consistent with existing code in fsl-mc.=0A=
=0A=
> +		 * If base address is in the region_desc use it otherwise=0A=
> +		 * revert to old mechanism=0A=
> +		 */=0A=
> +		if (region_desc.base_address)=0A=
> +			regions[i].start =3D region_desc.base_address +=0A=
> +						region_desc.base_offset;=0A=
> +		else=0A=
> +			error =3D translate_mc_addr(mc_dev, mc_region_type,=0A=
>  					  region_desc.base_offset,=0A=
>  					  &regions[i].start);=0A=
> +=0A=
>  		if (error < 0) {=0A=
>  			dev_err(parent_dev,=0A=
>  				"Invalid MC offset: %#x (for %s.%d\'s region %d)\n",=0A=
> @@ -504,6 +512,8 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_=
mc_device *mc_dev,=0A=
>  		regions[i].flags =3D IORESOURCE_IO;=0A=
>  		if (region_desc.flags & DPRC_REGION_CACHEABLE)=0A=
>  			regions[i].flags |=3D IORESOURCE_CACHEABLE;=0A=
> +		if (region_desc.flags & DPRC_REGION_SHAREABLE)=0A=
> +			regions[i].flags |=3D IORESOURCE_MEM;=0A=
>  	}=0A=
>  =0A=
>  	mc_dev->regions =3D regions;=0A=
> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl=
-mc-private.h=0A=
> index ea11b4f..28e40d1 100644=0A=
> --- a/drivers/bus/fsl-mc/fsl-mc-private.h=0A=
> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h=0A=
> @@ -79,9 +79,11 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,=0A=
>  =0A=
>  /* DPRC command versioning */=0A=
>  #define DPRC_CMD_BASE_VERSION			1=0A=
> +#define DPRC_CMD_2ND_VERSION			2=0A=
>  #define DPRC_CMD_ID_OFFSET			4=0A=
>  =0A=
>  #define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSI=
ON)=0A=
> +#define DPRC_CMD_V2(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_2ND_VER=
SION)=0A=
>  =0A=
>  /* DPRC command IDs */=0A=
>  #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)=0A=
> @@ -99,7 +101,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,=0A=
>  #define DPRC_CMDID_GET_CONT_ID                  DPRC_CMD(0x830)=0A=
>  #define DPRC_CMDID_GET_OBJ_COUNT                DPRC_CMD(0x159)=0A=
>  #define DPRC_CMDID_GET_OBJ                      DPRC_CMD(0x15A)=0A=
> -#define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD(0x15E)=0A=
> +#define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD_V2(0x15E)=0A=
>  #define DPRC_CMDID_SET_OBJ_IRQ                  DPRC_CMD(0x15F)=0A=
>  =0A=
>  struct dprc_cmd_open {=0A=
> @@ -199,9 +201,15 @@ struct dprc_rsp_get_obj_region {=0A=
>  	/* response word 0 */=0A=
>  	__le64 pad;=0A=
>  	/* response word 1 */=0A=
> -	__le64 base_addr;=0A=
> +	__le64 base_offset;=0A=
>  	/* response word 2 */=0A=
>  	__le32 size;=0A=
> +	u8 pad2[3];=0A=
Padding size (3B) is incorrect.=0A=
=0A=
Either add 4B of padding:=0A=
__le32 pad2;=0A=
=0A=
or expose the "type" field:=0A=
u8 type;=0A=
u8 pad2[3];=0A=
=0A=
> +	/* response word 3 */=0A=
> +	__le32 flags;=0A=
> +	__le32 pad3;=0A=
> +	/* response word 4 */=0A=
> +	__le64 base_addr;=0A=
>  };=0A=
>  =0A=
>  struct dprc_cmd_set_obj_irq {=0A=
> @@ -334,6 +342,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,=0A=
>  /* Region flags */=0A=
>  /* Cacheable - Indicates that region should be mapped as cacheable */=0A=
>  #define DPRC_REGION_CACHEABLE	0x00000001=0A=
> +#define DPRC_REGION_SHAREABLE	0x00000002=0A=
>  =0A=
The new flag should be added in documentation (DPAA2 UM).=0A=
=0A=
Regards,=0A=
Horia=0A=
=0A=
