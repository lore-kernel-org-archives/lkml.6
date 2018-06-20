Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43129C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEC120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZxWFYFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEC120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeFTKr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:47:57 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:27620
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751031AbeFTKry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nPPqBrU2N9+FdFaz7EZBRIcXoEOQr8ZV0JsvODSjh4=;
 b=dZxWFYFDOisWQBl5QpPC1PUO1zvYO/dKehoO0bj7xYghkltiQ8fPIxecgOF5MK0lod5kRiIxlmTyCxr/R4BSm+hjcxidqHvyG7ElcBUIePfkYGXEY8YfYZuhtARajsz4ROmZZ9Rib6h1jST73BB33ibaX6gEfWv07f4aULkGxV8=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB4463.eurprd04.prod.outlook.com (20.177.53.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 10:47:51 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::c52f:a1e3:54eb:fa7a]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::c52f:a1e3:54eb:fa7a%2]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 10:47:51 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Subject: Re: [PATCH v3 2/3] pinctrl: imx: allow to configure SION with generic
 pinconf
Thread-Topic: [PATCH v3 2/3] pinctrl: imx: allow to configure SION with
 generic pinconf
Thread-Index: AQHUCGfIMsZTrQyqbE2Ux8EVo3iJD6RozToAgAAqOgA=
Date:   Wed, 20 Jun 2018 10:47:51 +0000
Message-ID: <20180620104750.unr2xryqszbv33mo@fsr-ub1664-175>
References: <1529479463-26961-1-git-send-email-abel.vesa@nxp.com>
 <1529479463-26961-3-git-send-email-abel.vesa@nxp.com>
 <1529482602.7211.32.camel@pengutronix.de>
