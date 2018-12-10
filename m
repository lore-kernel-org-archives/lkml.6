Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4338F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4338F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbeLJU7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:59:39 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:49195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeLJU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:59:39 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1HmG-1gTiYq0UyA-002sOD; Mon, 10 Dec 2018 21:59:30 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: add missing Kconfig dependencies
Date:   Mon, 10 Dec 2018 21:58:54 +0100
Message-Id: <20181210205929.3213516-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xoNhphRHQXdkYZP/b5IOxlR5jcfQmSAzvNH38P4crTBcPNi0nIo
 MhBVhTi7TVoksmicOymmYEelaKjqAuK6pg3r5mgRNWTK6UV7UN5lozRDOShD7HMxOi54D9w
 zUXggJUqlKpgg9MWUoEeI2X0A/uX7KZBAzquYiVDeBrrF9XQRAIgvuEfGuVsZTVEPG1roU7
 cUCwkweTi/cIoiGEOeR9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+BQSkXC+a68=:Jtp8V7phoEFy6iZ0l5IrJ1
 NTjvLrTQdPO/HG2Jcl9LSOnfJW8UlN/o9VZsWo3UsGUyrzseE0/zwJptj8K4l+d1YRP+rRnnh
 jBoaKt47+5H9Ck1rHhc7/w+vpqeyrNXsGi/XmFo8CPa8uxM/8v4EbSZsGOzL/BDCqTaRg+Xi/
 S+uTAr2xdhpxxlSkTECF6ZNIDZ5KVV4zqttulmpoNId1vgVC2xrdpOrNddm9LRDDHZQdqX8XR
 wKika1H4sZ3FNqBQz6/JWSeV2V+8FsHGrQOZy9zgKrAkBcwXLz75PmYBgY/RV/LyY9aDy57+j
 IiHzZzwZ7v68833sTHj8YknxAkCcG2B1qCpgG5QW8LTZfg56PixEeff8I96U3xq60Ya1sr4bh
 LFrmwq2XJ4M7TJi+3lFU6jnuroSk03S9628zIGtoQkneEA1KADXLpOpBYBEEv4wafQU55txSG
 6ZxFesgZ0UOftb+vX6ojVB0J/xVcpIjh7T/MfVkUrc/x+aHOtpXA6wFsC8/2By/PoJNF63Tt/
 e1xZ8HTytPCUtAGcyDUlninBppMxDdK/PDN/oIFL1CXjf+3p9b1qbGluKqbRshj2K1qabpR27
 4oxB+A58kPOPCfOYKd9ihln+0ei09MDKPCtZjnFuAkWMgk3d9S1OTM8rCTri/Yy4Ngnto/jsK
 K5pQtiZxxkiuPd1ZskIxAASvbe9j8JBhhhUIFryWzVa1we4iEoOAetNJK6uxZDWIoLTVlyGeT
 0ifbvbxxt+ijV9GtF6A8KGJOXAIYV2Epgvje7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with CONFIG_KASAN=y when neither KASAN_GENERIC nor KASAN_SW_TAGS
can be selected leads to a build error:

arch/arm64/mm/kasan_init.c: In function 'kasan_pte_populate':
arch/arm64/mm/kasan_init.c:106:28: error: 'KASAN_SHADOW_INIT' undeclared (first use in this function); did you mean 'KASAN_SHADOW_END'?

We should really only allow enabling KASAN when all its dependencies
are met as it was before the introduction of CONFIG_KASAN_SW_TAGS.

Fixes: b8440cc16515 ("kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.kasan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index b5d0cbfce4a1..83286bca2f70 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -15,6 +15,8 @@ if HAVE_ARCH_KASAN
 
 config KASAN
 	bool "KASAN: runtime memory debugger"
+	depends on CC_HAS_KASAN_GENERIC || CC_HAS_KASAN_SW_TAGS
+	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
-- 
2.20.0

