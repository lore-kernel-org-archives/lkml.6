Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C372098B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYPwP41/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C372098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeHQFf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:35:27 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:41166
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeHQFf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1VLVmaZbNtFcEvfKF9Xxfr4M7ZiYOzVaM17kNgucJE=;
 b=lYPwP41/zfN9YBI5iS1ZqcZbgVSVLIqUhHm0B7U05YgSS1MnjcBfOQCWnMzjihZAPKxKqoEyFuYALXZ8dvQjMP85Sa6eV4igzRc/cO7Mf/OKW1QsYehGpcO5OkdoehGyItFPyD0xF39Ifdkvbt3sAeMB6bTI/zJ0iNVV3MwXTkk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4772.eurprd04.prod.outlook.com (20.176.215.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Fri, 17 Aug 2018 02:33:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9d03:cb77:db21:fa1b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9d03:cb77:db21:fa1b%5]) with mapi id 15.20.1059.021; Fri, 17 Aug 2018
 02:33:52 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Thread-Topic: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Thread-Index: AQHT9BSLZakbaB/d6k+ADoO1VMpzWKRom4gQgFsgTNA=
Date:   Fri, 17 Aug 2018 02:33:52 +0000
Message-ID: <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4772;6:QP4y9GgMD2l4XymGwpdXyalpg5ekPlRi3GqUc6Mg+4wiR+OvhGOWyVcAdFCFVCeCAOWK7sqyVP6ShpNfDei9wQtKm8Izuu5QNvGcTJ3naUqZoNazeeNxA/thHD3HRLU5P6jJ6kgZZTIBJESiHfif6pzsdTasqar57P/imBKHcA6ZRwIQXqxfNDWOnxkIEJHPOi69ygaolo/kSfXMkrFke7TnrWN2mLClKml2hgHlsiumLurGpb4sWhVqwUmsNtumE/F5L4UGzf+4dKDGIt0dHA8baiZOfVoNKRKC9q4ZwDGP7Daqe3AoLvHUrd8aQMeM31YMPFmEJ0tiX0VrrPeldXb2l1k3IvC+3Ophcu2LOkv9FiudoANWir/OsljXuzE3jPGeWJJBflSC81Gg1vzrzMdVfltJrJMzcMR4A/By+Nps5FvKVUZUrqMpdzhyAvTwId6+eVd1ypv2G35Vu7pOyA==;5:9N3LALiXe+LVVG5yBRgtFIgMOQVvMkhcZRraVrnsNYXKTchA8ovX+AA4itE4rM5lDYrOMgK+nfC8JTSjEtW1FjjffCyQIdoikg3Utu2A0f/FEz3HM9cpKkGoY83PkeL6YCMgFNuVnaHUkAIkc1GKynsSAMuwZqNWIZCluBroMiE=;7:qPNfoTeL2CjTVqIyy8gJoDaNQVt3qhSKP8OJKV3WpIz1uyNbfwRrKcPkXEhTukqfugAKbbeRRFemG9tVdr7+QJ4U3pd/VErS9Q8BoaSyJDCRP/mbeLaLGKRU6/NzGOTZMVtCF5tPejqNFZ3IT51fq6MjksjdV+0u+lbHcvorSuWq1rURUNsdSf1tGp9KWC7swUI+xqVP6JWupEqphrt+DwH6VnXeN/KOYrxe+HTwfTno7rzcg7BwVamtYN1Zqk8i
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 68ff3666-f2f7-4fd3-c47c-08d603e9df50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4772;
x-ms-traffictypediagnostic: AM0PR04MB4772:
x-microsoft-antispam-prvs: <AM0PR04MB4772F17E17A6125D025FE61E803D0@AM0PR04MB4772.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:AM0PR04MB4772;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4772;
x-forefront-prvs: 076777155F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(13464003)(199004)(189003)(1730700003)(14444005)(256004)(102836004)(55016002)(11346002)(6306002)(9686003)(53936002)(186003)(446003)(25786009)(6436002)(97736004)(33656002)(6506007)(66066001)(305945005)(486006)(2900100001)(53546011)(26005)(7696005)(4326008)(5640700003)(74316002)(76176011)(99286004)(5660300001)(7736002)(6246003)(3846002)(6116002)(229853002)(86362001)(8676002)(966005)(106356001)(14454004)(2351001)(68736007)(316002)(54906003)(5250100002)(478600001)(2501003)(8936002)(6916009)(81166006)(2906002)(476003)(105586002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4772;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k7B+1MwWrZtetXWq5nBw5Ab7BLvZvUOqOymAZmRHGsJjEJBHlDXJJYKDf1+BQIt/stgMVjbDOLuZaVeHUOEmLNaIw5yl1m92N49x2lq8guv9fjNS8gtJMcP7Tb82uyFuzjiPRbpSuiPmA7qycYl3paQV1T+m1lq3msEHST0BR4CHucFaJ8tn+EwwRZIAj4r39rmgSeU82AlGieZgty9cmOw9lTiqoqzlTUflbA1SHWhNI9fapSDgJ5cmGfkZdIhaLYg8ZxPKxwpPg7hU9SFdM410vBkWnDJcX5PJYA95Zkh45mZ0u+Ux5a4Gtke5u5FGFWZvh22R5YNfXFCNquteIrPzrQ5R7gycvnJn9gr6xoI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ff3666-f2f7-4fd3-c47c-08d603e9df50
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 02:33:52.7285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Do you want me to resend this series for review?
It seems have been pending for quite a long time.

Thor just pinged me for its status as he wants to use it.

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Wednesday, June 20, 2018 10:54 AM
> To: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org; dl-
> linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH V3 0/4] clk: new APIs to handle all available clocks
>=20
> Ping....
>=20
> > -----Original Message-----
> > From: A.s. Dong
> > Sent: Friday, May 25, 2018 6:37 PM
> > To: linux-clk@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org;
> > sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org; dl-
> > linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: [PATCH V3 0/4] clk: new APIs to handle all available clocks
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
> >  drivers/video/fbdev/simplefb.c | 66 +++++++---------------------------
> >  include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
> >  4 files changed, 180 insertions(+), 55 deletions(-)
> >
> > --
> > 2.7.4

