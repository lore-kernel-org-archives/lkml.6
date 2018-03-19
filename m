Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497468-2-12374655385665628283
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
    t=1521497467; b=jKoegvSzJPXyjkAeeGz0sGiZRZwhVk5SBpxPJwrGnBB0xk/
    Q/hgoWSyjTsM11ToXjAv2ZP/El/VImlXMkg72dGqwc6QziFYWwwbzLuGFQ9T2FAb
    OlpyaHG4U4d42jr8odBEFKFYvvAGhH+6Vr6bdYOG9+xgsMCydBSs8kJvpWem9Uc+
    W0nypD9yRQGVo7tQ1dd3dZUk6l8c1ZjioXvJalflyr4Y9Fa9p8f0cuxNkMSWT8M3
    5XebvXPjeFuAXtUSCIiwNuge8Lg5ENtNTvvYJv7Xo/DuM5KSDVDAqa+gVGGLiYR1
    81FvhY5+/O/Ze5fxjshyXu9HYdVnl/Qsh6dovEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497467; bh=kBGOGF
    tNeR7FHQE0/ZWb6uUacgzUp+TZLdDF9Qohk0I=; b=UzsIcwVoGVaeax0uksCnd2
    eD7qWd4nY3gIpmLrpEwy/W8P8RcE1LhbubQNctYek7KdcnTqVCJitkAd/XD9MJ9U
    96f5YsMIw3acE7wEnITHfjXPPzRiPqLFdzvAzEnuzmFaZ7cLHv/exAedKZDxu2rp
    c686fYd6Tyt1izFXgr0TO53nDwSl7SkQcK1ijZ7NgGvSA97XqWfTmjIyLSWq5R5B
    BgzQJwbuvZXex7NbpAOTGLPj/Lxxt2m0mAbDb/wmY0OwBHYKxnhN5duMdU6YaRo4
    x2hej7FPHqshaEzJpqPGRrLee89h1xLJIMgDPw+WjW8+FgXzRg1DchfXg8xX04og
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m4oUh195 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvdehrdhsohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduudejleenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m4oUh195 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvdehrdhsohenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduudejleenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeCSPyl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:41 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:27808
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934280AbeCSPyf (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 09/97] perf probe: Find versioned symbols
 from map
Thread-Topic: [PATCH AUTOSEL for 4.14 09/97] perf probe: Find versioned
 symbols from map
Thread-Index: AQHTv5qRN8oZQChAuU2VITyxJSS7bQ==
Date: Mon, 19 Mar 2018 15:54:31 +0000
Message-ID: <20180319155411.12348-9-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:Y9vbbEOJR/0emAtSXVRXpyPlIhRe2rUMnx8fSrun5HNv7oKJXL1WGAYFlNJugWva9OTo2KztBm8MgBdxbc30s56oFjCDwCDwc2EYC18CsZkGpuCr01Mg05SWq8jBszeFkqOrmCWnVnH4u6UyiARRXdat2nS9tXm/GuVWQGVJ8+of8LlEYGTSG4o5T97DHM6Dk0iFPhVSSFx3CgaJzZe4fstJPguNgpqGroAiq9CKjEoEOawIaU9wVMO5mRNFvCE4;20:kSURisEzl7YaVQbtBaCu7zkxvZ1VV2xeKe4t/6L0r6DbXECbD9t+Fxhulzc7i6vs9f3H/TQjHDbd/rfzNvrQ59xd9BBTvHb+kBXYtKU3SOSRqWEStbkhsxEBSCy925dO50lHqAuCQ5XvcF3+565Rb21s3bKVkYGqq+ZvdGa0nbU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe9873c9-0e05-49c6-740b-08d58db1b441
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090322053C628C3957C7368CFBD40@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(274839183919467)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(189003)(199004)(106356001)(99286004)(22452003)(5250100002)(8656006)(66066001)(2950100002)(2501003)(105586002)(54906003)(86612001)(110136005)(316002)(5660300001)(102836004)(3660700001)(36756003)(6486002)(478600001)(2906002)(97736004)(10090500001)(26005)(186003)(53936002)(1076002)(6116002)(966005)(3846002)(72206003)(81156014)(7736002)(305945005)(8676002)(81166006)(10290500003)(107886003)(6512007)(6306002)(8936002)(68736007)(39060400002)(6506007)(76176011)(14454004)(59450400001)(4326008)(2900100001)(3280700002)(25786009)(86362001)(6436002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jT8Tno/+GnHN5RhdoCrp/shZRJ8jQX+ZbWjEi67+/tAOVP5e3K3um5AnDINS0OwQX7RVhyJVWuWB1a9q5hdvoChz9kyREaBGYhn8c/hMad1lrJtP3N9nUcKj40uGzEKf+IR6Osg0sMufdR0Gd6IGPkmoIQpRhVsRCi0m9g8DvRBl0UTEkSLN6kZxGUi7hxETPqcyh1KPf79mmGXKjcN4lVnbfK2gHA+MJbXENPs9fXcyo7tx91F5FKyAagGAI24qjVxkaGgkLOSilpaLBUTGp7tKf2CwxdiTJ3M4TTofQ5HVA/1Qemt1Rdj1kUW1fcfj6rfKGnNmyht2Y9aja8xQZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9873c9-0e05-49c6-740b-08d58db1b441
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:31.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
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
index 6492ef38b090..4e8dd5fd45fd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -93,6 +93,11 @@ static int prefix_underscores_count(const char *str)
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
index 6352022593c6..698c65e603a8 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -347,6 +347,7 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
=20
+const char *arch__normalize_symbol_name(const char *name);
 #define SYMBOL_A 0
 #define SYMBOL_B 1
=20
--=20
2.14.1
