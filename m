Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521476735-2-11660880925302281995
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
    t=1521476734; b=HBukoBC1E+jx/IiwD86T6c61A+5Tt6XKf7QwnQFCh9rD/lB
    LgcQYK1sNmS68Cp9x1y08UuLwMyItp/1xawWv+U13elWIxQokk5iYD6/uf0DVc9G
    9Hqk0sghmTK9aWVrX/aYPt2nBS3EDMlnzQ7ys1+G3JdB1VPuApJiFJKAZXtgah1F
    xUaWX/pK7VOdx0o0V/T0qRL86D/mH85qILFTK0CgdrzeSlYa/5nFJd5FmXK2LeAZ
    r6j4qG3Xs+ysXLyV1MqFmEMrPFMhxkjuYxpT3SGCagXN5hGLSekaaMRBXPISJBys
    MSZiAwCzUnaInggzIGjhE23SNkkcYfzsx7H6SGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476734; bh=ikWQsM
    7xRTuZh3+Ho5Qk55kPlh9PTVDZedH6vY4x+K8=; b=ib4vPyzrQm4AdkV2L3PEip
    cSMZlJduvHLjqr9TSG9gHX106i0y1PBKtMdupHzUOpW8boI9sQDbq+T4nR8KR60b
    CT6VFL2npIwi0WaGv+nUooTqlAFXeR/kqvW5WnpYqsym1TqYy4lTWU2QHdiq2Xwv
    WZt2lyZsRdQweH3Gmz2+d8BUymFls8gJvEPNNI7sdOG5JcAuJn3Inh4elVZMfLuA
    zd6a5W4pk5zUgFOOw6NlL3zJb6AP/P5DS8KFUESdRx6W/5euSkCwWgpJsP0cptLc
    p0b7FMTYFT4cnPUrGSW5RhUjxMpJB0Y9utoIzoTxbtgdRFIiaYvlDL+eezBv5sFg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FJqEv8Xe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeehjeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FJqEv8Xe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeehjeenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935360AbeCSQZB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:25:01 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:53605
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966903AbeCSQOG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 071/102] perf report: Ensure the perf DSO
 mapping matches what libdw sees
Thread-Topic: [PATCH AUTOSEL for 3.18 071/102] perf report: Ensure the perf
 DSO mapping matches what libdw sees
Thread-Index: AQHTv50lwgg6Pmi4lkaXSQsCWeVk3w==
Date: Mon, 19 Mar 2018 16:12:58 +0000
Message-ID: <20180319161117.17833-71-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:EWrwQOiC7Kuyupqb3m5m7X0YPLeo02x04nedYKeP+7tGDvD6ZoShLs7wbz/nvjmcgn9ig9KpOzXtqE/gnj79MaxzyfoEzHUEq7PQHzsfaM/jvgVN/fHyyKet4ms4zBixWUIPMH+RmXCAwdDtMCM0PDr5RcoN8MPyv3NRWIfsut2czev3RwiPlQXUY3fhIlKIlFWecTJTbDc11Kk2RpYCpUkBbUSV1Ctpi7IiF7pQ3Tr9iED8fsUDuQ0MS/h6Uj4N;20:yMPrhMHCm6CtMM5PkK2UoIB2CZPxG9WD+BlPSpBFI1TbAr59e0oXFafet1Bdg8VPG6UxBmBOk5ub4eAxQFQPuWPKvwGfrhKMuvfgQvJQV7GhSsD5BBGjtyfCk/kuwV80pJD6axP6fxidQc2Bh4dW4M3JliePDFRbyM9dbi+j7KM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 624faee3-a840-4010-0527-08d58db46c72
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063EA38E4F850B9776B7E71FBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(5213294742642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6306002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(575784001)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(966005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kAdZ8dtkDGFnN1DjeySFq9s9kZ+znICtpb0B/7ClH5dpez6DSVbBNpizooPMwg0aDuMGLbWTcsPxu1Zv1XcUMrOpCqyydQzL9at3I4BYoQGYd1+KUFNz69SVQI/D6JYkLH1xUAZOpsHfus3MsRI+JMwd8bDizYltHmrcl8CZ/iiUUzaCouRz7a608xe25pC4dzequpV0xGsfgKz11MrDw5ZF8F4FoFsLcCUafVfylk0o4ruWSdufKZdnqUhNxrqGc2aJKbUWfjrVrEotKhFlOTHWxZlPL4LL8q/6pJDJAngHoOZ7iGFDEtxQSNCTqkBDqZBc8Iefj8n6/6zXlHahcA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624faee3-a840-4010-0527-08d58db46c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:58.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 7419768c38b1..dbd9954eda4a 100644
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
