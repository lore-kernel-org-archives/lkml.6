Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E872DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D1D20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D1D20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeLKKGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:06:23 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:06:23 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MwQKr-1hM0ev20Jx-00sKbk; Tue, 11 Dec 2018 11:06:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: kexec_file: include linux/vmalloc.h
Date:   Tue, 11 Dec 2018 11:05:46 +0100
Message-Id: <20181211100603.625505-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yYDiuhpQ+tZ2vF9nwseAh/VNtghlaPVJmWclb1ijaMXon2lItJ5
 Tgopoglfbb2g7E3BZiaQDRCEfhlrbrbhhbQU8i33VhIZR+SZLvaGcgnI6EuQHJ5YYAiDdIr
 QmxovIBpM9mXS1V7VFbMoeXHb1Nk5TsZpT2RAH2vmR6DCkaYHiECyY47V9QhU/Z9k07xCz3
 iAil+H6rlJvdmRkZFuG+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6/e6p/Wq+4I=:IHLTE78yGGJv4tHgxx58kc
 szN9eVbUz31GAws+PH7b8X2bau5MGL8t3V5/kBAv9BK34Nrioj52/eIgyM1dM53T8uAa6+YIH
 PQ0Dgtdefk/v5524KasFk1gUK/Hk1tEqK8MEaLx08+p8BKQ2NCn2PqTh+TAhjCrUzxEyWe5Gw
 P9sBi4W+B9n8i57qsa7i7ZQDGhYpY3NC0/Ns2dk/ijK8ZZ62ldHDBl/7Ma5Gdm33JgTEmxwCi
 IqHtkvxZJnsoffIk/1ilYNZcLMd//WK5E4cLYv6b0tvi+WOzu2hq5lfwDznyADkuvVgmfx98s
 KpKmoo3vRxYFka0mUb2Q446uZ/ghOEf1Ok717YlHY1OCv8YHrzqYVBKjdPHo4+NefKm/Jyz2c
 PZfiiHcv1jDHzLNVKSQXD9IfoiHdK34jNBWL1l4jT7XEk/Gf4sOvpENjYcTWA3rrKdRu0cJSf
 9pA1Ox2LbReLnb1TCzds2xqFh0LIEIq90p559ytejYGVDjzokxss++VD0olLzC6ehLK2IU0i0
 o5rhotVhBDGJCJ6yqt6+l0d9ULFJPBqaCtz0B8bBn+NhVTgMou8SwlRuVxpZj01NTWe1ifqjz
 cbRRsy5JIy1sHlYxNCfmjamoT12ylreur4IRSme1krCpHI8zCRdqNskW5gGe4kmVsOeGsb/3v
 tB6jfttqMIfMblgxuOdHkUtJgUjhnR25ikWeBzwj/3qZ+i1boQ5kdQo1UDhbc19YMwGNyd07b
 JMPNSoZeq96GfY41P+YDgaB0lqOGr82dzIkXoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed for compilation in some configurations that don't
include it implicitly:

arch/arm64/kernel/machine_kexec_file.c: In function 'arch_kimage_file_post_load_cleanup':
arch/arm64/kernel/machine_kexec_file.c:37:2: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]

Fixes: 52b2a8af7436 ("arm64: kexec_file: load initrd and device-tree")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/machine_kexec_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 3c2c8a687149..10e33860e47a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -19,6 +19,7 @@
 #include <linux/random.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
-- 
2.20.0

