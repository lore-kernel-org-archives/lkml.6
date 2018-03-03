Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520115985-2-7877983866772270307
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
    t=1520115984; b=QeVpdXbNifGfWv8WCae+KW8mcYNqECXqOBllpn1eG+glEt+
    D0MNcHL6s2ErdkZZKWIFeqYm2uqQ+GiEBWyqOxJSIXcUaDeeQm3cHOX4qffzQRru
    nbIf2sLwkwP9FkqtXOP0Xgldc91YfzCRLLliLG6qS1eFoqjBESncc9t/tE33MUdD
    vqDgFNiDx71zHYpuUgH/olcAv+2WCUBfQPTb/2/Aupm9kLvcX1aDLTNoe+RTLUmW
    X0B/Z4jYWPFZHHwLsY9oCPjro3EYtFAHaC742Dz/D4H7THvozMt9twgnLsfyn+E7
    ULEAhbf2ulLiHFxSI8t1T26jGRReWAllH+aWNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520115984; bh=i4RusG
    9MVCNR46m6Gj3/AyUe1Xpx8BLdIHh4ezc76AI=; b=JVMw0kJrfOlTW04GukSnDa
    Uur/IX6zGTDh6z7+RsxaC+Jr7AUzn3sUbppphvCGmukClmTh2xll1BqUUxpWYhCO
    ia3vKJpYmwAr3IYcWJs7OBYfMHXV/6PXcgzNCWUtdtPGD796Y9f2hJu2ITzISytL
    7o2Fbu+38X1oWOGHnbA/U7JJogpb6U48MBU65Jn8tfVNVyv8HzxqGhbenIazE9sQ
    VQCJ74fqI2x9fD7sFx8jkDSGN0PX+KpCn7tkiGOrs1is5BkI6+8nr78MY9VxdYLg
    KjIa4z+F3EWTOBU2fXSZaKtQovQZTWDAWVPTy/1DSuRpSiLvGlHX6RDjR4zWrVwQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ea+bKY88 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ea+bKY88 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeCCWZc (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:25:32 -0500
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:39076
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932448AbeCCWZ2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:25:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 030/102] perf report: Fix -D output for user
 metadata events
Thread-Topic: [PATCH AUTOSEL for 4.15 030/102] perf report: Fix -D output for
 user metadata events
Thread-Index: AQHTsz5jsIAHAv6kX06xBIvU5c0c2Q==
Date: Sat, 3 Mar 2018 22:24:26 +0000
Message-ID: <20180303222318.26006-30-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:DJuT6uP9C7NUqPfqzGnmpL1ab31A6tY2tYVMI1Ycf4flTyi2fO9dupXMeFhfd4ZWqwDDAJhP2zf0S1TbQGj/hcmwx6czuBS1VT1VRpR9AtxqwKXigGh+ydjHGYCVuSQDhxFw2jsJYPMitR+sN7HCFZVvFv0Nb4gXO2EzhZLLXB5wOTdZKTm9UDjp7ObIFSvVMzvA7PGYRCl+kIY64/W+uhdvZ/yrDJINcCm4MYVARMgX9pqliEB6ZMpFLFRIoUGR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f263ff3c-547d-462b-6b7e-08d58155a7cd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3534DF7F9BFAFC1D3671237FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(84791874153150)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(966005)(8676002)(59450400001)(8936002)(7416002)(575784001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(6306002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(2501003)(107886003)(39060400002)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nzgEis81TlU6c0++YHE24h6rEVjBdQUyXd6aT67zKW5+/spMSAYNuO0fi9GzvPCZjSWsOVVfV8Qu//TUqRJvxiYYOUd5Jj7AzCs31K9Y/Tv+oslOECPj3qr1lSwmuyNhanRe8FO2p1ZHnsRaj5xgZjX4wu35wUliikpO0hcBcGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f263ff3c-547d-462b-6b7e-08d58155a7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:26.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit f250b09c779550e4a7a412dae6d3ad34d5201019 ]

The PERF_RECORD_USER_ events are synthesized by the tool to assist in
processing the PERF_RECORD_ ones generated by the kernel, the printing
of that information doesn't come with a perf_sample structure, so, when
dumping the event fields using 'perf report -D' there were columns that
end up not being printed.

To tidy up a bit this, fake a perf_sample structure with zeroes to have
the missing columns printed and avoid the occasional surprise with that.

Before:

0 0x45b8 [0x68]: PERF_RECORD_MMAP -1/0: [0xffffffffc12ec000(0x4000) @ 0]: x=
 /lib/modules/4.14.0+/kernel/fs/nls/nls_utf8.ko
0x4620 [0x28]: PERF_RECORD_THREAD_MAP nr: 1 thread: 27820
0x4648 [0x18]: PERF_RECORD_CPU_MAP: 0-3
0 0x4660 [0x28]: PERF_RECORD_COMM: perf:27820/27820
0x4a58 [0x8]: PERF_RECORD_FINISHED_ROUND
447723433020976 0x4688 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4001): 27820/27820:=
 0xffffffff8f1b6d7a period: 1 addr: 0

After:

  $ perf report -D | grep PERF_RECORD_ | head
  0 0xe8 [0x20]: PERF_RECORD_TIME_CONV: unhandled!
  0 0x108 [0x28]: PERF_RECORD_THREAD_MAP nr: 1 thread: 32555
  0 0x130 [0x18]: PERF_RECORD_CPU_MAP: 0-3
  0 0x148 [0x28]: PERF_RECORD_COMM: perf:32555/32555
  0 0x4e8 [0x8]: PERF_RECORD_FINISHED_ROUND
  448743409421205 0x170 [0x28]: PERF_RECORD_COMM exec: sleep:32555/32555
  448743409431883 0x198 [0x68]: PERF_RECORD_MMAP2 32555/32555: [0x55e11d75a=
000(0x208000) @ 0 fd:00 3147174 2566255743]: r-xp /usr/bin/sleep
  448743409443873 0x200 [0x70]: PERF_RECORD_MMAP2 32555/32555: [0x7f0ced316=
000(0x229000) @ 0 fd:00 3151761 2566238119]: r-xp /usr/lib64/ld-2.25.so
  448743409454790 0x270 [0x60]: PERF_RECORD_MMAP2 32555/32555: [0x7ffe84f6d=
000(0x2000) @ 0 00:00 0 0]: r-xp [vdso]
  448743409479500 0x2d0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4002): 32555/32555=
: 0xffffffff8f84c7e7 period: 1 addr: 0
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 9aefcab0de47 ("perf session: Consolidate the dump code")
Link: https://lkml.kernel.org/n/tip-todcu15x0cwgppkh1gi6uhru@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5c412310f266..1ea5b95ee93e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1350,10 +1350,11 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
 {
 	struct ordered_events *oe =3D &session->ordered_events;
 	struct perf_tool *tool =3D session->tool;
+	struct perf_sample sample =3D { .time =3D 0, };
 	int fd =3D perf_data__fd(session->data);
 	int err;
=20
-	dump_event(session->evlist, event, file_offset, NULL);
+	dump_event(session->evlist, event, file_offset, &sample);
=20
 	/* These events are processed right away */
 	switch (event->header.type) {
--=20
2.14.1
