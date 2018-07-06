Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E21C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3FE223C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HhXMM+Wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3FE223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934424AbeGFSvf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:51:35 -0400
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:21920
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934201AbeGFSve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=305GKhceV1gX8M56CbdObaUoQZ4EGorb0J1A2ifqM+o=;
 b=HhXMM+WaOA8gNYzKCIcVtMDRKOKTfOihsAqE0nitIk/yFEoCzsiGFepxJqtdTLS2Zvd1LpBL8CK6IfGOr90Vg5BmdnhY8lK11tjD92iMnGkHkbJ7M1UlNtsGas/lNf/+ZUDtw/smEswIR4Q2iV4zaCWKltfnU1DTwH9AAK+6Wnc=
Received: from VI1PR04MB4494.eurprd04.prod.outlook.com (20.177.54.85) by
 VI1PR04MB0975.eurprd04.prod.outlook.com (10.161.109.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Fri, 6 Jul 2018 18:51:30 +0000
Received: from VI1PR04MB4494.eurprd04.prod.outlook.com
 ([fe80::9089:9970:7f16:8cfd]) by VI1PR04MB4494.eurprd04.prod.outlook.com
 ([fe80::9089:9970:7f16:8cfd%3]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 18:51:30 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Topic: [PATCH 0/2] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Index: AQHUFJgtih02/09aHkWZRSUFqxsPGA==
Date:   Fri, 6 Jul 2018 18:51:30 +0000
Message-ID: <VI1PR04MB4494A72D6734ECAA57BA93C586470@VI1PR04MB4494.eurprd04.prod.outlook.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
 <VI1PR0402MB34853F03375D3BCA4791432698470@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB0975;7:ywzKOrZJj2MlF8uuEBzrDX9baTDtk89BMqt8Y60aC+xmVJ+emeJFvw370OJXOWTlSz4jfSTzvoIixON58slz5p7TnKRewJWcWtRKIOpeOuPlUgh/KsfSd8NRgvF9hxyvdQNfHIZNBfUGO5qzzdGTxODgXtlwDOpxYRQBgeLGj+XD/9zibIKGHukbYkaprnxk7KBa4Dh5oowgFSbvAEKXop5mPRtmLjH5Cx6bvHuQ05RHR4B0Ge+VkE5JbED2/3N8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 00d3f542-3aea-4e11-de87-08d5e3717cb1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB0975;
x-ms-traffictypediagnostic: VI1PR04MB0975:
x-microsoft-antispam-prvs: <VI1PR04MB09757AE1C4F1F01C9332D8C586470@VI1PR04MB0975.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB0975;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB0975;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(199004)(229853002)(575784001)(2900100001)(110136005)(9686003)(6506007)(6436002)(53936002)(25786009)(54906003)(256004)(14444005)(6636002)(2906002)(2201001)(5250100002)(6246003)(53546011)(102836004)(86362001)(4326008)(106356001)(99286004)(446003)(81156014)(3846002)(8936002)(316002)(8676002)(81166006)(6116002)(97736004)(305945005)(7736002)(26005)(105586002)(5660300001)(476003)(14454004)(33656002)(66066001)(76176011)(44832011)(74316002)(7696005)(55016002)(478600001)(68736007)(486006)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB0975;H:VI1PR04MB4494.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rFB3lx4u9ArzRsVuId+P1icccdiDh4i5eoYV1rjs7f78PPEbsZO4yKWqVkx4dFVdjP6HBRw+hMDn55bMWqmFLoiP0S/pa+cS3xU2GG2QdNQMHyjFsOdlp5yJ6k6SnybMrHNt32QfyWeZLr3lwvEkgdmpHLi9csTOpJRhc5t8LJxuwXr6cUM4CXmMioXRgu8AfWBiuEvys/gPkOYYCqeehlnDGfsfIcAkPiFOyCpr2ioqWb2nlBkyTmsd5pLZxbrfg94WbKZ9Fd7cQlVQDMryZe5Xodn3mp6mrKRYw751jhr8GTMKPzwvVQD+5dWLzzDXSh3iujNsIPfR0gYskPJO7VSA/06OWtjxswWzoDnETXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d3f542-3aea-4e11-de87-08d5e3717cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 18:51:30.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2018 8:25 AM, Horia Geanta wrote:=0A=
> On 7/5/2018 10:41 PM, Roy Pledge wrote:=0A=
>> Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-mc/bus/dpio=
=0A=
>> directory to the drivers/soc/fsl directory.=0A=
>>=0A=
>> The DPIO driver enables access to the Queue and Buffer Managemer (QBMAN)=
=0A=
>> hardware of NXP DPAA2 devices. This is a prerequiste for moving the DPAA=
2=0A=
>> Ethernet device driver from the staging directory.=0A=
>>=0A=
> Roy, Ioana,=0A=
>=0A=
> Would it be ok to add the following patch on top of the series?=0A=
> It's a dependency for dpseci object.=0A=
> If not added now I fear it won't be accepted until dpaa2-ethernet=0A=
> moves out of staging, thus gating dpseci upstreaming.=0A=
>=0A=
> Thanks,=0A=
> Horia=0A=
I can add this to the series - I will respin and send a v2.=0A=
>=0A=
> --->8---=0A=
> Previous commits:=0A=
> 6e2387e8f19ed ("staging: fsl-dpaa2/eth: Add Freescale DPAA2 Ethernet driv=
er")=0A=
> 39163c0ce0f48 ("staging: fsl-dpaa2/eth: Errors checking update")=0A=
> added bits that are not specific to the WRIOP accelerator.=0A=
>=0A=
> Move these where they belong (in DPIO) such that other accelerators=0A=
> can make use of them.=0A=
>=0A=
> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
> ---=0A=
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  4 ++--=0A=
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 18 +++++-------------=
=0A=
>  drivers/staging/fsl-mc/include/dpaa2-fd.h      | 12 ++++++++++++=0A=
>  3 files changed, 19 insertions(+), 15 deletions(-)=0A=
>=0A=
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/sta=
ging/fsl-dpaa2/ethernet/dpaa2-eth.c=0A=
> index 396371728aa1..d5f0ac5c2d1f 100644=0A=
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c=0A=
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c=0A=
> @@ -455,7 +455,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,=
=0A=
>  	dpaa2_fd_set_format(fd, dpaa2_fd_sg);=0A=
>  	dpaa2_fd_set_addr(fd, addr);=0A=
>  	dpaa2_fd_set_len(fd, skb->len);=0A=
> -	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);=0A=
> +	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);=0A=
>=0A=
>  	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)=0A=
>  		enable_tx_tstamp(fd, sgt_buf);=0A=
> @@ -508,7 +508,7 @@ static int build_single_fd(struct dpaa2_eth_priv *pri=
v,=0A=
>  	dpaa2_fd_set_offset(fd, (u16)(skb->data - buffer_start));=0A=
>  	dpaa2_fd_set_len(fd, skb->len);=0A=
>  	dpaa2_fd_set_format(fd, dpaa2_fd_single);=0A=
> -	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);=0A=
> +	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);=0A=
>=0A=
>  	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)=0A=
>  		enable_tx_tstamp(fd, buffer_start);=0A=
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/sta=
ging/fsl-dpaa2/ethernet/dpaa2-eth.h=0A=
> index 905a4e6be8fa..9269cb05a84b 100644=0A=
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h=0A=
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h=0A=
> @@ -124,21 +124,13 @@ struct dpaa2_eth_swa {=0A=
>  #define DPAA2_FD_FRC_FAICFDV		0x0400=0A=
>=0A=
>  /* Error bits in FD CTRL */=0A=
> -#define DPAA2_FD_CTRL_UFD		0x00000004=0A=
> -#define DPAA2_FD_CTRL_SBE		0x00000008=0A=
> -#define DPAA2_FD_CTRL_FSE		0x00000020=0A=
> -#define DPAA2_FD_CTRL_FAERR		0x00000040=0A=
> -=0A=
> -#define DPAA2_FD_RX_ERR_MASK		(DPAA2_FD_CTRL_SBE	| \=0A=
> -					 DPAA2_FD_CTRL_FAERR)=0A=
> -#define DPAA2_FD_TX_ERR_MASK		(DPAA2_FD_CTRL_UFD	| \=0A=
> -					 DPAA2_FD_CTRL_SBE	| \=0A=
> -					 DPAA2_FD_CTRL_FSE	| \=0A=
> -					 DPAA2_FD_CTRL_FAERR)=0A=
> +#define DPAA2_FD_RX_ERR_MASK		(FD_CTRL_SBE | FD_CTRL_FAERR)=0A=
> +#define DPAA2_FD_TX_ERR_MASK		(FD_CTRL_UFD	| \=0A=
> +					 FD_CTRL_SBE	| \=0A=
> +					 FD_CTRL_FSE	| \=0A=
> +					 FD_CTRL_FAERR)=0A=
>=0A=
>  /* Annotation bits in FD CTRL */=0A=
> -#define DPAA2_FD_CTRL_PTA		0x00800000=0A=
> -#define DPAA2_FD_CTRL_PTV1		0x00400000=0A=
>  #define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL =3D 128B */=0A=
>=0A=
>  /* Frame annotation status */=0A=
> diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/=
fsl-mc/include/dpaa2-fd.h=0A=
> index b55b89ba4eda..2576abaa7779 100644=0A=
> --- a/drivers/staging/fsl-mc/include/dpaa2-fd.h=0A=
> +++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h=0A=
> @@ -67,6 +67,18 @@ struct dpaa2_fd {=0A=
>  #define SG_FINAL_FLAG_MASK	0x1=0A=
>  #define SG_FINAL_FLAG_SHIFT	15=0A=
>=0A=
> +/* Error bits in FD CTRL */=0A=
> +#define FD_CTRL_ERR_MASK	0x000000FF=0A=
> +#define FD_CTRL_UFD		0x00000004=0A=
> +#define FD_CTRL_SBE		0x00000008=0A=
> +#define FD_CTRL_FLC		0x00000010=0A=
> +#define FD_CTRL_FSE		0x00000020=0A=
> +#define FD_CTRL_FAERR		0x00000040=0A=
> +=0A=
> +/* Annotation bits in FD CTRL */=0A=
> +#define FD_CTRL_PTA		0x00800000=0A=
> +#define FD_CTRL_PTV1		0x00400000=0A=
> +=0A=
>  enum dpaa2_fd_format {=0A=
>  	dpaa2_fd_single =3D 0,=0A=
>  	dpaa2_fd_list,=0A=
=0A=
=0A=
