Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246886-2-6752337418267896613
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
    1523246885; b=OmH5yRLveQubrVzzovlyrQrpqjCkcNOfI2TejfsCjEUgl40IBe
    3SlwssrCoXhhTl/oIzzflloZtqLKEzsEoMuOL1lovoGMBuFLRXpr3pjGhKmLCuBP
    GkRuQyBcAGJgi3SFunR1w95A4AtSCeU2rZ6cFu0agLKCCs4DFq390I4OS+URCW1E
    Zf9q87q4S7dJEaza9TznNpcFUmAJ0/eE9/P6/GAudYMHGNWDfNkur55o2t7m2wAa
    jojaC1yXLa5DqqbByEvSalBwXqUpd6tT+8qMoc+efy4uAlN9JcGa7fPD6YvVJyET
    ST91PEDxRNMbYTzCztBw0Z+98pLDninleuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246885; bh=5s21/pY34+
    iVyFaSQxhOWYVZ6j44ARxHpf71trwK5PE=; b=fnQFAJGuB5zW7hHPA/LGHgTml6
    EPPxIODeQdgfas4VqUmEb7XStnncIJkK1odoAj018pa+KrNbFZYBjd8p1mn2qsbb
    BMYBhqPpKl4Wh/jBkdlo8+B3NteOB10C6SP9kln85DTJAIrptl2WV3pMfWozcTuN
    IwAjrHHfHw0pnWNh29929vU9S5/5DDPwIJ03LP83Z7+GaNuNItAHPGytANu/+oPJ
    bsbaAFIyFZUTxkYuDGuZm+G/AMMQFVBIcLYMfjUB/b5q7h5mWYBCSffcRe8gxedj
    TKa4U1sGDUJGML+8/4eoyeYzYhnjgdWDZZmYOXAPddqVt5kPXjFyCBdHVUaA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G81suQ6K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G81suQ6K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIt2L5TtaNLhQggr8bZxJCZU6/py5kpQ28WnAAZvtDQOE8Uw1HqRkI1KWYOGjqDmTn1BCsAfsu+xz/cQocj+511DdxCIixZy274u5fuhY8zPrZy8GiF6
    LvL5EC7sLDDlyFDGgFYdFl1eaW18ZSlsnEDqfI0OO4r8+GbS3iTx8iQOKPJgvT/7WOYjKgwkGawKaAgag0D0MWz0JDmBy9f/D0kWOfu0oxzyP/FzlHAxB9uv
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8
    a=zYEbUM22sCDeiSH6AisA:9 a=ksnP1fiyDI0qeK2J:21 a=2zvRHfKVTcBhZT32:21
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeDIART (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:19 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753096AbeDIARO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Hendrick Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 028/189] perf unwind: Do not look just at the
 global callchain_param.record_mode
Thread-Topic: [PATCH AUTOSEL for 4.15 028/189] perf unwind: Do not look just
 at the global callchain_param.record_mode
Thread-Index: AQHTz5gYWn+VIaTY90aEkU/48zUiww==
Date: Mon, 9 Apr 2018 00:17:08 +0000
Message-ID: <20180409001637.162453-28-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:R9wVOob46ulY3Y5w9ovk41mddfVqjD/lfZnzVcImzFrjz/sDYkUxMDGKdtiw3FK+tjhtbEsfUE4Yu41wex23XtYpyB6rEosbw0Kv2MlOxNzRWChijalrxtIta+eojT323zp4ASEk8wZf3H1s7DYNLE7JTqkDWhgNec7yRhMmFma4kg/CoYIHlVp+ge9ScyQfJvIwKpREEkc5vr5RVXk3EGv9gCjQoTSHEwoxGeuJzRs8lY1CISqGARLK9QlyoAWl;20:aBvra/T9UfiwfUtc5Q01bx+Nm3Iqf+qaG3Zx2MUikPKDkUygXQABH9BWxr+REps2h89xyndoIzXM4B3xJ2Hfb+Pv4keWLBXZq2xYYowNP2iPUAjxefVBPADDPMgb8FmkvxbReH6QOgWaV45gYgWL426KSu31VXRXUJkUTp0r3VM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dda97817-f392-46db-0eaf-08d59daf3b72
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11278AB89EF027472C0D6178FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(39060400002)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: INsrEeIL7EG+5MfoWWJkpi6bnVBEOeN1Op/5B5c22VW9NingmgzuyUtodkb+qY4WgI618dCWmVtmeQVgiLxVetkaHplRsT6l0XPgugwJ+VLHYIzYlXnONQNO91jNO44iepakb1WrSuESwK0GTwiExOKJZrc0HzuVZNQi5RiZcw8dHXe6BGijJmzyCZQPxyydzuubUPXu2RNM1yVnhAcPXRRmwahGIBHEqBnd8lxWegfwOawcwFZ/aMpEytgTaztLUXFDl/NHM+wrNYrp/0w3sNdKHcOQDXg/WcYo+oxL/8ZUbtfqYKHAf1ktE9S3Pg49J4T52G/uiDboNcP1JX31i6A8NUZfgXdv0u0ppZAke1lZEwA47hLZRxGQpjPXyi/F9EiHJJJ7SnF77OGxb+pwZmuBIBXG91AQhJDU9s3rge8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda97817-f392-46db-0eaf-08d59daf3b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:08.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit eabad8c6856f185f876b54c426c2cc69fe0f0a7d ]

