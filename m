Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A2EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A082083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NXIDkc45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A082083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeIGFPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:47 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:3440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729437AbeIGFPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0Yfg+UTbnc2+nQPJhFM410hH7URHMxhFvOwke/dAaE=;
 b=NXIDkc45Y5djO02ZduHdfT+zokMcd/+tuyD/o4rjLDL/eMOSp37HWH8yZCtHUrIUzb+ypV+jUn97UDCH9VJA8SgDwPzHzQ1W1he/Ta3tDWmLANHdnHcerSj+OyLU6WZ2Z47GVVpWa1X4dvwmatMHdduk+d+cq5nAygjGP4IQ55I=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:36 +0000
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
Subject: [PATCH AUTOSEL 4.18 75/88] platform/x86: toshiba_acpi: Fix defined
 but not used build warnings
Thread-Topic: [PATCH AUTOSEL 4.18 75/88] platform/x86: toshiba_acpi: Fix
 defined but not used build warnings
Thread-Index: AQHURkLabngQPVbD4UuAqad7rtSqww==
Date:   Fri, 7 Sep 2018 00:36:45 +0000
Message-ID: <20180907003547.57567-75-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:YGW/6aGir4/n+r+9iA00IYg9FjRpq7xfhxTRTS3sa3Ohg8V+AY0ZbzlX875g8a4OlYmTXnMyq8YP2T1lNA5a8mYP/tQ/NwYGRZoDDOybNSyfoM2ir8VDGTA00H07zye848Nw9rkpbAZq32dvPXk+/Ua3xpT/jJblM7G07pjSy5zRHPOalr+sPhymKUQl9LKnFAVsQCjvWiJwU/jAV22ape6YTyPTINcvRDJ4oPiXHbMv4eIZk6LpXVCIyzNxgtmd5FfGe0BIUiJmAvQzP7Ml0ElNlXLFL+dluhJpcCk8921Cvs1IBiN8Se+ONGd0nCzt4FlexvMuz6ZN6YsTQNB8eh52ntlydp5i2kEyFBbOKvZYS598frEyco74GrM+zT5PljKaKOthY5DbAqnV5gIdOv4JSJXDnSYsAouvg/1yBSDYcfctIZpy8JXO/KvHLSsubIHO/yCZnJ2KLHwXk0LnCA==;5:te2C1jRI1MxtOuOsKByk4/oK9aXeL9f3p91NjiQK0y9tcFqDm8VqE+tcCeePB7ulOWs9b01s2szoDLUzYdkJot7Q/BE/URsZN19LDmINGnBUwPz4+Vla6JBs5YrefRtNAFY3TsldM4Q0a6XqG8kyrhoAw3wQFgJx/KhXP5fckF0=;7:7MNfjGcb0ISVxsHFhAIzbYJfm2smlFWH03v2w55geN+6+LHxVs3MoYsukvZrY1NoQxCQdv3yCKIc5QoiCpPJ+lWIOUWauE/igd0uib7il1ZKGA9BGRdhUyqVqvlNkOftaSAXmYmjmhS5Iw5g+2Fn4QNl29Wb/y00ycUlduhRW19aZJIQxLbPAq69jwHvSRu1U4ICYLe66qq5eU3HBbNi9Bdxrkw4RyswipX2h85PDBEdcUUhcGSduUp6sw3EOB5p
x-ms-office365-filtering-correlation-id: 2cea3536-ec19-4c3b-aba7-08d6145a1b82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011824C271215FC634DF1467FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(39060400002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /cS29PffANW6Fse5Ldn6GHtg8GkE2zBIhXCx11KrRkLJDQFgUOJ4ecn5nrAcWNTtHQT4KBChuJDbeBccYh4zhVWn+2I5uGPPp2YOglckZcu+TF7ZtbqlGBdRye2P4pb+k9SM6SOsVNejRk8I0v6vcfBtHJ1oGt+wwamex4KKlg+uZvwBHK6qhASGe9ShdVHVUxTVan4v497v02Fnj2u0/5mzRZol9K+JEUVkSizyWD6SR/0wllzRtJkD57FmluJk0ci5Ib+m81goG357XlwkSFnq0GNtKRwkhOxOaTPi5+v3toE+0e4HsD3QLG5xFLAC0A+l5HAOaZFWjzb1Tcwrp6zfCWEbyTTBLQDR1RXnp4Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cea3536-ec19-4c3b-aba7-08d6145a1b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:45.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
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
index eef76bfa5d73..e50941c3ba54 100644
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
