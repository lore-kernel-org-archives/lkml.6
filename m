Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242717-2-15228517702388308371
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
    1523242716; b=gLfMMH7KS8lUR/8WHGcPDaTN+gDomdkPl7gM/ysxmNZHStjr2g
    HSvp8YEl9SAScdbJ/B9VmN/L16AfdEE157DT45FHgoEYeqYZ/YnYuy60R1SFUR6C
    P1SoL0G1ytIfNPmDebuaxAGEdj4LEWepov+uRhqZvOYGiE/qGvmxI+UwYkpTGm7p
    owPjZXsK/IoJ6AWMpBvOg+CvoSWqccSy3azcZYhDIGlaioVAUnD7Pc5fUiy65pEV
    g/KnvVcGQcqt81k/FgzhUKiTRX1K8OHdHuah4o/R7fBy6dlG2L9+OsduhXjY364E
    vImHw6+lfDgtNevVqn1pVp+/KOH+9tqvrXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242716; bh=iSFoO/pc+I
    xBY+yeCyRq8vW4Owm1reBoKClP37TyZ0g=; b=BXCr/zOOAxwb01G2u2w/jvjGG3
    jncBCyu6ABi9oyT8+wdlFwxUkoLlCrl/zq1q1Ba18Uh5dyK1SIX7TlFZR2Z0jqjf
    htHnHVJU+q8FQp006HWlxVVw8GyhyFywDl0mpCRuAWKAcOJqlqFv4ApkjK5mPlvt
    vWShJBAE75rfGUFNCWRDbyOeRlt4r3Izb9MgSKw47oGZeJnHzMPOjBiigChPGnht
    yhoiJAuulTntzerlhV/CfMQO+LDBv1nHd6kZSFdsqFvNjWbDjxP7egySiEa6b6te
    IfH9hOl0thSRovCFdLIeIUf5Na98HcjCBp1roiPhquM61iaEVJ581pItim6w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BEIize3s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BEIize3s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFv5QYd5ZKdhpdZ3k5lq+7e3L6+ibheZN6mXPEljeiGMQBfNMJbVoepOQU9r1R/mI/7d6pV+97nsUWtiR++ZCxZRolhugJE/x7JgwQ2l8NT6Eztdy34J
    Qif2EYxFltJ/zijCCG5Mhmzq/kAN0evO1Y/xt8Ivvshdya31mGEu1xGEG7eIqEDJZvSqEHKwhspXhqWx/IOR1YGdJV7OO0MEM/DcoV+xNLnFqF1abAefEWzN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8
    a=NPUu3cVeRLjibWiU9KYA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755211AbeDIC6B (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:58:01 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755213AbeDIAZh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:37 -0400
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
Subject: [PATCH AUTOSEL for 4.14 125/161] perf record: Fix period option
 handling
Thread-Topic: [PATCH AUTOSEL for 4.14 125/161] perf record: Fix period option
 handling
Thread-Index: AQHTz5i4aE/9EYG0oEe6zzW+rK7y+A==
Date: Mon, 9 Apr 2018 00:21:35 +0000
Message-ID: <20180409001936.162706-125-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:JLDDNsWyncFl4Cx08bE+Oaf0KT+tqqCNREaZaPAA1BmETf0mEUjd3XlMbhusypG64ciCehjBx6e533u2j0EezHQp+zttZW5PgQmRFfk0s6hShK3TKIg5oIZ9kN3plzjlrLUNil9aVqYw8zv9CuJI/nENL3z8HmLCbU0b4EA2GGGk52Q+1EJrXpT/FUt8WP7ctKVEmDzE2bnFf9YeY0wwH884FJQAGVrU/tG8ssBR5/oNeAWGnIPV2ceOWGIOwTJK;20:gSuwQWf57+x2pY/djTtJYREwIG+o7+iIZk7Fuph5Ouoruu73zRok7z1zks8jHT1BY+XvRjs+TC0kfmU7iTDAeVl9CYIMUqjHuxFwbFs0AAsofWxZ1KutwJ5kPpXu66ia51ifj0avYbdUrWesHQM5yw8Nqtp8OXy5czUx2PO+TVQ=
X-MS-Office365-Filtering-Correlation-Id: c8795498-65ca-4e8c-f448-08d59db06736
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013CC24075C7FE3602ED001FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(39060400002)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5KP8ca6yRK8wAgHLGtX7oV79w5GP3ajlX+0Xxqki1wv7pfQLZChLw9e0PboKyvcQro2pZ6STcxaQHm53Dc49JFpBNnTwlOcOz9WS2hzWLtH3PEomTYFwtf1n+UwQOGLCLyQXD0qryWKIFFjSBIhCQsCknYS4tdBI5n2IUpp63MPMYriUUbUVM4+XBmZMb5gBBjGuMvIRLrINvgYwo+RvqzMOQpIE1TXwql8YrXL1EdsFgANA2UcsYMmP2s5RHxB+iy+5NdV8txL6j+chOGXfR9q3I9eckuiwaNmZrY0VdMtKNyvnXjyJsNcXzauZf7JltoUVjs0iXuKinTQUdnfaJ09wykwt8HbTc0lWovNprRVF8tDGqnKVIqQL3P5eEqc2DsTwM5NQ5GDSRagboF/v+l/Tscz/qLi47HxkL3wp26g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8795498-65ca-4e8c-f448-08d59db06736
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:35.8936
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
index 0c95ffefb6cc..272ff4b5e80e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1611,7 +1611,8 @@ static struct option __record_options[] =3D {
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
index f75f3dec7485..55086389fc06 100644
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
index 4c31a22bbaa0..7c335d84becf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -943,9 +943,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struc=
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
@@ -1047,6 +1044,14 @@ void perf_evsel__config(struct perf_evsel *evsel, st=
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
