Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333C1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D872A2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FfFdIWNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D872A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbeIGFU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:26 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:29984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730596AbeIGFUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31gKJ/CUxBTt0yRs3xrvKHvyMO2o8KUrWmgzwJ6Lp9k=;
 b=FfFdIWNdP8FWD7oZVrk2XKoTeTYNgDnb3TiotSiQWE6p8t3enZwWMlFED35rFF9uyzqe+Msn9OFVaoCkOIYDPczkYn6D6lINBao24SjxQmAzm8AqfV6WGXAYAsiDGTlib1ZwcIv3Jwv/6+ZY5w7VAZaU62153xaAjKy1cUxmWE0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:07 +0000
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
Subject: [PATCH AUTOSEL 4.4 29/30] platform/x86: toshiba_acpi: Fix defined but
 not used build warnings
Thread-Topic: [PATCH AUTOSEL 4.4 29/30] platform/x86: toshiba_acpi: Fix
 defined but not used build warnings
Thread-Index: AQHURkM1XtmuMj1NsUuYmrbj/6Mg5A==
Date:   Fri, 7 Sep 2018 00:39:18 +0000
Message-ID: <20180907003853.57942-29-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:sQDs/pumXEQ5du1EfePlGXzN6532LAdcxsypQ58Kf/oWRu5AfVvjbwBzevZLDZ+V2VWJtgB2VLHYkXAAqlJLXGOJJ/m8GlbKSeQT7vlxbOgsZoXpdH3p3sMcuReaLvCWxTxkjfSKs365wz+9s4B1EHbB9IBxdEGRhPQXAXmsk7bHszmUiA6pqnC3Y8eBXFBFQqAGh7ETXLQh2BOfEELAI3fXIcGUxIN3QaBgHKfftDYGwhfdm0qG7sfxicEXFPN0wc6s7XPszktY97bjZVdnMtXbnJrlYMBOWSPva+AOwQfPzUk/iDRKzBTKuTmbJk44DQYJDFaPeX8uvfsNtYASZhsJiZaApuG0HBPh9tdtSS5zVLTYgO29IGqNCd7HZCmZxm/fnzCdhkr3xG5wEwOH9kNRxFwlC7rldFHOBCFIc39lay/yLweplLZAilZRnCBklKqhhlb6ZNotQV1cJNZvZw==;5:pJFJfzBUQLLRmceLJgWUC29BrPs6yliYa6jGJLGdttT5Ylsqn3XnynGb0X1eU8O75I0VDH4ZTitE/LLsGQZLfCgnAohP6qPmU9NsHDvZwjVxjzbtPEJGNlDUFCkX5BTiJHafPVNqpvTd71QzKBzPAt4l+wb+PzJTuUr0gUYN9mQ=;7:k4i064OWpTA61fwcrixTmTtbwBrFzy1WMB4+ebAvMavxLYKTi/2p0A76d0buJRd3sJ0Yor87K8ZAeQY5P6jjARTLS335yl5x7L7bQF8IpUiZd7t68nQuYu7gysloztEkfOELI4kj7gadD6g2qrcjSIjYYGsui2kEJ9IJ4hPmv9HNnMZys7aotrc8cM/36GJPUYvh9B9RU/uUR00qWJ/7HxxMATtQ56XxBH6tf4GlFustpwvF2N3iV69qfmh8UcJ2
x-ms-office365-filtering-correlation-id: 1bfa9a7a-55c2-4442-7795-08d6145abd26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822E13D4AA95310BCEDE47BFB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(39060400002)(11346002)(107886003)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J5d8C2D3bucp2j6LTYM/gIMkfwloH4G45UvdEdhCgor1AHxErc6P/3KDMbfef2lfsmVAzKT2RHcg0CvtYvhwfJyu1zv2dH1G2LaZqFBrUdlzAAuMnhBnBKKcqqf6eZbutVxMi9NUJUU3etxA9FCBmbVpdTQZxIA+RQLx0LKbxSjCNrSChVdtz64GF1LdrkazdQW560w8tujZBwz0/J5oW7/FLNOf6BPqyzaIVAGGhdTEMR38y5xzEQF1PxFbPMsXhEuqDzsbS366sHrTbEJ0h8gDKC2JNSRWXSD5+Wf7I4fGbU/1k1HOpGtccG01NhAjyGmqQ3Ol2+TjRD85JZvN2LBJ32OlyDLv6Mulqev9gDc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfa9a7a-55c2-4442-7795-08d6145abd26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:18.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index f774cb576ffa..1ff95b5a429d 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -34,6 +34,7 @@
 #define TOSHIBA_ACPI_VERSION	"0.23"
 #define PROC_INTERFACE_VERSION	1
=20
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -1472,7 +1473,7 @@ static const struct file_operations keys_proc_fops =
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
