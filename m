Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494136-2-10502322216127602078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494135; b=RMA6SB2RCMLjVCdAgngtoFmKFNMqKrbBAbKNNuTHOZYrAvx
    tgl3xAuFLdWU7CqXPOiZ3BHWMskEVDzrbOvJa1T+QxX/4sVB/ZsUNkygnmDolj7F
    xKCjRc/kva68yVzfssBFHuenAgSbZ8GVBP8iA9ptKeYWwFMVL++jHttZxbCWqNbp
    Zyo0u1hMIGVFJoo4Wi3MDQ1czlHF3Jf6T2+zSeoEznw4xHnGzvfgCOgGIXIFRiM7
    S9yBaDUMIBLDxFk+Ec+4PlIl/4Xjtm7bfMSuLO+cKhjEgRg6xMt979Y1AT6i2OkL
    a5YtUKE8jaKkIEsldiaEsV2VpDfx9XJPJZDaO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494135; bh=uflAgK
    1/lzQphuGo7hpRFmIwMa7xzxaIBJwQ+3pwhF4=; b=E0LJiHiwD0J1YWCXiKRKGl
    F8+S7+QqZbR0/7fPkVetb+oYZB1w9ix3Vqg25GN9FiUT4oYO7tvExUPItgroXOum
    sprL+qvutA0Pz4JXHAgcmMn6o+EeJSbMwNTAkhXjLZ+fOYvRMgAIQ+i8YZfWNYws
    2PS71Om2d/b0R7BjvxwgYWTFCQAQsOhtw4dKdPl47TrGmavix6B19fTP2fE5YiVf
    fjJD5XUkjNGdZMXIziAbA5/z7U7OwCqo4LwoKzhbRbrUN+W1o7l0x8vzpaOqa5HV
    93Aaz6GBaJh9wuGUANKCuMmFdIDljCERpwLdYzem6TFrwSYGOHU+R+Xj2ZRib1qQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U9ke6Xfq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedugeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U9ke6Xfq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedugeegnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965336AbeCSQBW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:01:22 -0400
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:6335
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965264AbeCSQBR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 119/281] kprobes/x86: Fix to set RWX bits
 correctly before releasing trampoline
Thread-Topic: [PATCH AUTOSEL for 4.9 119/281] kprobes/x86: Fix to set RWX bits
 correctly before releasing trampoline
Thread-Index: AQHTv5teF72rc4wlIU24+ojYZe+wxw==
Date: Mon, 19 Mar 2018 16:00:15 +0000
Message-ID: <20180319155742.13731-119-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:pDZ2OOTjNrb9JxtfAT5Opi6CfYf6zbxW0LNWIXbnsTq1AOfi4I0msp2bYsGKAoghZXa2TCbulhzKtn0NtiWh+ZJLoAVaTMs3DD8p33f42TpSqYewd79CfoOKCDQJk5TKNAcDWUmzBve0XJUVPUlBiLZOWeagOi5O1YY7SpdOemg735uNqae8yzXF0JirfCwNHCdMlz7INzDwu/TXIUaukFcQZ7ehdABv+DEE0ILEXQnVuLJ3pX/CppBBrAR1PrT7;20:C0cebyZVAzeMlBh4SC9C8KQ4oo+dF1598cP2F285qnSeurQvlO5ww4UWgYkc3a/b+amRpv1QefNwJMCMh6Q5WLxrB5WP+dh+QT/wqPL2p1IqlhHeujJ75Bwb+2nVlz8dWZ0Wwezy1KgCKJfcNn8l+a4HRshRJpwCmVkfWlN3maI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db7dc82a-5087-4dae-3054-08d58db29fd3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10159E598353C7799C77D279FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(6306002)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(26005)(86362001)(53936002)(5660300001)(6512007)(966005)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kIjUhUwNTyU/f5LYfRa2vXybJHmD5wQDBgdfjMN/z60jeGUajYuaIWe6T8jv3b47pc/UkhEIlWse9j9fSG7FSwSfzoRzisM6We6tQFYJ2YYQ5vxwn7psotLT9Bbh1+XHrjoEBYjdKnqVvcRrqvGsUXRv0TqJN21ADwEUPCAR4IiuOZom7GFQ5J0J7N5MqFJ394C5Q9G5SR8I66ZIDE2Gs6++ZJeO87Mx4TZMTTFaPVwyxNWAeGhQ42hYlvijRByxhYRmta9teQB/GtcGM++fTipYaUwNc7Y6MhdDCQZAFTEYT/o+bXDO49QoyKUkT05RVOCDjs4Ux/rlEWjAmcuVVQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7dc82a-5087-4dae-3054-08d58db29fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:15.1615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit c93f5cf571e7795f97d49ef51b766cf25e328545 ]

Fix kprobes to set(recover) RWX bits correctly on trampoline
buffer before releasing it. Releasing readonly page to
module_memfree() crash the kernel.

Without this fix, if kprobes user register a bunch of kprobes
in function body (since kprobes on function entry usually
use ftrace) and unregister it, kernel hits a BUG and crash.

Link: http://lkml.kernel.org/r/149570868652.3518.14120169373590420503.stgit=
@devbox

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: d0381c81c2f7 ("kprobes/x86: Set kprobes pages read-only")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/kprobes/core.c | 9 +++++++++
 kernel/kprobes.c               | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.=
c
index b55d07b9d530..9f352705a094 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -51,6 +51,7 @@
 #include <linux/ftrace.h>
 #include <linux/frame.h>
 #include <linux/kasan.h>
+#include <linux/moduleloader.h>
=20
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>
@@ -403,6 +404,14 @@ int __copy_instruction(u8 *dest, u8 *src)
 	return length;
 }
=20
+/* Recover page to RW mode before releasing it */
+void free_insn_page(void *page)
+{
+	set_memory_nx((unsigned long)page & PAGE_MASK, 1);
+	set_memory_rw((unsigned long)page & PAGE_MASK, 1);
+	module_memfree(page);
+}
+
 static int arch_copy_kprobe(struct kprobe *p)
 {
 	int ret;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a1a07cf1101f..69485183af79 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -125,7 +125,7 @@ static void *alloc_insn_page(void)
 	return module_alloc(PAGE_SIZE);
 }
=20
-static void free_insn_page(void *page)
+void __weak free_insn_page(void *page)
 {
 	module_memfree(page);
 }
--=20
2.14.1
