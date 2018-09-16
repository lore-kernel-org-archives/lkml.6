Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C3ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01EC208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mM+GvAfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01EC208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeIPSr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:47:59 -0400
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:62529
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728350AbeIPSr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wjciFfZUZbFfpwFtTyQkXkSbFC99twF6mxmukaqCHM=;
 b=mM+GvAfULeGXSQgGn513qu+q0uWZScRjBkZW9raqrwV1EKq9RCbNNE7u0fHx3B6jtu/XwfjrzfWi0rhENfGNvaX9rIBXr5LMBafcpMYlmLEbr2YfTig5CzuGurzv9gTohk1etaLB1ZynvU+xWX39ROtcfeIjwwIfIEfmzB/hcSk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4977.eurprd04.prod.outlook.com (20.177.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.19; Sun, 16 Sep 2018 13:24:58 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802%5]) with mapi id 15.20.1143.017; Sun, 16 Sep 2018
 13:24:58 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: RE: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Topic: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Index: AQHUQOYAqzg0fl5c6km76P92aepQ6qTin9AQgBBfjVA=
Date:   Sun, 16 Sep 2018 13:24:57 +0000
Message-ID: <AM0PR04MB4211A3900BC5A2DF857F7451801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4977;6:EZupptMlKJf1YVp5q2XlvR8BfnRQeqKW94seyxiYAZYHAZALhQnixXAaoOj2siltgbt268wtdzDLUgYb68c5bRA01ZS3v0d1MoRcEwnkqYOx6OWXkS5I6ZVb5X9n9eq6trHvR+lg/lUmIZtYY2s1ZnZIbsCOrF/VvTYP4wyXYHWAfWz2+j3b1KpFMJPRR94d6zuGQcCgt1N0iWb/DIf1+xIcI/WqTBEpoEwmUZ6jtBktrkrVhECK0WJ7Kltj64uf01rGmhpNrwTnCZGVcv8bkMpCNSwzR5uQcdjB9inO+BxIT1bi2jY83KBC85PJ8UauhaEl7d8X9tbzrUUn8oq2KhPB5aQ5hHZz9zOz5JI12pjGdc7RnQ1XbBi3q+chJzAh2mRc9EkKdKZbU+pIKY0iaYDWnk9kOuqtstfroTWWl4+ymKitM9c05J8iyqoOWweZ8kkFbe0vc+BuLc3HOyUZjw==;5:aVwMJkX4885jAvtphO9MCa/r1EkCPcB88+7RS6pZgPtRAQyN+FF4hC6RMt+brNfzlwmpqVDoBiB4RvGcc0WWFcp7anQmSeGmRjGO48VgfjZnXvi9Z8UpSg3WkeAmNfVTvIibBknz9beoFkRGx/Ko5NmplOdA39jYVyovHn77u3o=;7:nXnJvGnUrhd0E3/FgEhHBMTkzxC203oWoiHz5vnh6Rr7eEQ+V6Qfe6t7jvDt5u4Mp948mNx4UzKad8HcX7GeFMEC0eznSeeCcmVcgvxpYgkZAvh/TsVdi/GCVgVQdwuqfhqLIX1Lvnj1cCrJDuU0z5f+t+JWCqU/uDDe+F7nS4hd0W/pwf0epQ7FC8tItz8v7WXWfLN3VX3Nbq8mv/oMhbTrnCVN8T1YlPjhFgnOTApqLUtOfZjXRx9B206vU38P
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 75f775b7-7b22-4ceb-5fcc-08d61bd7cc7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4977;
x-ms-traffictypediagnostic: AM0PR04MB4977:
x-microsoft-antispam-prvs: <AM0PR04MB4977B89F30F293EE211434F6801F0@AM0PR04MB4977.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4977;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4977;
x-forefront-prvs: 079756C6B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(13464003)(81156014)(76176011)(68736007)(53936002)(446003)(6306002)(55016002)(81166006)(186003)(5640700003)(11346002)(6436002)(229853002)(102836004)(8936002)(26005)(2900100001)(2906002)(8676002)(14454004)(966005)(106356001)(9686003)(478600001)(6506007)(476003)(33656002)(7736002)(74316002)(305945005)(66066001)(53546011)(7696005)(6246003)(316002)(54906003)(97736004)(6916009)(5250100002)(2501003)(2351001)(86362001)(4326008)(99286004)(486006)(105586002)(3846002)(6116002)(256004)(25786009)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4977;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bPY44VWSKbPaJ/FEfYgG5wlSh16DCY7RaqvYwbsZWSXWpV5eL4zy9B/vzlik+alVSyNg+ydUMNK+hFB3jxKxWbw5XOs/PnALgMrCX/NrnzK0IFftqawr3cPbS9wsARdZdL6/deBJezzGM8Hgu56jkBDqgM8RzTTWGsdH9V+Xgn0fZRVj45ybirW6/oexmL4etzUMK4XDcWKSiEZmSOMu/ZHW+kMFSd6f9YASgNIDAGhH2+PUyUYRma1N8qkowH+gfNKzOP3HDtuPhYLgJwxC5o/VWlEkycvI6O/wR6njCskAXAk7Shgnxp8ZjaTrySRdlswKIqAZUjtTrlN5CNWJAl+M5jh/yCZ3KDF08c8keDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f775b7-7b22-4ceb-5fcc-08d61bd7cc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2018 13:24:58.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping again

