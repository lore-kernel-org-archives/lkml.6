Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7505320856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bOLjmArv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7505320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeIBRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:42:55 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbeIBRWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRsbJ/K6303MoKfIRc3yWo6qbWjRizJjFALe35FZbT4=;
 b=bOLjmArvxJsqo7uq06dpGVDlENMx81i2GUot7IEoUhxvCUfeHnywZ/GaKJgANcofyAEZv1Ee8PC5LJ+BAxPMpgMHeofVjEnCSNcxa3O1SHv7K0lNBC9hDSUr3VNcCYDzK7LTos0bR2+5l8c3e4EHran2Bk3Ec9fCi83wOJy94xA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 04/89] i2c: aspeed: Add an explicit type casting
 for *get_clk_reg_val
Thread-Topic: [PATCH AUTOSEL 4.14 04/89] i2c: aspeed: Add an explicit type
 casting for *get_clk_reg_val
Thread-Index: AQHUQr26y8vdYVP7tEWiTOhUcEXAPA==
Date:   Sun, 2 Sep 2018 13:06:14 +0000
Message-ID: <20180902064918.183387-4-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:KXE79v3qLtx9rdgzYuEJH0NWaBK0V1T86SzJsfbAykRJ6VZg8gtkkid80uBrkjNNPaV4zcRcG0hMLPWZtbrvVpNCYqgPmCJ6LYTzauePRr8vEBee8jMuueD3t8wOMC/iektNPIaIl3wfp6eoMnOoh4NshPI4aS6KE0AP3QS3y6fPuOOk9B4KSU7CB5KdIAESp3rzYxTedsYsI/Jl8z0sAygQDqO5tiC0d1AoKCl6BGZdoaiU9t7OrmDVCVL637V6mdZDX2QDBKRiiMky5W9CD8pl02ldavkJCKZbG+T/64MIeuj3mcwJg7nIlOFg9l8VHAs/F992UA1BLADyyYXyLjdffpWBNc5MZLDRlGa767SfVCxr8mUGZ0xgC1hPAOxkiEhJHYPP8hSvmNNqBzb+M2QFUgbm+HmpWER3JW5UqjGNglWKm7Gn7Th8RapW+mn5+VGBwaJcIkmdV+iQjEnktA==;5:gnyPkB85Cf5EbFVS+WQA6oiMg28Z07Vy3c6uFYMaNSoGLsadlhzgQE3c9O2IYZ+xkMdr6CXpZiB8fJlobXSlowfh//JMjtcEZiHTnHwafDUwnjQ34uXJhxUt9DFNuYkYPX5kGBIIwBQIa9T2rracwW8OJE9/472ReC8z2WAVxXM=;7:ZDfli3TQaZ74XZ0ZwTkDw6rpR+EPAwmksFTg2Y1jb9YtP2fGA0dpNFFn5EIuKk5cCNVq5nvLRbTZGTs2Z7nPeFtJZogrCGalPDpFRg/EOfS+4CJZ+VdHWTXRjEYkIj2Z8JcRWbBBVGBPvZNcqRu4Tj/XU/IkJZcCmsJc77/tJDHOvOlmKH1W9qVLXZ0nn0HGzydRXbbnbBa03Riwijxs8hA/cVL82bZhd8yf1LT+8hX+LkFBp3xWLwfS4Y2ZfJjT
x-ms-office365-filtering-correlation-id: e859d580-b4f3-47cb-f949-08d610d4e110
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082251FDE36C67E7507B5189FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lkvmOLexNUJZR09yxvKXMP8G/cflKDHnjEscrJiAhqZwvpSKhgfDg1kg+1VNofxvIPC2luOa0OqHi8lQpWrQWhioF54j0Z103ftifE+Fgh1BjPu5aQSoNOTkz+ZI/nQVYLiB92wAMpvZVH6Tw5vh1tWiImy82vuZ2RBRnWAjBb95FaCaXoOIwnx+KQ9QE/KivezKoagDsHPAPwRX1CyZ7Dnjy19PnhkNcoFZuD+pBlgwJczBTGemy0L2PJf/d08BV9Ih+H6YLJD0bklc0mxfu1bsETJSQTZ6/eH/PYQKsZJk7hUSBJDTPc/s7P02S/al8Wgz5o/4tfJ+e1/01k6W0rlpQ9IFA1/quPkLlo/N6K4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e859d580-b4f3-47cb-f949-08d610d4e110
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:14.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 284f8670dbeb..2feae9a421e6 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -859,7 +859,7 @@ static int aspeed_i2c_probe_bus(struct platform_device =
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
