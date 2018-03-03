Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119170-2-10892347845180584351
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
    t=1520119170; b=ebUjx9e3VB8PyV8sL33vBL3k4G91uZoPMGkbNsTe9vz8hjU
    fDO7DK1yU3/hXhRQ5+OaKRnaDLsLiyHjvrQ/U0fzpabduRulIf1Vh1nd/J/0Yhws
    8DbveXTYr32lwRUeG+cui6QaOWk1+Lk7u1q0UOmVnoaVgU9yx1KeQp5F8bg9Kcyg
    GvjvN70jL5wTBzBAusPBOR9Vqg4gxISnoU5nCtG0y9zxYs3IJ9SAp+bCIZlQZfxG
    zmjJaxevH+2u4EZFFN0WnN6xSYfXTzf3+glNK0Rd78HnmH29KsmRzdCgGJp5QQsW
    5K7rEoQaGjIaoP37839tHOS+V7YNL+uTFkepj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119170; bh=5luEzr
    u+QigGEqFOSoY5tUMJWZvVyZ3sLFPg+Jf14bk=; b=PnVw9wbEJhK974ohiq2AQM
    o4JRVFxbw4RuaXJrz1+6y01lK2k7FUeft83xXoEVxU0H0rKt6Zd4atL6nkHr3MFN
    16dOBGe+x+n+pEKPkxq/lATbkKg8q3V9JIOD/iDs7lqP1GdpruOyUQln9ga4zjou
    qdD6MKWpfVzhshrsl8YNEc7n4RR+e5SZKDwIPSjBHw2Td7wjEMPbTTDvMWNQLsfP
    Cn1jcyAaaO8s6CcTe+LQwbsHwlcytXt3HVyygx4LbuGJKOCGMJQYNnvHI9RyLFnk
    nzIrTvFHTf9udLcbOJu8cu9bcj3WAKmFHqI7YfS5qGWChxzNCQhRNt2RkBr48WSQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MguDMDrZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MguDMDrZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeCCXTN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:19:13 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:16253
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934831AbeCCWiF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 014/115] perf tools: Make
 perf_event__synthesize_mmap_events() scale
Thread-Topic: [PATCH AUTOSEL for 4.4 014/115] perf tools: Make
 perf_event__synthesize_mmap_events() scale
Thread-Index: AQHTsz9LqmZnU2F3hk2pE4kxs0AJng==
Date: Sat, 3 Mar 2018 22:30:55 +0000
Message-ID: <20180303223010.27106-14-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:ZOUapP6a0/o57jByYvvHjsAj2+69MmvjqTF5adpLz2x9zVVyJ55DKdIxGi1eUaVEAKBQGl//JT0hYPFlEaFHg8f6yYWW5ib7jTF5Qew8g5fvLgKNNNEZZirzsJRvkJ7V6S6aBeGdVVaBIg8pOxwHwd4WVxO+jUwREpK4lVfZTvLMLkFvYDVAqPbhK7PzvubTlw9o5VhTN8DYY345+9SyVmGbyB1Vg3WwaOmnDMPjm9Nk+OSAE3rFT3cNAtqS5fSg
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bf3e103-9cc3-4996-4cfa-08d581576b06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093836B908FAB963E1AA8D30FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(966005)(6436002)(6512007)(14454004)(6306002)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(101420200001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: D/ckU/8XX0dEYQ649RyE2XB96ZQrFF5Ok/1qp579nPELhvqu/RzOoqm1Ywe/vZj68XEmZR4Qzdq4LFVuM20E9nTuVIMUTORsP/HwnBACbaMqTduWE1+1pVANp619d4pXlEXNoqs6Iy++otynxHioR0vRWsO6YAn8//YTZWsHKrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf3e103-9cc3-4996-4cfa-08d581576b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:55.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephane Eranian <eranian@google.com>

[ Upstream commit 88b897a30c525c2eee6e7f16e1e8d0f18830845e ]

This patch significantly improves the execution time of
perf_event__synthesize_mmap_events() when running perf record on systems
where processes have lots of threads.

It just happens that cat /proc/pid/maps support uses a O(N^2) algorithm to
generate each map line in the maps file.  If you have 1000 threads, then yo=
u
have necessarily 1000 stacks.  For each vma, you need to check if it
corresponds to a thread's stack.  With a large number of threads, this can =
take
a very long time. I have seen latencies >> 10mn.

As of today, perf does not use the fact that a mapping is a stack, therefor=
e we
can work around the issue by using /proc/pid/tasks/pid/maps.  This entry do=
es
not try to map a vma to stack and is thus much faster with no loss of
functonality.

The proc-map-timeout logic is kept in case users still want some upper limi=
t.

In V2, we fix the file path from /proc/pid/tasks/pid/maps to actual
/proc/pid/task/pid/maps, tasks -> task.  Thanks Arnaldo for catching this.

Committer note:

This problem seems to have been elliminated in the kernel since commit :
b18cb64ead40 ("fs/proc: Stop trying to report thread stacks").

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170315135059.GC2177@redhat.com
Link: http://lkml.kernel.org/r/1489598233-25586-1-git-send-email-eranian@go=
ogle.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 26cba64345e3..46af9dde11e2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -234,8 +234,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool=
 *tool,
 	if (machine__is_default_guest(machine))
 		return 0;
=20
-	snprintf(filename, sizeof(filename), "%s/proc/%d/maps",
-		 machine->root_dir, pid);
+	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
+		 machine->root_dir, pid, pid);
=20
 	fp =3D fopen(filename, "r");
 	if (fp =3D=3D NULL) {
--=20
2.14.1
