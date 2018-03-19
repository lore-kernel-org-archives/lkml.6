Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521479234-2-6248100774345595296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479233; b=wNmjFKstTykgsKG28LV1sEMpRALs3BZoYGlWe+2vM38Whq+
    l3jpyXOEIipB32+C5WI1Fut2WXRFxblVu2LTZ5rIdaGwuAhSDI44siavWmR3ORwF
    K5t8F3Hq/oeyu/NyMl+vS7FyVA66krbJPCc5XaOpEMPX7U94Gdug4Deu4Iio9lh7
    1qc3daZmIMu45lQ53jx/yXhZwyPMR5aLZKzLbpMCXL1tUKcyIJjBh/FSlGh/aFU+
    YPxvLH2k5F/SRwItwi9Wz5+qAEwfvo+/GYwbJ2GJRyoHzVq03+pgnnuPpp5BcPyG
    fiEBxF7gxBRxkNhYgUFimMRxurygbv/FTWwNqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479233; bh=wK3Vrg
    V1APM/9dLfOF5FEkqruoYpNgrWvYpNXpIOO1Q=; b=pw693hhBbzawxlESJnmJ1+
    xm+ipiQQEdLBjV+UqJCEh73jgxPqZCiluLaxuG8nI9+cytmtvquATnpZIgr08LWI
    jZAHwDCecTekbtjEQW+OZAtYhoCiFfODye4ilwoy2lF3hPKldkak5i7ZIbq2uWV1
    g0wTa0fZGG2ULizPZZkesWRpono2TSbKpYkwCuyv7m0I0mf0uvolZBP7UKlrqPEd
    mzoML0FkjOSKGuRN7Ie8QKWXi6Jp3u4t4E6DyLuazup80JBcX8ypKwLUT487Bs5G
    jDMuo0E7ALqnGZFJPbynemT91uxzw+f7cweBNKfdQZ00fvizUais4n6PG08BGt+w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JIdnKGp5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekheeiheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JIdnKGp5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekheeiheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934591AbeCSRHL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:07:11 -0400
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:57012
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966666AbeCSQKu (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>,
        "kernel-team@lge.com" <kernel-team@lge.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 140/167] perf tests: Decompress kernel module
 before objdump
Thread-Topic: [PATCH AUTOSEL for 4.4 140/167] perf tests: Decompress kernel
 module before objdump
Thread-Index: AQHTv5x+0ElvJ8Bke02EnUy4VtJaiA==
Date: Mon, 19 Mar 2018 16:08:18 +0000
Message-ID: <20180319160513.16384-140-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:9CrU/Rcern0qlAiY8+YFmBAHWEu3SluG2czMVEolYIVKOqJN6hf/nnVQVc7MURod8OJqLEKCF0pBPOVwppI1H1qi7y/FeTUF27geXNH9t/ZkMQDAwgRBaUHuySqPiIfP4ZVLxC2v0W5v4p7h3lm8WuMqV3Hl+flFTXO88yHEhtX20yfsIrk12c3ekBDYWdFaMk0mdREqwRc5ygncjh6kJyVn8TOfMNwz3C+0VH3ZJVz8dYH7SToXHw0ZpbIk7UL5;20:Pe/BFyjPuxW3Xpjn5K+EmBEspE4CDlvnLqc45kcET7w+sYCzOMHFdVvdcVxxu97p5jewmZMXwjMKpuLIq0uqDR9OTSzuUqxxF/UnlnVwb3hg1CuHhGdMAQcbhZHTxnjWNl+20HDLCi5qRrz5svM8efWOvipwzG4TW2drjrO9D7I=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5da18f2c-aa69-4b31-42dc-08d58db3f89f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10955A83BBB3C5ECA6CDA916FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(39060400002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(966005)(59450400001)(97736004)(54906003)(6512007)(6306002)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: QWRNxILbJIeaXtcI0ZW+0yKWcrOQf9J9K3SBP6MH0AhklRAJwV0XJAkosdyJM2SqnkbMY6b/kVIjb5ZiPlW2BZ5xdVr/YOc1QZtTjNwyf4lq73gcGU+O218X8bW0DSy6KmvRzTSwxhILJ3kf3DhaV/nW8Eo4egJkRsu7BRftiL9PgMLcTpQ5ZTlUZSgU4tPtlS8X1u2iLf1g4OZ8RyqhoCxuVrNcjkIGK9XNwoULfjm6ZAjE5H+HLcsniXcFCtU24RhTJyFH58Ee+dM2pnG7fevRPDUBBrkSUIUKhLJkIqKgorWTiAVXazDSs7efNC7A0Gb1WOoK0ZscE1yeIB0Sdw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da18f2c-aa69-4b31-42dc-08d58db3f89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:18.7744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 ]

If a kernel modules is compressed, it should be decompressed before
running objdump to parse binary data correctly.  This fixes a failure of
object code reading test for me.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20170608073109.30699-8-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/tests/code-reading.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-readin=
g.c
index a767a6400c5c..6ea4fcfaab36 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -182,6 +182,8 @@ static int read_object_code(u64 addr, size_t len, u8 cp=
umode,
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
=20
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -242,9 +244,25 @@ static int read_object_code(u64 addr, size_t len, u8 c=
pumode,
 		state->done[state->done_cnt++] =3D al.map->start;
 	}
=20
+	objdump_name =3D al.map->dso->long_name;
+	if (dso__needs_decompress(al.map->dso)) {
+		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
+						 decomp_name,
+						 sizeof(decomp_name)) < 0) {
+			pr_debug("decompression failed\n");
+			return -1;
+		}
+
+		objdump_name =3D decomp_name;
+	}
+
 	/* Read the object code using objdump */
 	objdump_addr =3D map__rip_2objdump(al.map, al.addr);
-	ret =3D read_via_objdump(al.map->dso->long_name, objdump_addr, buf2, len)=
;
+	ret =3D read_via_objdump(objdump_name, objdump_addr, buf2, len);
+
+	if (dso__needs_decompress(al.map->dso))
+		unlink(objdump_name);
+
 	if (ret > 0) {
 		/*
 		 * The kernel maps are inaccurate - assume objdump is right in
--=20
2.14.1
