Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6684C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A9D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M+M2AxVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A9D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeIGFTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:37 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbeIGFTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ysfh6/HCLKDDdVXJYMpJq9yib0kFiCQtXWsUMnp/Wj8=;
 b=M+M2AxVWJHNtQcNvQ44CZbboXpke1bW3CHPZmIYk8XL3plgnWjtRxHSttL3KjyHv75k58ueofz7bs0c/v+CzNna7V255mWJowV4CV/gRIF2ds2ciSE7+fTqYqw/QFeijGzS/l0i3rSmTbgbQhg8rugTovADGfFvGTI1Y2tdUdMY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:22 +0000
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
Subject: [PATCH AUTOSEL 4.9 39/43] platform/x86: toshiba_acpi: Fix defined but
 not used build warnings
Thread-Topic: [PATCH AUTOSEL 4.9 39/43] platform/x86: toshiba_acpi: Fix
 defined but not used build warnings
Thread-Index: AQHURkMim0CNx7ijHUaSuXiA2HtJLQ==
Date:   Fri, 7 Sep 2018 00:38:45 +0000
Message-ID: <20180907003816.57852-39-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:6U94SE4N+u6vQIWS9bagBzfVkiERtNLK1xNijr3VBhwTq68cz+7irm1+QllSa2LUNe+HwcYEmHi8GmvKdUQO+SPEypWvwuPUZhKO/H37JSzhlI4iD4y/7nDK5ct6W1b/bM/lXrDC5en8M1wyVeSPrXeG3rC6d8Cn1qC5nPx19cXyjEfn+Msv6zFoLmO1GosplTJYgiIWiq3lhSH4vcvTvPARr+dUWE8XPfO7Bls0CD0Nh8ROCmgDLqYg9aw9E3znbJGq0WUlMrdtfd0FMmBeewqAMNV6Asq9ZzZBHYWyl9O0b2Or40IIOXtmjP/b2drM2vIUqFY576zYVXUN4ByzHWI3drgn7mtsP41Iv0eXK6vzYmuRU4B32wLqXLFqCbNvAZHXaSO49C0N4wnMhCaq252kv3ZaccThIBTm43WZ/CasXjcmRTp2cBhwsvbUnCXTiNFVvOcezO3F6wHIK43xlA==;5:CVbC8df5Oi0wOFMULC6B4/pIJeB3gy4E9BdBOGMQpU0uUHix0gTOFjyawq4zBESUI21WXYX47w6xhv1+VZ24dmkZNEojKLsY2jAD3PqdaC0n0ev7+L/9zHTduhglc88SQv7UjArqX1cmXmKNHv1o2wfMKFIrMw6jIy7FNixBHfQ=;7:MVghFbbK838unpgm5PCHbn2vXZua6icwZfCY9WWih/J6PxvbR3AvqMqYPRvMyjnOIGhm8ago1SBlVTbMsodYFHOW27XVqk6/f/2cSm5QGE5BKRUwhhZw86RupqL+MVxjZEOK1m1NEVo16Z0bshid+F1R3+zmkpVTONo+LmHwAWO2OE82eZP+L3x5pDta1HATtglt7B20UQoqBxnSn+ozKJRPbpnOdNucmNfo04JeDJKuqytT1xUpG6w/XpJ98Xz/
x-ms-office365-filtering-correlation-id: 5d82b735-ce79-4f50-b781-08d6145aa28a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-microsoft-antispam-prvs: <CY4PR21MB06945EB28BC159BD697C8FE7FB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(39060400002)(2906002)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: pjyjr6m44MFwlR0p5UHRCQdP46H+tBDHXeuNioaBo/Joklxq4rLDDhMiHz8PRrWpV1+0JQzktfHd/6R4983nh8jvc4mYWg7AhmFGYJv+aq+T1MEr92G6tRioZaN1WirGka2ngZhfq8afH33glKMlRryi833qvCq7u8ts6T3PRUmEHVQSrpVFX8cdOHEeUBS2F1/e/kVH/dALrYdlu1/Zr3gvF2yeCfSRAtj56wAzLaninTiGxQdZPLpOBZtnM6xsR4e6VCa9YQU5MCqUT34rP+AIYoZyEnSf00oN2LgLma9BZ7Uv5Qh15gK9i+Q7XQ6tgCbXmaPi3me1C9Up7Lrp9YgxqLm9LeoXZQ98cctnAr4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d82b735-ce79-4f50-b781-08d6145aa28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:45.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index 074bf2fa1c55..79a228937072 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -34,6 +34,7 @@
 #define TOSHIBA_ACPI_VERSION	"0.24"
 #define PROC_INTERFACE_VERSION	1
=20
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -1687,7 +1688,7 @@ static const struct file_operations keys_proc_fops =
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
