Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20871ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D230C20843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hUbIbfCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D230C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJUVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:25:07 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:64912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727613AbeJUVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4dxKRxADGByl06ImxIU8efnlwzpLckm5BO+cuZMrYM=;
 b=hUbIbfCDauHghMlIbEiLa778fQyLoKb/Lu8UrH6ZttwS35jAwJ0jRuWrJ8DqMmJE+Tfk368booZ5N0RWty1yqKqI7Njhb6aa6XEBM4nHyl/nTKuO1AE2O1VxxOa1bcu5sCGhjxWWV4mXDedRBnfdSbIas+PDBpq6jj2Ti9LzvqU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:10:44 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:10:44 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUaT95oCO6Jr50e0qyeeRGaZQa8g==
Date:   Sun, 21 Oct 2018 13:10:44 +0000
Message-ID: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:BMiVxfu+Bm44TIWvdMr3aDfpnh+UdHcwKYJQpvya4OhyRf7ZS7jEjTfHZ/2HvEv7KJRkALSDNjn30YJvMWhblUE7WhQAsVvKFPd8tDXP6FlIu5pkoGyi4J3zmzIGQ0IlwiVSG4eQ9eb/5o1KSi0TvlzzxIOwL2yP+1+Nxw68HFKxxwYAoMpEPV4iLzC6lhfvHeA44LxIfvr+xBgHnuDnra4Ngfe09PIz5eIGkC72leoMKFzCl0Msh7uykXTeKqT3VKK2RJ2F3KHzKSFvRmglgMeUMgodgKU0PLGL9l8/7haYlDr/FbRLieuRel++JCyijBk+Mm4GSKUgJcEQpqM6g9gtSZktc/Om9U2z6wtNEfOETWuAhU8UT7Jh1zj7ivpQalk+xle1xio8oNs7KyiLAsXIGLLa+WZzsRdqkmTdEO0o6+T2zcVX608Li0YUiPqYKvocBI3lGGlLynwGuqeJ8w==;5:Q0CTxgt3HzILXAWI9V00KuBWd1NPuYUl+g+95lRPp46ZcsorIYidFSvbo6nMkI5RxERvQxY7YdHdt3+XuzDQgyCpy4S7vKypstGy1sWgOoYEwppE7eL9/2fUKcSwpqfwfYBwYAZNuSArc9AMYOK9B2RmhoamG5IPZYwYCa1H1l8=;7:EXsCUWeO2S23YlWe/Chv1Se7FcuP1tQq9O+GO724umjeE3eod3ez1Rl91d9PnelJd1bQaai0oh69DDM+H/XmNtrkI3CMcdus7YtozQ6OTtWIUe4JCLOL7V+zakPfJ7uCujOZ/J3zax0G5Cumd87HDi2RgzUwM7rh2H4Msct5CvumEXQ/LbhN70NUlqxuyf9nTxAgF6W0w+7x7fWnsdX4SPJzeNwvUs5XGZcy43GgcG7Wc5cGd5LzXNR08dvEnyHW
x-ms-office365-filtering-correlation-id: f0e1d3f7-255e-4bc0-91fd-08d637569be1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB458005199A6DAD56F117254480FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(199004)(189003)(476003)(2616005)(66066001)(54906003)(316002)(26005)(52116002)(99286004)(486006)(186003)(7736002)(386003)(6506007)(305945005)(102836004)(105586002)(50226002)(86362001)(106356001)(256004)(14444005)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(6306002)(6512007)(53936002)(2351001)(6486002)(36756003)(966005)(71200400001)(478600001)(5640700003)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gmNPx/cGhX6X/AtsFJOvw7p0zzto7U3hWfEj9QQkBYi364wZhWGI2SkxlVBstC5N980WRAMb+FoauXNrkEPcSRY9SYsBJ1hZC/Bsel7EKrx9/+tlnG+Yo6y9RECGq5SlLBilC3fOxvkJIfXzoOP0dQifPXI/k8BvAnMJi0k2O8bAW/KnHJ3G9of7Xps3y73IGqy9D3u0E3V9SGN5A8UFlnSfvORvqF5CFVMt2TF7CzPfa+vNOzKl63n8GvhNWDJzc9bWeTyWoskK7REmduNoubq2xEOWbMdZzLVquP5Z/XJv/e2zyDDaX5e+q1QnsNrdLU6jgIQrFDqVn8F+gPnY/zdcKI3CuQPx+9Be3K49090=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e1d3f7-255e-4bc0-91fd-08d637569be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:10:44.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebased version of below patch series against latest clk tree.
[PATCH RESEND V3 0/9] clk: add imx7ulp clk support
https://lkml.org/lkml/2018/3/16/310

It only updates the license to SPDX format as well as a minor fix of
pllv4.

This patch series intends to add imx7ulp clk support.

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

Note: this series only adds A7 clock domain support as M4 clock
domain will be handled by M4 seperately.

Change Log:
v3->v4:
 * update after changing scg and pcc into separete nodes according to
   Rob's suggestion
v2->v3:
 * Patch 1 changed on: 1) split normal and gate ops 2) fix the possible rac=
y
   Others no changes.

v1->v2:
 * add enable/disable for the type of CLK_DIVIDER_ZERO_GATE dividers
 * use clk_hw apis to register clocks
 * use of_clk_add_hw_provider
 * split the clocks register process into two parts: early part for possibl=
e
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.

Dong Aisheng (9):
  clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
  clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support
  clk: imx: add pllv4 support
  clk: imx: add pfdv2 support
  clk: imx: add composite clk support
  dt-bindings: clock: add imx7ulp clock binding doc
  clk: imx: make mux parent strings const
  clk: imx: implement new clk_hw based APIs
  clk: imx: add imx7ulp clk driver

 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 +++++++++
 drivers/clk/clk-divider.c                          | 152 +++++++++++++++
 drivers/clk/clk-fractional-divider.c               |  10 +
 drivers/clk/imx/Makefile                           |   6 +-
 drivers/clk/imx/clk-busy.c                         |   2 +-
 drivers/clk/imx/clk-composite.c                    |  85 +++++++++
 drivers/clk/imx/clk-fixup-mux.c                    |   2 +-
 drivers/clk/imx/clk-imx7ulp.c                      | 209 +++++++++++++++++=
++++
 drivers/clk/imx/clk-pfdv2.c                        | 201 +++++++++++++++++=
+++
 drivers/clk/imx/clk-pllv4.c                        | 182 +++++++++++++++++=
+
 drivers/clk/imx/clk.c                              |  22 +++
 drivers/clk/imx/clk.h                              |  92 ++++++++-
 include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++
 include/linux/clk-provider.h                       |  17 ++
 14 files changed, 1166 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.t=
xt
 create mode 100644 drivers/clk/imx/clk-composite.c
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c
 create mode 100644 drivers/clk/imx/clk-pfdv2.c
 create mode 100644 drivers/clk/imx/clk-pllv4.c
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

--=20
2.7.4

