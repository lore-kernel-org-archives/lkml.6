Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245361-2-3728858765261700191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245360; b=MbKE3A8IS7lXwzRtiDlRRX5lIJ0MP26b4V738CrekDeSxaN9EA
    txy/WITLHfj3c3gcy4XaKdu8Ams5iIQbGdxyFWmUHZNpHqosbaKmaT3tK9aIcuq3
    LSHy0pqWsHooPr6PwmHP6zzYtpbJ5PilBE9i4gsilS1w6tJqfhXVE8E1ULQb4HYF
    Z7RURlKEMJJiIM+YexAlKudxzUS6y0K10BDALAuUpHNFfgN2GVZcuGvf+rNRHWmm
    6qPD+B6lhEYF1FfcYJEAtBU7YkLdBBdGxMNg8DVJMnqRUIdhGjSQnNYOowZdSXmZ
    +Iv8/Q6LWrQms/DoGC3F+HK8Ltj2xZlqEwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245360; bh=bqVwEpvR9T
    ssMuZ4pxi5bZYWlDZQve1R9aFbs4q5hn0=; b=lwWNcyVyjeUOGwEyVWJ77wgN2t
    kwzdKbtxwYmLJF7/w8+1fXzamry2y18YQM8bSSzUlby41bAxhfFS64ryyVucuCnL
    qEOO1MU+pIHwx5fxggBMz2KTTCA7o5kaDMOV3FvuN/PsgRhDQLdcRCJv2Kt31h/N
    ZDBWSN/+tpNQpsOmi/0SQL6cH8UQn+o6p87FePginEwRoA5rGakxgIogPBkZFmvV
    hA5YRovNVaPM/4bhV8Rf7cczvDcpgbgiy/kWhqZ04oWe4zFTbOY7W9xCG1omUmHN
    Cj5UZIdSE7dyBeyW3eGNuwANCwn5AeJIUbnbxIxh89Z2PkqGb8BMoMRy3Lfg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I3uHJ4yj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I3uHJ4yj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKGxbmqfpzlhIFM5t43SmvWIw93H9TSrLlsUd4DAUuj3TrGW3JruYwZyj38JihK4cOTG0LfK/OamfeTcXZ6roG4F6U5Bweks99RtoVuHyuPixWGZhXoz
    pbuDAu7OGCZrQcKUY+6pFAMabFnyl4kqgnFJy3REVNYrt182EjZz+WurJFuxSRe75Cw+Fl3qk1WgAN/g7DoYujEfM2WBs0X7kP6LyGMr0xsTE6AVRSqFtI8x
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8
    a=NPUu3cVeRLjibWiU9KYA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeDIDmY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:42:24 -0400
Received: from mail-dm3nam03on0097.outbound.protection.outlook.com ([104.47.41.97]:45238
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754272AbeDIAUg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 149/189] perf record: Fix period option
 handling
Thread-Topic: [PATCH AUTOSEL for 4.15 149/189] perf record: Fix period option
 handling
