Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116346-2-11016402892343932725
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
    t=1520116345; b=sqpIexHGo77gdegWe0a66iu/jFxPQl7zF/WiQFvF1e9zR9u
    73oAnNADp4BkrN9LXyTAvxEY+RjDnk05Kl3LLsQWjsy0uq15p4+mXWmph0sgGKjG
    Um535eojXMmJOWG7tVOleVWcNBGjMZx4CqatEim5H74dD/fHayOv/jUp1X4Gj+hr
    V7/u7zRNa2u3Hw5slO0NpLRrdXfytmbU2ZY1FScjUvzTtmOVVnNHm+Rw3fJtqSze
    UzAs93+PKTDgj7k76ApgEjgUt8OnM2nOb0Rm568neOnRBGub32I9g1uGAzzQFuNA
    vg9T/1t8xnzHT7XNo6pfAXqkcSR0mbqSYY+6lmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116345; bh=0ayMVN
    5vEujOU70VzWG/jBSft45jaYO8hQFrG+6LmNw=; b=jxleMjaxAKXR064KrhwyOM
    9DJPSXMEhve2FXnLR7S6OlEB9Za5vC+Eg/qKoQigM328f4cLS1cKcmTV4cF6uELA
    bNnnh5AU1Wb6gZaH6nT/7WqiV8EgCnh9+OuVLFF9/HQJfZKnT1WmMTfvVdWg6r06
    a0RUEamKOaA6e4FOF43tcuCkVDseLKSoHIlLEvW/rFw7JFPe/GP86GT1nF5uNeI9
    5D+gEMW2WWfamtp7kSEXfuj1jJ4QfMEK8i1rw+tCqfnAAR2aIphxv+f4zjvro7/W
    9V/XvNGdao9eanoT+ylXsqAQhmEr3PnxPqaJKiOdMdkvh9LXtwIDrGvBhHeFeRNw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QQzxrLTk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QQzxrLTk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbeCCWbf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:35 -0500
Received: from mail-sn1nam01on0104.outbound.protection.outlook.com ([104.47.32.104]:49722
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933694AbeCCWb2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 028/219] perf tools: Make
 perf_event__synthesize_mmap_events() scale
Thread-Topic: [PATCH AUTOSEL for 4.9 028/219] perf tools: Make
 perf_event__synthesize_mmap_events() scale
Thread-Index: AQHTsz7qFH7IlbHWoE2wAhj8JY6qlg==
Date: Sat, 3 Mar 2018 22:28:12 +0000
Message-ID: <20180303222716.26640-28-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:4p9PqEFWSxISgz8I8uY/IXE20Jlow72/peT15zHiC12IzTRQFsV8eJJnZ34PJkDOAcbAp/4p5e3ALKTgKRbjjREMo1ddgHho/vrpCQjeiNPUOQ71wJng7nmcbrli9JoTybqKQ0hKR/8UYCVAU0mTrrpv8uMDb9ZTh+9V9f9MTJrGJezkZQ/x9bDuZvS97/NhuovGeHcKKP8u4H0p9TuXMCAU2lMsl8zd+OwDtVsXU7vypF/bgvHgTh8V/wDe8CHs
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: feaceb55-7cdd-462e-51b1-08d581567dec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970E60C4DDE3BFEC6C81F2FFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(101420200001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: DRdYne2D2IQT+KOZQMXv1g8o5Aepb4so2yT2cJO5azF0Eb1RvbgOCXMhHSV9SDPNLrehSB1WkhM6GlAu2cp4ovZq6ueSPfdrGDyVKvoQrhNRm7TS1LroHcxH7QHiCQR/Tp/iAuBPweOJAiCgQt3A+2uTPHi3kVipm2bXqOaryoY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feaceb55-7cdd-462e-51b1-08d581567dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:12.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 8ab0d7da956b..663192395780 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -255,8 +255,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool=
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
