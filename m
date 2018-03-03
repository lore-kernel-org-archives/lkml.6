Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120215-2-2729911781017439112
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
    t=1520120214; b=w2AuabE3f4Q5FIFIWH5ct5mzhYkkPHtS1servEDvO/kVuEY
    hD/7MSIAgvkfPGCcGUfUV0z5XEbQKmS/XqMUyxO5L6llNQtSRvRZFIUpDKlZrgOD
    tAVI8Nf29Vfkrdd9vwczSaHIXdq1ZulFz8NYuh95gWfp3YTRtDbv3xCF8dO62VT8
    OyimrXzr7nPjs937SNRXCtThoPHjG7T8g0w9x6qY1ZN7V0vkmxwq5giCBbD33qRz
    mlSiBs2ECU8NwdMECO811RjkWvbbLNqTthkk54bd0t+wcW/CmVUZniExwZyRkaYQ
    7gBDCvquCgJ0F2I/JL4js80qVyDTLn+qr4sTKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120214; bh=D1y7f3
    iDfzF8vPEAyyV2DkuYV2Bxb+R4s/673mOwk/M=; b=dJJaS8xuNUkM67ueFuBpcZ
    2XCDkwdzIgfsnVggcajutkNjjejynehl2CVP626YFyPNLMX68PGuwi/LI3PJdASQ
    pgKSGe9/9rSo9kQO+6RlDZMYPKlDBvIj2jVq/iNUtubN8/IUQ7mKs1SIaVoupXix
    pOg8wtB8xBAKNRCn8Sxu0Wy2xb67soAupHDUnZPG7wQ2aQxzEI8oxIiPBivuEr1t
    lYVwTgX6ye2gvVdVGzXr/47QJhJG8+V8Af1i8N9e+3RAiuRFT1nhug2l2Xv1uHFI
    bze6sUzpQaUY5AWSZ8tpQOCdxfIK6RLm678lAElXx1AFXTuls0EjQSfhESwiZmUQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dz/Y2Z0i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dz/Y2Z0i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeCCXgi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:36:38 -0500
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:43384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934038AbeCCWfp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:45 -0500
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
Subject: [PATCH AUTOSEL for 4.9 151/219] perf inject: Copy events when
 reordering events in pipe mode
Thread-Topic: [PATCH AUTOSEL for 4.9 151/219] perf inject: Copy events when
 reordering events in pipe mode
Thread-Index: AQHTsz8VYyyM5t8RcU+tpe6G+2z+0w==
Date: Sat, 3 Mar 2018 22:29:24 +0000
Message-ID: <20180303222716.26640-151-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;6:tMrAT1V+icuKn+RUuyhZ+nh+xUs4xJw+Y+L9LU+XCexOcUhNkQPGKGr0qoiGIL+n4VAzIcnIV/jTDbBrTdf7pjuDRVMCCz0p8YnoluVm6VDRI/wxHOBt9R5Iwv8vLx17fpaZor8fklW6qyhtqoyKKeGA3f9gZYrxNgF9MnVn/UX7YsV0s7SFNnKQABzQ7uw+LYfZMiHJmA69uiXW7d6b2IPN43raFLyy44BqzIGa+o/DtzJyjjTEJTmmHR7Z3DI0PCCtY1lkAij3mzKRrtjfGmpWCc5Gn80k+EbVcyKjbRaFMnmlWPiC7IW6gXufde3AYPicvSLw7EuOEXQPbqVD8KOPJF+p8bL42NPFFek0128l6aLqqY7uqaq4P2hAAM8c;5:85Yzxg9HIcUTOzgmZVdvij4GMpKQvE2f8Liws6WDcr0HiaW8By5Cjd1ZzRsTXSLyYWUf4ZIXfqJx3JHQtYBTxGmnPXv+64XlnRwC7JNqmeue9e/aBUXkqbHD2Rkpiey7bPm/aL8O1aCOBxIJq3LiXOrB2bvWSISnsayn4sf3iiM=;24:IRE6d0KPxEIusuQVK6OZpqzCf8pdtwEkdg7P2ylhN6S9WKGJI8Xz60F5HYiWaFRJNjGcZkbo9n8t2Y93oh+Hwh0VxICtItyuMJ0ehZsrgkc=;7:GY7OmAqLO5MPlIEaUrjLm5LvZE9tYTXlWsGmZ9haN4WDsz+PZjnZPXxbd8DzR19xkGuEav+0emtMVfvXYkCPQLh+S6suUHkVxC+ZUZwRG4bkBL47YHoo5iF7xFW+b+00oF1Y0TyD6hXFzer247rgxg63EII+DUO2uM1O4W2LkQfT0DxY7B6CqsJaSTh4XFnoitBl6a+3bv924juiFeaEQD7/ll6G0Q7zoxszGjSktXbW2dpf0VwrvkW/xG9IZdhN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9194335-21e6-4590-78a0-08d58157174e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10344E08DD39B8D58759525EFBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(966005)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(7416002)(68736007)(575784001)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(6306002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: l5vfjVDxaU2n31XGs2NL5NjOmsEzp8L3xhx97MmzM93KWxp9LOIWwhYiqLGK8H4nTUzu4UBPkphGk+46D90WgKL/aGdbpCn8CtN6dDRoxra8EAizUHN2D50dWPpGqVGTsPHLyDK7tKUlxYD7jieYgaQNdYIRTd9cz0IAi0/iXdU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9194335-21e6-4590-78a0-08d58157174e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:24.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
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
index fe84df1875aa..e70e935b1841 100644
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
index 5d61242a6e64..97b4822fe7f0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1628,6 +1628,7 @@ static int __perf_session__process_pipe_events(struct=
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
