Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3980569-1521499351-2-11998372557893315121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499350; b=OPbvBkv1DS3ScDXWg7muY+mWgOQBbtkYdIRTZ2Q2FNbZZuO
    WScaq43y2Rhmfg0k83Q3Vw5KigwKUhuc/JCgiEkYboggvvxBboGM0L6dUJM7qS9X
    9FN1xOAbCPX27GlcWWaVfrPrBGDz+n2JDguBXb70939YWJ37G+qhnBI7+6jcCEqj
    87tvyxmdR80yTE6s2iiEkGD0bvTkCVkIqpor5sers1fhGciG/aYWIEFu+te056hw
    FgwV2qgft/V79oF5PTN7AeLy0wxZYwCO31d0Av8tZPOTQHkvPF3ai4FUPaMhGCtf
    tq0AnKFUL+LIzDkZb9oRpk3PFww0aPoz6DjtAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499350; bh=eKeOD6
    fvJ6fYMqBFUoL1Un5ptoOcyyUhHRDNz09A0JU=; b=wpcTQSM2up+F12w+p5LciY
    89FjDY2P0rs5g9fxqi0LpA19CB5ezAZ2P0dkXHNZfKnpTVLViX1p3MNHDrkE03+4
    AOPa20z2niC7lTBtUBatAD/QBXsXddz2e4PwDm1yrUV1l5OF4493bCDhxjx3Adec
    JHWZvx2bnzTeO6BFSJeq4ploU+4zphlJaM3lc0xzck1aPm+XFl9Z0gnpgoq9+yGi
    D8+KL6JxFZuxYNAj+2idsCICzn0/NK3tjsQMDSvKN1vDrT/6jYiyaqJfj2ZnpS/5
    eHsCfgmfrpRrkKk1oVB9N8S+Kuw8iQIfJFfzpA4E6F87L9S2AxY2aEtOQ/CAUfIQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BJRmnB5t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddujeelnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BJRmnB5t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddvhedrshhonecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddujeelnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936828AbeCSWl5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:41:57 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755999AbeCSPrM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 009/124] perf probe: Find versioned symbols
 from map
Thread-Topic: [PATCH AUTOSEL for 4.15 009/124] perf probe: Find versioned
 symbols from map
Thread-Index: AQHTv5mIpFrtTTsamU2f/Wm7JWU1ZA==
Date: Mon, 19 Mar 2018 15:47:06 +0000
Message-ID: <20180319154645.11350-9-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:qgjWgWSwl3arJimrScmxslwCoX7i287fKp8OxlehUVw6kKrpnWe6wrDcY3PNbD1k5Te+YSwJ/2H12mL1Z/hwPLWW/sYKrmNtE3KGiraNmyDG6e2UZ4yTaHFpoUVhdW/yXrq2MYKNboAXHvUtyZlJz4eRgFOfTfyhhS76yq1BfN687WM7mtJOe5/RvZJAM8CflPhxZvEKggUiGq0QqfRVHTA/TKcw/4K0HRrfdjqfGujXDgLr7Ysgk9CVsQTz+3eZ;20:jhchPW2Zil3pTol7+CVxOVQFIs1PYGp+m5MGJc3HLTP0/kfg0mbW2gVcBzAGKz1B8QS93Tg5KVlj+vuiuIsWwc1jMefUD8b3jdMAwSNcogI8cs/YfbvuARVpeKcTahhh3P9m+DND0G579HTY9jfr1t24ZQ59UPNJYIZSS6NgcnY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a57c8d5b-963f-4af9-4f49-08d58db0ab17
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10136F87A238B6DFD51FB754FBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(274839183919467)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(966005)(86362001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(39060400002)(14454004)(22452003)(8656006)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6306002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SN3VG+OkLBqGespwU+s3RelNHQCW5pXdCYGja6yz+CHwJO3WFHGxMuWtbLWwZ1BWMhFvZRS29Yeujz5bgDQ88a9d7GkSOCQ8v7hWwqzGLSJ2MsXHj1OAoIE7XZdpfSuzAofpTTBQKpPfU5YvX03BBvQ+kwlS2HA/bViYQlXmUdIP5MYUexMbI31XPRG5dzU30eB2ruQ2zTRehs4yggeLpBV11HpmEMDv1d1Ndhk1iblbCMNxsH0KmgJFdcL8YvmSvHy5TFLvKX6GttQE9UFp7NKIPJwsmWFHvL8fPGDN5QiZb/eNUFaZHnbUD/LodVI0yNkc2kAKZ59nFDWCiatfUw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57c8d5b-963f-4af9-4f49-08d58db0ab17
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:06.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 4b3a2716dd785fabb9f6ac80c1d53cb29a88169d ]