Thread-Index: AQHTz5hUW+hOF5fkK02WiJpk8gifkg==
Date: Mon, 9 Apr 2018 00:18:48 +0000
Message-ID: <20180409001637.162453-149-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:AM5w60bToajAPKqbudhVA1OqWKbjqX2NFhmOajFOVkiI4CODF9okhDMw9uqz7CyJ3K6OJcadEHsmBtVKb2m3YaijB0VHl45LJ0BetiVP8cIcdEY6aMMX8QkwJERj+azke/YKmefRoCqfqCMgCGYwb518InQkgNVU6rtclbbuihm0Z6rNGcCVMmSoOCluJsY4aNmlB+j9Ycxlk6iehxfqVY/9Klx61Dj7ZveE0vo8YIzm0BSuYDvamC9BDTdIAS1K;20:m3+pWLQc4Qu7d0sBCjPcQ3+LrXhKwE66HHbYl7qembpn68LpCxxEf1+8j+7grHzehPT8cPDhUz3rGkzD7ZOdiTmFCBms6UNqJfmMa31maGIPSwTSRyM6ozl/jP1Y293UA408AU2JQpX/YZft3jqv/BkIAz+eogA70vJ99EadL5c=
X-MS-Office365-Filtering-Correlation-Id: c055e641-7d66-4e3e-6c96-08d59dafb0e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920C8023FB74200096BBF5BFBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(39060400002)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: I5uSRpioqgUOyWNETBOCHKgEJoLZwVvi1MlaBYxO416lIhuBVWT1iXh1VKZ8RgRCG7qlaNU4ZyusWF2WWtdEehDtF4b4DsFvSXPxl0AuECUG/gqvgwr7YvEaScptfBpmtcCcxiggkDQUnoih8QvQNnp9kuW8jSns/I7Al/+Lclup2r7I+WH8cCF/fOJ1N5mbMmHZUZLmyX+7gHFavOfq13ghtXkyOkBsB6Mg49QVf2ztPVT/kB1bcbVFC0qKINwxxB+BWhUanz+mgjDkFCq01wjvp4T2J2nq7C8PSHXXpIDqQ7nUyOnWqFRDdUYt/DnxEg1/wH/GBWXm3G0QaINS/zF4EqBZ9R5PqCsNHvWbZwJY9v3Cg0Thudgw5B3hz1FbfmjMQae7+C7Ph5YtXHgkbIRiRdm9oouzSdP3amYn2Ao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c055e641-7d66-4e3e-6c96-08d59dafb0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:48.4248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit f290aa1ffa45ed7e37599840878b4dae68269ee1 ]

Stephan reported we don't unset PERIOD sample type when --no-period is
specified. Adding the unset check and reset PERIOD if --no-period is
specified.

Committer notes:

Check the sample_type, it shouldn't have PERF_SAMPLE_PERIOD there when
--no-period is used.

Before:

  # perf record --no-period sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (7 samples) ]
  # perf evlist -v
  cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type:=
 IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, en=
able_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1=
, mmap2: 1, comm_exec: 1
  #

After:

[root@jouet ~]# perf record --no-period sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (17 samples) ]
[root@jouet ~]# perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: I=
P|TID|TIME, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_e=
xec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: =
1, comm_exec: 1
[root@jouet ~]#

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-record.c |  3 ++-
 tools/perf/perf.h           |  1 +
 tools/perf/util/evsel.c     | 11 ++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 003255910c05..2ccb709c0b08 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1533,7 +1533,8 @@ static struct option __record_options[] =3D {
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
 			"Record the sample timestamps"),
-	OPT_BOOLEAN('P', "period", &record.opts.period, "Record the sample period=
"),
+	OPT_BOOLEAN_SET('P', "period", &record.opts.period, &record.opts.period_s=
et,
+			"Record the sample period"),
 	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
 		    "don't sample"),
 	OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 2357f4ccc9c7..cfe46236a5e5 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -50,6 +50,7 @@ struct record_opts {
 	bool	     sample_time_set;
 	bool	     sample_cpu;
 	bool	     period;
+	bool	     period_set;
 	bool	     running_time;
 	bool	     full_auxtrace;
 	bool	     auxtrace_snapshot_mode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 784d852c91cc..d23a8c51b307 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -948,9 +948,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struc=
t record_opts *opts,
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
 		perf_evsel__set_sample_bit(evsel, CPU);
=20
-	if (opts->period)
-		perf_evsel__set_sample_bit(evsel, PERIOD);
-
 	/*
 	 * When the user explicitly disabled time don't force it here.
 	 */
@@ -1052,6 +1049,14 @@ void perf_evsel__config(struct perf_evsel *evsel, st=
ruct record_opts *opts,
 	apply_config_terms(evsel, opts);
=20
 	evsel->ignore_missing_thread =3D opts->ignore_missing_thread;
+
+	/* The --period option takes the precedence. */
+	if (opts->period_set) {
+		if (opts->period)
+			perf_evsel__set_sample_bit(evsel, PERIOD);
+		else
+			perf_evsel__reset_sample_bit(evsel, PERIOD);
+	}
 }
=20
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int n=
threads)
--=20
2.15.1
