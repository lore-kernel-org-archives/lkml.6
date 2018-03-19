Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479377-2-11217655783508148385
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
    t=1521479376; b=lTOQqHi01OupYb/X9jJBDpMmmdQN787haDYlJBhs2ZW1Rrn
    zo9vnormGejX8pp+GnPrg494ytkEa9O+1RbDtALtgi6Y80FNHPIX8qqXejpqL9R5
    wk5+suCdGuIR/V5pkM4p+GI52s3VzytdtKeA7k5jSrnJT/wPdL0ob7FtbMFwT+9t
    bc55Q6bRSW0j20NhiSjnGmxJGQ429VzdB8Uo2oyUDAF6YL/6TorWB/j3kxwecvCx
    fq1h5lnrOJgFSPKrmsPbEOxBOkYmjUomDNnyk0M1hlyvCOLzJgau+i4mI/JtZuCT
    CrMLkq0ukjqCKnBi0/g1jEagQrLIPpyE9AUf8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479376; bh=SkF8Fp
    wpUszDsjsZ8gLRx4sK0jF2l/bLhq3firkcNjw=; b=QZi5DOxduZAHR8RoZfZ19h
    CWNh/rySBfbaRRIU+6hrjtqkI+mDpRJJo5RDP5dnKjpsEWK6Hp9tlWvS5xn9Nypu
    a60KuiXkFqCCUhS6v8IEiR0seuEeXoiZXnljvzbs9RqE/FoyHsHqx6CwnhCpugYn
    2vVu4Rw3oe1xVxxyDKi7cgAFRb2j4uiVd2nwguYGob226fwu5sprl5Go4bOisRuW
    SWksX1RtEQEhsVmMRwH8qEWHY0vksBVMArB7UpfWpKZ90JTQJL6AUQLrtI6ouN8c
    nztDIIzoMezvnMNEBtZnPEp2hUsHvoUgag2pA5VMa3MpjA8U1nNpqyE9b4HfKewQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P+yWBXAq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeeivdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=P+yWBXAq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeeivdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934217AbeCSRJf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:09:35 -0400
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:31330
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966641AbeCSQKn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 126/167] perf report: Ensure the perf DSO
 mapping matches what libdw sees
Thread-Topic: [PATCH AUTOSEL for 4.4 126/167] perf report: Ensure the perf DSO
 mapping matches what libdw sees
Thread-Index: AQHTv5x0ToH1GR1VAUu52Wqv6mqLhA==
Date: Mon, 19 Mar 2018 16:08:00 +0000
Message-ID: <20180319160513.16384-126-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:OYPCezflMRopQ1Ti5LLs4N5og6G5+ql/ZyC+auFGxqil7/Z7AP+L6mY5ZUSNZKD78Rwp5v7YR5+rp6qMjr/U0gm29UJ+KEvcml2yGsKNy1U9xArA8b1tXJPxGmTlXycTTFc1wF/iWJCzYl0b9xNEnaTiyaibQtJcNtc+DpijInjzUyKxX8ZbxLI9G9EazL+RSNpbe9qvnirV9fX6C3qL0MglQeEvUvZu74b5jERbYH4bLckPR2ZODnexWp2x1QL7;20:+H2/RA6fNlienSIEKFBwv2jvNizBQO76EYLbWGRsg+SSS5QMkHNHj+WxDXOizqBu9zPNbjc2VzQdYhtCmqKOwfNmQ88YxrmlUZQZKQCfZ929d5u1q89QRksVEWUgIPYoux9O4mAbIk02DBe4uXDtyddG33kv4aTQ7JC4JkfbQ/8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d944b815-d26f-48ab-3c77-08d58db3f354
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045754EEA8469A112BB11A0FBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(5213294742642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(575784001)(102836004)(8936002)(6512007)(7736002)(3280700002)(6306002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(966005)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cYjqWLhot6uip5dAe8XVdEgjDsA639GhQ4ef1tzN35j/daOVkyrXbZqZFLNySBxo1uT/7wEVHmbRcEuMXfZZ657NKizIwIFGdAQnSR6MxUhGK8nP1TcrV2f2ivepBYL4XAeEPjbn7Vmli/Vqf4VG09rjZwCssaPr+ZanG9ay/qlemXBcdtPhAOqzaj2a0yG28Zndo0pcb8SCA1pFvpjS2wnUHZilTXpfIeLZACUQfQvM8E0VoNzLTTcInpFqkqB/4PNZbQQj7shPY+hqq4CimVHbprflBSt0S6JMPQl3W9be2XJoLpGNdiFlsRtXfUkU2GgcFzeCWaP/3ZyckUxOhQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d944b815-d26f-48ab-3c77-08d58db3f354
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:00.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Milian Wolff <milian.wolff@kdab.com>

[ Upstream commit 2538b9e2450ae255337c04356e9e0f8cb9ec48d9 ]

In some situations the libdw unwinder stopped working properly.  I.e.
with libunwind we see:

~~~~~
heaptrack_gui  2228 135073.400112:     641314 cycles:
	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/proj=
ects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
	           608f3 _GLOBAL__sub_I_kdynamicjobtracker.cpp (/home/milian/proje=
cts/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
	            f199 call_init.part.0 (/usr/lib/ld-2.25.so)
	            f2a5 _dl_init (/usr/lib/ld-2.25.so)
	             db9 _dl_start_user (/usr/lib/ld-2.25.so)
~~~~~

But with libdw and without this patch this sample is not properly
unwound:

~~~~~
heaptrack_gui  2228 135073.400112:     641314 cycles:
	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/proj=
ects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
~~~~~

Debug output showed me that libdw found a module for the last frame
address, but it thinks it belongs to /usr/lib/ld-2.25.so. This patch
double-checks what libdw sees and what perf knows. If the mappings
mismatch, we now report the elf known to perf. This fixes the situation
above, and the libdw unwinder produces the same stack as libunwind.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20170602143753.16907-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/unwind-libdw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.=
c
index 2dcfe9a7c8d0..60edec383281 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -37,6 +37,14 @@ static int __report_module(struct addr_location *al, u64=
 ip,
 		return 0;
=20
 	mod =3D dwfl_addrmodule(ui->dwfl, ip);
+	if (mod) {
+		Dwarf_Addr s;
+
+		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
+		if (s !=3D al->map->start)
+			mod =3D 0;
+	}
+
 	if (!mod)
 		mod =3D dwfl_report_elf(ui->dwfl, dso->short_name,
 				      dso->long_name, -1, al->map->start,
--=20
2.14.1