When setting up DWARF callchains on specific events, without using
'record' or 'trace' --call-graph, but instead doing it like:

	perf trace -e cycles/call-graph=3Ddwarf/

The unwind__prepare_access() call in thread__insert_map() when we
process PERF_RECORD_MMAP(2) metadata events were not being performed,
precluding us from using per-event DWARF callchains, handling them just
when we asked for all events to be DWARF, using "--call-graph dwarf".

We do it in the PERF_RECORD_MMAP because we have to look at one of the
executable maps to figure out the executable type (64-bit, 32-bit) of
the DSO laid out in that mmap. Also to look at the architecture where
the perf.data file was recorded.

All this probably should be deferred to when we process a sample for
some thread that has callchains, so that we do this processing only for
the threads with samples, not for all of them.

For now, fix using DWARF on specific events.

Before:

  # perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=3Ddwarf/ pi=
ng -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.048 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev =3D 0.048/0.048/0.048/0.000 ms
     0.000 probe_libc:inet_pton:(7fe9597bb350))
  Problem processing probe_libc:inet_pton callchain, skipping...
  #

After:

  # perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=3Ddwarf/ pi=
ng -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.060 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev =3D 0.060/0.060/0.060/0.000 ms
       0.000 probe_libc:inet_pton:(7fd4aa930350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/=
libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffaa804e51af3f] (/usr/bin/pin=
g)
                                         __libc_start_main (/usr/lib64/libc=
-2.26.so)
                                         [0xffffaa804e51b379] (/usr/bin/pin=
g)
  #
  # perf trace --call-graph=3Ddwarf --no-syscalls -e probe_libc:inet_pton/c=
all-graph=3Ddwarf/ ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.057 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev =3D 0.057/0.057/0.057/0.000 ms
       0.000 probe_libc:inet_pton:(7f9363b9e350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/=
libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffa9e8a14e0f3f] (/usr/bin/pin=
g)
                                         __libc_start_main (/usr/lib64/libc=
-2.26.so)
                                         [0xffffa9e8a14e1379] (/usr/bin/pin=
g)
  #
  # perf trace --call-graph=3Dfp --no-syscalls -e probe_libc:inet_pton/call=
-graph=3Ddwarf/ ping -6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.077 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev =3D 0.077/0.077/0.077/0.000 ms
       0.000 probe_libc:inet_pton:(7f4947e1c350))
                                         __inet_pton (inlined)
                                         gaih_inet.constprop.7 (/usr/lib64/=
libc-2.26.so)
                                         __GI_getaddrinfo (inlined)
                                         [0xffffaa716d88ef3f] (/usr/bin/pin=
g)
                                         __libc_start_main (/usr/lib64/libc=
-2.26.so)
                                         [0xffffaa716d88f379] (/usr/bin/pin=
g)
  #
  # perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=3Dfp/ ping =
-6 -c 1 ::1
  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=3D1 ttl=3D64 time=3D0.078 ms

  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev =3D 0.078/0.078/0.078/0.000 ms
       0.000 probe_libc:inet_pton:(7fa157696350))
                                         __GI___inet_pton (/usr/lib64/libc-=
2.26.so)
                                         getaddrinfo (/usr/lib64/libc-2.26.=
so)
                                         [0xffffa9ba39c74f40] (/usr/bin/pin=
g)
  #

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrick Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/r/20180116182650.GE16107@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-c2c.c                 |  5 +++--
 tools/perf/builtin-report.c              |  5 +++--
 tools/perf/builtin-script.c              |  5 +++--
 tools/perf/tests/dwarf-unwind.c          |  1 +
 tools/perf/util/callchain.c              | 10 ++++++++++
 tools/perf/util/callchain.h              |  2 ++
 tools/perf/util/unwind-libunwind-local.c |  9 +++------
 7 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 17855c4626a0..c8a5faaca47f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2393,9 +2393,10 @@ static int setup_callchain(struct perf_evlist *evlis=
t)
 	enum perf_call_graph_mode mode =3D CALLCHAIN_NONE;
