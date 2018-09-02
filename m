Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C547C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5578020855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q9TJcosu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5578020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeIBRTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:03 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbeIBRTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mGWjCIc+qfW0uSC7EGzhEs5GWjxlt8JBR6FJcIg9ys=;
 b=Q9TJcosuyOTu9C3bTpvB2JtGuGijV2lCHM+gy59GmvLf1tqo7cyUyROFnZcuoFj0XfZs/UU1/Gdqgs+Pdl8+aWViPKBJV7sqqXJTfxkY8vM4wO5fdOEhkj+xratz58Lc5gjGskIjonxMcYuornxTVbMiqB2nhFPKYrQ2w9LwRhM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 006/131] i2c: aspeed: Add an explicit type
 casting for *get_clk_reg_val
Thread-Topic: [PATCH AUTOSEL 4.18 006/131] i2c: aspeed: Add an explicit type
 casting for *get_clk_reg_val
Thread-Index: AQHUQr1JJLWROEzWnkSJ81lgzGt3Dw==
Date:   Sun, 2 Sep 2018 13:03:05 +0000
Message-ID: <20180902064601.183036-6-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:O7Yr6tuqOiLWakjO6IEdbwDYIOdRVhpx68RmlMja0cImfx/q85bfnEw0GlEXY08obGE1tz01Eu4tCCPG0Vsb2cSHbkibpePyk/iGdUQ3I21Nr4MeepToMlLz03s9A1pNBbNED02Ut8I7hRD5udUMpM0COMzfMJQtlDht4zJz0lz5CjSOEh2d99Hk1HqSkXOUU90wkLiL6QdYpBIasuLJRCfnnwiHx3EUGAb6ytmCNOXMSWYFGGv9ylYnTM0tId/MxJ3160/1hMD9/jreq77pgzug9lIVZGlgsB3s+IK5dm9qafYZycB//WT2X2+Ol455yt2MR977hqgkSO2I2scU5UChkobB68P6/X0TuUGKAsfO9CU1avh3E/psPENV+lhcMsnlk0bo6ckyXxKANMFNGvdf3vEzj0eRdB118d2kbYGJkSHBnqI2c0oND7Kr8ix+qusx+LBHGm+s41CGrM6DtA==;5:Vb4JOU3/LsTWlxU9Dd1O8YAXYcRBBD5IecowEQMNzyNaS8fb2nMcMTnqZpwvby0ywg/GsbExcyqYHIwQ0BNLAC0ylUyKeoJr6vTdDUUcp2VEEqAaWtpphIIX8mwqELdG2Q09YQenYUmo/h4z+OKbVUTGW7CseydNZfby8ol4wQE=;7:oDu+QQuUmVVof7KZnYK4UoM3TKcKeW1WzZ7zQw3oPoqCUmenqK3pezMx2GqDlvQn71nH7kOXwHagNU5g8sxAvTSrcjmIzQHkE4CtO8Fcluq8u7dSyDTQoPepY1w35kskoEoFlfcNXy+iLaFgamdOjc9LqNo9l6ITW/LLjyWCUlxWMsIrfy3+SuglUP3yxW40uB+V3h+I0u1U0Hks4MsAPNP0OOjw3sM1sL/hXV4ae2YzZl1/xOchDMNrMk0jgNf0
x-ms-office365-filtering-correlation-id: e195b3b2-f5a6-4b7a-b2d5-08d610d46c36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0837A225B8A069E8F23CA80DFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(575784001)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6Slcq/b2/AnOEGJ/HsnEirMjP96EN+JkGATbZcghX0a8z1w4bTLY6EKXqDp1NooVY6VwmlA6Aji3vt/zpg5xcdYqXZv148WPZClXfare0MGx2RML5+40GklzWjc7ieM82svmGFAM/a2kdnwk8a3bRukydHXp4aC0xUVstyfAsu6wItjTaDd+TOvLjy5XmSHb4EII6KCn5NbfyQTxeRWPkWHuzFr7RYGcDlNf/cJxPDI2W0Ju0d2E5MayXhSaB7CzPAsIeMOq45qLj5h9cbGotTd1wks7UOClcsom7qddAnskuLk0/BtpXYc7T7oTyA2YLV/ru3wcby+b935fkPrHcr/m9baB+yB7TJa+kRa+trM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e195b3b2-f5a6-4b7a-b2d5-08d610d46c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:05.2617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

[ Upstream commit 5799c4b2f1dbc0166d9b1d94443deaafc6e7a070 ]

This commit fixes this sparse warning:
drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignme=
nt (different modifiers)
drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk=
_reg_val )( ... )
drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data

Reported-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspee=
d.c
index 60e4d0e939a3..715b6fdb4989 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -868,7 +868,7 @@ static int aspeed_i2c_probe_bus(struct platform_device =
*pdev)
 	if (!match)
 		bus->get_clk_reg_val =3D aspeed_i2c_24xx_get_clk_reg_val;
 	else
-		bus->get_clk_reg_val =3D match->data;
+		bus->get_clk_reg_val =3D (u32 (*)(u32))match->data;
=20
 	/* Initialize the I2C adapter */
 	spin_lock_init(&bus->lock);
--=20
2.17.1
