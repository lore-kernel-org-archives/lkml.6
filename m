Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D798CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4672082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4672082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeKCA5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:57:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKCA5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:57:46 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MAwoL-1gPSP318jh-00BNpa; Fri, 02 Nov 2018 16:49:36 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MAwoL-1gPSP318jh-00BNpa; Fri, 02 Nov 2018 16:49:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: vsmp: avoid link error with gcc -Og
Date:   Fri,  2 Nov 2018 16:49:22 +0100
Message-Id: <20181102154935.2073592-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:fCq3YIon1uKOvhOeX8iivnNGq8J6favtUcCaobIMvUSiBnhqDwi
 hmi0B7DH4t/2Dli4f6M4lnVkC5fqtEAufGVh0d3sf7ImmA2AQ9jUPyMxkJfNw8ZjbchyhkD
 lGWOvMyI67HT2E/MQlhCCJnonwypyalo4KpIGxZA0vdMTixoRpwRPfy7+GW9qXUbLi0qtdx
 ywGJSN3Efm2j3SXdXM4JA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I4HWw2JW6X8=:GtMHXLFsqlVmywN4jYs2gk
 6bFB3JKZp1+kU2OUvece2y4SRjCTtMrQDCxcIbdQpn0VWN6t6kWazUSsNuF7e9IGxWgXnhpR7
 1pjz1/11xzSTCeofb5oV4lwKWSqiWRBVaqDKW7Hmn+sY4v07cufj50aNChoP+5EXgjRFnuSom
 PAcLO5n/dhRR965nhG70dtOd9BqLMQa/jPtPCxr+w70TURvL07YDt4oO3QauMJq7HkYdSyjGt
 PWJqd6ybWfETiWg5CyXtLWFyDVMZWO5QX/hLozM9YBCW4OoMwHgGfgh05g+R8prTIFDAr4rBf
 BEE5cTO5tuVwJ15CleJf8b8WOPTd5NIm/WehvG4ZcUucTZoBxPV8C7gRIRnSyLeamDVmOBZio
 flhF9ijNdRd8ZFb2qQnzTWi/B3Do0MCBUg6Ss5RoFVcel/iUs3cki5myOJqL6UFIvjY+9Gf05
 IoD8XWksZdp5P2G9LTA7Msp3Zv8H2Hwds4Ny3zkcbV83Y496mV4OxRYKjxrWSO7LkY0LkGd8j
 s+ya+fEJUCtea7rnrRVxqyKl3EpWwmeO28XzUGIp/7DQ5uz5lmDEz9vi1ZUJx4bMkyieBk08o
 4Mwwrgsd+5AYovfCSEuMnkBEdf54fbEjfqmGJozzgHzvO9eRG17q9Hu+w3ifB7DPzqNKYrspx
 f6qfF+FZmgEsyCA0g8TuLF5hN2abcfAZuigEuPPkIwxqJP5CcAnObXtiREBACcJ5Qy6Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the compiler skips optimizations for ease of debugging,
teh vsmp_cap_cpus() function is not eliminated from the build
with CONFIG_PCI=n:

arch/x86/kernel/vsmp_64.o: In function `vsmp_cap_cpus':
vsmp_64.c:(.init.text+0x23): undefined reference to `read_pci_config'

Change the caller in a way that will always optimize this
as required.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/vsmp_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 1eae5af491c2..6a2ae6964ce5 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -146,8 +146,10 @@ static void __init detect_vsmp_box(void)
 		is_vsmp = 1;
 }
 
-static int is_vsmp_box(void)
+static int __init is_vsmp_box(void)
 {
+	detect_vsmp_box();
+
 	if (is_vsmp != -1)
 		return is_vsmp;
 	else {
@@ -157,10 +159,7 @@ static int is_vsmp_box(void)
 }
 
 #else
-static void __init detect_vsmp_box(void)
-{
-}
-static int is_vsmp_box(void)
+static __always_inline int is_vsmp_box(void)
 {
 	return 0;
 }
@@ -213,7 +212,6 @@ static void vsmp_apic_post_init(void)
 
 void __init vsmp_init(void)
 {
-	detect_vsmp_box();
 	if (!is_vsmp_box())
 		return;
 
-- 
2.18.0

