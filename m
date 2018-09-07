Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A03C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A32E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ORwL2p4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A32E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeIGFbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:31:31 -0400
Received: from mail-eopbgr710120.outbound.protection.outlook.com ([40.107.71.120]:61954
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729854AbeIGFQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb1GMOQfeaTcpC714dWpk18G/BLAc0A3rkFCtPzuma4=;
 b=ORwL2p4l4V1gAAlZhgVD8ZmTMKvLuDo/7UxlXtP3hA8knkSw5a2SebFXELrM1ll26oKlR92SBca0JI/IGEW8Rf7mj2bfbUgpJXDf2KbmvxI6TjQ+m6gGGO25q1SDF+0B+5fMNMA8pfbBLnY9N/W961TMo/f93HNUKGU7BV8WrI8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 14/67] clk: clk-fixed-factor: Clear OF_POPULATED
 flag in case of failure
Thread-Topic: [PATCH AUTOSEL 4.14 14/67] clk: clk-fixed-factor: Clear
 OF_POPULATED flag in case of failure
Thread-Index: AQHURkL1UkCgW0qN4E2L1lgr2YTscQ==
Date:   Fri, 7 Sep 2018 00:37:30 +0000
Message-ID: <20180907003716.57737-14-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:0+A+mC+nlfrTrBhIExRi8bvAgAksbl/KuQTPfvmspI4JrAwkux3KQSd2s4j3zJFJmss47ve1/lRIEfWG3K/ELJZKJPpOlZTOCpmMMdOCWwWOI8iMMgLffOG2HhYzoAjHf5gnIUx08iprJK/99Edks0bgTBzZVKOjMp7mGtDj0pB1L3Cc97/ra3a/8Aoawc7+Pc/y5eyvSLdGbq1BnE2NFkMU2l03p184XaIKiwUBqemCuK3kWYklr9A79o4n3T714Jj8drmcV9yPjWpu4oKTTI9oikb/3MSWCF5Wd79TkZKyLv0L8dLcxmWbFMk300H2PxXs0l1tURqkJ2sJ08VjXPRd/Oe5kATDKM8BeXJkG0duOPaHQdpXTt3xOxxu81y3rPRFD3lPad6yh0frTbEWMCqJk6lO4EtAJO3v+6wJZpuEy5T+doih4mShSJsZfqlfSQ5TUCPswFx3Qa4ESPdt5w==;5:9JEUpoIzajB7ybWTxXMtmP8EZQKN8wiTb7DiNXDLsONxNJhbNW0ohpM2VsDMFASdVjG0GiLbX18KUAfQxdsdsXHzjK2/9dg9kAWNONMBUPIKA50xRZBx/9KQNknjECWVEFw+x4gKAOxC4tKiwi6Z8w7L4pW/qtpK5lTlz/ffaz4=;7:6YCNyZyNhvrwLpqjxsEfnh2r1dIlkcfqGVGXFF66Aawe7mFiyo7AChVyGwqK7LYk/f7D39Q6eldCQYDQhlflL0zClcFXnGyRJOO03aSjS0xx4pViXQ14XIgrnOTYWueRH0QLgn0W6F678n32tRfDtptjHI2yfAkT0eOWkwOh6JszwRI/HnJWKXS5BkNjisjo4Js5WivU1RdpzUBlrVqN/Q7XMGHpwiEJAEGPjdSFX5NiqawJRSwnbT95yY508zuA
x-ms-office365-filtering-correlation-id: 2d2f3ae0-db2f-4f42-283c-08d6145a3432
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839694AAA6F62A24B48AE79FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ybfJiq2ngSK6d5UmqtBdh1GNXBRzXdmuH1HaNCx+I5Wq1Xy+MaJ9vLuONJQUFudrvKTYaLv/kQq/UBLy+TaTmxZkwHmOvXXXwVxeuRazN+wWGUnbQyoOMy0IVYeddVg33PxMrS4cpROh2nxGLhDFqR8CqRpUx/Mey3cnNSNT/xmy5Q08/6ZHLjCzQeCkPUXoRs3uyHm5xUglthNF5UggeJ4+20+02P1/Y6s0eHD/rxR8KSNU9fD2HEjUx8sx4D6ltvj44kcARKbogba1yuLvXT1OQQ5apVByxiXlZ1OVe5ZLIxgQLLIAA4VdFetmi2BQxkTnN1367wx5drBpn19Hzgn0rD4XyjLNS7zVipe2UT0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2f3ae0-db2f-4f42-283c-08d6145a3432
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:30.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