In-Reply-To: <1529482602.7211.32.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4463;7:COZxpGVihyiwVmXmQARlKE8QszUp9sHD/8OkTzSb92w5zO/NQY1EzYZ/jbsr88XYI/LH9/jWCMv7NlSK1n37PJpwjZ+qxP7/FSa4080NBsh8S1DaoAA72Ua2LvzXOkU/iG+/ozwNXkRDs6pjjlzmRtK6N2VsnPEaUm8PhNZZ934ze5pGbiaeOT3nZLb3PsVQ7ZhRvLxF0sW3GjzxdgzuXRAiOO+q/cgRm18UVtjpMtNTqCP/jz+PXK3jiWzjP+Zd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ae287e3f-95c8-45f6-a9d8-08d5d69b456f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4463;
x-ms-traffictypediagnostic: VI1PR04MB4463:
x-microsoft-antispam-prvs: <VI1PR04MB44635B42FC97ECB8A1D3F2B9F6770@VI1PR04MB4463.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4463;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(39380400002)(376002)(396003)(366004)(346002)(189003)(199004)(8936002)(81166006)(6506007)(8676002)(76176011)(33896004)(105586002)(102836004)(7416002)(81156014)(66066001)(1076002)(6246003)(4326008)(305945005)(7736002)(2900100001)(3846002)(5250100002)(106356001)(6116002)(25786009)(229853002)(6486002)(486006)(44832011)(99286004)(446003)(2906002)(97736004)(5660300001)(68736007)(478600001)(476003)(6916009)(33716001)(54906003)(53936002)(316002)(575784001)(86362001)(186003)(6512007)(6436002)(3660700001)(9686003)(11346002)(26005)(14454004)(3280700002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4463;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Shb7Dftwec5pHvxfkOXpiMerTwbxYc0VXlU6pqnlmTW9PlxbhmniXYHwxgN+rTdIazAfn2q5ujydTx9av8QnnoN5lcFGeJB0h5faXnJZDVIlslLNH79Tf4jcoy7gG4EPn4zKA7/tOmp/FQdHxYSUTw6KA0X50M7/ObKQanh2o0j+FcowoYj24E2a7uDnI3Pv0npILTBuketLXjgPi1TZfQ3nAcq5RffUvA+gSiKilgZCD9Qy3BZ1RzZp5ZyDrI7429/AM0SjvwPDb7ctBKh8R772ImcHdqKwhX9cEVLaeOsU6n41lc+GfYh1D1xqMWfb8hEmmfCgRKaz8rC4Zf5RqQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <86A17210CB1B1146910492DE4AFB7A27@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae287e3f-95c8-45f6-a9d8-08d5d69b456f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 10:47:51.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:16:42AM +0200, Lucas Stach wrote:
> Hi Abel,
>=20
> as this series switches back to using the raw padcfg values in DT
> instead of generic pinconf (which I think is the right move), we can
> drop this patch from the series.
>=20

Cool, will drop it in the next version.

Thanks,
Abel

> Regards,
> Lucas
>=20
> Am Mittwoch, den 20.06.2018, 10:24 +0300 schrieb Abel Vesa:
> > > From: Lucas Stach <l.stach@pengutronix.de>
> >=20
> > The SION bit force enables the input buffer, overriding the configurati=
on
> > driven by the muxed module. It is not located in the pad config registe=
r,
> > but in the mux register and thus needs special handling.
> >=20
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > =A0drivers/pinctrl/freescale/pinctrl-imx.c | 19 +++++++------------
> > =A0drivers/pinctrl/freescale/pinctrl-imx.h |=A0=A04 ++++
> > =A02 files changed, 11 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/=
freescale/pinctrl-imx.c
> > index 1c6bb15..335edc9 100644
> > --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> > +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> > @@ -26,10 +26,6 @@
> > =A0#include "../pinmux.h"
> > =A0#include "pinctrl-imx.h"
> > =A0
> > -/* The bits in CONFIG cell defined in binding doc*/
> > > > -#define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
> > > -#define IMX_PAD_SION 0x40000000		/* set SION */
> > -
> > =A0static inline const struct group_desc *imx_pinctrl_find_group_by_nam=
e(
> > > =A0				struct pinctrl_dev *pctldev,
> > > =A0				const char *name)
> > @@ -514,18 +510,17 @@ static int imx_pinctrl_parse_groups(struct device=
_node *np,
> > > =A0		pin->mux_mode =3D be32_to_cpu(*list++);
> > > =A0		pin->input_val =3D be32_to_cpu(*list++);
> > =A0
> > > -		if (info->generic_pinconf) {
> > > +		if (info->generic_pinconf)
> > > =A0			/* generic pin config decoded */
> > > =A0			pin->config =3D config;
> > > -		} else {
> > > +		else
> > > =A0			/* legacy pin config read from devicetree */
> > > -			config =3D be32_to_cpu(*list++);
> > > +			pin->config =3D be32_to_cpu(*list++);
> > =A0
> > > -			/* SION bit is in mux register */
> > > -			if (config & IMX_PAD_SION)
> > > -				pin->mux_mode |=3D IOMUXC_CONFIG_SION;
> > > -			pin->config =3D config & ~IMX_PAD_SION;
> > > -		}
> > > +		/* SION bit is in mux register */
> > > +		if (pin->config & IMX_PAD_SION)
> > > +			pin->mux_mode |=3D IOMUXC_CONFIG_SION;
> > > +		pin->config =3D pin->config & ~IMX_PAD_SION;
> > =A0
> > > =A0		dev_dbg(ipctl->dev, "%s: 0x%x 0x%08lx", info->pins[pin_id].name,
> > > =A0				pin->mux_mode, pin->config);
> > diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/=
freescale/pinctrl-imx.h
> > index 4b8225c..44567a6 100644
> > --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> > +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> > @@ -14,6 +14,10 @@
> > =A0#include <linux/pinctrl/pinconf-generic.h>
> > =A0#include <linux/pinctrl/pinmux.h>
> > =A0
> > +/* The bits in CONFIG cell defined in binding doc*/
> > > > +#define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
> > > +#define IMX_PAD_SION 0x40000000		/* set SION */
> > +
> > =A0struct platform_device;
> > =A0
> > =A0extern struct pinmux_ops imx_pmx_ops;

-- =
