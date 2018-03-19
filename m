Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477388-2-13452974563528332838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477387; b=MuprDj9gUqk7R7mfO1C0ZUV6aKm+YMQFUkY2V7DJ3+Cmx/D
    UvzxacETGlhu8Fk8Gzg/mC5DYOjVgx5ce3av3n9PQ5qMUNr00RnIb5ZioqRXhkHk
    lJwoTzjpivXDuQhDB2y9STsYBjjfAcpLqBpiFOthSTpIWa68weor7DeoFxygqqi+
    F3ldSh2qj7NYUkMdoEiggJumKIMjCXODsMGVKWbHocDGJh5F3wFTutKzkLECeanF
    siVnU14P+t7sEqE0EcNJAIaPRm+jmAkcl5F+CE4h2Humf5GjfccblSo6wP6XYLoV
    epjDX7GKnN02eOuhBwXuYtOgZh2Hll/1tZVfxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477387; bh=rcc7Vo
    tIHMn3d9GT5gQaEBkiqXCUOgmFlF4BDsVkb8A=; b=JE9LCYpomfEW9bt/jWbfrd
    uVBLn5tlMbpuprrL49YDfL3rU/gc7ZUM32l7A95WquKnHwr44fUEZ+Vk16zqPTP7
    5NfrDgEd/BstNzr/gJDMOqQ4NPBgVVoFk+dKDLmnHt9nNYdkPBct/hmPi98S2BA4
    gUKcp9lLpfJ64zKfSs0cL5hW+vXpTKWuzB9eYnHRGfzDWR8xGzSHuMcVmUbd6S4j
    dtyMcye6ie9RRi/s3B8hjAIB1OJdIxm+zACb7Wh/OoFk7XDRmddIGhR7yy1ZsFzj
    FAfumP7kSYRSmoYOss4p4DYjlp0R2jJx395tLj5tL7kDXsitsy4eJbu2gnpLPfbQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EwgVpHcY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvddutdenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EwgVpHcY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvddutdenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeCSQgI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:36:08 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:64207
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935287AbeCSQNY (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 063/102] perf trace: Add mmap alias for s390
Thread-Topic: [PATCH AUTOSEL for 3.18 063/102] perf trace: Add mmap alias for
 s390
Thread-Index: AQHTv50fTzBzLabFmkOC6e2bklK9Eg==
Date: Mon, 19 Mar 2018 16:12:48 +0000
Message-ID: <20180319161117.17833-63-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:QUw6Yt8/ERSCr8H/eVZqDIPh2MlISqzozB6VnonZGnGXcGMZL47ZxJ2tjYBnfb2lzLkU4lPUsiLX4+/cV0MSGU1/GK2A2L0I5SL8aTtQ4NGDTQoUuvNGHENxA5uVyRampFi0yH8V+e8bLXaAW6ay4Dg0dZczYOfsyznPYtGYKmx0vmiT17L+rgrKiGSE7mnowfmtpKfc4O2rLANAA9akGGassncnxtUkiuZpXKoNy9e6ke6l0jHww6A1i3TA3vSj;20:CJDVmEChbSfe5RrzU2+G2QwCMKUKKxmBqqPpkBSb2bKVXyWLi8R/hDvaeQKUkDVApGqFOWAmN+GMCxOyHN9z2rmxRAASgH2Ol4dBHpwutvWk1OjAWqeNS/RYpNl44rBXBp6OVY8NSJ7W+fJ9HT7SveX1cyAU/dwOqMhKGHxxTMI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4de01392-34aa-4ac2-c11b-08d58db453fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048175A7330CF2FF2D2361BFBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(10090500001)(107886003)(25786009)(106356001)(102836004)(26005)(6506007)(8936002)(2906002)(6666003)(186003)(86362001)(2950100002)(5250100002)(66066001)(3280700002)(5660300001)(4326008)(72206003)(68736007)(10290500003)(966005)(86612001)(2501003)(478600001)(81156014)(81166006)(8676002)(2900100001)(1076002)(39060400002)(105586002)(6436002)(54906003)(110136005)(53936002)(36756003)(6116002)(3846002)(305945005)(6306002)(316002)(6512007)(6486002)(14454004)(97736004)(3660700001)(7736002)(76176011)(22452003)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: v6NJB+k0jCsfTav+57ZRVfqUlHGN6KMkwwP8XqRcViExuCz8gck8PYgmqIgrkr7A4jSY1byWPJxzSbgtHdZaYXoNQfkmei89SRQ54RcL+EZwFok9zALolmzwIx3HMNQWtLlOoE7JjkYFydoBY/N537USXuu7hTOWWvMNi1eUDxs9uaLep3eRPb8YBiN7IUNq7i+aI3o/j7G4ERlkkLcaxz8tCAzKgkdIbU/NFZvC6jAr+z52gueikLppPVOyfNGk3iaDCsmcqYODHBNkDgzXj4lZ4pwKsevyCXmncG27l8PIy3fO9UH8rgkCTd+mzuT9yjtuDyNiDz09QszXajpekQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de01392-34aa-4ac2-c11b-08d58db453fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:48.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 54265664c15a68905d8d67d19205e9a767636434 ]

The s390 architecture maps sys_mmap (nr 90) into sys_old_mmap.  For this
reason perf trace can't find the proper syscall event to get args format
from and displays it wrongly as 'continued'.

To fix that fill the "alias" field with "old_mmap" for trace's mmap record
to get the correct translation.

Before:
     0.042 ( 0.011 ms): vest/43052 fstat(statbuf: 0x3ffff89fd90            =
    ) =3D 0
     0.042 ( 0.028 ms): vest/43052  ... [continued]: mmap()) =3D 0x3fffd6e2=
000
     0.072 ( 0.025 ms): vest/43052 read(buf: 0x3fffd6e2000, count: 4096    =
    ) =3D 6

After:
     0.045 ( 0.011 ms): fstat(statbuf: 0x3ffff8a0930                       =
    ) =3D 0
     0.057 ( 0.018 ms): mmap(arg: 0x3ffff8a0858                            =
    ) =3D 0x3fffd14a000
     0.076 ( 0.025 ms): read(buf: 0x3fffd14a000, count: 4096               =
    ) =3D 6

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170531113557.19175-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/builtin-trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fb126459b134..7e74d8aea99b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1020,6 +1020,10 @@ static struct syscall_fmt {
 	{ .name	    =3D "mlockall",   .errmsg =3D true,
 	  .arg_scnprintf =3D { [0] =3D SCA_HEX, /* addr */ }, },
 	{ .name	    =3D "mmap",	    .hexret =3D true,
+/* The standard mmap maps to old_mmap on s390x */
+#if defined(__s390x__)
+	.alias =3D "old_mmap",
+#endif
 	  .arg_scnprintf =3D { [0] =3D SCA_HEX,	  /* addr */
 			     [2] =3D SCA_MMAP_PROT, /* prot */
 			     [3] =3D SCA_MMAP_FLAGS, /* flags */
--=20
2.14.1
