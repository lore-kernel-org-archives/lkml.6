Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5542FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109DA2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gv6QtO5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109DA2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbeKFNDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:03:34 -0500
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:37448
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeKFNDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlZOYfTiRjfQIe9RRyfEyLue9Rb+3lWuscyF3A57a3Y=;
 b=Gv6QtO5E8iL+fDIzZRFRSOthI5LmAeH0topYtPWY7eRgrXvWj0i8REVpKqA7eYVcLQE6EFluhlN/MhdDv8OTfshsVq0fpJUzExz7TNtokIwz5inyGL8P2TtyN9G7hpgwgnqh6F9pxT8CoZpnDEwKj4lHdXJoN4MhYYJkyS29ElM=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) by
 DB7PR04MB5068.eurprd04.prod.outlook.com (20.176.235.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Tue, 6 Nov 2018 03:40:25 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267%3]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 03:40:25 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 1/4] Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma
 allocations"
Thread-Topic: [PATCH v3 1/4] Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for
 dma allocations"
Thread-Index: AQHUdYJzJ1kUZnKPWkeZZUj9fayqWg==
Date:   Tue, 6 Nov 2018 03:40:25 +0000
Message-ID: <1541504525-25720-2-git-send-email-yibin.gong@nxp.com>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:36::16) To DB7PR04MB4538.eurprd04.prod.outlook.com
 (2603:10a6:5:35::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5068;6:waVr69dmqMYWZYChkvEA1TNftLPywcaktH/SG3YI4tHkkUbu9hRwrjN8toB+I/mYU80b5M4ZHhhQF/SQyM22FEWj/tYbr2zUDN9juNvLP+H45Rpc95eo0FqLSXTHY33lY1j6Ju/e90KN2taIdxbnTZG9hVCYE77UCiQ2TP7pcFisLuAhpY7Tb6MurxJHv0rUbI0thdWbWzsh0i7/39w4STSXqb2slLaKitlATxzrvUjGe8rxLt2HuzelwcKIb3fffeU3mLSl7GtC182kW2mUvzCEuavBjrRIC6r72OoK9uWNVxFC+1WmzmsR7RWMIFm8yk8Otp/bF8PPjmJp8QyH26TE7VPoxu/Tbl56v+zv+gBZ+doPRBRA80rLleNBCziW4CFH+UMj33POawghxhPn1wG+6bX53f96LOrN8SifVjyhG0UOfoXh/5wxPn7Euorq1jDIWqgujMJ3TbkWqPO/Hw==;5:xAgQMpfMfpnNu8QTPv/JOc5aYIIRSADTYgNOgXuJupWJshaAmRPPl4FnrSrDRQM95cXpFoKQiyveOMkiRNwJWDt512mQYtiheFgmk0l4SRuUCAu2YPRU8aU79JMm0M9XqouuyvPGwNuRMl+ytNTgTCfDh3sOeIfauitU+WheXHA=;7:l2SywgWodq2TPDVU2cM67F7ORd475vleavd5grC0QRUy46AVBzhKsfdlNLGP2VkXmmtTOz2ixVOL8gmhFONXYI12D9x/1kc2Tls8gkdlfD5i/RMnvz3JbMS6mWmGO5gAVV1acq2b2VS27jwnNHVgXQ==
x-ms-office365-filtering-correlation-id: d9b1abf5-6c1a-4fcc-3f16-08d64399960c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5068;
x-ms-traffictypediagnostic: DB7PR04MB5068:
x-microsoft-antispam-prvs: <DB7PR04MB50684A2B66961E3A512ADD5D89CB0@DB7PR04MB5068.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5068;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5068;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(52116002)(7736002)(36756003)(305945005)(256004)(8676002)(6486002)(386003)(68736007)(6116002)(102836004)(97736004)(5660300001)(6512007)(66066001)(2501003)(478600001)(3846002)(2900100001)(6436002)(53936002)(2906002)(6506007)(316002)(26005)(14454004)(8936002)(71190400001)(71200400001)(186003)(50226002)(86362001)(99286004)(486006)(25786009)(4326008)(76176011)(476003)(105586002)(54906003)(110136005)(81156014)(2616005)(106356001)(81166006)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5068;H:DB7PR04MB4538.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oynwJmHo2C+SdDv1PTRaPJMiL6JkZa9OcslafyHi5z4q920/aH9Mh08jwZxO9aL+YLLESCbg/ixkhLqt4bBl0QOIJG160tOfixJriMqLSs28P7cu4FcPeMfkYmn4OiDR0Be9ZIwNdcAbM8KN26mEH4NnKPf7uH9NKnqjG1rem+mXhbo53Cg8ExSaL34SB3pL/4WuSFZIAeT0Sl978o4LMT5TM1DGeP6iSFV94kIpsUvDw3ELqeICK7Kuj1Qaqvqd5Eabgz2KMudTWdi+K2EzkSdDkegb8OAYsV0zb8/03NLQUjmyfhzvMzW8GgCMllT0bx7z3WFbQZzD4TqvFPkgCRTeETtK9zYysSSZTAazxMY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b1abf5-6c1a-4fcc-3f16-08d64399960c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 03:40:25.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This reverts commit c1199875d327, as this depends on another commit
that is going to be reverted.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b4ec2d2..3bca5e0 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1194,8 +1194,8 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 {
 	int ret =3D 0;
=20
-	desc->bd =3D dma_pool_alloc(desc->sdmac->bd_pool, GFP_NOWAIT,
-				  &desc->bd_phys);
+	desc->bd =3D dma_pool_alloc(desc->sdmac->bd_pool, GFP_ATOMIC,
+					&desc->bd_phys);
 	if (!desc->bd) {
 		ret =3D -ENOMEM;
 		goto out;
--=20
2.7.4

