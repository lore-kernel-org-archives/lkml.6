Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE45C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCA02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HFwzj2la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCA02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeIGFVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:21:03 -0400
Received: from mail-bl2nam02on0097.outbound.protection.outlook.com ([104.47.38.97]:7296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730438AbeIGFVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emINAizXXfFqckpEV90bqdKWufCJ6b398mnXPc2zTvc=;
 b=HFwzj2lavL7St50yurZmuFauEMgF5jQTmB4x5iljFZiZPoSNO5SPsLrq558dXG/tTB1M/lQaVvYs4bq4JrOn7LT7i9rgSpIK8LKY2W5BC7m+TRZDtfFpxZALhfCuKYvMT6xtxe6CQU6YGEBoWL68VEnGUM7n2NUa081wfC+bedg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:42:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Azael Avalos <coproscefalo@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 19/19] platform/x86: toshiba_acpi: Fix defined
 but not used build warnings
Thread-Topic: [PATCH AUTOSEL 3.18 19/19] platform/x86: toshiba_acpi: Fix
 defined but not used build warnings
Thread-Index: AQHURkNCNpqrM1aUhE2FcEviPuHopA==
Date:   Fri, 7 Sep 2018 00:39:39 +0000
Message-ID: <20180907003923.58019-19-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:UR2v/12/rB75Am7ePXPHhUbsT7IEjrjAgWZHoKzbgq92h+pObJu8y/hxq/vMLgRpHR0PTPzWGR2ntzwk4gOr+1h+72YwT4W+JVU/hUP/iSy0huXu8ZZGSqau0BD7mis3FDbNEEALyMyz7uWmro2sUojwvvUPU2HmVDp2s2GnCExE7EyaFOapCaDyf1TM+6Y1pOgJSjJ97NPf7RwgIpoSg4v8HX5YQmV101rY2XyCa9RwiwBKQ5AjG3C/9kUZrVLKotdzozpGOJKpWV0uapRr5qDnMopaCLR/JtvmMHzZTHgRgIEV/p3I3LpsykX8umkEZnP0iqIytndCvk7Yi7GGj0/NnlOIl42YADd7xV+v243sj7ZzFoXdrTupNOlMeu+xG2HDPBO/rGwpXMAo5ZM08gNqJDEllVyF5MHFPdverHvjDw0k7Wyv2QhxeZHqEL1afywRLvRL2CkH62PXxs12lA==;5:R0VEhWlq3Roh4KdASG0KCj3LugSQrWeoIunaY5z+lpH5xntPNSJqKAT8RF7YKfa0fmVd28bZbQ1F2SYpQ5fqm5jjG05VSl/jJbXKhOclWcKmcEzezapmDNS2tK7ewlO7Y4EH9Aoz2lQACzE7yCjXVtC3aU8Zp2aEXgsVW9fhc28=;7:ds+q7XryuIu4efyttsV37LHSh3fAJoJv3h2qhYviQB0eCQT7u906LFqwbFrcMhROewLUOwPOn8TlCR/z/1X2fSG/Q0sJRUnb+7lqptC4BiqBhgmeJVWxbSUUH3Q0ufDDk0kEz+uGf1OW5jzjzM7xhlW2pauWD/DoeRn+3SAcAuB0avnq3FGb8KYFwxcwhK+b86V98sM2NEN55lQ5lTWH+Df7PLcqhABOlMjGZWm8IbtZ+bzx7kV6T35JD3rvtkxc
x-ms-office365-filtering-correlation-id: b6ef1515-6e61-4614-659b-08d6145ad4ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-microsoft-antispam-prvs: <CY4PR21MB0631EBF3CFC801727926EA4AFB000@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(72206003)(5660300001)(26005)(39060400002)(66066001)(6486002)(2501003)(14454004)(8936002)(6506007)(81166006)(36756003)(97736004)(10290500003)(81156014)(478600001)(22452003)(6346003)(4326008)(217873002)(10090500001)(102836004)(1076002)(107886003)(6436002)(256004)(68736007)(106356001)(14444005)(110136005)(486006)(11346002)(6666003)(186003)(6512007)(99286004)(2900100001)(105586002)(7736002)(305945005)(6116002)(2616005)(3846002)(316002)(5250100002)(54906003)(2906002)(86612001)(25786009)(476003)(76176011)(446003)(53936002)(86362001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: kipJpCikq+WI9nr90EOtTyEO/qxCgCbj166/7eS0BVBrrTIIILs0jjKYzt3oorFZn3rjPCSoHQbe4ZaeQJF/m/VIREx15Ht8mxHsjdjjAcgiq9F2qU3AJD8hUWIoKQkhrOpU39Essir+9Y9CLlwiYwiCZFDt7GVGw1Oi6dJysxNDdIr8sR630X+bXKRWy5N+ko/JlrVwQOaTTv4E5/QrXnkR421NIiRYqu2Y0rllx1G5lEVH/4MMEzX1hTWvy0ZCRe1TXU7A+0RXHm9JZuVLsX4pqA0LzHoyGw53pqq0SyJy1nG6PAurLlt9AmNi/OFzwW8iREhrHLQ8kdhXgS5cxAr5SZ9idnISOlhQ+77Hz8w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ef1515-6e61-4614-659b-08d6145ad4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:39.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c2e2a618eb7104e18fdcf739d4d911563812a81c ]

Fix a build warning in toshiba_acpi.c when CONFIG_PROC_FS is not enabled
by marking the unused function as __maybe_unused.

../drivers/platform/x86/toshiba_acpi.c:1685:12: warning: 'version_proc_show=
' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Azael Avalos <coproscefalo@gmail.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/toshiba_acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/tos=
hiba_acpi.c
index ab6151f05420..c0b64e571a5e 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -41,6 +41,7 @@
 #define TOSHIBA_ACPI_VERSION	"0.20"
 #define PROC_INTERFACE_VERSION	1
=20
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -1233,7 +1234,7 @@ static const struct file_operations keys_proc_fops =
=3D {
 	.write		=3D keys_proc_write,
 };
=20
-static int version_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused version_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "driver:                  %s\n", TOSHIBA_ACPI_VERSION);
 	seq_printf(m, "proc_interface:          %d\n", PROC_INTERFACE_VERSION);
--=20
2.17.1
