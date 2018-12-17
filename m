Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16FBC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D0F2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e7kdVqWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbeLQLfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:35:45 -0500
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:58342
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbeLQLfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLQA0AAM74hZZMXm1BJ70SKssFHccJdkxW3Ti3ufHUg=;
 b=e7kdVqWsI1U8R5v3zVQiSzitOQmFPlURC0z0+NjEiXkHomWuIUc1b2koM9vXlud6CfuRdm/atIa8Y/hrp/2EjFMfcOa1Kzxw/coAyv935UPxLCcdAHse3tgSq0HkqyYwfDisEUZjLN9WxjTszD987MNTeGc9hSRyGXSWyOy/kzc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Mon, 17 Dec 2018 11:35:40 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::55a5:d113:d738:e0c9]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::55a5:d113:d738:e0c9%4]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 11:35:40 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Topic: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Index: AQHUk8HlzY+WhQB2ck6/TH6/+MaDIqV+utiAgAQW6YA=
Date:   Mon, 17 Dec 2018 11:35:40 +0000
Message-ID: <20181217113539.nfwp4knbx3luxoqn@fsr-ub1664-175>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
 <154482171780.19322.123667425822315496@swboyd.mtv.corp.google.com>
In-Reply-To: <154482171780.19322.123667425822315496@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3911;6:GoWtoe2PHhCj9YhgpY0UhD3UuDDvq3O7D7OTRYW/FMAvbwSSUoWWEgLz1ST/9KfR+LMLsUJWuXj5S+1CAuG3uPgLnt25FM3aZqwkH2M0gFeg1bwl52OPTjg5GwMBgN+dbfq3id1iXgtaw795+L+gtuhse6VWgzQ2lw8CQzkl0PLnjY0nF6Epi1CQqNqduwY2ngOibWLnabdw6VFrbCxgmNyPImu384jQ+j8MJMDUo4u1S2eDvMqPOAcy48XeurExq7S1JH+j+JZlo07HqFe9Mzbiny6OHznvdAmx+27xbj+lqqED+0N0XFFyynrN71AUlAt/BoRNyYSnCMlsh/rvxkfw0QADFZR03IXvIomqIGmAFEdCHNDGGGyNQiJpaxngwE9LZUalYWKag82El/KkG8nbQ691g4oylbS4Cdp6gOqrm38svJk2kn5IHnGXiCZ2myR/KZ456PfAvTXKv+e8iw==;5:fx3QjBT/TdZ7UPqiEaUPNSQ7lLHgqjybgxmNj5CjpgwnIm/yU9JNhohF09VlSij6FUDKEB+KrdDRUx9l1/kh7ov9HRkpVsoUcHVvs7e5wKQDlpoCaa84iS4i2sKVz3g2clS3Iv1s/KtiK2Gx6CFV8u7tnVglv/mhDb78wvhqEdY=;7:U69oOeYP28iwfitNNRIAFVnEN6w4L1I4NFJlc/3f5elJb16l03NN6Y1aXWecmhzQaazp/l7HrMUx8sZr+ZXhTJyqFsyR7oeYGB8l46nUXCzd5XekVu/gN6F/kuYa2DMWIxI9aymmvtOhK60N9srp+Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 833786eb-e0f2-47bc-cde0-08d66413c5d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3911;
x-ms-traffictypediagnostic: AM6PR0402MB3911:
x-microsoft-antispam-prvs: <AM6PR0402MB3911811B9C657D7B09A4C5AFF6BC0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3911;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3911;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(9686003)(81156014)(81166006)(11346002)(6486002)(256004)(14444005)(229853002)(446003)(6512007)(25786009)(71200400001)(71190400001)(68736007)(6436002)(478600001)(106356001)(476003)(486006)(7736002)(105586002)(305945005)(66066001)(54906003)(44832011)(33896004)(97736004)(6916009)(99286004)(76176011)(316002)(186003)(1076002)(6506007)(6116002)(3846002)(26005)(102836004)(53546011)(2906002)(4001150100001)(6246003)(4326008)(8936002)(86362001)(33716001)(5660300001)(8676002)(14454004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3911;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nHyBCzhroq34QKMFcs/jgLndceVGbH8YTk2HZn8jVDNuIhCndI2u8Xtp5ZYaFzmDyL4GRVI1W0fYZ5NPVWTZWFQ/MnfaRGNbLfEcx+2/ZJfMSfEA4FJmYhQh9qyMh0wrTpcFWj8OfkYItLD5NVX6Nutq8/eaAJF77D/IRbNbTzcoJkgaCDFwCDbiBuLoJW/6BUlNZ4u4Fd7feHRvb366jjaMdx2XBnIbHfZtTQHTW2FahmG8r8HIbPQGDBcZU9756AW1sE58KzLxa32jWgc/jM97kZLT+6mFjywNOzfJj7Ks7DszuKQSJ5pguuE+PxSB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6D47A4708134C4DB5BCC6B52E479160@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833786eb-e0f2-47bc-cde0-08d66413c5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 11:35:40.5314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-14 13:08:37, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-12-14 07:30:08)
> > This is mainly to shut up the checkpatch.pl script warnings about the
> > "static const char *" needing to be "static const char * const".
> >=20
> > Abel Vesa (3):
> >   clk: imx: Make parent_names const pointer in composite-8m
> >   clk: imx: Make parents const pointer in mux wrappers
> >   clk: imx8mq: Make parent names arrays const pointers
> >=20
>=20
> I still see warnings though so there seems to be some more work to do.
>=20
> drivers/clk/imx/clk-imx8mq.c:401:89: warning: passing argument 5 of 'imx_=
clk_mux2' discards 'const' qualifier from pointer target type [-Wdiscarded-=
qualifiers]
>   clks[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_mux2("gpu_shader_src", base=
 + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sel=
s));
>=20
Hmm, I guess you applied this on top of clk-imx8mq, right ?
This change is against linux-next. The actual problem is the imx_clk_mux2
which looks like this on branch clk-imx8mq:

static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,=
 =20
                u8 shift, u8 width, const char **parents, int num_parents) =
 =20

but it looks like this on linux-next (which is exactly the same on clk-next=
):

static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,=
 =20
                        u8 shift, u8 width, const char * const *parents,   =
 =20
                        int num_parents)                                   =
 =20
