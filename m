Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496882-2-7966452782945032059
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
    t=1521496882; b=ALsotDaf3hJFm7vRj+bciQKfsTGJ2aq2qQ3N6j1ZngoUU7c
    kIQkjqxSJ7sO8dlfXz9hEnQkHxjKi4yp/cureDKTye2uFwooZeIHxPic1WWF+Mzm
    X/DZLA5emn+oOycXVwHT4QUvmmUe3iyGNLoxebKMNFnOSeVsiVPvY6Glvj1MmK5d
    3bZq6VmGBE2YD+0qvD1FrLc/ucnQU2I6+wAaHL9RNG79FyR+QyJfJIafKyq2Xw4v
    rkSj7Sj5pbzwCYvug3nGgMDdiVLSlFviC25MHwJitpbtrCgZwP+EwPgHsICU1HSN
    hJe2s8NE8vLJCZLvzyHSVJMgn+msrplYf1MSWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496882; bh=sflMsk
    Rgu+MiwLtGuCBqDlHP/jIixZX4mKg2qPoDwWA=; b=qcX5jlpDkrtrv9cODHxRZf
    EAY1yfZMXcDK7dBW1adc5hERMJzntJw9BiLC6mCewHa9h4tpPPWAwE39iuK/RQPh
    9j9DwL38rj712WuZO6Oj06/s1z0WLsCF8r7CLvcLhXUSeLreNQt6MP3Nsanp5JjT
    rpnD46e6q2tN8NnsJA/L33nlq/kOGWHIvagH3DM4CYrZAeuA2geIuF4+nkT7TokD
    c7cEz5MTfwmFMgM3tN/IgIc2AFxdIau5rEGZOeUZDpr/Uen0kXqHhGXdcWuqi3Fc
    Ugt7OdniPqw3UcS3CyDBSruTdNrv7a8I7AKtWsn3CnmVkeq0W1hnDmf67bIQivvg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A3yNJlWK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledttddtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A3yNJlWK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledttddtnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934450AbeCSWBS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:01:18 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934446AbeCSPz7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 50/97] perf report: Fix a no annotate browser
 displayed issue
Thread-Topic: [PATCH AUTOSEL for 4.14 50/97] perf report: Fix a no annotate
 browser displayed issue
Thread-Index: AQHTv5q0/2E15gefPEO+wAf5dfyy0w==
Date: Mon, 19 Mar 2018 15:55:30 +0000
Message-ID: <20180319155411.12348-50-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:RQCpfUc9SOOMgjt3dHjoNc39h6cUuj+DvdVzr2YNlhP1AkI8lavu9p4s96cu8KW34gZOWkZXBDc/JNGGiXenhDcri9oagqYU7w1bsw61hGHCeMpX9w5YLfzwZRm8Y8P83SCAMacqyCdI/E5n43jxSr25T3L29iJOl+v7bpZo5akQ2Fqa3RIXYDlHAYncXoM4zQdexyK1LTEFZ3yYNPzXVx7DGDu/duSATHQILS8qpNCyOJ5xRfmZ62y/woKd9jAB;20:3KK9oH4//2l0XM7Nnhv7uDBRtaeNhuaa/5cJPRLPXo3yKwJJ8Q1G0WfJjVdvVtUQf8WnKriKetrCE3TJ6xCfmWgLxIdaqlO4h4f/NLMpn3apkO5soF2aaBlIeZfhWzanjd3QJ/ELqms/gT2+MkbBc3ynRktThvtRhP1Z31eR/9Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc8b5b59-e1c4-44c1-3ef0-08d58db1e2f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096742B927D628DFE36E5188FBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(59450400001)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(966005)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(6306002)(86362001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LGMwF1UzQqAZdcZYTssFVOYILWWH6WQaiHZxbfKGIt9Id+Wl+RwROfBcc4ubcE5jl+2VL8bwG5vooFmzutkEg1F5Du7Uc0V5E1cehK/yqCESm81CQFfAqfCwZ14IrwI5QE+1PdNE3lGQ1+6Y5JRvrZpigCzsLgzqqE80F/wi0n2lRR8r91Izqe1PMaApOXAmCIxgVMq+szwsFSOLdGIkkkL1IGFUoPlIQDfpeBkjiuh8t5kIOa/jMA9Hx2OfCC5OkzHSS2Yvz3t48vMmZSXM17lrBu4QahGFQscnGjT0IIXF1sr6UxsM/DqkXvF75EGS5u30tCiC64uVDj+IMa3ZxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b5b59-e1c4-44c1-3ef0-08d58db1e2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:30.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jin Yao <yao.jin@linux.intel.com>

[ Upstream commit 40c39e3046411f84bab82f66783ff3593e2bcd9b ]

When enabling '-b' option in perf record, for example,

  perf record -b ...
  perf report

and then browsing the annotate browser from perf report (press 'A'), it
would fail (annotate browser can't be displayed).

It's because the '.add_entry_cb' op of struct report is overwritten by
hist_iter__branch_callback() in builtin-report.c. But this function doesn't=
 do
something like mapping symbols and sources. So next, do_annotate() will ret=
urn
directly.

        notes =3D symbol__annotation(act->ms.sym);
        if (!notes->src)
                return 0;

This patch adds the lost code to hist_iter__branch_callback (refer to
hist_iter__report_callback).

v2:

Fix a crash bug when perform 'perf report --stdio'.

The reason is that we init the symbol annotation only in browser mode, it
doesn't allocate/init resources for stdio mode.

So now in hist_iter__branch_callback(), it will return directly if it's not=
 in
browser mode.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1514284963-18587-1-git-send-email-yao.jin@li=
nux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-report.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index fae4b0340750..183c3ed56e08 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -162,12 +162,28 @@ static int hist_iter__branch_callback(struct hist_ent=
ry_iter *iter,
 	struct hist_entry *he =3D iter->he;
 	struct report *rep =3D arg;
 	struct branch_info *bi;
+	struct perf_sample *sample =3D iter->sample;
+	struct perf_evsel *evsel =3D iter->evsel;
+	int err;
+
+	if (!ui__has_annotation())
+		return 0;
+
+	hist__account_cycles(sample->branch_stack, al, sample,
+			     rep->nonany_branch_mode);
=20
 	bi =3D he->branch_info;
+	err =3D addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	if (err)
+		goto out;
+
+	err =3D addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+
 	branch_type_count(&rep->brtype_stat, &bi->flags,
 			  bi->from.addr, bi->to.addr);
=20
-	return 0;
+out:
+	return err;
 }
=20
 static int process_sample_event(struct perf_tool *tool,
--=20
2.14.1