> -----Original Message-----
> From: A.s. Dong
> Sent: Thursday, September 6, 2018 11:23 AM
> To: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> thor.thayer@linux.intel.com; dl-linux-imx <linux-imx@nxp.com>;
> hdegoede@redhat.com
> Subject: RE: [PATCH V6 0/4] clk: new APIs to handle all available clocks
>=20
> Gently ping...
>=20
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Friday, August 31, 2018 12:46 PM
> > To: linux-clk@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> > thor.thayer@linux.intel.com; dl-linux-imx <linux-imx@nxp.com>;
> > hdegoede@redhat.com; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: [PATCH V6 0/4] clk: new APIs to handle all available clocks
> >
> > This patch series is a continue of discussion from here,
> > https://patchwork.kernel.org/patch/9986293/
> > that some users may want to handle all available clocks from device
> > tree without need to know the detailed clock information likes clock
> > numbers and names. This is useful in writing some generic drivers to ha=
ndle
> clock part.
> >
> > Note:
> > This patch series is tested on MX6Q SDB cpufreq driver with a minor
> > change to switch to use clk_bulk_get_all.
> > But patch 4 only test compiling. Hopefully someone could help test the
> > function.
> >
> > v3->v4:
> >  * improve 'devres->clks =3D *clks' according to Stephen's suggestion
> > v2->v3:
> >  * address all comments from Stephen
> >  * fix build warnings on other architectures.
> > v1->v2:
> >  * add clk_bulk_{get|put}_all() which only supports DT platform
> > currently
> >  * remove _all variants and the wrapper struct clk_bulk
> >  * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
> >    proves they need it because they don't have a struct device pointer.
> >
> > Dong Aisheng (4):
> >   clk: bulk: add of_clk_bulk_get()
> >   clk: add new APIs to operate on all available clocks
> >   clk: add managed version of clk_bulk_get_all
> >   video: simplefb: switch to use clk_bulk API to simplify clock
> >     operations
> >
> >  drivers/clk/clk-bulk.c         | 80
> > ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/clk-devres.c       | 24 +++++++++++++
> >  drivers/video/fbdev/simplefb.c | 72 ++++++++++------------------------=
---
> >  include/linux/clk.h            | 65
> > +++++++++++++++++++++++++++++++++-
> >  4 files changed, 186 insertions(+), 55 deletions(-)
> >
> > --
> > 2.7.4

