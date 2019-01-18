Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F7DC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE94E2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zFKf6XpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfARS2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:28:18 -0500
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:40721
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728704AbfARS1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAS6+v81Ry2N987NykGdDPIwB+uYE7At/woMuHPqDyk=;
 b=zFKf6XpYdDofrVk2Rbj6i+zMLmabIPd+0zTnMTGjgjVhqFKugJKOjo6w6bjRCSI4Ryr6hE7tX1atDFHPWMWoEKxN0xDsELXw2SB/N2FFS/85qc5fLa2UtWZET9GEQagrVdpm+ia9dvgHv8O4aJeIhvaFNAc+poBeYdiG6JnO6kk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1276.namprd12.prod.outlook.com (10.168.237.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:02 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:02 +0000
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
Subject: [PATCH v5 01/13] selftests/resctrl: Add README for resctrl tests
Thread-Topic: [PATCH v5 01/13] selftests/resctrl: Add README for resctrl tests
Thread-Index: AQHUr1toReNS/q/OK0qxlHYs77jZAQ==
Date:   Fri, 18 Jan 2019 18:27:02 +0000
Message-ID: <20190118182646.16594-2-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1276;20:cxAi8h319b5RgSqbwNib4QMWlnyVtmxS53ZmyxDhAd9UjP+J3pRk/rSRXkBH8NbJhdr2Fx5jQvTwm3bgowFajYJhOPpTzldudifwMzmcZUIAAatWVqIYAMHF12G63TCFQufvEWJ4CD43UiC2cHAMciNoau74mFhHkuj2xufvUM/9FRVum5jSSMB4W9oVWUqwaSaZoXVxxXuVqRiov8+//ayoMofabn9NpBE8udLJbLrZW9R3UBLMVF9P9l1V77kj
x-ms-office365-filtering-correlation-id: 8b4a7ac8-ce81-4028-085d-08d67d728a97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1276;
x-ms-traffictypediagnostic: DM5PR12MB1276:
x-microsoft-antispam-prvs: <DM5PR12MB1276ACED45EB58D160F3929C959C0@DM5PR12MB1276.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(14444005)(305945005)(3846002)(53936002)(6512007)(54906003)(110136005)(4326008)(99286004)(102836004)(6486002)(8676002)(25786009)(476003)(7736002)(316002)(6436002)(2616005)(446003)(11346002)(106356001)(486006)(386003)(68736007)(186003)(2906002)(50226002)(76176011)(81156014)(81166006)(52116002)(26005)(71200400001)(6506007)(97736004)(478600001)(8936002)(2501003)(71190400001)(72206003)(1076003)(256004)(66066001)(7416002)(2201001)(105586002)(36756003)(86362001)(6116002)(14454004)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1276;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UXXe2RcgYyy+PDeoIxNhE0a0eydsV93PQ+037O7iviIjOxzkXFDR6xuIA679PKRctSV30S6wYApBe4S26uR03Ap0hJZLa5Ut59jErALXl4IpIENG337N/C1aXsDuJ7FNvOvpzWYbiqZgrboSMgDR99bwn5NCs79sn3tB/E33yQNEX8uYZl9IlSpqJd5JigDUK6m61aNkUQWz0O46IX2EtGY4zFzcHD1bcaWz4AUO+ZiVTDSjl48IR3W+vtXlB5eKcglcfaBCQgJ8eKkb15tM45P+qNgIelLdyLrCTbPkgI6L6BCsJOk/M6tNh6pEQZAw8CqYWQcnNBuaAKwJrmxEg2x3cYewhdcWPr8GNqEwe6y5T/x4B/vxGU5ohIYnhYGqET8S2kJIak20PA/SmI7gT5MdsbVZ8mirtcu+kil8vDQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4a7ac8-ce81-4028-085d-08d67d728a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:01.6276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

resctrl tests will be implemented. README is added for the tool first.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/README | 53 ++++++++++++++++++++++++++++++=
++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/README

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftes=
ts/resctrl/README
new file mode 100644
index 0000000..f9621d6
--- /dev/null
+++ b/tools/testing/selftests/resctrl/README
@@ -0,0 +1,53 @@
+resctrl_tests - resctrl file system test suit
+
+Authors:
+	Fenghua Yu <fenghua.yu@intel.com>
+	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+	Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+
+resctrl_tests tests various resctrl functionalities and interfaces includi=
ng
+both software and hardware.
+
+Currently it supports Memory Bandwidth Monitoring test and Memory Bandwidt=
h
+Allocation test on Intel RDT hardware. More tests will be added in the fut=
ure.
+And the test suit can be extended to cover AMD QoS and ARM MPAM hardware
+as well.
+
+BUILD
+-----
+
+Run "make" to build executable file "resctrl_tests".
+
+RUN
+---
+
+To use resctrl_tests, root or sudoer privileges are required. This is beca=
use
+the test needs to mount resctrl file system and change contents in the fil=
e
+system.
+
+Executing the test without any parameter will run all supported tests:
+
+	sudo ./resctrl_tests
+
+OVERVIEW OF EXECUTION
+---------------------
+
+A test case has four stages:
+
+  - setup: mount resctrl file system, create group, setup schemata, move t=
est
+    process pids to tasks, start benchmark.
+  - execute: let benchmark run
+  - verify: get resctrl data and verify the data with another source, e.g.
+    perf event.
+  - teardown: umount resctrl and clear temporary files.
+
+ARGUMENTS
+---------
+
+Parameter '-h' shows usage information.
+
+usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-=
n no_of_bits]
+        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA a=
nd CQM default benchmark is builtin fill_buf
+        -t test list: run tests specified in the test list, e.g. -t mbm, m=
ba, cqm, cat
+        -n no_of_bits: run cache tests using specified no of bits in cache=
 bit mask
+        -h: help
--=20
1.8.3.1