Commit d80406453ad4 ("perf symbols: Allow user probes on versioned
symbols") allows user to find default versioned symbols (with "@@") in
map. However, it did not enable normal versioned symbol (with "@") for
perf-probe.  E.g.

  =3D=3D=3D=3D=3D
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Failed to find symbol malloc_get_state in /usr/lib64/libc-2.25.so
    Error: Failed to add events.
  =3D=3D=3D=3D=3D

This solves above issue by improving perf-probe symbol search function,
as below.

  =3D=3D=3D=3D=3D
  # ./perf probe -x /lib64/libc-2.25.so malloc_get_state
  Added new event:
    probe_libc:malloc_get_state (on malloc_get_state in /usr/lib64/libc-2.2=
5.so)

  You can now use it in all perf tools, such as:

	  perf record -e probe_libc:malloc_get_state -aR sleep 1

  # ./perf probe -l
    probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/li=
b64/libc-2.25.so)
  =3D=3D=3D=3D=3D

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275049269.24652.1639103455496216255.stgit=
@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c |  8 ++++++++
 tools/perf/util/probe-event.c               | 20 ++++++++++++++++++--
 tools/perf/util/symbol.c                    |  5 +++++
 tools/perf/util/symbol.h                    |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/=
powerpc/util/sym-handling.c
index 9c4e23d8c8ce..53d83d7e6a09 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -64,6 +64,14 @@ int arch__compare_symbol_names_n(const char *namea, cons=
t char *nameb,
=20
 	return strncmp(namea, nameb, n);
 }
+
+const char *arch__normalize_symbol_name(const char *name)
+{
+	/* Skip over initial dot */
+	if (name && *name =3D=3D '.')
+		name++;
+	return name;
+}
 #endif
=20
 #if defined(_CALL_ELF) && _CALL_ELF =3D=3D 2
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index b7aaf9b2294d..c3cd3488fee7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2792,16 +2792,32 @@ static int find_probe_functions(struct map *map, ch=
ar *name,
 	int found =3D 0;
 	struct symbol *sym;
 	struct rb_node *tmp;
+	const char *norm, *ver;
+	char *buf =3D NULL;
=20
 	if (map__load(map) < 0)
 		return 0;
=20
 	map__for_each_symbol(map, sym, tmp) {
-		if (strglobmatch(sym->name, name)) {
+		norm =3D arch__normalize_symbol_name(sym->name);
+		if (!norm)
+			continue;
+
+		/* We don't care about default symbol or not */
+		ver =3D strchr(norm, '@');
+		if (ver) {
+			buf =3D strndup(norm, ver - norm);
+			if (!buf)
+				return -ENOMEM;
+			norm =3D buf;
+		}
+		if (strglobmatch(norm, name)) {
 			found++;
 			if (syms && found < probe_conf.max_probes)
 				syms[found - 1] =3D sym;
 		}
+		if (buf)
+			zfree(&buf);
 	}
=20
 	return found;
@@ -2847,7 +2863,7 @@ static int find_probe_trace_events_from_map(struct pe=
rf_probe_event *pev,
 	 * same name but different addresses, this lists all the symbols.
 	 */
 	num_matched_functions =3D find_probe_functions(map, pp->function, syms);
-	if (num_matched_functions =3D=3D 0) {
+	if (num_matched_functions <=3D 0) {
 		pr_err("Failed to find symbol %s in %s\n", pp->function,
 			pev->target ? : "kernel");
 		ret =3D -ENOENT;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1b67a8639dfe..cc065d4bfafc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -94,6 +94,11 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
=20
+const char * __weak arch__normalize_symbol_name(const char *name)
+{
+	return name;
+}
+
 int __weak arch__compare_symbol_names(const char *namea, const char *nameb=
)
 {
 	return strcmp(namea, nameb);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a4f0075b4e5c..0563f33c1eb3 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -349,6 +349,7 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
=20
+const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
=20
--=20
2.14.1
