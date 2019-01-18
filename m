Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1884C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823712087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oahhYomB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfARS1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:17 -0500
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:43360
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729030AbfARS1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAHzit5IafEMWyuF4F7vXaIOY6TgBG5O4y1XDZXhbtg=;
 b=oahhYomBsXymE8A/WY16gZgE6FJ6hST3bpkp9QgS5Km5MlrgieSwiw5D9Cq1X9ldEwoBZAUDZYYtfpMT0R+cZ821gYbMDqNChqF+0AyLfZGvBT7n/gZ1mNqJVfV85dyrQxR5geptNmoGJc9bBJGdtqxIVvj+DtSmdsNQg678l0g=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2376.namprd12.prod.outlook.com (52.132.141.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 18:27:08 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:08 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "sai.praneeth.prakhya@intel.com" <sai.praneeth.prakhya@intel.com>,
        "arshiya.hayatkhan.pathan@intel.com" 
        <arshiya.hayatkhan.pathan@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: [PATCH v5 05/13] selftests/resctrl: Add built in benchmark
Thread-Topic: [PATCH v5 05/13] selftests/resctrl: Add built in benchmark
Thread-Index: AQHUr1trRq5PsAhpckCYHNa1ji4/Cg==
Date:   Fri, 18 Jan 2019 18:27:08 +0000
Message-ID: <20190118182646.16594-6-babu.moger@amd.com>
References: <20190118182646.16594-1-babu.moger@amd.com>
In-Reply-To: <20190118182646.16594-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2376;20:6eDXJXyFDzqJjbJSRqYYtFqyjXbNdNUHnPXRAbvXMOrXLlLbOAq8Nno0A782mDkAg8xfEAj0XcvnY6AiHjIf3nhwivgwQSxxhUhM963btJPPn3Uu79etwMpciv1oMohGJ7fThyxhRN1PV2Let8VLo6MFeb3zBFJqRYJ8PtEeK2VQALy5CDsDlEpAt1mHDuVx3WO9RmD/lqVfJwURqU5FQRbJ9CVnBlOG8wqOzfkdZIPwTqYMF3MrnO4XsESy1t5V
x-ms-office365-filtering-correlation-id: d484659f-6528-4cd4-3541-08d67d728dcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2376;
x-ms-traffictypediagnostic: DM5PR12MB2376:
x-microsoft-antispam-prvs: <DM5PR12MB23761A8BECBB10AA715247CD959C0@DM5PR12MB2376.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(1076003)(25786009)(26005)(52116002)(4326008)(186003)(102836004)(2201001)(6506007)(76176011)(72206003)(86362001)(386003)(3846002)(71200400001)(71190400001)(256004)(6486002)(54906003)(99286004)(305945005)(110136005)(6436002)(7736002)(486006)(6512007)(316002)(2616005)(446003)(2906002)(97736004)(476003)(11346002)(478600001)(7416002)(105586002)(53936002)(106356001)(81166006)(8936002)(8676002)(5660300001)(36756003)(68736007)(66066001)(6116002)(50226002)(14454004)(2501003)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2376;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h6K3AGh8YLFBUu/Yrwy+AI5pFBecEw2m9q7/viPP35hlO1eZdNmeMwiOzaK307/2H2wjf5nBHTvQBrwToCrx4219xsKUVP1Wdd7BmfwCPS/Vacd0EzAwALRR7n9jUQYA0ybUkIEFh+qFtPBF3+hw6ITG7p77ris/jrKTBViLYJmROYeZl5224SfDASiddunlYIAzv/eEHtlctv5Mf4EuB/Kh5gKZxR49WqnSPmRRiQqTIbI6mZUqW/OZC/2GPWBKCXOmSFxtbACuT6W09k34OHj/ScJt46nH/OM1UjI7guLM3udIvjQ6QsREsDEWkcQPnCZdkl9uyRgUo/CK3g8685FDYnyfo11hIF4ExyHAeVWRypBt0RKkD2wsknhze7PlVcsEgreYddtcUXrKn32HsLroqgiU3cqYz+Di5Mx7pkc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d484659f-6528-4cd4-3541-08d67d728dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:07.0027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Built-in benchmark fill_buf generates stressful memory bandwidth
and cache traffic.

Later it will be used as a default benchmark by various resctrl tests
such as MBA (Memory Bandwidth Allocation) and MBM (Memory Bandwidth
Monitoring) tests.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com=
>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 175 +++++++++++++++++++++++++=
++++
 1 file changed, 175 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/sel=
ftests/resctrl/fill_buf.c
new file mode 100644
index 0000000..d9950b5
--- /dev/null
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fill_buf benchmark
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <inttypes.h>
+#include <malloc.h>
+#include <string.h>
+
+#include "resctrl.h"
+
+#define CL_SIZE			(64)
+#define PAGE_SIZE		(4 * 1024)
+#define MB			(1024 * 1024)
+
+static unsigned char *startptr;
+
+static void sb(void)
+{
+	asm volatile("sfence\n\t"
+		     : : : "memory");
+}
+
+static void ctrl_handler(int signo)
+{
+	free(startptr);
+	printf("\nEnding\n");
+	sb();
+	exit(EXIT_SUCCESS);
+}
+
+static void cl_flush(void *p)
+{
+	asm volatile("clflush (%0)\n\t"
+		     : : "r"(p) : "memory");
+}
+
+static void mem_flush(void *p, size_t s)
+{
+	char *cp =3D (char *)p;
+	size_t i =3D 0;
+
+	s =3D s / CL_SIZE; /* mem size in cache llines */
+
+	for (i =3D 0; i < s; i++)
+		cl_flush(&cp[i * CL_SIZE]);
+
+	sb();
+}
+
+static void *malloc_and_init_memory(size_t s)
+{
+	uint64_t *p64;
+	size_t s64;
+
+	void *p =3D memalign(PAGE_SIZE, s);
+
+	p64 =3D (uint64_t *)p;
+	s64 =3D s / sizeof(uint64_t);
+
+	while (s64 > 0) {
+		*p64 =3D (uint64_t)rand();
+		p64 +=3D (CL_SIZE / sizeof(uint64_t));
+		s64 -=3D (CL_SIZE / sizeof(uint64_t));
+	}
+
+	return p;
+}
+
+static void fill_cache_read(unsigned char *start_ptr, unsigned char *end_p=
tr)
+{
+	while (1) {
+		unsigned char sum, *p;
+
+		p =3D start_ptr;
+		/* Read two chars in each cache line to stress cache */
+		while (p < (end_ptr - 1024)) {
+			sum +=3D p[0] + p[32] + p[64] + p[96] + p[128] +
+			       p[160] + p[192] + p[224] + p[256] + p[288] +
+			       p[320] + p[352] + p[384] + p[416] + p[448] +
+			       p[480] + p[512] + p[544] + p[576] + p[608] +
+			       p[640] + p[672] + p[704] + p[736] + p[768] +
+			       p[800] + p[832] + p[864] + p[896] + p[928] +
+			       p[960] + p[992];
+			p +=3D 1024;
+		}
+	}
+}
+
+static void fill_cache_write(unsigned char *start_ptr, unsigned char *end_=
ptr)
+{
+	while (1) {
+		while (start_ptr < end_ptr) {
+			*start_ptr =3D '1';
+			start_ptr +=3D (CL_SIZE / 2);
+		}
+		start_ptr =3D startptr;
+	}
+}
+
+static void
+fill_cache(unsigned long long buf_size, int malloc_and_init,
+	   int memflush, int op)
+{
+	unsigned char *start_ptr, *end_ptr;
+	unsigned long long i;
+
+	if (malloc_and_init) {
+		start_ptr =3D malloc_and_init_memory(buf_size);
+		printf("Started benchmark with memalign\n");
+	} else {
+		start_ptr =3D malloc(buf_size);
+		printf("Started benchmark with malloc\n");
+	}
+
+	if (!start_ptr)
+		return;
+
+	startptr =3D start_ptr;
+	end_ptr =3D start_ptr + buf_size;
+
+	/*
+	 * It's better to touch the memory once to avoid any compiler
+	 * optimizations
+	 */
+	if (!malloc_and_init) {
+		for (i =3D 0; i < buf_size; i++)
+			*start_ptr++ =3D (unsigned char)rand();
+	}
+
+	start_ptr =3D startptr;
+
+	/* Flush the memory before using to avoid "cache hot pages" effect */
+	if (memflush) {
+		mem_flush(start_ptr, buf_size);
+		printf("Started benchmark with memflush\n");
+	} else {
+		printf("Started benchmark *without* memflush\n");
+	}
+
+	if (op =3D=3D 0)
+		fill_cache_read(start_ptr, end_ptr);
+	else
+		fill_cache_write(start_ptr, end_ptr);
+
+	free(startptr);
+}
+
+int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int o=
p)
+{
+	unsigned long long cache_size =3D span * MB;
+
+	/* set up ctrl-c handler */
+	if (signal(SIGINT, ctrl_handler) =3D=3D SIG_ERR)
+		printf("Failed to catch SIGINT!\n");
+	if (signal(SIGHUP, ctrl_handler) =3D=3D SIG_ERR)
+		printf("Failed to catch SIGHUP!\n");
+
+	printf("Cache size in Bytes =3D %llu\n", cache_size);
+
+	fill_cache(cache_size, malloc_and_init_memory, memflush, op);
+
+	return -1;
+}
--=20
1.8.3.1

