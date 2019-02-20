Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D27C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF122147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jkhIERgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfBTFdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:33:33 -0500
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:23472
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbfBTFdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SONOZl48q+1ulRJ85hjztHK+JikC9hB9ZfnOvau0xYs=;
 b=jkhIERgv4/YjXf7BV1Z0iykkkQkuNQqjeyXoueSTZXNwGSGRkgKKEd0BbzJzTyf4SR+YHcFqpe5OOxbcGlC8vLuMHj4yvpycvIwJDPHwJ42PhXDhVfM7eN7jdG6Y7mxxkyPEfyLrrEWzIF95vCk03wVKc/eTcK37YIL2ki5h1mo=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5351.eurprd04.prod.outlook.com (20.178.86.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 05:33:26 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 05:33:26 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Topic: [PATCH V3 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHUyACy8HmIYiPaSECjXHiTh1QyKKXoHWZg
Date:   Wed, 20 Feb 2019 05:33:26 +0000
Message-ID: <AM6PR04MB42159D22AC552CB81AEEF6DE807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f09f7e54-9e2b-49fe-10a3-08d696f4f050
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5351;
x-ms-traffictypediagnostic: AM6PR04MB5351:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB5351;23:mdT7hGt7Yk9GKR3OdA7Vs5MtqJGyOeos4GFhBMrWF?=
 =?us-ascii?Q?vEPx1AbsITGO6f1dfmdZ0S3k6ukh8qBgP5ChShJmwQ4VqcdH/DKuDY0Hxcz+?=
 =?us-ascii?Q?B5kepEnS2KvDJJXA8zzD9m782sZaMc867iGSF+femTsCVjFZzoAEbuLdg6R/?=
 =?us-ascii?Q?L3byLPsIn1D9mc8xFzM99r0LAgxsa2D5MFw8r9tqs0DaUH5Y4AwmPoCAwuGD?=
 =?us-ascii?Q?WKZRZM2RnYVS067Kw1gDfN6gxuHesXZIbBbb1HKvVhAZcoOLXVIUByzCqMbh?=
 =?us-ascii?Q?8BEhZoXHFsdXCPMFAP/hr8Eb2bDD572zbtNO8wsNS0W+3DN0SpZruZaHICfR?=
 =?us-ascii?Q?2XqYADYYWnsJ9mAJX+IHYEXi0skQSvOz/EwyBk08tWX5O+Q0pQSR3pYbovWk?=
 =?us-ascii?Q?rO7Bg/ziyU65sf8MPtFidy3gU/dGhZZsIoAKRIvkvEYZmFwZjGUgGng/2dVM?=
 =?us-ascii?Q?oKwyrszX0GXHegvmWn9NT0NURRexNzfZOHtuSNiEYqkAa6iWHEE34tl3rMtC?=
 =?us-ascii?Q?4C/cEwXDGPIN+dLxqxnRLWUUvuO77muETgZNfe4BaEaAHwM3RzxK8b3d5Tc9?=
 =?us-ascii?Q?3vRj3Flcf/Z8T4zDvJK+fLTQl/YPEDTguQawX/m5wDBtXG/GF5fM2E84IotI?=
 =?us-ascii?Q?xzxrw/weqXqZC5/7N85UuR4j2th70teUnq23XIeE5+KjuvPkShIrpIixeS6d?=
 =?us-ascii?Q?VIAE1OlSO3Oj0hQOn+zi+vTqRr1as4q1GA/W6gijYmUr1AFy2fdJE9y1UlKb?=
 =?us-ascii?Q?dwW483wMO2M3SJuyzF/LCkpLGmgO6atdkGL0oikSPBHiVmjEev2CrK5U7nsM?=
 =?us-ascii?Q?RqpmE/TOUmV+HHrUoOSEgSxu3rFfSJoq8FS6Zon0zq+sdR9R/h1PEgGeFdTC?=
 =?us-ascii?Q?DLAlhe20KxGTZ5TpZj3GuBW9CuFjlWgvu2lSzff5ImQVWflSFdFQp3toATkb?=
 =?us-ascii?Q?5dZAXf5DvefPhiv2wGBrJRe0F7E75GTxZvHXbbWfSANv35IOePnBcaTfVYry?=
 =?us-ascii?Q?STF/gnnSqBHrU1xEY0u+LCQNJ55rX7JzdDTM0dp0Ta8R0xMmL37u6sxm4CW3?=
 =?us-ascii?Q?izfKpu1fok+qTZTMuAlKCnAe4VrMrDH0iVBpQwhLDRk+v0VIznNYpxlVScfK?=
 =?us-ascii?Q?fwW2Lc5GK/4JlDeaJVDNh7t/vJeN6m7btm/lkMwJ4zylwnV02CHlAQuKUROx?=
 =?us-ascii?Q?zWwIe1tHJRCWcJLZZZrEZwI8Oe6W8Yekn93kxS6hjPW7IqJeV7FRgGBEDaV4?=
 =?us-ascii?Q?2OKFsgN5K0+rRgwD9alJi8/l4t/oIr6qNMb7fCpiJKf3A7XkTLJ0pG9hwUlv?=
 =?us-ascii?Q?kPv6cbVBuXPGF5lcjFx5+k=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB53518CA2A403D6D0EE102A55807D0@AM6PR04MB5351.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(110136005)(99286004)(2201001)(86362001)(102836004)(6506007)(53546011)(7696005)(33656002)(26005)(76176011)(446003)(11346002)(486006)(44832011)(68736007)(229853002)(186003)(6436002)(476003)(316002)(55016002)(9686003)(105586002)(106356001)(256004)(71200400001)(71190400001)(6116002)(3846002)(25786009)(53936002)(66066001)(7736002)(6246003)(14454004)(478600001)(81156014)(4326008)(97736004)(8936002)(81166006)(2501003)(5660300002)(305945005)(8676002)(7416002)(74316002)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5351;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sLtyYUAyd2zL0PhZwQw7fDl9lqMVjr7jtW0hu+OKdDdEPIfgzIFgAOWrIGffwsFyUkgLM2+YLPH7XKRJqtQLiCH+jWFHu9CdJoG6G2SKFZDHXZlRfriSGv/VfykkZNiPsXidMT++niGFk14XBr98Vbphn+fVFRZt4xpybVXejVfjEwgXXAoRJJoQwVmw0MkshBkRL3rH5xsQ1epVtTDpzqTyGtYmhdwRg00KPd+O7Z+ixui2pByi8Fs/AHTuW8TrLZeZnkE/1+HkqZ8Zne7DeiOulTWA75OSqniQvZtSAhDgxr3u/HKDgTPJ/ZsSP8iDaFbW0HAryGMLCO91eqWsMjXdMPi5VX2ca0gmjOLJjif2LRqFliYOvjtAKvAHzwr/0sH3CV38bmpbFn5OG0229f3SX+pVSG+SLeBMrxk/St4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09f7e54-9e2b-49fe-10a3-08d696f4f050
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 05:33:26.6488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Tuesday, February 19, 2019 11:11 AM
> Subject: [PATCH V3 1/4] dt-bindings: fsl: scu: add general interrupt supp=
ort
>=20
> Add scu general interrupt function support.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> No change since V2.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18
> ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index f388ec6..e5def3e 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -22,9 +22,11 @@ Required properties:
>  -------------------
>  - compatible:	should be "fsl,imx-scu".
>  - mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
> -			       "rx0", "rx1", "rx2", "rx3".
> -- mboxes:	List of phandle of 4 MU channels for tx and 4 MU channels
> -		for rx. All 8 MU channels must be in the same MU instance.
> +			       "rx0", "rx1", "rx2", "rx3",
> +			       "gi3".

Should it be optional as SCU firmware does not require it for normal functi=
on?

And as MU also support sending interrupt via GIRn register,
How about using gip3 to distinguish sending general purpose interrupt?

Regards
Dong Aisheng
> +- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
> +		rx, and 1 MU channel for general interrupt. All 9 MU channels
> +		must be in the same MU instance.
>  		Cross instances are not allowed. The MU instance can only
>  		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
>  		to make sure use the one which is not conflict with other @@ -34,6
> +36,7 @@ Required properties:
>  		Channel 1 must be "tx1" or "rx1".
>  		Channel 2 must be "tx2" or "rx2".
>  		Channel 3 must be "tx3" or "rx3".
> +		General interrupt channel must be "gi3".

This can be:
		General interrupt Rx channel must be "gip3"

Regards
Dong Aisheng

>  		e.g.
>  		mboxes =3D <&lsio_mu1 0 0
>  			  &lsio_mu1 0 1
> @@ -42,7 +45,8 @@ Required properties:
>  			  &lsio_mu1 1 0
>  			  &lsio_mu1 1 1
>  			  &lsio_mu1 1 2
> -			  &lsio_mu1 1 3>;
> +			  &lsio_mu1 1 3
> +			  &lsio_mu1 3 3>;
>  		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>  		for detailed mailbox binding.
>=20
> @@ -153,7 +157,8 @@ firmware {
>  	scu {
>  		compatible =3D "fsl,imx-scu";
>  		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
> -			     "rx0", "rx1", "rx2", "rx3";
> +			     "rx0", "rx1", "rx2", "rx3",
> +			     "gi3";
>  		mboxes =3D <&lsio_mu1 0 0
>  			  &lsio_mu1 0 1
>  			  &lsio_mu1 0 2
> @@ -161,7 +166,8 @@ firmware {
>  			  &lsio_mu1 1 0
>  			  &lsio_mu1 1 1
>  			  &lsio_mu1 1 2
> -			  &lsio_mu1 1 3>;
> +			  &lsio_mu1 1 3
> +			  &lsio_mu1 3 3>;
>=20
>  		clk: clk {
>  			compatible =3D "fsl,imx8qxp-clk", "fsl,scu-clk";
> --
> 2.7.4

