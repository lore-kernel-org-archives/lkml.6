Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490585-2-12026619865911477939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490584; b=CtSN8kbCattwYI+Ec9OfROCwE/McpfxxgdnRfzSXv96F/Pd
    sE74rU13d02ad0ptruB0buPGloa1l0MbHaPVXhLMzEdlUsIfcIFOcFOqVsOmKi7h
    R8l/TVxLRG2SUy4AIS7QkE89zw53MsAII4EZ6ldGVCtPWQ+nnec91jpylFX8IbWE
    ZYL6tbBwwl68Y/YY1k59azt6tlTV2DUwDXQfuRPJZcAhJVzgO46z9siK/ycG5siT
    P3JkOQQoILt4lNp0NvjBfYq+eQAJU8xcmTMDfpeFWR41yU/vlq6jNsmR9yDUrGcM
    iY/JJwgFLxKHJTIgVRIR/AGJOxXB/agmpzDgqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490584; bh=jC5hNV
    ldV3qTFLK3bxurz2cJCx6/4hzFCSbC9jw2KkM=; b=H9wHOaTVcVuMiPj95gDqIe
    mFhZ8jPljfkXv+uAgrhTL+Sb3jjSEewo6sH0xa++wLjx0vZdCLw7KxZ52WP39lXN
    GxecfEpS1SZa5wwEr1d6yGf2YmwJGQ9+KRDXgFg85GfpXEn8xHJ/YRWOdD2y1fPb
    guYWEuPKHESPE34iE4+Q694O3J6k/rYGoisZbkt0rimU+h7ISNh0i6pgZp/uaI2d
    yhm5JV1npFSwYmszH0cR3vd9F2sr901RhedOmu78veWYE03blidt2uOEVjCFgkSi
    gsXJM39Y+6pavBY1FrnFXVjL5bVJ5MUSII5t62WiaTQytmLB5y/FZTUbp5hdacdA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G8Nk73bs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G8Nk73bs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbeCHG3T (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:29:19 -0500
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:8240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751335AbeCHFAP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:15 -0500
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
Subject: [PATCH AUTOSEL for 4.9 023/190] perf stat: Fix bug in handling events
 in error state
Thread-Topic: [PATCH AUTOSEL for 4.9 023/190] perf stat: Fix bug in handling
 events in error state
Thread-Index: AQHTtporrhD3ssVzJkiY2D0oPd6/Og==
Date: Thu, 8 Mar 2018 04:59:00 +0000
Message-ID: <20180308045810.8041-23-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:Wp1Gmz3vW5RvwySslt1zd6/56MT6V3QYjbXC2Uxo1fq09Q+1UxoVnGQ7p/uoMDn+IcnNNSVoDaE5mt6oQkPsinRdBn6cdP3CnrAMZEaeTlZhD49gw2RIo1ZfS5sg5ibcRKR8/qMg5QAlAwXNukMNPP7g8/K1y2Jj0d78jlN2tdZAzBCxGZ0SbrIRss3pne5dEfPfEfZ7Z0z7X1RQkemGEjUiGlcg1pZXhGCZRRPoAi6Uz/lNR0EhM/24hMB6yFzy;20:yiyghA/wNYOJzMysTGOJE/VgiFd37wEO2rsKHvhjlcwK6kgLjLjG8kX/KiStbrv7AU7j/8ndQBDQyAHN2WySb147Mtl/ttWR8xYYHcuQ7x3zYZMySHAGvoi47T4jS6rt2UOwhR36OyruatBRmTYLKbzQ1OAfQCJDqalkLthFqR4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c49684ad-bb2f-44c6-79dc-08d584b17330
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983982292C94633E931DFFAFBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(6306002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(7416002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(966005)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ggD85h44BgWX/ugdAim7nh/yPJMDhlFkUUVMs+W7yn5hPVqdOvctQ+RCCkH22O+zFXeSPlbzsnJcWtEkp2tYp4NLlwJ8WAK3EBXQygbUum24Xe713igeAbMhYyZeLWKUWy9tk/XWjYNY+4OGtTadXF7+kRAsdTULfqbqRwm569lSgQiz+WuqkZKv+tTcPD0FnFB+ndKbTmycIHoypLXihdRLFP7mcxpYTHf1EYHqV9gdekMtfbxkJZA+EHqzewiHf12C7LOgLL8SPCHW8Eb3pB5DtbDB2Wun9Rt0vVM5yWEfyeykusqYWyR6B8Wt4WCe453qb10zLGsejBPD/+bV3g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49684ad-bb2f-44c6-79dc-08d584b17330
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:00.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index 688dea7cb08f..c3c4b4990f3c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -310,8 +310,12 @@ static int read_counter(struct perf_evsel *counter)
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
@@ -336,12 +340,14 @@ static int read_counter(struct perf_evsel *counter)
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
