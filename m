Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3980569-1521499353-2-2222725023213543012
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499353; b=f5Q1rqchHsiBKZcgTMwJB73HPLOp6eECwYL2sW47w6hIxGE
    rdBmY82XENd3SaZm2SflrDYBjQlcsUud7WYXWC5yh793/BCVJ0W5mFKZC2mOLwBL
    uA0lI3wUyYfduWK4/6qUF9bXPTyFE9R+tT9CtbHHX2Uzeld3xKtZpjaaR88BTcO1
    6nuJFrtyNFlx7k2LZ+A5RATECSa3tJ0/h7Ydr0l+GH5o7lVzrihVYsXvsI9GQN7k
    KxYW1tzc6s7bfQ8ZQtonr5WlJ+b375/KBOjkhZhPL98mJong75Weu3KcxZ4lb2dx
    9kFRUn8F5IoL3S+AH4LUFkAJoNEywZfBBSSkXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499353; bh=SdPATO
    JCWCiuhQcv7wGgo+67G6sG7M7a0gmwVdWYg88=; b=s+DwoXfvhBFeW0/QW9Zh6U
    9vUb1PY0gsAR2nvxXKVfsGOmZcbOtPW5RptVIjEDaMVti3A9LP7ws6OxZ6cT60ET
    o8fBvUiCb5Wv8HYo3bPbAEOocY25kvz/lEHb29KglRBqAlntaYwM2g8tX0dGy679
    RjLQsb0JRiDReuHgo0nxd0yxZixkIwVLY+jvhew1dzie0dTav84KV0ngh+OUE8FZ
    4gWJsgHweRYlFYtR07w1hqQPkdoH1ZwtBu2lhf6oZ2YSD4k2R2zc4m3cowLaWUH5
    C+lR/t+HZJk1mLiMEFfSITPdaGicoGmk4KiChCZV8ZdGNy0qyv0EOtW1dVrO8Z7g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bl/XpYBW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheeikeenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bl/XpYBW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheeikeenucevlhhushhtvghrufhiiigvpeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936825AbeCSWl4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:41:56 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756009AbeCSPrQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 011/124] perf evsel: Fix swap for samples
 with raw data
Thread-Topic: [PATCH AUTOSEL for 4.15 011/124] perf evsel: Fix swap for
 samples with raw data
Thread-Index: AQHTv5mJ2gyOdvKb0UOu6Gkryg2HTA==
Date: Mon, 19 Mar 2018 15:47:09 +0000
Message-ID: <20180319154645.11350-11-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:DdZrRUx0R1PwG9DIjMvsFf74FbhPUcou+6f4+UVzi1RxIFHWoTUSNqKROEDcRXGcTJVB11SeDO9kVYajHyHufZn/LxumCRUl14KsJaZV5Vh22nz4ywrZeTrC6S+ja5ZSUC3dNrgqUvphabimvc7N/wqcq5U7dddbSsVNyjvblWoytvCDGwNAwLR3KBKUqJ+/Xh2Oh+Dny686lMZOFFJeZqaFibJshUL2PUNrOildesOZ6yGMjiNilsTeL2ZT/DGZ;20:T7WhJPcnBHHIwGto2viNCvdFJeI3CtQl3mo9FPc5K+NQwoIb01gZ+aSYef15+6udYdWWP3fRlJYU10uqGZte8Rcpipi2cnP5VFyViysM7zQd1Ttr4eHRxppqHURgH4bDw+A/GPsS+aM8u/Mw6UY7boQmyhYawHl6DrnO6FqI4GU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53904acd-657f-457f-32e7-08d58db0acc8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013F00E8E862538E7CA6C9FFBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(966005)(86362001)(575784001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(39060400002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6306002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eqFxSI4Zz6dPfo56H/9cA8kcFikZWaDuENjXeKmiea69/cPF9UqaPCaShJgL6BvYFcUhbj+B+3fcGVgXzUTdstiQOswQNmPvbiCFxh8yMQEEWV/W6YnsMZMdJLRsMMI35zJx+GBfG8t0rkTG6xFchHXj3WH3Y2t6jsE0jxl9SwlpAzxDIPzJjAEPuEtpeLYpMUv3WHHeEXKAndBjtLWBIUYnqWYO4vWmVWCxWbeB7g1yKnXoB+2nKHDnLQFI7VlILh7aVz8RUY+Q5mZBB3XEoov4VZ7hiSEM76jW7W7fn3MALMgvM65pFV0i/XU75gqSpGVkzFcGXsrSf7fxaqEfIA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53904acd-657f-457f-32e7-08d58db0acc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:09.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit f9d8adb345d7adbb2d3431eea73beb89c8d6d612 ]

When we detect a different endianity we swap event before processing.
It's tricky for samples because we have no idea what's inside. We treat
it as an array of u64s, swap them and later on we swap back parts which
are different.

We mangle this way also the tracepoint raw data, which ends up in report
showing wrong data:

  1.95%  comm=3DQ^B pid=3D29285 prio=3D16777216 target_cpu=3D000
  1.67%  comm=3Dl^B pid=3D0 prio=3D16777216 target_cpu=3D000

Luckily the traceevent library handles the endianity by itself (thank
you Steven!), so we can pass the RAW data directly in the other
endianity.

  2.51%  comm=3Dbeah-rhts-task pid=3D1175 prio=3D120 target_cpu=3D002
  2.23%  comm=3Dkworker/0:0 pid=3D11566 prio=3D120 target_cpu=3D000

The fix is basically to swap back the raw data if different endianity is
detected.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20171129184346.3656-1-jolsa@kernel.org
[ Add util/memswap.c to python-ext-sources to link missing mem_bswap_64() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/evsel.c            | 20 +++++++++++++++++---
 tools/perf/util/python-ext-sources |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d5fbcf8c7aa7..111b924f0a17 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -36,6 +36,7 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "stat.h"
+#include "memswap.h"
 #include "util/parse-branch-options.h"
=20
 #include "sane_ctype.h"
@@ -2120,14 +2121,27 @@ int perf_evsel__parse_sample(struct perf_evsel *evs=
el, union perf_event *event,
 	if (type & PERF_SAMPLE_RAW) {
 		OVERFLOW_CHECK_u64(array);
 		u.val64 =3D *array;
-		if (WARN_ONCE(swapped,
-			      "Endianness of raw data not corrected!\n")) {
-			/* undo swap of u64, then swap on individual u32s */
+
+		/*
+		 * Undo swap of u64, then swap on individual u32s,
+		 * get the size of the raw area and undo all of the
+		 * swap. The pevent interface handles endianity by
+		 * itself.
+		 */
+		if (swapped) {
 			u.val64 =3D bswap_64(u.val64);
 			u.val32[0] =3D bswap_32(u.val32[0]);
 			u.val32[1] =3D bswap_32(u.val32[1]);
 		}
 		data->raw_size =3D u.val32[0];
+
+		/*
+		 * The raw data is aligned on 64bits including the
+		 * u32 size, so it's safe to use mem_bswap_64.
+		 */
+		if (swapped)
+			mem_bswap_64((void *) array, data->raw_size);
+
 		array =3D (void *)array + sizeof(u32);
=20
 		OVERFLOW_CHECK(array, data->raw_size, max_size);
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ex=
t-sources
index b4f2f06722a7..7aa0ea64544e 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -10,6 +10,7 @@ util/ctype.c
 util/evlist.c
 util/evsel.c
 util/cpumap.c
+util/memswap.c
 util/mmap.c
 util/namespaces.c
 ../lib/bitmap.c
--=20
2.14.1
