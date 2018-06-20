Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B27C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13972083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWFI14b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13972083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFTCxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:53:41 -0400
Received: from mail-ve1eur01on0077.outbound.protection.outlook.com ([104.47.1.77]:47456
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752861AbeFTCxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxv3fv2Ygsh3pW6/ke+/0U/4WvKdu7oeBvoRBvOTbio=;
 b=cWFI14b3YDzRdCYKBh20hWXZaWhou0M+tDeVedgTie/2b7Ld3Vnj0mMGeXPcfHoiVfXhNZPncBXSAVpIFN6LTjq9G4K7JROOeYCWWk3IrgIOa1T49Gum9LnvcPChzFzra8MCzhBOHrGOt1UjBtAR7xkimGgBserwRYFiYgz55bM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4516.eurprd04.prod.outlook.com (52.135.148.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 02:53:35 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4df:6e44:6fab:ebe1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4df:6e44:6fab:ebe1%5]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 02:53:35 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Thread-Topic: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Thread-Index: AQHT9BSLZakbaB/d6k+ADoO1VMpzWKRom4gQ
Date:   Wed, 20 Jun 2018 02:53:35 +0000
Message-ID: <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4516;7:zpbMw3GMyKpn8+mR5j/5WKjF8xmI/37oUXHB0ecB8QBr2AeHA6iRUAJQJuc3Z5TA6LX+HtLxuMdbMKSRJa00l9Snlzxsi2d9Q4lxN9gHWIEQcfjAzSCF/RzgB0CgJ1+An7odaa9tuMGGkMTihDNMjtUq+9dQ7B7YxbXO+gdFOJoIx4zY5I73UNdEPFS92GtagJs1l9uZ5/2V4tnu4IIMEa1rSxFrNY/3CHdChfLCc+ZMirPKwguBUykQ5/9hoedC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: de59808d-247d-456b-a901-08d5d6590459
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4516;
x-ms-traffictypediagnostic: AM0PR04MB4516:
x-microsoft-antispam-prvs: <AM0PR04MB451605DA9B1F19B66A63061280770@AM0PR04MB4516.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4516;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4516;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(13464003)(199004)(189003)(6246003)(76176011)(5660300001)(316002)(6916009)(5640700003)(33656002)(6116002)(3846002)(7696005)(66066001)(25786009)(54906003)(8936002)(68736007)(2351001)(97736004)(106356001)(7736002)(105586002)(3280700002)(478600001)(53936002)(3660700001)(229853002)(305945005)(4326008)(74316002)(446003)(8676002)(966005)(81156014)(2906002)(6436002)(5250100002)(9686003)(6506007)(81166006)(14454004)(53546011)(2900100001)(476003)(2501003)(486006)(86362001)(186003)(102836004)(26005)(55016002)(6306002)(11346002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4516;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OuFzYm+DLaSYHvFUZSTWlqeQbqZhunQDeAg7KW5A8NFidBG8ZMwn1m9yos9pc+klLrDNRhEX8BxfMBCq02/MJNHkXXZ40IbkeGVvWu6icvpkth5wzLvgXCHH7USgcCry5KkNbqobheCUP4z2qPpfjDMSxt42qEK7kOEuoyNOG+iN1Mm3shvtYXksl1tDL4sLaYPYhE52zBrUH38v3VrqLfz8ljlIksF9OHConPbucL8yza3nT/5J6v58P21xXMTKWDuUad+oJcVJ4PIUsidT4mkzOxymXKKP7x/FiFZycuNaIPzwPmCzifVdbY2GiIL3Cv7vPGjXSbhdiIeE3JtKJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de59808d-247d-456b-a901-08d5d6590459
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 02:53:35.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping....

> -----Original Message-----
> From: A.s. Dong
> Sent: Friday, May 25, 2018 6:37 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org; dl-
> linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V3 0/4] clk: new APIs to handle all available clocks
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
e
> to switch to use clk_bulk_get_all.
> But patch 4 only test compiling. Hopefully someone could help test the
> function.
>=20
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
>  drivers/video/fbdev/simplefb.c | 66 +++++++---------------------------
>  include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
>  4 files changed, 180 insertions(+), 55 deletions(-)
>=20
> --
> 2.7.4

