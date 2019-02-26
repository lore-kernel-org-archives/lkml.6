Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BBE2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pKcLcAna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfBZMWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:22:35 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:51272
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfBZMWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XXROg2dgExn4K/fA4WzD34x/B2jTkmMlFgjJZnImTY=;
 b=pKcLcAna4NwJF81zh2sNxufNC7xRrntJqZEIrAd/x8LV3RCsxNakZBUhrhL3o6u96NkthvAeer0yeeypzLMFaMHhxQ2JFRURmGZBax8jMZO0s0XCGKVgajtih6LYLRBpcbM3Yw2Lx2ppiaYzIFePHUkKFm+fzh1qBsvipeFrCGk=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5950.eurprd04.prod.outlook.com (20.178.123.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 12:21:50 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 12:21:50 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Christina Quast <cquast@hanoverdisplays.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Topic: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Index: AQHUytCIfTFXSadJckWCjEy0gWR0oKXyA8SQ
Date:   Tue, 26 Feb 2019 12:21:49 +0000
Message-ID: <VI1PR04MB42227AA158BA1FCBF314AA27807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20190222170038.9669-1-cquast@hanoverdisplays.com>
In-Reply-To: <20190222170038.9669-1-cquast@hanoverdisplays.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4119fd96-1be4-41dc-f40f-08d69be4fbe4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5950;
x-ms-traffictypediagnostic: VI1PR04MB5950:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB5950;23:SSXAUthfATqJtmhnIgCKjHKZKIM2yw1BTDUaKZBtc?=
 =?us-ascii?Q?RmTndkYv/dESHUnKm7+k/o9FEkGXymdhhnHmW55YpHtALDmvukSkY+dKCCh1?=
 =?us-ascii?Q?bqPqMFAyKbeC0lzn3Cry0VvVlhUDfzKFzXaq48OVol/1LRL6EFtutWjBVEfs?=
 =?us-ascii?Q?lgWZvpn+BupMNKuiCNbmzfiBhqlPuM4g3hZsc9JXSOzwSZCh6NQnlpF/09Vo?=
 =?us-ascii?Q?pO6lPNyzIan1GtB1dhKBwtyZxlumKzIOUbBLsD64gnewb392GHe81Z/bYjM/?=
 =?us-ascii?Q?K58SgB9XKCw/ijjWXe51MS+VgEu9pvR2Zlw+wOgNO1cgR6O+4mpFhVjJrs6a?=
 =?us-ascii?Q?LdZMJFFbv1h74gh4CaSeqI67fGQfPR52XpqXXvWZRNl1rtvhkNcxzOQ6ZxZ9?=
 =?us-ascii?Q?drLSQqqaNc1TSiflUzMXL7TZHvP5Q0pIPfRgHr38LQRxddCaiEQx6HUhPHyT?=
 =?us-ascii?Q?LTFHeTUz0D7r2sQyrNBTOfH1ZyneAQT4X7HsmLNTLrHgaOdt+WelKxajDRak?=
 =?us-ascii?Q?Z3uCEsKjXzkI0D9fY7EtbCICiM2nv373NChl28RD0zaBPJXHjMGVXJ76N1L8?=
 =?us-ascii?Q?2A1TGr8geWsrEm+heHbkOPaoEQWq8S/g/B+6kBYJrMdwDXOE17vtTtwyEsNO?=
 =?us-ascii?Q?+OPbs7zQyGktO21xG29YpU517Qo034ZXXTVRVWlw6aMbEyr9lbhhYuQO4nzl?=
 =?us-ascii?Q?ddSsT2qTvBVtfsNK5izWNg0Py91r1R52FVDLfecuMSnKuM2adO2+tBvSuTHr?=
 =?us-ascii?Q?1xUhb6ExN0dJQpz/dOGFhOelmOUgVC5ux3VPkVXVQIjiMRXyckBDs6rdt2YK?=
 =?us-ascii?Q?rHp5dUP9bm0lSirYjuPQrZ1VNPeuJQXf1ABwAVMXW2dMOo9nYCZ5/hE3x2yv?=
 =?us-ascii?Q?xUOnKJFAggbZcCnssKrUaN65+gPUo4DZTFZdwEbl9h6BFqNt02qsBCyE/ruv?=
 =?us-ascii?Q?EUlkA+dCoi9Pab3kr1pVZspvK1ExJ+TYXMeMgnJ00g9xzO4QrLQ0qGx6KR+t?=
 =?us-ascii?Q?hPCCo1rMKTFyVKP+LR7x+EMlrd0GoXtLdsPiLMKmiWWnBLo39jrU8EuR16YG?=
 =?us-ascii?Q?uXI5r60MkXv9GRgi4Q1ZGgbe4NLda+X4uDNGLTHrmo3+zvedDkb+nSrZXcM9?=
 =?us-ascii?Q?nbhLdLALoz4ff5605uH7s2ct0EpJY1nMjCvbKuNeNUeyOyc3AbWfpPawkuND?=
 =?us-ascii?Q?4BJtutd88fLK8EtZ3QjEGdMaXhzrBRU0x8LJ2qKh4Xkyd1eujs9vmOxeQ7qz?=
 =?us-ascii?Q?b8KZayW+8NR4Nnpi3UUuSKvhvO/rj5eg0yDTLUnNc0v7YUUkK4HTtXXzbByW?=
 =?us-ascii?Q?OE0ZXzT3gqDI5SppXMRa3U=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB595002CB2441374564F32162807B0@VI1PR04MB5950.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(26244003)(189003)(199004)(186003)(8676002)(81156014)(81166006)(8936002)(486006)(305945005)(66066001)(7736002)(102836004)(74316002)(7696005)(53936002)(478600001)(76176011)(33656002)(44832011)(26005)(446003)(11346002)(476003)(14454004)(68736007)(97736004)(105586002)(106356001)(6506007)(9686003)(6916009)(5024004)(14444005)(25786009)(6246003)(86362001)(256004)(6116002)(99286004)(5660300002)(316002)(4326008)(229853002)(2906002)(6436002)(7416002)(71200400001)(71190400001)(3846002)(52536013)(54906003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5950;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FDjt2B0KK7dgO6e4BZcCOlrHQYW2oPlY0xYP3s4Ufu813Vq4ipfJ1hcQtypH+xuNdBPguoU3RqJpg2apF+UePbVs4MXRK0nzW0LxX7bNuf45WNf887Z70YRTJ9eNdGsU2IA8N3beIZnsMGzZ5ktWxFkcsPB7K6PULoSrVTXp7JfIulrJhSsKi3fEdkhwCS+Yc3v1lQlLLQFLA65NhS6KcBLwwl05rQgK3GNQFyzrR3ipzY0gzKromA7+AN8DdIgihkUCN3aQ6gIJwI5RLtvC8alLuO20SQCcKkMcz5ODvMIvOI1Yo6DNI1c3iB0GKnXKLKtDjxEmHmYup6U1Ymxe+le3jJBdEwDz8QZ20lXxPwlYsDniqDcipCvimv/jQmURUBV0/kY7/9muQDog/+ugNpS9etnA4FY76T06MgjpfUk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4119fd96-1be4-41dc-f40f-08d69be4fbe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 12:21:49.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christina Quast [mailto:cquast@hanoverdisplays.com]
> Sent: Saturday, February 23, 2019 1:01 AM
>=20
> In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from the
> documentation.
>=20

It's a doc problem.
Latest RM seems got updated.

As here it's a reference definition in binding doc and device tree actually=
 does not
use it (IMX Pinctrl use raw data to set pad configuration). So it won't cau=
se any
compatibility issue to me.

Please update the patch title to:
dt-bindings: pinctrl: imx7d: xxxxx

Otherwise:
Ack-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> ---
>  .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.=
txt
> b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> index 6666277c3acb..8ac1d0851a0f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> @@ -48,9 +48,9 @@ PAD_CTL_HYS                     (1 << 3)
>  PAD_CTL_SRE_SLOW                (1 << 2)
>  PAD_CTL_SRE_FAST                (0 << 2)
>  PAD_CTL_DSE_X1                  (0 << 0)
> -PAD_CTL_DSE_X2                  (1 << 0)
> -PAD_CTL_DSE_X3                  (2 << 0)
> -PAD_CTL_DSE_X4                  (3 << 0)
> +PAD_CTL_DSE_X4                  (1 << 0)
> +PAD_CTL_DSE_X2                  (2 << 0)
> +PAD_CTL_DSE_X6                  (3 << 0)
>=20


>  Examples:
>  While iomuxc-lpsr is intended to be used by dedicated peripherals to tak=
e
> --
> 2.20.1
>=20
>=20
>=20
>=20
>=20
> Please consider the environment before printing this email
>=20
>=20
>=20
>=20
>=20
> The information transmitted is intended only for the person or entity to =
which
> it is addressed and may contain confidential and/or privileged material. =
Any
> review, retransmission, dissemination or other use of, or taking of any a=
ction in
> reliance upon, this information by persons or entities other than the int=
ended
> recipient is prohibited.
> If you received this in error, please contact the sender or postmaster
> (postmaster@hanoverdisplays.com) and delete the material from any
> computer.
> Although we routinely screen for viruses, addressees should check this e-=
mail
> and any attachment for viruses. We make no warranty as to absence of viru=
ses
> in this e-mail or any attachments.
> Our Company's email policy is to permit incidental personal use. If this =
email is
> of a personal nature, it must not be relied upon as expressing the views =
or
> opinions of the company.

