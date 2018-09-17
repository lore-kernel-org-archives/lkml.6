Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D51ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787F42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QkPI+H+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787F42147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeIQI1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:06 -0400
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:58413
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbeIQI1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RLzObtBMekgQjqvblilnajSfXOBOwCFJ7HmDakS8NU=;
 b=QkPI+H+2I30KosLxqCHyWAKmbvswe0AhQOMgwCNcevR6jGGCBB6HgCOBaBU31cgOEv4b3OwTt/fApuuBn0tuiaaZNjvuXHi258WajSgIWt4rGWQZ4a1oNqShlKVwgRo/kqqzAYpAF7/NDE3UEdEDfxXmIlmSyy3Ga4oafSD87p8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 063/136] mtd: rawnand: atmel: add module param to
 avoid using dma
Thread-Topic: [PATCH AUTOSEL 4.18 063/136] mtd: rawnand: atmel: add module
 param to avoid using dma
Thread-Index: AQHUTjKkJiRd+3m2jUW1g3G5BItKZw==
Date:   Mon, 17 Sep 2018 03:00:51 +0000
Message-ID: <20180917030006.245495-63-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:mgEbVTJClll3GzMs/VwPPxy424C9MWXn+gMivvAJyjT4M5OiGX1SCdKGDEC7NDcOS9Gx7bbEgSz6eO8xdHos0eRSHFuv6WuBt0Hzt0P++O5J62Yyap7hjH9YHTbQnvCUSbWnlgroYC5Lbxr7HsOGIflgMJ7VrCD1f2JR8MQvxqOftmRueCzz6CPp/dKvsMJ3WGHqMrXEMyWt0Gp2SBvVK2lEk61l+/32uPjAzG47aVG7tLFQKlgcAaM01FPqZc0Tz3Xh9NB4h+uOD+eksh8T6vvJrfKroK796/xIokvpPfD+CwEHGstY71Jc9t6g5ruM3elCT6UifeOBaxkifWmhVmFN8Z+t0IsCfGQqePSCGevaq46O5dI+bV9AB2vVCuLj4FCHwg9NzQNpp53JIAac1NyUcwZqKnycEHwmY2/pIjJF1E22UoDNlpSETgWIjkv0LR22D6b4cLAaMn9NgivukA==;5:11qsORZQUpKc+XlsnAB+PZFO1whAFWCP2dqTKMA0YQPmY7pmV1jIy6TwdxEf6yRU6T0tLM/dGOcuU72V7Fdhuu6ZzomiRk5wdlzDnI+9uLnzW2+8f0A+8RKczYCVGt2Dht5loW/6914yZ5u95FTvzDkLTKz3rOxs8CCAi/uqskI=;7:ibFbg2ZVBRhyCcc+1APa+nW0+gFYDmsLXd1jGkP/TuOMHSzc2MTDzG9/nQQqdloMK3DObG4ZYOpeMxm9wEhb7BAglUXm67W+kMAnwlKbq5XMPlD0Xo3uFRwtsZBZxc6uhY4vIFxcemqQRvTt45gu7LLaVVp73uDWJQueEwjOfyHFuAe9OQaubxUNCYMZa9TgGD2Dfka2FKQbf5a6Adkh7F5eDcu9QibXsY8j+iZtyVPUxL919WKptqUCvyINrymH
x-ms-office365-filtering-correlation-id: 0392a1b3-519e-4051-2191-08d61c49e8fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502EAF774B60505CE24EC8DFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(6666003)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z2AOP3E/NXLD9E2UtAsSe1kgdPNYFjWQ4j2e6NM/KlitlnWTnmnamHIdnWEPCrQ7LRFAVtD2locmPQv5YIsnNghku9TDsX4F4FyJTcZNZYC8vFZ15mXTCeJ50kHoUIJfVzYSdeL1zr39tRimd2F713CvX9JvE85PbXYvL+A8Tipg8Qvrrc+3ewAhcfDoSTFAiELLQCp1fQFEaBaR0B4Kb8ZgdWCUKEjRRFIFxQ/3Ays2lGOmDguYZ4L2h16bRn1lvp7pwjlWKp1y0RaeGDIfsWgg9XrTyqQmRd/8CvGdxPOsy/A8kXS7XujKQmPriEXyu3vD52VEkuukEzn2l3v2aysaLwhqot7iPNyYDOXxDEc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0392a1b3-519e-4051-2191-08d61c49e8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:51.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit efc6362c6f8c1e74b340e2611f1b35e7d557ce7b ]

On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
flash accesses have a tendency to cause display disturbances. Add a
module param to disable DMA from the NAND controller, since that fixes
the display problem for me.

Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nan=
d/raw/atmel/nand-controller.c
index 12f6753d47ae..e686fe73159e 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -129,6 +129,11 @@
 #define DEFAULT_TIMEOUT_MS			1000
 #define MIN_DMA_LEN				128
=20
+static bool atmel_nand_avoid_dma __read_mostly;
+
+MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
+module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);
+
 enum atmel_nand_rb_type {
 	ATMEL_NAND_NO_RB,
 	ATMEL_NAND_NATIVE_RB,
@@ -1977,7 +1982,7 @@ static int atmel_nand_controller_init(struct atmel_na=
nd_controller *nc,
 		return ret;
 	}
=20
-	if (nc->caps->has_dma) {
+	if (nc->caps->has_dma && !atmel_nand_avoid_dma) {
 		dma_cap_mask_t mask;
=20
 		dma_cap_zero(mask);
--=20
2.17.1
