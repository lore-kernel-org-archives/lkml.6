Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D2C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB36B20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oiVkpgPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB36B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeIGFOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:14 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbeIGFON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb1GMOQfeaTcpC714dWpk18G/BLAc0A3rkFCtPzuma4=;
 b=oiVkpgPVbt+LDwcggKIoYmmx7RcyyIZ3j5uG4ufECx4uXsWJJ/G5HJVXbZrLhoEVER6itQKmpnBWIKo+L68n18gs6FAni2o3TaVqlpCGMF7x1kRwjBnauIgTzSvukJXDnbz8Bn2Rx+SxToayXFdScrbvnBEBT9/ihDea2FGIvk4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 21/88] clk: clk-fixed-factor: Clear OF_POPULATED
 flag in case of failure
Thread-Topic: [PATCH AUTOSEL 4.18 21/88] clk: clk-fixed-factor: Clear
 OF_POPULATED flag in case of failure
Thread-Index: AQHURkLEcZOe2H2ZfE+cbxDRxC6s1w==
Date:   Fri, 7 Sep 2018 00:36:07 +0000
Message-ID: <20180907003547.57567-21-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:DugYP3eOJ/t+VnPsXjx8A76DqycvO86vPDfJV0D3Jc/uQ8wMAmGbfFnGT1yybS05W2lxUyhQe9K9WFUHcQ2zBRrVwvar+uctoqoWuUBUCnbEP0T3B+76JeUhVbtAS38ZPC1s6bJ9kLilLaxQoQzCg0m+9CjDeMGo/nySN/Z+p69zVpSVI3hfKGXbtAFpZj67RUukMmIKcpRYYhZuxGaBXtSErm5wWmbTvs4F197OQ0g1HBRjAGvIxFUYvrTZcazVcKlbvpWzL4K9Mpfeyw4fDuFPtlGk4xyVdHaAuaWJUg/N68Tzx/s/NGaDeMm2jgBbDdFaFQ1XzVtFVJm2Z2G5GysvjnPJt5CdTXmCon4QoPdJCd7udJaGb0p/I+bwZoZj3ZoBe99J32BgzbdJZ3MizfNRO4LPIY2ASEr+6jVrB5dD4+REpNsTEqhCplpaVP0WppIZ8Bl0YfkMGCexIO5KCg==;5:juE0GCqTuHUsO0rKNrD5H6foshLu9wLGGQGwheqSg8e/x0NrysK0tj2sTSkZVlLLHmOCaGk5Eqz1t0qU4liq5jHJvrOF9jm/nYsO2NP7k3YDpChPnDoi3rBP9I92Q1hBbLbnaGWLEgWjoBxqh9Q8tJJkYyrhMxRhxDgCpJAMLvs=;7:j/5zQs/9OOLTNWyNAcplNAS14T/xYc9CWjIJ5h8LTS7O6gbooLhFo5D8he8arj91yVB2D48K692MjM3XWyzQOTbaL7O/Lkter0NGSSrQGjhCw5Yd10F/TEu1RYj917woo4yABKUvDq1kzEDn4f1bg6T64khKSKa4n0rTDNlv3ij6YxLPyF/iZv07W2edWPrtqfh1jbvrrsHE9nmYubANxIUpa3o56yPilEQuctDyqo54V6q4tALlQ3oYzD1p9Oy2
x-ms-office365-filtering-correlation-id: 1fcdc8a8-5443-405d-7084-08d61459e6bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB082468D6456DB7A92F3EAC94FB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: F24k2thrnZel2EMeJn0xREsTlJdgQ552+4DtHX79JFsNhObGoyLnXgfua5zeUYPODTbv47qwDyQ0XAuJV337rOV5fjiA5U6yoaAHUki0nRzLlfHlgTcRE8BEYPb/9RBtz9dZ66e+Q4nIVaf1iCaD5q0IdJhaKAzgN/R8MWfyB/3CjDAgUMVbbmjzKD5SwCFfWyeyGRSIJdoYkhEbxxkO3v+ILeH2RWXnkvnsDoyq1b7OjVzsNn97hFh+Yokuo7tcIA4x3qgpe3b4Lfc/m6p1Gf1JCk3Fr7Eq6kNpnZ+5TEvcOQivvVWUOhYl1vdMQTeVzMHV43yc4AjQLxauPlp62/FtyQRc4j9oAgSpu0yb7QA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcdc8a8-5443-405d-7084-08d61459e6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:07.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
