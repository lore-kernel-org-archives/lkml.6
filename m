Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117338-5-14288080698239950082
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
    t=1520117338; b=OxCDxAiaIx4zZSBOBJoRffx/8wPO9i9pGKjWqAd9EOuiIX1
    oAEEEOF0KyyJJ5g7gAJzEDRvuQe5ltJy/1KIbGuvIoaI9frRKHRPL/ice+6dfGmQ
    rcxPAwDJROku54tZpY0WuavHbp22ArresrKnyhgcTBb24vP068MZic6khvVhecUp
    kfKfH469GfwoK0T87k9KailcLJTv28w9nGSsU1nJ9WKc5vND6gtdPbRRg2DpquFq
    7bk0a1FfLOtucXLrghhArKwhi3pIklhwazqWALS3cXxKIo/4bEA9PDoe0H8SLLj6
    s6HYMzYWv9Y2xr63UYRyVOk97vUU3oAS3q8rW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117338; bh=bGTzXI
    8y/5BPdqjzmdkZwJSVWV2pFu8juil4JqBAKsM=; b=hnqmf2/jqNu+zTJTH70ese
    HOLAiqRlblo8wTUP39QYOLaUyBV1Zq7tj/syj6tsIc7wQL1hMefIeVAJgNZYb0rR
    8F6bVOmFqeAn1ItcbKPXpAG72WUpDfXOhksjGi1Lp1Ev2AZqXMZ7+TjrqBYDTCQA
    PwhJDWvS35/LR9MO7pd/BpSplb1UOazv0o08DdDxFgxAypSQ/FdyuCyw+e7TOfZ+
    dAu6FdiiwtvVBft0POsJeu/CCMX1C0UldUY/rgtktrqS4z+g++fPld8FVQsFpffJ
    6ezBxeJfpAj0BIRk2/BX0lQ8J9aw5O0bQIxfoY4NOxY9Kec3n/i5AREyqhEHhM1Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sq4KiZYa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sq4KiZYa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeCCWsd (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:48:33 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935151AbeCCWlu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:50 -0500
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
Subject: [PATCH AUTOSEL for 3.18 40/63] perf inject: Copy events when
 reordering events in pipe mode
Thread-Topic: [PATCH AUTOSEL for 3.18 40/63] perf inject: Copy events when
 reordering events in pipe mode
Thread-Index: AQHTsz+pJGomDVKAfEy7mlnOgCDoIw==
Date: Sat, 3 Mar 2018 22:33:34 +0000
Message-ID: <20180303223228.27323-40-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:4pSVimy7vmG71YtIcBwPhPzo1C4zJHYxHLsWgZIg0yHIh757bim7MhxuZfKcP74ifMCmYdYBJo8f3kL1gct2G7IljdaKZoL21UwnaMXLwYhmHU8sZm8t20WUyEOGmRozMmIddywmcS4YvF8XzT4UzxAcqYD7960iqwmwIEyKOYVvFZwLnaajZFDUK7oiT0GZ5RTRHuwOWdJrDOOUH+xvDIEbgEiHPW9CB2rWCChdOGrg0Kgk05fOGlNhSHSwZaqo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5eddc69e-d395-4024-2c63-08d58157f2e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0632C8F4A3B579C1B70887FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(42068640409301)(153496737603132)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(966005)(6306002)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(7416002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: USjI0eV53RNcpE4Wlb6NRypQZq/4jubaJIXhfrfTWz28Qr0XKb71zPfowiGOl3aW37lisQt8M21azwn+QmoCaeluWmVdxt1IS0yTsmUwvaxUzgLRqO76/zIs2JEPPDRJp3Rw3wetjmwjEaBpNVmp1bAxEkT2COgwFrderdZojr4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eddc69e-d395-4024-2c63-08d58157f2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:34.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index fd4be94125fb..e2c53bb0e476 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -80,7 +80,7 @@ static union perf_event *dup_event(struct ordered_events =
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
@@ -151,6 +151,7 @@ void ordered_events__delete(struct ordered_events *oe, =
struct ordered_event *eve
 	list_move(&event->list, &oe->cache);
 	oe->nr_events--;
 	free_dup_event(oe, event->event);
+	event->event =3D NULL;
 }
=20
 static int __ordered_events__flush(struct perf_session *s,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 80dbba095f30..e798b58971bf 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1080,6 +1080,7 @@ static int __perf_session__process_pipe_events(struct=
 perf_session *session,
 	buf =3D malloc(cur_size);
 	if (!buf)
 		return -errno;
+	ordered_events__set_copy_on_queue(oe, true);
 more:
 	event =3D buf;
 	err =3D readn(fd, event, sizeof(struct perf_event_header));
--=20
2.14.1
