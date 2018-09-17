Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51044ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A5E214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BiuRwGBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A5E214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeIQI2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:44 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:50080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729079AbeIQI2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6X6i9Pnmya3KIZws3+0MkPBRWFtHeIP+W0ouE8deK4=;
 b=BiuRwGBysBj8y3zG3axY0wHtd5pY9FXgTt4oUwy6rtzcsBgODv1Y7yahAQhod5EKetQVsNpZ+yy7GRmCEhOkttCyIg3pzQcjxbPjTEUkQjGCOacdVGBCgC08Yq+eQ80NjjuvmVIl7SxOaq5NNSMChh8Ismya7zU95G6mggj4r4k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sandipan Das <sandipan@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 135/136] perf tests: Fix indexing when invoking
 subtests
Thread-Topic: [PATCH AUTOSEL 4.18 135/136] perf tests: Fix indexing when
 invoking subtests
Thread-Index: AQHUTjK/0BCz/Uioe0WKqovScJn51A==
Date:   Mon, 17 Sep 2018 03:01:36 +0000
Message-ID: <20180917030006.245495-135-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:PsI/loQ5I8g2TkFTIxeRXEpaJ9ju9Ni1lQFQuEA5bUDETLlIC1lEIgTu3IbFFwBf79GsY5owZGacF+ybAAQkAJbE576MrXCmf8fAarVOpB4vONS/2f1Eb0FE3Et3vvg8gdTAAnHlwzPEj21MScIJkU7KqZPIn0TpH5Newmrz8e4UqX2gQexJDD5n9rrFw2ARTWTaNiy2sRFI023JKVqn4aKHxKl0jAyyBCjUG7Jo3mbVh63vN6wULBrO4v/nH4YqkqXzSZfvvMSKZr+HBvklwJQSAmGCHLU8t+htIr+BIATQlj7qbOIQFeWRJ0cg7pXK0fh+msRTC09FWJTp3rYLFLsuKNYq3jnxzct3QhUtpuK6qBP4skn8qrTK0L6GBubZDmfAZ3pBepTORVNF370WBmrqOZ6f7aEH+usK600KAkUmmNoZRuwBalhEfDFSrZbGlfVGImHpuyhN18Yp308FdA==;5:JnKV08PXffeHnerNqLH/1bHHZOXGYfwiGLCzIWnyuuwqDApM+yCpkyQb/ytIcWWvxpcnOkQOcO3eS/i+XkOiv4g61Uq/DJMGtxJBar3icpaIyGo27Vc3cGv0pX137wPAg4l2a1MF7bPanKDaQxw/VX1KWcUGRdLF+JAmFiAgtrU=;7:qq+SMTSuQZlDEEF5MFS+DeZePKTw30Xo1M3FvAl828YWkF0E7T9xFKqYHOad7M9pjOJ599BpN0o0OLl2bEDhAxGLPVZnI15PNaVAo0vpFbvwjwZb3uCKYCRgPeNt7hP6rM1Mw+AStxZPyRdpHSwMQgsuYQovNuaHsYObYqSmaU5rUOIt1gLbVJl6yAETSLbgTWFNdwwtegVerP/npeNlfHmZpnBKiPuLfOQ7CDtcqhRzAVRPDatQdRgHyZrBPUYl
x-ms-office365-filtering-correlation-id: a8541a85-adf3-4605-a389-08d61c4a237a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB085597C5720E305262632ADBFB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(7416002)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6666003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(966005)(5250100002)(2501003)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 70Pfbo/gwAS1ljEprE3kwcjq9mQo1ay9V3ja5YxmjftSJeoCxqw+ZqMp30YMuwiaYqFTZU4p3TB69PzD1Lp6jDSKTS1c838CPmTE1559YxPQ2ouPqi8cSu4pSWy7iiyxfRw/H1fJNtJD90nd43zLxUHywRuv/qHYDzihL2jOC2fZM6qh+ckJAiBVHZWhzVUh6th3XGRkTeobNoRk6Iz2HdN6cPkCMmRWQmH8kOLp8VaZ2tvpgci7DJV4lEoQxg04vm+zxkbtq+IQtPBaWD8K+QQx2rVaocaA/isxf54dNLrydqQLZ5fnP+IMck8Tzp+6tRaXGaN6bQyDE7EwKZcGTaeWREeI5fSBeWjzf4DtwaA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8541a85-adf3-4605-a389-08d61c4a237a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:36.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit aa90f9f9554616d5738f7bedb4a8f0e5e14d1bc6 ]

Recently, the subtest numbering was changed to start from 1.  While it
is fine for displaying results, this should not be the case when the
subtests are actually invoked.

Typically, the subtests are stored in zero-indexed arrays and invoked
based on the index passed to the main test function.  Since the index
now starts from 1, the second subtest in the array (index 1) gets
invoked instead of the first (index 0).  This applies to all of the
following subtests but for the last one, the subtest always fails
because it does not meet the boundary condition of the subtest index
being lesser than the number of subtests.

This can be observed on powerpc64 and x86_64 systems running Fedora 28
as shown below.

Before:

  # perf test "builtin clang support"
  55: builtin clang support                                 :
  55.1: builtin clang compile C source to IR                : Ok
  55.2: builtin clang compile C source to ELF object        : FAILED!

  # perf test "LLVM search and compile"
  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : FAILED!

  # perf test "BPF filter"
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : FAILED!

After:

  # perf test "builtin clang support"
  55: builtin clang support                                 :
  55.1: builtin clang compile C source to IR                : Ok
  55.2: builtin clang compile C source to ELF object        : Ok

  # perf test "LLVM search and compile"
  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : Ok

  # perf test "BPF filter"
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Fixes: 9ef0112442bd ("perf test: Fix subtest number when showing results")
Link: http://lkml.kernel.org/r/20180726171733.33208-1-sandipan@linux.ibm.co=
m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-tes=
t.c
index dd850a26d579..d7a5e1b9aa6f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -385,7 +385,7 @@ static int test_and_print(struct test *t, bool force_sk=
ip, int subtest)
 	if (!t->subtest.get_nr)
 		pr_debug("%s:", t->desc);
 	else
-		pr_debug("%s subtest %d:", t->desc, subtest);
+		pr_debug("%s subtest %d:", t->desc, subtest + 1);
=20
 	switch (err) {
 	case TEST_OK:
--=20
2.17.1
