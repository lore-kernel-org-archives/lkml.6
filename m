Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506D02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cdq6gawa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506D02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeIGFSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:51 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbeIGFSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb1GMOQfeaTcpC714dWpk18G/BLAc0A3rkFCtPzuma4=;
 b=cdq6gawakkm1k8FUbEmVlOOKxLEQ0y/zvJdIXI6tU0u6UCGERqjHouJd0rBWRIUxYCiY0rDC2Zf34C/T3WTzeV+KLmveOhUcEmFx2365T3bT05TIJo5RBI3yP+yqhb1b+zsuyX0yQsOLKFuxYC7UM167Qa8U1GtKrNQPplO3LR8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 08/43] clk: clk-fixed-factor: Clear OF_POPULATED
 flag in case of failure
Thread-Topic: [PATCH AUTOSEL 4.9 08/43] clk: clk-fixed-factor: Clear
 OF_POPULATED flag in case of failure
Thread-Index: AQHURkMVf+6/tWF+ckGVJ8zBOwJ7Pg==
Date:   Fri, 7 Sep 2018 00:38:24 +0000
Message-ID: <20180907003816.57852-8-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:gsOVVHf6ZYFNPJdlm3rezFyQ/owJD3a0ML+o9f9125+41YzhjG9NDb0ttVwy9ExuVwKUlDI8ZBXWiWMndvzWVTri1E5TdL3OA/4dbU9RLhxYgavO6hYC/ruWYjYnH30a4Ns1kSpLcrGE0A7SLeuscPPSx62ydcT1fssa7AXPluMveS8F7TOk13/UnqOHwZpTcXaSuhizp+ZCY7wiy70K8+3jaHkV55af4EEDhtw4AUgegTblSLpukIc1xBv8cYAxzoc87d77MNhjhORk5P8B/33BhKum840cRuF256cphbHRrLKtINIozXV9Yw9Pfek0DREVTMTg1Wq/oCbPPQ8i6bpCurQOH0D4QLuaoWp+vLWWxSr2Y4WSmrccnY7WpPQIdeBI2yuiwAsqanmU/cJuy2+oToNC2wejzqxtGsoPow+Coh6rXerea7MXJcLX3eDsw0UGuEVEWR4ECycdaOCVtg==;5:0lBiadmZuOXRbJFu01abqk8Qb6EZ3Q+0QvLs911rZBpz2v/GOzyeqavaA4fwAPBuAIte5CQuZS1dmXQGTzHBP/dRkf448PEgl+I7iUzQIfP5j0qmtusye0goxz8UvJqiIjdDUmFfbpVlR7mrqT6zLCgqOJIQ2+5WtAJOWX1W1KQ=;7:ToVr/gYAdRtvXi/EClfmD+m4W/eDhSClX1hn3jdVNCrrnDnJg0c81szaHHhy+D3+L6cIFdDCsNDm2pto6bejNAP1Kz5uY3cnxnW3mC9JobB7rh3yxjZfJ7gv/FaTAswqO1s5scoWrwfBgr4b6qZJ43N8/zXvgVVmOso3xTfUwd8gXCRJxDrF9VgS4ke92IVgNx8tMn0M41Mk4BSunQQd98ZRfgg0ARAvHtxnvB70S+jloalyBZfo7EPFmc9JJsUo
x-ms-office365-filtering-correlation-id: 49c3411f-4875-4ea4-1def-08d6145a88f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB0149A74A58796500756C0BBBFB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZyD7gW8BMkM8BUS00zeHwe2VgW0xCXPfJwXBpbdcbwRlxwheeqfgGd9fTVTXm+BYOoXJh6f34OuVb5VkqnBNOnegqoEAitYxe8/qLA/95NQEi+xPA7uLJ0SYa0WeGkAVTr2XJVHUMEXBfojg42Kxt57wC26KoGS/SV9ubETc8BJmsic9L4PJEPovq6qlO5Is5P+4N7IdP+36tN55zItj9EtnHF/ga1tm1Vr6sotmketweU7yPS6dfnk9ajdemOseEZTVZBxPRsG4vurE0A3A9+IUiUi0YWKH3GP70BsHJIAPD+zuFdK/ulD6F5Atdm60k7RaYx5nhVI7ixlAl9cSlFcbAKYcWByiph7Svb+leZo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c3411f-4875-4ea4-1def-08d6145a88f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:24.3951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

[ Upstream commit f6dab4233d6b64d719109040503b567f71fbfa01 ]

Fixed factor clock has two initializations at of_clk_init() time
and during platform driver probe. Before of_clk_init() call,
node is marked as populated and so its probe never gets called.

During of_clk_init() fixed factor clock registration may fail if
any of its parent clock is not registered. In this case, it doesn't
get chance to retry registration from probe. Clear OF_POPULATED
flag if fixed factor clock registration fails so that clock
registration is attempted again from probe.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-fixed-factor.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.=
c
index a5d402de5584..20724abd38bd 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -177,8 +177,15 @@ static struct clk *_of_fixed_factor_clk_setup(struct d=
evice_node *node)
=20
 	clk =3D clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
 					mult, div);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		/*
+		 * If parent clock is not registered, registration would fail.
+		 * Clear OF_POPULATED flag so that clock registration can be
+		 * attempted again from probe function.
+		 */
+		of_node_clear_flag(node, OF_POPULATED);
 		return clk;
+	}
=20
 	ret =3D of_clk_add_provider(node, of_clk_src_simple_get, clk);
 	if (ret) {
--=20
2.17.1
