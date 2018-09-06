Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF24C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E728E2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q8Pad43Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E728E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeIFHz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:55:59 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:9536
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFHz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBGJywUwg49aVm6UoHTWhevok+3ct3OxzGz/K5PkaUQ=;
 b=Q8Pad43YMew6s3SfBfoTG3VdsaWoiu1hUmPId6JLSfVTLJ8fenymYvSscIdC1u4l3JG5/Q+WVNZS0fgRy0SU5Luu3fNLRKyNVeltZVGxIaCMCKb6wZ3yL1O5brzksjkVAGKyRdi5q2CZAobG7lmKYT9zxR1elXHmaWrKo5jnfBM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4547.eurprd04.prod.outlook.com (52.135.148.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Thu, 6 Sep 2018 03:22:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802%4]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 03:22:42 +0000
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
Thread-Index: AQHUQOYAqzg0fl5c6km76P92aepQ6qTin9AQ
Date:   Thu, 6 Sep 2018 03:22:42 +0000
Message-ID: <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4547;6:itku6Ko2Ulj5/Y59UQ27rwjW8JMR8vzJWTXzdwvENbetnrFaEOpgy0X5W136Ne4m4YJlgx+CtJn1YCNgMhi9Q0xhowYrhq+82+azWmkdT10myLcx7qIhwgYYUkU3y2WjvEVhfhcVjr3JgFCM0fQ5nM1p0Q/C3mo3DHAHDN7+h8vg4tutxyVPk8x3Xwd0yl0sYskUe7zHHwGTmo6Yxw7q/WppeFc6IV5BPhlCG2naJsMTNP8Db+xLqXcAeMJt0UY3RUiOZ28rbs7hfKMUXFZdDSadF+XXJ0Y1mvgnwKwtu+dtXUBzbf7vLhU6azb/e4Yr3LopkbiWHrmCvPItDLgEau1Neqt10XxDe50NpmFYCRpOVmlejeflVARImPE/Nk1zMifaX4TPZj/GBOasFeImpuA8i5uUkd8Eb1xyWd50oDu0cvfdaxx5ENcthrPmnW8Ie9oZe2rstEPYLsBo+pm6vg==;5:2MMujGkZq5gddxLcF+asvnw6JG3X33j6ALWO7WuUW9u1CmXaf7zqaewu3hhtE7/56N6vp5CRlXG0ne69b4kFoUZq4GsnR0GTqW6yInpt9PZ0d/IMOgq/bRW0mIhhED71u87QnkQGRkBIdtqMrWjZKCz6n86nJDRYAxnlLa7sUBU=;7:m3OkuluNHxC19LRJvcaoohsSaSRQuX8SJeYpDy0wc3vBTAPbklX5pwFHw+U4+C4OX0sH828lkkznNEs5XhRbETmVMn7/kFA7cY8kAKACYfIvaPCX/OKOdyPvbHOiq3isBJ5U+RTcmIdGXlQlESmBjnRvTg7ECFGG6ybNLqF34SAfvV5xsFNcOfoj7/L1b+a+WO/tQnEpfJN7c+JIel2dbrBQc74b/WH47sAzFmtdJYYZ8gBhKKRAaSibyFxO6Xrl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a56d0f36-a701-40ba-28e8-08d613a8020a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4547;
x-ms-traffictypediagnostic: AM0PR04MB4547:
x-microsoft-antispam-prvs: <AM0PR04MB4547976493E40C794BFBC52B80010@AM0PR04MB4547.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR04MB4547;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4547;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(366004)(13464003)(189003)(199004)(74316002)(6306002)(2900100001)(446003)(8936002)(86362001)(105586002)(4326008)(81166006)(81156014)(3846002)(11346002)(53936002)(8676002)(6436002)(6506007)(53546011)(486006)(5640700003)(229853002)(305945005)(55016002)(2906002)(9686003)(7736002)(476003)(2501003)(97736004)(256004)(966005)(7696005)(33656002)(25786009)(68736007)(26005)(186003)(316002)(14454004)(102836004)(76176011)(6246003)(106356001)(66066001)(6916009)(5250100002)(6116002)(99286004)(478600001)(2351001)(54906003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4547;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MNY5jlE1oMAAum7X8OQA5fH0v3rlel5+Og9KTwVE6O534XbYV+8MmbI8fJN8lcbxe6XYHCnFIBOxha8NQ3FECnbsR80n603QQymMTETIvawyusOUWHYP6RApM2rkdGn8pTxwdAl6WpPAf+s/ZFvBkdQCCnmjeXPo6bEv4Eoi1fmx1lfApuNwEFKAsaR8XUcM5GImekFPyyQG1QmNFGGACOwsTVktLsFuPyXeHiHgRdpCaWJ/0uaF8bXwAZtsIZcOBq3a2V+Bs7XvEBz2X/3rXxvLE3LzGHt3iqKYjH/pYa/37lHcraxyCjSuGnU271CCRIhD2a3eCvulCakSFfFzCQfuEDsIHR9b/9Nb+SMATTw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56d0f36-a701-40ba-28e8-08d613a8020a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 03:22:42.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gently ping...

> -----Original Message-----
> From: A.s. Dong
> Sent: Friday, August 31, 2018 12:46 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
> thor.thayer@linux.intel.com; dl-linux-imx <linux-imx@nxp.com>;
> hdegoede@redhat.com; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V6 0/4] clk: new APIs to handle all available clocks
>=20
> This patch series is a continue of discussion from here,
> https://patchwork.kernel.org/patch/9986293/
> that some users may want to handle all available clocks from device tree
> without need to know the detailed clock information likes clock numbers a=
nd
> names. This is useful in writing some generic drivers to handle clock par=
t.
>=20
> Note:
> This patch series is tested on MX6Q SDB cpufreq driver with a minor chang=
e to
> switch to use clk_bulk_get_all.
> But patch 4 only test compiling. Hopefully someone could help test the
> function.
>=20
> v3->v4:
>  * improve 'devres->clks =3D *clks' according to Stephen's suggestion
> v2->v3:
>  * address all comments from Stephen
>  * fix build warnings on other architectures.
> v1->v2:
>  * add clk_bulk_{get|put}_all() which only supports DT platform currently
>  * remove _all variants and the wrapper struct clk_bulk
>  * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
>    proves they need it because they don't have a struct device pointer.
>=20
> Dong Aisheng (4):
>   clk: bulk: add of_clk_bulk_get()
>   clk: add new APIs to operate on all available clocks
>   clk: add managed version of clk_bulk_get_all
>   video: simplefb: switch to use clk_bulk API to simplify clock
>     operations
>=20
>  drivers/clk/clk-bulk.c         | 80
> ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk-devres.c       | 24 +++++++++++++
>  drivers/video/fbdev/simplefb.c | 72 ++++++++++--------------------------=
-
>  include/linux/clk.h            | 65
> +++++++++++++++++++++++++++++++++-
>  4 files changed, 186 insertions(+), 55 deletions(-)
>=20
> --
> 2.7.4

