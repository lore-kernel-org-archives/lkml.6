Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475461-2-653479616850284018
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
    t=1521475459; b=TCGxU67x0ySwFXAu88dLgNVb0IC73qc3/nuNxU3MyfsKxH4
    Ev6Jrd7YwMY76TK0zU7DWjC1xmvjJEbcPo86y9oP0282Ik27p0rD704I6uHE0BkK
    b7tcReuPxZW3RFEBlKPu7Ysl7jjINh9oeTVbWSZ1UGQvoQZLaBSdrhg56vM8B3V/
    NwnRZreqiWnVrK3H7Z7Rt6nUq8pKDiUmp0vNiodr9xbFOUiO0U6K7VLIn/gihyqh
    WB/+H9W7vBwYdQKnpEa3+xG0WiBtzswMv/cvB8Bd1Wkx9uKtNhLaUpF+7dviBi3U
    j0BzxKutYNqzitytE9U8++kuaPDY2CAI4PMQQ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475459; bh=h6q1S4
    ro2MCIDB498HgeTCcxcMJ0dBgv5NyyY89JXe8=; b=QUnVZzggTthv4ucUVdKz5j
    idfqXvbWyDvrvX5Rc9+24G0xc052uHMEjFH7CJJ5EcdFkB7R6/aGvect5TgH+Gwj
    Lode8Xvh+dATdAwYNumEgTblUIxep9+wjUT4uhZyW6D6iS2q/JUyCg/+tQF1qPHj
    i4EyZghh5fVCjOhqsi2gIDfeiwg6vCmopoJYWgHqO0Nk8z957cjhb0gb1A2L3Q/G
    mjqvOOpM5vMGZa7X1wk4Pc8Wl5+HOrUoFt5VncdIEoOXd3cjvjTw8xzpIWGaPFic
    H7fACDo9cQ9O9x0gyPYE+dPNWWcTwry42E26Nj2If+aM23ATBo/01aUoPlV7wU2Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UdAOz34t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeeifeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UdAOz34t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekjeeifeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935072AbeCSQES (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:18 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:26624
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934959AbeCSQEM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 201/281] perf report: Ensure the perf DSO
 mapping matches what libdw sees
Thread-Topic: [PATCH AUTOSEL for 4.9 201/281] perf report: Ensure the perf DSO
 mapping matches what libdw sees
Thread-Index: AQHTv5uYazSmri2X2k+xwVlJEkBikg==
Date: Mon, 19 Mar 2018 16:01:52 +0000
Message-ID: <20180319155742.13731-201-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:EBuDQ02B9ysmac4mkaLvxI0Pji3pb/tMUGMhiAWXDOgM/g6tajOjgQIj+/L5Zx4vTXPfAw9yXaI6CMs5cykaBCzEtoki49KCrnptA5ze5pFa0XPlLtWlnMQjeB2J7/VeTV1TUoEhZEk3K2r1Rwl3zNrtZlXw+vWDnxz+2ZdKh/BqvmR3hTUYmM0KlxlrCsYW+Cd3k7dY592c4wTGzQCVyAwvUOfHxgMrT0EcndHhfuPttWrniCU28AnE41fjBCCg;20:RPTQA7Np5koqDxRb5VciJUBdnn6/D9MI0EQXClP5ADbO9on8VzNnVMApQSTTfE2rfe+ng5hLQ4svjFJY0QhJsfohThtXQ6I+QwoV88IlH0Kpf6CXZVb1grrJqQwXFnu+4iZSnH4MGNCh9cQegrLFvqlWQIbvl4LKp7cPwJLYDT8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48cc3719-d6fd-43bd-59bb-08d58db30622
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727FD801366DDD02494335EFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(5213294742642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(6306002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(966005)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ozY1CWmgGH/QDsxXond0OD31JfhLWBEmuUcyhCC1Ll6qcJep1/xAMCMngGUYFoBpfvj7DdKqDdEfSBBakq7QCfU18uASa0NQTbW4+qhT5QQQnmWqgcjKNCrg3Ubto5EG1NQtCSI0ZFAAzlUwn2WB2LTIZX08EHpFH4OINigbdWNqxbOTiLe9+vnL1Oqb8DF/iNcaOEHojzUauHXQh51EBnYjmuPUmrdZ8qHTUvLj9VnGxt5HYVO4Xqn94/n8zCtBvx6hXQpZ8ZwJGg/9kskTVeN8SrH/Il0ivnIuBsMQ3+vPZ2KhJ1WQX4NdGQOFMwWBv8iChhMzRyytIzeQZeQwNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cc3719-d6fd-43bd-59bb-08d58db30622
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:52.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 7c4defce0115..b46e1cf347e5 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -38,6 +38,14 @@ static int __report_module(struct addr_location *al, u64=
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
