Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C10DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CBE21550
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wcagKKDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CBE21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJRR5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:57:43 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:61415
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727997AbeJRR5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLgawDfgTY16R9xzh2AP4zfy6o5LOlo4kXF4fGRL/f0=;
 b=wcagKKDdw/oKHuzP4+ZESmaFAFvV5fFQNwzY8Q1sQ/fbAQKZbBNNKI5WQQIK2LrBYzB/liG0IdX2q6yGbRJbrIKeCrZaM8q3WcUBQy+4mNYdB7S0cHwCxDyE8TOo2gpnGiJ3lXcs4+Vj5H1zP3IUwwJOmiH7VgnVl3yd/cPcIt4=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB3021.eurprd04.prod.outlook.com (10.170.228.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 18 Oct 2018 09:57:24 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3%4]) with mapi id 15.20.1228.027; Thu, 18 Oct 2018
 09:57:23 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abelvesa@linux.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v9 4/5] clk: imx: add imx composite clock
Thread-Topic: [PATCH v9 4/5] clk: imx: add imx composite clock
Thread-Index: AQHUU/MQDiYKhpdes0SA+ypwWnj3TaUj/biAgADsToA=
Date:   Thu, 18 Oct 2018 09:57:22 +0000
Message-ID: <20181018095721.eg46zj2srcyd5xy5@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
 <153980589525.5275.9065338436630625817@swboyd.mtv.corp.google.com>
In-Reply-To: <153980589525.5275.9065338436630625817@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3021;6:d3dFDGUq/idsKnV5VRVh3LH62EgfiMh7AxFt13Nsh1Un6LjGjO2DfYYigBHb8J38uHp2eqLMFSyxk3WqPDVWVdmUj0Y4bgdXKEP1qwWkiIK2SJXzTfFkr+LF/i4vlK8RTLQQLEPTra4PQRrbgrEbJ7kJwF+DndlRT593nfj/OG8iLUbiSBG2sCnPRi4m8aLbiWLIBFihcQs14cFtonCwV0YGLC+08J6ZnW4PVcgLT5+3EeL9AQiPts6tpFn0oa8vjHb4+BwWUMuBNEc21UIMoDcMhdshpFhIsND2Vj5Sx1ZUinodp7FfmrdMvJQXA4bcm+qd4SnaRIrIzp+7lWa9tx7zS/irY+17B0n3JdcRIo98GttNw3Yuh2x70AYDZ0t7VFnBalHOaYHApwyAaaelTWqtOxsol320s70EP7xpK0JdfPU39PdOEtmPzm1lH5ArkVizk53fbyy/TNguR6zSzQ==;5:txi7wu7lIqPivyHjuHFU25Cayi6DfbRwq37SZ69KLmJfNbIWF9fMC2YbUKtRWYhN9y2r6oR+qT3yxR7LxFcSxAI3mJDocI4napjVSTgc0CfEpm8h6Uy82/PKuDdkfgMi1wgpt50+lpipZ5QDqtuMLNVQ3R0DNeLqG9+4ES3N9xk=;7:iBO3fRRzcy0uxIF2ow2Xr/SkP1EI2JVdqwzaXjayi4om1pxmpk7Y+Edrd4Pamn5Qh+Da6vww0uA5PQl8SUDcHcgKfvCyXt7NSgU/bfbuwnmHMWmgwfStnZAeDeL1jJPiWgOxiQ5a9X5Hspn+PHxKRL9RIwXAmQwgJ4prkSH4ht3IRreQECQj9h5sgV0MVC8yOs1Yz9QYziMzjzmuRcUFc49MmrQRbx5MSIVU1kyqGmmCd9Ci4pRFckLaAH8JYeU7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3d9e885c-2eec-4a38-b575-08d634e019e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3021;
x-ms-traffictypediagnostic: VI1PR04MB3021:
x-microsoft-antispam-prvs: <VI1PR04MB302155ABB40BFF671A769950F6F80@VI1PR04MB3021.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3021;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3021;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(81166006)(6916009)(81156014)(8936002)(33716001)(6346003)(305945005)(2906002)(54906003)(8676002)(186003)(7736002)(508600001)(5250100002)(6246003)(102836004)(14454004)(44832011)(11346002)(446003)(39060400002)(6512007)(4326008)(26005)(99286004)(476003)(486006)(5660300001)(6486002)(6436002)(53936002)(9686003)(68736007)(106356001)(71190400001)(229853002)(105586002)(316002)(66066001)(97736004)(256004)(76176011)(2900100001)(3846002)(6506007)(33896004)(71200400001)(6116002)(86362001)(25786009)(1076002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3021;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-message-info: dVkr+9NKH6wr3rJSpYplsoYEFX96oROhqAcBksgu3XlzfUauZdk84v+3YUqum/NeXXqxMXGNQqwfh0QPnJTjHPoU3R7Pg/vXsbGkP8tFLsx+qXeccabI7oZB585mapQbkf+L14K+NDeumQZj9OUSWwg25U5IPEtawgcQM/R5KS7BdTo5CHUcPd/b7nkIesHUPbx3XX+FZddihzyBx1cdLL1DFxBnhP2in/d8Ba+3Yuqrnxe+Eo1WkHZtFDdzv3PhFa8Jjti8mRP65PK2lTewOuALosOPBE9jUSdGHR8lt0Px9B2b6R7YsYw5WySloWl7IalfefiQOkpMufq7Hc/RxzqtbfR7yEWRD/8tjOeHEOY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92011518DBDF6E479ED3716DDA388479@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9e885c-2eec-4a38-b575-08d634e019e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 09:57:22.9920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:51:35PM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-09-24 03:39:56)
> > +       clk =3D clk_register_composite(NULL, name, parent_names, num_pa=
rents,
> > +                                       mux_hw, &clk_mux_ops, div_hw,
> > +                                       &imx_clk_composite_divider_ops,=
 gate_hw,
> > +                                       &clk_gate_ops, flags);
>=20
> Didn't I already review this? I'd prefer we move this to using clk_hw
> based APIs and then return the clk pointer if needed.
>=20

Yes, you reviewed the v11, so you can ignore this 9th version.

I'll implement all the comments from you in the 12th version before sending=
.

I'll also switch all clk based register functions call sites
to clk_hw based ones.

Thanks

> > +       if (IS_ERR(clk))
> > +               goto fail;
> > +
> > +       return clk;
> > +
> > +fail:
> > +       kfree(gate);
> > +       kfree(div);
> > +       kfree(mux);
> > +       return clk;
> > +}

-- =