=20
 	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-	    (sample_type & PERF_SAMPLE_STACK_USER))
+	    (sample_type & PERF_SAMPLE_STACK_USER)) {
 		mode =3D CALLCHAIN_DWARF;
-	else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+		dwarf_callchain_users =3D true;
+	} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
 		mode =3D CALLCHAIN_LBR;
 	else if (sample_type & PERF_SAMPLE_CALLCHAIN)
 		mode =3D CALLCHAIN_FP;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index af5dd038195e..ca2ed616236e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -312,9 +312,10 @@ static int report__setup_sample_type(struct report *re=
p)
=20
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		    (sample_type & PERF_SAMPLE_STACK_USER))
+		    (sample_type & PERF_SAMPLE_STACK_USER)) {
 			callchain_param.record_mode =3D CALLCHAIN_DWARF;
-		else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+			dwarf_callchain_users =3D true;
+		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
 			callchain_param.record_mode =3D CALLCHAIN_LBR;
 		else
 			callchain_param.record_mode =3D CALLCHAIN_FP;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9b43bda45a41..fc3974b1d8fd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2758,9 +2758,10 @@ static void script__setup_sample_type(struct perf_sc=
ript *script)
=20
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		    (sample_type & PERF_SAMPLE_STACK_USER))
+		    (sample_type & PERF_SAMPLE_STACK_USER)) {
 			callchain_param.record_mode =3D CALLCHAIN_DWARF;
-		else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+			dwarf_callchain_users =3D true;
+		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
 			callchain_param.record_mode =3D CALLCHAIN_LBR;
 		else
 			callchain_param.record_mode =3D CALLCHAIN_FP;
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwin=
d.c
index ac40e05bcab4..260418969120 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -173,6 +173,7 @@ int test__dwarf_unwind(struct test *test __maybe_unused=
, int subtest __maybe_unu
 	}
=20
 	callchain_param.record_mode =3D CALLCHAIN_DWARF;
+	dwarf_callchain_users =3D true;
=20
 	if (init_live_machine(machine)) {
 		pr_err("Could not init machine\n");
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 082505d08d72..32ef7bdca1cf 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -37,6 +37,15 @@ struct callchain_param callchain_param =3D {
 	CALLCHAIN_PARAM_DEFAULT
 };
=20
+/*
+ * Are there any events usind DWARF callchains?
+ *
+ * I.e.
+ *
+ * -e cycles/call-graph=3Ddwarf/
+ */
+bool dwarf_callchain_users;
+
 struct callchain_param callchain_param_default =3D {
 	CALLCHAIN_PARAM_DEFAULT
 };
@@ -265,6 +274,7 @@ int parse_callchain_record(const char *arg, struct call=
chain_param *param)
 			ret =3D 0;
 			param->record_mode =3D CALLCHAIN_DWARF;
 			param->dump_size =3D default_stack_dump_size;
+			dwarf_callchain_users =3D true;
=20
 			tok =3D strtok_r(NULL, ",", &saveptr);
 			if (tok) {
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b79ef2478a57..154560b1eb65 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -89,6 +89,8 @@ enum chain_value {
 	CCVAL_COUNT,
 };
=20
+extern bool dwarf_callchain_users;
+
 struct callchain_param {
 	bool			enabled;
 	enum perf_call_graph_mode record_mode;
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unw=
ind-libunwind-local.c
index 7a42f703e858..af873044d33a 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -631,9 +631,8 @@ static unw_accessors_t accessors =3D {
=20
 static int _unwind__prepare_access(struct thread *thread)
 {
-	if (callchain_param.record_mode !=3D CALLCHAIN_DWARF)
+	if (!dwarf_callchain_users)
 		return 0;
-
 	thread->addr_space =3D unw_create_addr_space(&accessors, 0);
 	if (!thread->addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
@@ -646,17 +645,15 @@ static int _unwind__prepare_access(struct thread *thr=
ead)
=20
 static void _unwind__flush_access(struct thread *thread)
 {
-	if (callchain_param.record_mode !=3D CALLCHAIN_DWARF)
+	if (!dwarf_callchain_users)
 		return;
-
 	unw_flush_cache(thread->addr_space, 0, 0);
 }
=20
 static void _unwind__finish_access(struct thread *thread)
 {
-	if (callchain_param.record_mode !=3D CALLCHAIN_DWARF)
+	if (!dwarf_callchain_users)
 		return;
-
 	unw_destroy_addr_space(thread->addr_space);
 }
=20
--=20
2.15.1
