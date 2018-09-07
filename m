Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C21C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748422083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TWu/HZrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748422083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeIGFR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:26 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:33184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbeIGFRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CHEIt5omAEvP/Wl67H+XMuETPSU/YneQ6itXpQqW1U=;
 b=TWu/HZrDFg7LpyJKh7P1ZljjqrVkD8lbMV2lYIc24Mi/r3hqDiR5IDyH9WHeHnMG29OwVoPAAgxOBn+bB/1D4qfXUhuwTF9eUt47pqaNVrJt8ruRqkGnPV9YshxU7K1wVVaiHRsRqOW3vPERrCZnpa6yklvz7C+bN3R893ym08E=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:09 +0000
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
Subject: [PATCH AUTOSEL 4.14 59/67] platform/x86: toshiba_acpi: Fix defined
 but not used build warnings
Thread-Topic: [PATCH AUTOSEL 4.14 59/67] platform/x86: toshiba_acpi: Fix
 defined but not used build warnings
Thread-Index: AQHURkMJnI+E+MR8pkO2sXCizcfu2A==
Date:   Fri, 7 Sep 2018 00:38:03 +0000
Message-ID: <20180907003716.57737-59-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:PmdEOjbiGLd+pdb1LabPPOqjXJOWsbp5W5k8G77wLZ9OptRpI4kz7RHM6OVBArUdfsnPclhx2pjr0g7bHjBshPqXYqRCWIirvqhFOVWKsGlw99iiHt6Dpax5CaPQN/Z/BV9c24r+Py2gGwUtpEWr6zatj+RLUPOJPuJXbrblc/5vUhfH/EjQi4ihwVHVvAPdSDhhAQDi3hxHlJT9lK2bt5ZnJ/J2ng1W7XpszhtkQ7QL8VrMXlBQam72w8kSe9wDYn4oG4wDOwTAesjAiOhabjk8YmM2bnZ8Bkcen8ECLH+8qC6Y5h0GZd9/lDi3g15Iv35e8APoYqyBFHyz+OsqBm2oz1yDfmSYQdroMkWBJ9tx5Oss3n5fXcZwv3D3OJUcZqGVTT8ump6FeQO+7vMgcHRJOIW9r91hrL872H39L59/HAf/83NdZOIKzULvZtr9x0aJgAlARInhfQj2fSwiYg==;5:pIXqFOqtYTyL+ZtYQXyMp2wMtgV+U4EeuLVKocznJwrKSZHAw/vXzL0AcfkaZL33bW7eQrX+ZSZ+rMGqiR/h/Q7Ar1udj7PrFQn+HKQB4VsB7oorzAxhBejbFIyY5d64Yt3ZGCE7N8LaOPWuNl+agIGT4vf5i5wyoWIXT9J1b1M=;7:QlCXRIGlFF/PJzps17sICofaHF5iTejtG6lDKfKhnoZQQGOIGxLGisDi0B2mneasYKTyCnPwG5f2CVmuzT5VsoBHi/I0Ff/3vN8ieU/+WOCxh82Y/D7ThPdMBO9sG6uN1P3DytfBZPGpLMyTB/KOOFChoGQMdHrbS/V5GJXyzQ8Cta2YaxgtF4kh0bUS/swRWLtuDVv62qmrzjz4RsPZRVplSQUgyb7rYDowxDb4Iue9xVUyCUDyKoZ1E19UnwQ3
x-ms-office365-filtering-correlation-id: 21c96c07-d5f5-44ca-c551-08d6145a5317
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07574B4479C0CFD27D7D8298FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(39060400002)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ar4+16VEnacKnPS0mYrXiwIGV5wrvLZlj6i0eDF3AFRmb6hgi2flhczBq/vmM6JMigHekrLzO1HAHoZudz5Yf0P10Vxno0EeGIDBo7rRRLiVUlwHy0ou8qddX7Wm3HYGgXcThwL/1c8l4vlciOsc91LsUmHUakV/BOvseD+JmJGPtIBNOklDgAfESCHlN+/Kb15YMIVFJ8747ooeP8atJoyb9udvwerBpRtLMRRtdCUK70rnAmZV4I2Htn9x5b54dTSRix7MVsGPtAn//uVbeFx+/8Zzql7cvS4jmlNaA2qopL0AdCT3f/DqP6dBjfdQDuPddRoCRIPytf23Zn9iRmu+MU0LlpHY67RUCTCjOpE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c96c07-d5f5-44ca-c551-08d6145a5317
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:03.9484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index bb1dcd7fbdeb..8221e000c8c2 100644
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
@@ -1682,7 +1683,7 @@ static const struct file_operations keys_proc_fops =
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
