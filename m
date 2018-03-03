Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119888-2-6066146662810611631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119888; b=wPvfIgorPO3OfamY0kwHZ+oUeA7BKxwTbXnDmm4fwKyrbHf
    2o26zVQdjzZQgXPs5OUmYv3NmSHbM7vKHRFK1QVLJUMTBN85X8zYJPUN25fnp+wu
    HQhqKUTHlQK8XNAEO5DSTTKLkKfT6Kvnub1eWektjTME89LwhhjU3oRPqa8TRstz
    92RBcTA/kehh0SXrjtRquB//Sc8YeGRW0QrfUw4H0IVS/nUGw9rp1NPlp+tSdJTv
    HdCMskaGfKa5kjeoySWSQJMP72IKHffbZsxO3Rpqxe8yVE5QJ3ElXatdo1oc2um6
    7mDG6QHJYyT2pUFYwuIsM1Do+T4b/Wo79w1i4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119888; bh=DGHh8v
    ItsZFmKILuvcxpKPbjUqd2WyeuuhGpH4creQQ=; b=rWTG4erEgy40lqTKuxZ7gT
    smzzVfBX+vrNnA0vdytlh5qPK70uqaVq6Lm0rAch7XvBUe0fRBuBs/j4KaYJA8DI
    gZfTsOs3MFXYU3UA8doSLePt6mvdLwpzGwuboT6e+i4e6EpkxU2+pNmEvyvUcmcW
    AdhmiqxW5JsKbRT/4vAwVZUjuNkD8YABb5w3pw5B9edUcAWjw9cyGM3GoRqS6AM7
    /wkoyegbTxcST5Op1p6n6wuugjST6sVuX3FNGjVroqo6/6VVdNoiCcRyPUaVh8pv
    YTu7+ACsGW5wKmn/wTyYqiAgfJ4jgCc0nl+5VDs9psVvt1p9uvHzytVf0aNjAJ5g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDlNetum x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RDlNetum x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeCCXan (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:30:43 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934540AbeCCWgO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 169/219] perf stat: Fix bug in handling events
 in error state
Thread-Topic: [PATCH AUTOSEL for 4.9 169/219] perf stat: Fix bug in handling
 events in error state
Thread-Index: AQHTsz8bBwlRahIClE2EJ/yaNZU72w==
Date: Sat, 3 Mar 2018 22:29:35 +0000
Message-ID: <20180303222716.26640-169-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:ijKJc56UHB5EnRC47bpMwdswUiyEtogLsV7k+6B8UHlXlZR5Gv8C8WFXHk/lpAQR1IXbJVc9bajYzN5hgWGCBmuu1ff2dgLLMpPwFbVdIdszTSQFOGAOqzh933Oay8qCo62+rn40GtSqNjIxjnhZzrjLR1WAPGfYDbliW6tf1xC/R/Px4h1NRI4j9DL/nzyuIGC+Pz8vbNrX5usEzVC/1yYI9Xbd1Oo8T/9TzxnW5fEPCwx4O3naKRQq2iVua9Kr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91967515-f636-4e75-33d5-08d581572587
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10347D4F3A301C43C8E1DF95FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(966005)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(7416002)(68736007)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(6306002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zqSlxLWZ0v0+YGcR/eXWFe+uNJxv2L4n1+4rN5EKEqWAmX4DE3y9ImsWlMgoh+AR5m61XAP2Dk9hI7wG4wlhuhM+hV/IU89/iUBV2322J8Z2sLfp8h7cOwdDPwnGTtqs6JaWUhF+oT63EYehnQ7aMkuasSuxcUwVHYR27RS4hrs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91967515-f636-4e75-33d5-08d581572587
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:35.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephane Eranian <eranian@google.com>

[ Upstream commit db49a71798a38f3ddf3f3462703328dca39b1ac7 ]

(This is a patch has been sitting in the Intel CQM/CMT driver series for
 a while, despite not depend on it. Sending it now independently since
 the series is being discarded.)

When an event is in error state, read() returns 0 instead of sizeof()
buffer. In certain modes, such as interval printing, ignoring the 0
return value may cause bogus count deltas to be computed and thus
invalid results printed.

This patch fixes this problem by modifying read_counters() to mark the
event as not scaled (scaled =3D -1) to force the printout routine to show
<NOT COUNTED>.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170412182301.44406-1-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-stat.c | 12 +++++++++---
 tools/perf/util/evsel.c   |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c241167c76c9..5b60ec669e73 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -311,8 +311,12 @@ static int read_counter(struct perf_evsel *counter)
 			struct perf_counts_values *count;
=20
 			count =3D perf_counts(counter->counts, cpu, thread);
-			if (perf_evsel__read(counter, cpu, thread, count))
+			if (perf_evsel__read(counter, cpu, thread, count)) {
+				counter->counts->scaled =3D -1;
+				perf_counts(counter->counts, cpu, thread)->ena =3D 0;
+				perf_counts(counter->counts, cpu, thread)->run =3D 0;
 				return -1;
+			}
=20
 			if (STAT_RECORD) {
 				if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
@@ -337,12 +341,14 @@ static int read_counter(struct perf_evsel *counter)
 static void read_counters(void)
 {
 	struct perf_evsel *counter;
+	int ret;
=20
 	evlist__for_each_entry(evsel_list, counter) {
-		if (read_counter(counter))
+		ret =3D read_counter(counter);
+		if (ret)
 			pr_debug("failed to read counter %s\n", counter->name);
=20
-		if (perf_stat_process_counter(&stat_config, counter))
+		if (ret =3D=3D 0 && perf_stat_process_counter(&stat_config, counter))
 			pr_warning("failed to process counter %s\n", counter->name);
 	}
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 539724c7d30b..bce80f866dd0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1221,7 +1221,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cp=
u, int thread,
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;
=20
-	if (readn(FD(evsel, cpu, thread), count, sizeof(*count)) < 0)
+	if (readn(FD(evsel, cpu, thread), count, sizeof(*count)) <=3D 0)
 		return -errno;
=20
 	return 0;
@@ -1239,7 +1239,7 @@ int __perf_evsel__read_on_cpu(struct perf_evsel *evse=
l,
 	if (evsel->counts =3D=3D NULL && perf_evsel__alloc_counts(evsel, cpu + 1,=
 thread + 1) < 0)
 		return -ENOMEM;
=20
-	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) < 0)
+	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <=3D 0)
 		return -errno;
=20
 	perf_evsel__compute_deltas(evsel, cpu, thread, &count);
--=20
2.14.1
