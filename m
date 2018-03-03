Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118214-2-18044356021875781506
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
    t=1520118213; b=YIgv7yI0BHIJkbW8Fe5GM5y2ZbTOBiC5auuIrSVb9qjjOjb
    v74rMF51KW+ktbv0ZEvi2/3m2rjlOqUZKPiUCS3yw2jwXfqzChMgkRRuXdCiygZz
    KBlweTL8KuorsobgAj3C3efUmmHR6D6rXZbOPe+eGkh2+xpzozGdV0/WwRbi16LX
    qU0Uj/YYB0iZcJSWwIFM3mxABOiuAlArZ2jbrZaKAeA2MX3zTjJAC4bHlR5JRdyG
    TNzJGzX99Lm59gvOLo6bEB1Xb1T4/UjxQwt9mwuWcJsivkdRaBJhk/rDW4CjiavK
    YaurLRmhxGcCNLlQrpu2nm5Sm/2LySK4ECFaqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118213; bh=uCvQUn
    hMGqoet/s3RB6T6ij5lh2lVjfxP6iEWqtbVKk=; b=jdy/RmjgYDxQKJIxlQJuXw
    xDaIAztSEIQx+NcH9CLIYaWofL2YINhx+tzKsfJsOYxxifgaQW3cwDpYzTXTVUUU
    PbZoOebq1DKHn62oilVjrUmWNyXXGFdboi39S2zQ7wCN0pf+8qQlrWWBmKyRhhIm
    NT7uxFGSTrLj++MUvqjBHNV5ItuQMlmzjbr47SfacIxfo7tq1T2X2yTYpXo0tZyH
    hNOc/7LhPeQ79sI2nET5SdVHMJi2iFaFOYUx2D65FQVmg+/AMlHIGwWbkQMTcdn+
    XV4FV292ZgnxtFcW4MZG7kHcilYYcE5Rt90wIK0mooRXkkotKxoOvxnwb2R6XnhA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OhvmEj7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OhvmEj7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeCCWkS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:18 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934815AbeCCWkJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Carrillo-Cisneros <davidcc@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Simon Que <sque@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 076/115] perf inject: Copy events when
 reordering events in pipe mode
Thread-Topic: [PATCH AUTOSEL for 4.4 076/115] perf inject: Copy events when
 reordering events in pipe mode
Thread-Index: AQHTsz9iDkz1GCZE+E+dSBBEpkca9Q==
Date: Sat, 3 Mar 2018 22:31:34 +0000
Message-ID: <20180303223010.27106-76-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:u9daQHzciL0zlehfXGttpMdba1QX+1jf7jM5hHzhMKuR8oZrYlPGhgwMr793Q2d2fx+Kba4XeHSyQ08mf2oQAuzVeJuuYNla2tDGtnL0/fxNWMoBSY84BvxpJCtBp2kYc/PsvtKs3wh9ranKsckYViGhMNIqxdBkD0Kjl9Yhxh6MvpMrAxZxUhCnQjvEZHpy1cGnmuFBKuMCwM7rR+m5O+rYaor5LaRj8tOcmdEKlHVrSkvkoRM1NjBKq5TfSyWE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82abffd7-0f5b-4988-20e9-08d58157b2fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10334B3C504C7BAC95285285FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6306002)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(966005)(7416002)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: tIlDykMbSXQ/COE6Pdm0N7CJarlyWqtdvIoUH4t525pilL/GCguEidRBCUpUl/iS2vxuglu7Hh1GpAJQ8fANYO2wpu6TW4NkcEiWMIAjkgnoLqchU8PLej/JeeWo2etx/K3PLKy71/KnLoSvQA4jWPHkNAI9t9FbBNthz8ZBzN4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82abffd7-0f5b-4988-20e9-08d58157b2fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:34.0804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Carrillo-Cisneros <davidcc@google.com>

[ Upstream commit 1e0d4f0200e4dbdfc38d818f329d8a0955f7c6f5 ]

__perf_session__process_pipe_events reuses the same memory buffer to
process all events in the pipe.

When reordering is needed (e.g. -b option), events are not immediately
flushed, but kept around until reordering is possible, causing
memory corruption.

The problem is usually observed by a "Unknown sample error" output. It
can easily be reproduced by:

  perf record -o - noploop | perf inject -b > output

Committer testing:

Before:

  $ perf record -o - stress -t 2 -c 2 | perf inject -b > /dev/null
  stress: info: [8297] dispatching hogs: 2 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [8297] successful run completed in 2s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  Warning:
  Found 1 unknown events!

  Is this an older tool processing a perf.data file generated by a more rec=
ent tool?

  If that is not the case, consider reporting to linux-kernel@vger.kernel.o=
rg.

  $

After:

  $ perf record -o - stress -t 2 -c 2 | perf inject -b > /dev/null
  stress: info: [9027] dispatching hogs: 2 cpu, 0 io, 0 vm, 0 hdd
  stress: info: [9027] successful run completed in 2s
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  no symbols found in /usr/bin/stress, maybe install a debug package?
  no symbols found in /usr/bin/stress, maybe install a debug package?
  $

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170410201432.24807-3-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/ordered-events.c | 3 ++-
 tools/perf/util/session.c        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-eve=
nts.c
index b1b9e2385f4b..5e58149c4df2 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -79,7 +79,7 @@ static union perf_event *dup_event(struct ordered_events =
*oe,
=20
 static void free_dup_event(struct ordered_events *oe, union perf_event *ev=
ent)
 {
-	if (oe->copy_on_queue) {
+	if (event && oe->copy_on_queue) {
 		oe->cur_alloc_size -=3D event->header.size;
 		free(event);
 	}
@@ -150,6 +150,7 @@ void ordered_events__delete(struct ordered_events *oe, =
struct ordered_event *eve
 	list_move(&event->list, &oe->cache);
 	oe->nr_events--;
 	free_dup_event(oe, event->event);
+	event->event =3D NULL;
 }
=20
 int ordered_events__queue(struct ordered_events *oe, union perf_event *eve=
nt,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 468de95bc8bb..fe1c837459f4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1437,6 +1437,7 @@ static int __perf_session__process_pipe_events(struct=
 perf_session *session)
 	buf =3D malloc(cur_size);
 	if (!buf)
 		return -errno;
+	ordered_events__set_copy_on_queue(oe, true);
 more:
 	event =3D buf;
 	err =3D readn(fd, event, sizeof(struct perf_event_header));
--=20
2.14.1
