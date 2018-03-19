Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481764-2-10681063409371231948
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
    t=1521481763; b=OD75vpToCU1NF4qbeIzaoU08iB+TXG744OgSU3OiAXVwpnt
    CeQ4bTpa78cDgav3SWxOw+Qr11QkA4sZLfzaENAaNu2z94irBe+B4vVhW/auyw1y
    Wg/0ZVtp/CT1QeMi+p19aAvLT3uneOeav7Wc9tZtNdECYiBDnKHxglOKeU/r2kgp
    hnT86oAyKPIr0xhey5nKNzhoc/cafYc9AKfSlIOvNPpkt7XNVQGJTm0fNsfVceHB
    WTLbunGmKchwfjFg7v+agfE0ZQf6P4d2NLFNzWGgBjNwNMmvDyv9jst2Iwq78CeN
    2HVLXH7ks6Q2EC353RmKEGE0z1TPRiygEEBz0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481763; bh=UaKMwk
    tpwALuGe2TezOSeDXCqkyioJZtvVtQh+JuP/k=; b=FXnazm2hIILOvXoohy9hbS
    hRlnc7pfbvrwl59CFKWtL+nVwKeVPYa27pIo4wr1EjsLe3+7kKuq9D7Bv8rcTVF8
    h8K9Q7Vg4/SwThczrwatW9O7L7Gha3s0l3v7LYcKbv4y8OoXcP2J/7JLt+x5+u+T
    ZNOzXjpuOYtyQyXrj1T+3lnE9lfFrXtbymEsJXOqM2AbT1caa1FCDLTcdZKgowm/
    xKtRcXjjKK7h1seXdpM8uPnawXn8GAymwstCUfC5qLOPjflRWu64FrjvB9kmPGEw
    o2ZXKfc18bfCfha+qFrIeM+Xa09jYW70Erg3v1zu35Ovsk1Thl9MhvF6XgWSle3g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3eg0QeA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehieeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R3eg0QeA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeehieeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965804AbeCSRtT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:49:19 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45241
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965746AbeCSQFE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:04 -0400
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
Subject: [PATCH AUTOSEL for 4.9 230/281] perf tests: Decompress kernel module
 before objdump
Thread-Topic: [PATCH AUTOSEL for 4.9 230/281] perf tests: Decompress kernel
 module before objdump
Thread-Index: AQHTv5utfUgvLYPbPUCbd4u1hfoXEA==
Date: Mon, 19 Mar 2018 16:02:26 +0000
Message-ID: <20180319155742.13731-230-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:EhsRoLLwkE3/K5hB91I0YBRQtQ/m0spHHUA9IXQtAdLCwT4xPd01JzI3t+K/8iM1p1rngZ5zCNxR5tJBejZxBlNxKem1LBk46lG1gjMR55b0KECRLCB2pqFXfDOg+jXyfdQ5r2BV/t7HSqzorVsU20rUTGJeMGUI8m4UrxsomJiPbBqTvMrFIUt/CbjJzj3465vF7PJV0Zaiss3YFa23dDD8o2dhr6XFij5tKCzIzZSXy7jlNePwzhQEKcR+ffiw;20:z3AM67ki+L/WoEaVVbjkqINZsFu2epqAjbuL8lNor7SbRSJF27RKHboOvWrO+LhJqmnEmeyr4VULMwPBWHMSa9dxLHa4ddd8nqWjF/6Zz0UsmhHs6UbSwF47x6/hkYAa1DINlhiny4F0rGutXKqB/5svco2XI97TubrQ945jpLY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09ef52b9-b1a4-4e19-7214-08d58db3257b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08853266A2E487243CE97AD0FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(39060400002)(8936002)(99286004)(3846002)(107886003)(2900100001)(6306002)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(575784001)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(966005)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: c+Kg/D/SVhBr1l7lB1tyjW4k6GU/5VffSPCI+D0OPmlEbhYgs2Z15ktHX6dum/JHjl5h2sVeiF8Xl/hP0+4GUoeSFPI3HLAhHko8KRtiGQmqnbtIkwkPYWaG+0IFnKTiwY7cSGT6i6Dmjj5mAsAx5IRmzd+wCZ9renvU27jhU2cmvBVLswhxqQ8N/f7UHVQ6QSwgYXAXfjDJALbbxf8mQt+81sBGhzYrJoavB0VJZY54lrgqvGysNj5c3suSl2s6KJOvEtqbhLXWJK5JZ+EpU1L8tzcx2t67jntOou7VjIX4QYZ7iLIHcQWlU8X7biI4mPk9/u08O1dy3LIuLNUIkA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ef52b9-b1a4-4e19-7214-08d58db3257b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:26.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index ff5bc6363a79..150334064071 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -224,6 +224,8 @@ static int read_object_code(u64 addr, size_t len, u8 cp=
umode,
 	unsigned char buf2[BUFSZ];
 	size_t ret_len;
 	u64 objdump_addr;
+	const char *objdump_name;
+	char decomp_name[KMOD_DECOMP_LEN];
 	int ret;
=20
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -284,9 +286,25 @@ static int read_object_code(u64 addr, size_t len, u8 c=
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
