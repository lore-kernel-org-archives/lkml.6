Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121455-2-5547949979873242129
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
    t=1520121454; b=tkHkX0tP0PZ8FADKZ6xBxqc2+rBWGO6OXhxMvngEwDIwUXs
    9zTnk1qt/woIWnrYUN0DsY6FHjwyQ+R0oc+YmPBf0mo7OKTCms0BgRvA9wKLGpRp
    GX91JCpScL843H3CSn/Dp9+88jeB1o4LSkaVOyODIJN99QPmimRlzC4triY6xWJr
    CMqRf21eg57cHWLDRcmLivVtVELLxmN0tcJ8sgTvjkOvB8d6M9+kKXjP21r0OU8l
    FiqUYC/JJrq+TtaLNnbFfraJ/klk9eCknFBZxGfCGQJcEOebUPgI+WOEv9h51Nz+
    RLmTPmJPLdmN8447tlaNw44w9+IHoMjnD2kNHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121454; bh=KXwlKW
    RxXiqQTLPD7FZpJCCzBnKDhW05JVNmFj1zN58=; b=YYSxd1BUqBsAq/zvhe7ax0
    NQhJL07oWCG0s6BNcdx/44H1df5DakrZLO8XDLwh4Smwdsc1GAadHWC7RBJdic5Z
    GAn2caZP+8k0ZA/vMHPX98xGCICo/2derBfF9t3O8JpwLMEGK3qb5AIjVxUAKN3E
    YdrUvYphOOGGgGN2FwW7r6Eb+DjnPueQI7EvE9/JCAtjfn/RDoNRsTQ5EWWGkpBV
    U5lqTPN6G2eUYQPIgKdIuFFVjETjYxz0miknWzVtSym/AAi565Go1YcPssiWSMWx
    OBkXUtGSnq2ymCobr8WSsjYVNMIe6cos/CIcFeRGBfc+SOvNip6/9gfmt566j7EQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kS6wBpMD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kS6wBpMD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCCX5B (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:57:01 -0500
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:24496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933839AbeCCWc0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 054/219] x86/boot/32: Defer resyncing
 initial_page_table until per-cpu is set up
Thread-Topic: [PATCH AUTOSEL for 4.9 054/219] x86/boot/32: Defer resyncing
 initial_page_table until per-cpu is set up
Thread-Index: AQHTsz7zZSY5b43B+0GK0/OfwsSe5Q==
Date: Sat, 3 Mar 2018 22:28:27 +0000
Message-ID: <20180303222716.26640-54-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:Lyu4LqFE+ed3TbHACpkLcGXSGJmSEHmIGJaykFKE5a+gj/gv+s9XE5L4f7DHStAOq/fLMOAm7BDPm201yTpEnF3pxrO4fOp5cOc02uYlwNdgrvcSBgrCXuk1JY15L6197ml0dh5rzPYSOI+6l2Jd//bSRbQaT6H/E6hoqLCF97YK1yucJEekCgQN9wMgqWuqlXJNqXMVe02fFJmsULqhxzLPOg2mTz0NZAZbb0PwgrozwktLOEdWuI576FRNF0ohLI3pX8qYrhVAc9b49MjHLQHxGN/GIJIk35By/xgRGPQNF1dZ6OX1TQQ5c8kMOZr+JsMOuHP5L5IXZYLe5pUPoUA+IhOJ7bDNP9wjCMI8u/Auo1RoGpty/IuBWBA/TheT;5:HsRt/7PtcjS9MFIwx7w3ObNlOtGa3pxHgpPBprHzccn36kUYiGajA8DBib5nJ6Qdou8PCooYn2l3f3uOJf01G0QMMthE9auoJhXsJRKBPOGCnhR24FeBZK7J/E9A2mKri8QeUilItaooKseaiToCZzRC+XDhiVfMbH0dkcEuLXI=;24:2gNOSUDCvuk76YF9kA1VUZSXAdaSnUzR0p9yGmp6Nnqtc1q3IZFkA/PvOrWwusz9TRKPul5sde8eiXIoRG/L/3jfoMhANzan2KfYvuluIi0=;7:Wsvxs0xqoFa/pMFeYziXBJZB7dmDf8CIp+zHycxe5pqMHKkYRWkt7bxLbb3oaMgajdZobGDsA+Ccy7o2FYIjgfe61Fpo8tL2F4fKstJkKCHuY0oTC9MiU66ONCXioP9EG3s8qkALd6oPIIj4H3PcuvVySjFXlfIsfGOpSUccqgVsYJwCCv9rYvNf2CZGnO0mQoopVIZbAMw7+yMAKEqjMlaCiZeIVjhIkkmE7rAiV1yXag8SzGh6lRVM+py3zSU4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0e4a795-8f8a-45c0-a792-08d581569d83
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036514AC9D9BEFB62B871C2FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(211936372134217)(42068640409301)(153496737603132)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(39060400002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(6306002)(2501003)(966005)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(7416002)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0ydCqdyBTTqe/ZJ0ROesfl9X6zKVO9sDGM64GAepNtj9G6iVTcwsoI/4zDUw0FrMiW2EftLORkusIoEWT3cyPpM6PxjBl3GZS2Rr9B2FzifOYMxV3/NUfgXgmN9fNaOLZJmBFGNBeRILeYjPUWfptd7N40Ej8oN2WZXGvCJPktA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e4a795-8f8a-45c0-a792-08d581569d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:27.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit 23b2a4ddebdd17fad265b4bb77256c2e4ec37dee ]

The x86 smpboot trampoline expects initial_page_table to have the
GDT mapped.  If the GDT ends up in a virtually mapped per-cpu page,
then it won't be in the page tables at all until perc-pu areas are
set up.  The result will be a triple fault the first time that the
CPU attempts to access the GDT after LGDT loads the perc-pu GDT.

This appears to be an old bug, but somehow the GDT fixmap rework
is triggering it.  This seems to have something to do with the
memory layout.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/a553264a5972c6a86f9b5caac237470a0c74a720.149=
0218061.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/setup.c        | 15 ---------------
 arch/x86/kernel/setup_percpu.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6b55012d02a3..d1a214287fe3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1200,21 +1200,6 @@ void __init setup_arch(char **cmdline_p)
=20
 	kasan_init();
=20
-#ifdef CONFIG_X86_32
-	/* sync back kernel address range */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
-	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
-	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
-
 	tboot_probe();
=20
 	map_vsyscall();
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.=
c
index 2bbd27f89802..bbba27269fdd 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -287,4 +287,25 @@ void __init setup_per_cpu_areas(void)
=20
 	/* Setup cpu initialized, callin, callout masks */
 	setup_cpu_local_masks();
+
+#ifdef CONFIG_X86_32
+	/*
+	 * Sync back kernel address range.  We want to make sure that
+	 * all kernel mappings, including percpu mappings, are available
+	 * in the smpboot asm.  We can't reliably pick up percpu
+	 * mappings using vmalloc_fault(), because exception dispatch
+	 * needs percpu data.
+	 */
+	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			KERNEL_PGD_PTRS);
+
+	/*
+	 * sync back low identity map too.  It is used for example
+	 * in the 32-bit EFI stub.
+	 */
+	clone_pgd_range(initial_page_table,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
+#endif
 }
--=20
2.14.1
