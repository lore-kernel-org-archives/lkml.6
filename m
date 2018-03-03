Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117722-2-10157294741508551984
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
    t=1520117721; b=piHtpMd7vC1m/7DpkFcmklqtkksRvGQ57GpHJIHRcbPzwrN
    sVaKsEGscSrV2QTh9e8eTQfohReNU/etX23dXthgkm6zjKa1Oy9ejbi32+Ih1UDy
    EPrPBq8JMZgBPVtKw1AQ/M5VjMwirVynxbKJDqoxJ/Uplus9CbZ49rR5YbncVT2X
    FgOObdp2KQyi25HEKid5mgwuUzTNDXA+G2q+ITlYt6qAsTbeFQJqn+IISb6qX9dX
    Mjpy0gjybGs7mdYcPV+C69chPnvybGy3mKI2L74ZzL4xttan039PRO3zDHMlB9bN
    n4TL3A9oWDQEwqqOMqXwwe7pgMU58rdVLk3jbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117721; bh=ufzXbv
    FGAq0Sj0rJDYcLyvw/TH4Zq6wSx99csCR5HtQ=; b=jtubKId1W9IsudV5dhoXaZ
    zVNP6CdVJm/dCZxFRcMgpoGpICCE/Xt7DjbXa2w5kQpw8ehJ89kbkKXlFjZ/Utv1
    fVFGH2UtFxCF5BMUq3zu1EoEsHbNp7yix1/O3KIlGXDQ1yNlXwJ+D+sNF47H9eD+
    WENRthEUoBIVs9XDddPNPRtD6/2uTxXw7ioB9MTO01Yn/UOg0qt4zqTLhJ2DK0CU
    2Qtm07PIwyF1Rn/UuPuwJ9yf3psSLQNY7mSv6j+FLTrL4AqNuHWfsEU9Z+ZBhe3k
    DKz4OnOxXAvA/kpK3DaesLoLwdJaFSk3V6SOQk+9s8VaEaTB1MMdYkiQdFnAvJJQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VeJGmaPO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VeJGmaPO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935123AbeCCWzS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:55:18 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935369AbeCCWlB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 07/63] perf tools: Make
 perf_event__synthesize_mmap_events() scale
Thread-Topic: [PATCH AUTOSEL for 3.18 07/63] perf tools: Make
 perf_event__synthesize_mmap_events() scale
Thread-Index: AQHTsz+d9sXlFwJkgECAJDe7OVrSnA==
Date: Sat, 3 Mar 2018 22:33:12 +0000
Message-ID: <20180303223228.27323-7-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:pqqAlDvM06WiuPmLLyNDTyC+bWjUBMq7RTZemFVjNIaigc9a+1yC18+zX2PTrPYugIwKwn8mAa0jNgA4TwIRiwI7aCESWBLZdVQa/JX8YXgXqbJvJX0jUtQ9yREHsw5iUWBgeNcbPpAVIAINO5i+w1uwIY/5zb/A4ZgT+0UpxthFePFqRjLqyEXtcRrJf/WhaO3CXsQyulTjSoKN0dQxokLjRctakIC3bAoc1aFNxuJv3dK7VwXQgo97AF51E3pS
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 275d7690-3e34-4863-309a-08d58157d4af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344AE0546D296676E0EFC51FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(575784001)(7736002)(36756003)(25786009)(3846002)(6116002)(966005)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6306002)(6666003)(66066001)(22906009)(101420200001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ALXg62kJh/OJewc76F79nq3G8A2IPK2kEGTvQMO9G1vCKZp9qeFnNXyKQRBeDP8/rbE6eo0t1ndKi7g20k8HV4AYlzAqrf4UmvvTGRmsPcOcjUhvc6JxK/Q+oLs8H0IJz9xs2QO9pX8ian0TacNqBAKG3VWuDr/bb5ylblxonog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d7690-3e34-4863-309a-08d58157d4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:12.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index da4c17cccb71..b9743621b2d0 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -167,8 +167,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool=
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
