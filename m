Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FACC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85AA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GrzobUz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85AA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbeIGFcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:32:20 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:40960
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbeIGFQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL5VZoQrmrK5bgufreTHdiEk75akt3vdVJBpp+P4/IM=;
 b=GrzobUz8qKZZznqKg0+4USqnsfAYuFGaPbhFVW9Zxt3jqe3UcVnxHq2AJnFobO8RK/gjmDdo1pT9wZM5mR+K/ccYiJFKcEMaEi1I9fqdLYbu8Ziq1Mme9JhN8KUOdhfnXYLM1gMD0XVzhxy+jsugr5/SrZV4N8B+SV1ccWSVeds=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 12/67] clk: imx6ul: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.14 12/67] clk: imx6ul: fix missing
 of_node_put()
Thread-Index: AQHURkL0FKaVADKStECw1h1X/PzrnQ==
Date:   Fri, 7 Sep 2018 00:37:28 +0000
Message-ID: <20180907003716.57737-12-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:pKDc5+aqhvfMpW4ZU85QURpozOsdTFEb/3xZPmoardgpCBBYunZUv96b+kig+5OqtD702fCD1vb/vFx+bBMLWv28LsVBfPbPe20xTaVWEMt2jPK4SoCBHa9AdiCDjzAwCO5xcVQ5GFHl9zxEhtQ89iWPbGnfiK4nixINzbu55iPzED8aEDvLiy3VeiYr4SHgvFh4/ex3ueXCXXmM9qKhNotpErgnUmsMR51ISrs+hE1xcyTKvzAk5I1R3pKAz6Nj4+rzC95uc27sVxN/fksWKPKP/NmYSa+zV1j1bYmQIzcKSQSBs4L1QjkiuJ/ON9NriTdZtRH8sFp0W4PdrsdITZ7c67faLJRsRjGQ7DH3aX6HmP+mnhQJNhmdaPxrv5qkbgqb1htwHcmS6V/Pt40hEjriwzDod80E8ztiiPAwwOZS+0BaVKvzqc703ICVzfrxS4cLqYmZ6B1lJjLIpcU1QA==;5:HXsqnWb0+TMQL+/ZTbonnqJE34oaipH2RtK3blffQGOfWZar1xjPTcNx/H56yaPj9DrhXrv23yS5bFYQ4MWwBPlX/aO3bjVqwW1dpXv80zbihKVZtEx4UH7FNQjyeeeW1CK8IeUcvvGDlC8EzqRJoUp1xibTJeU1/dVGwsIRKgU=;7:MtMOdwqxojYYE9Ipta9gn/XCDeyXvOPNAuwbqv7lBtCM3oQoylpYkTZxZRRjy/44UzDa88zT9bsUDrfs47zcOgIkWtr5s2DoyuGUetl8F7AWzFVCGGRCOzhYo0qKPxntsBbQSg/0SK6bXRsunO3Qi3HiUxENluPk8+Vhs/ebeVzUgzA3szAUmG2gzS1STIoc3bUBpubQn/q5FSWfTxIB6dp9jdAS2E27zTrfegGDycnRiDgBH5MG/Nf+9nVKMHhz
x-ms-office365-filtering-correlation-id: 210284e6-d23e-45f4-dfe8-08d6145a33c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083992F8F617B7A60DF20BE8FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RX8Nq1FVhFB3SlbhaKokkRwyYVziP/Oj1c5XiGiNBD/Tc+butILVWcJJYHsdmtaXwBZity1V4R79I4SvDdTcAtJjEgOyPmm9ZId/qjhLlGwr29BkotE99hGzQ/fJg4vlLz0cHzJR1MTAPK7piyYZuucgkFtStMsczU73or4ow0iSjXKDt9AlembLT7We8Sm3jj8Gze7KJSGMuNAK15RF84mzabzIrRIJ+8JOvi8dO8v3IZzqqhocOvBiBx2w+Kx9ptanu3F3Cfq9CP53TL/JA8bYqibe99+erdUvPJMWm8mT1hdxopnsoummslke04tb6Xj72PrJhHQALmg6iue1XKitFA3J/j66xYUMiHhuy/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210284e6-d23e-45f4-dfe8-08d6145a33c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:28.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 11177e7a7aaef95935592072985526ebf0a3df43 ]

of_find_compatible_node() is returning a device node with refcount
incremented and must be explicitly decremented after the last use
which is right after the us in of_iomap() here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 787b4271a6a0 ("clk: imx: add imx6ul clk tree support")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/imx/clk-imx6ul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 41c08fc892b9..5cc5ff1b4e1f 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -135,6 +135,7 @@ static void __init imx6ul_clocks_init(struct device_nod=
e *ccm_node)
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6ul-anatop");
 	base =3D of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!base);
=20
 	clks[IMX6UL_PLL1_BYPASS_SRC] =3D imx_clk_mux("pll1_bypass_src", base + 0x=
00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
--=20
2.17.1
