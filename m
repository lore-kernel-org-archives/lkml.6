Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53484C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C1821927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d5WInQoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfBORsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:48:47 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:41470
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfBORsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY3+39fNVIPT8IjzAAwfL5Cy+Oigg+Jwu6nGciF7UAA=;
 b=d5WInQoAcK/+VDvXidD+k/m+edeUHGU5NdSXEPEsZGikeQvIBd9pqo+PfrTJ+2csHyWwEkh0tJv20FKEDm2KsilqmRFExuzADrTzMds4U0R/Wy060mHnrxNGb4lpQ7SRLMlUu91IxtWxsb0pjzj9nNvDFQ5wphn1uSfr2jZAKfk=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5330.eurprd04.prod.outlook.com (52.134.93.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:48:42 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 17:48:42 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Rob Herring <robh@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 0/3] Necessary i.MX8MQ clock updates in order to support
 cpufreq
Thread-Topic: [PATCH v2 0/3] Necessary i.MX8MQ clock updates in order to
 support cpufreq
Thread-Index: AQHUxVawLLfUipUyyUOHYLriSSAJag==
Date:   Fri, 15 Feb 2019 17:48:42 +0000
Message-ID: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:209:1::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee5c59d-5a00-4e79-733b-08d6936dd34a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5330;
x-ms-traffictypediagnostic: AM0PR04MB5330:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5330;23:f1scSmDqGxE1F1fVp4jxWzXDW/vyOa7IsZEsI1M?=
 =?iso-8859-1?Q?/rzv8rBir8zdRHpel6mxT5SmcrCKZrL6S39bKyz3puEs41xRQKUeKV+Rl3?=
 =?iso-8859-1?Q?7C3acXEQHJiPthWotTg4bqmpby6Bj0eENdI4fToYWyL5rX+DbT7HSSaAB3?=
 =?iso-8859-1?Q?CBIRi+5EjnnIb90zHgZbYyT4Ef+Er00Clrza0LUzdCzvaSWEUyulgl9nJA?=
 =?iso-8859-1?Q?f+MbYLwdToRlfr0PM2clHrY2Q5Czjvgsv0bhBVNCcxrkOfTj5jpV7rN1Q4?=
 =?iso-8859-1?Q?JaPhwT+pFGcMCwZbnBpNFJnXUBPgxVgBs+cqN4oGlvoUARNgLQCe7QF18S?=
 =?iso-8859-1?Q?G13En1r8UJGagUeRLiXqyuyYWzkxAazGWn/N9/dZEbijR/iYu1VXQpKhIt?=
 =?iso-8859-1?Q?eD5R2hKJ1aj1U1gLlmxy31CmB6fzY7W3PjFj7Kxz2phNN7wuZlViRK4d3P?=
 =?iso-8859-1?Q?4RVV5dj2fsshOFCg15hYQq4uNpSsidrSXjbrf2RkRKt1XjPuTx+Mrq04wi?=
 =?iso-8859-1?Q?1M9eX5lQ3nNMSjvrjT+Rxe5/ZNfuZu+bfjFLYvYkxsF2IR4QAKUUJmYxZA?=
 =?iso-8859-1?Q?fyulVBcwoX5dVzhodk7+/Joa9c3lY2USSXTl0mvdk1gpCTL/xnhF/biEpw?=
 =?iso-8859-1?Q?X9Tsvk8ypNo/F4r+OXTR+DKzHRBrulH6upsTGdsa+QXLzXlX+EE6u9jPPG?=
 =?iso-8859-1?Q?vQpp6eGuMbkQ8bjTx8CTZFtA+JAW57HVMl55Rr54KiE+zrUuz/foLYHgj2?=
 =?iso-8859-1?Q?WvL380SgnskAXAqKh0r3BaK29+kHinRz37NtQHCFeG/9Qu7h9SN66iLoN9?=
 =?iso-8859-1?Q?oykkChj1UvAy9Zq0u6OuLqHCI9dciemaNy8LqknrQtws5jAt6G70i+EGUU?=
 =?iso-8859-1?Q?RG3iJlBS+0LcvYXCuHz+R/kBHVH+KCM+v6CMrRMLUWJQi+an+pqUW5wW1E?=
 =?iso-8859-1?Q?ixZSQ0T2i3yIrLp0AE1nE1BRjAuEycOH1qIbFnTJk9PrXPRb7mggNrY/o1?=
 =?iso-8859-1?Q?rEAjrhPufLnqJ6ZL83o0+MQHLaXuRi6l3iAOCjg62vTv4auzt79jVuVTEm?=
 =?iso-8859-1?Q?dTtzZKBATCcq7D0SVfYVRaU9/Sw/VU4RHni+YsHN5gDj/UlCr4R+J2PP3I?=
 =?iso-8859-1?Q?pudMiZEWIlAc3JjZ27bbSsbNfbYYJXr873AI6JTZ8KWsUpxzKasivrypIY?=
 =?iso-8859-1?Q?8h2qImOrNiFxWuXKsMI03eQ6vFgdnbDNMHa2E2IwnhQTzPePXebg7kay3U?=
 =?iso-8859-1?Q?cH4D+djhoIVkuHW2g?=
x-microsoft-antispam-prvs: <AM0PR04MB53306866800ED10CC56FA3EEF6600@AM0PR04MB5330.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(6436002)(14454004)(6116002)(3846002)(97736004)(186003)(478600001)(476003)(110136005)(71200400001)(105586002)(106356001)(26005)(71190400001)(68736007)(2616005)(86362001)(6486002)(966005)(50226002)(54906003)(316002)(44832011)(486006)(7416002)(99286004)(81166006)(81156014)(8676002)(53936002)(8936002)(66066001)(386003)(6506007)(4326008)(36756003)(25786009)(52116002)(2906002)(305945005)(6512007)(6306002)(256004)(102836004)(4744005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5330;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6GNpSoOe8VtR+WLOWkSBVXUtXvAr16EllBr0V+lEmseyaXAvEDgc1tmOyqeFAot/XhU4beVABquhlvlxuNGcYZwNxgfB6mtdYYe7j2YCoFV1YtsURQw7vDWvRcgccMSTRjQrpNuEpPhtJRS2AM+ZMfOYYCtZ12gLSH/LESD8UPsXzzKKstXyT6PGE58UQsF5ZRyzOVNksE+Yfa3mdQW0d2yZ7StgRArszQfvlfEsYcwAJ2OGAsOn8VVQFUfqmHfvShc/juB4uZYZDTd66B5tUwUb1zAO0sA/GQqsDESzoro4MS09KZM6FDwbZXW7HquBdkT/XAHpZo+goY7QIkOEdk0eLfJpFC+ox+OC+GinD2P7PmNy0VwnkeLMa9ifBs1nblaJ3fD35tGzQ/Cxt1pzQggnHjg7PaVnAfUj0J/rKlY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee5c59d-5a00-4e79-733b-08d6936dd34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:48:41.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically the v2 for the proposed clock changes in the
following RFC:

https://lkml.org/lkml/2019/2/13/1111

No changes here (other than adding the Reviewed-by tags).
Just a resent as a separate patchset.

Abel Vesa (3):
  clk: imx: imx8mq: Fix the rate propagation for arm pll
  dt-bindings: imx8mq-clock: Add the missing ARM clock
  clk: imx8mq: Add the missing ARM clock

 drivers/clk/imx/clk-imx8mq.c             | 8 +++++++-
 include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

--=20
2.7.4

