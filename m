Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2931EECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47FF2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtNHjdpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47FF2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeIZARc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:17:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35036 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZARc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:17:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so14674846wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgszxiMh7UVkNVfekl9HVziiNCKJdcqkbKDqES3JS2E=;
        b=DtNHjdpn0/ZJiP0HFIxH3ajPaRp5xGtcpwUQP/J2HwZQ921pbrV4NErK+b+YWxXher
         Eo3d8DFNtXGM4L/hoaZFDJsHgHJr+W6wcz73yEHSVoCgQISWgI4EZ+wYgmKM5O0sQqlS
         mvntX8dRkekWByiuRrU//tK0G4dJP0PK2NRlIsM3ckOHGkCBsCTUPXm/BGtS6TmBkdYH
         e5CaDu0/mDL5tnPJJf96O2zq2LuLo1Sn3Ni7mTPX2X2O0E3TpUq19tCjKMN8bBF+tCO3
         Vn2CrKAYd48VCvqJuDzqv8nv+YDHvBAPKzl+qApjvq4esTgZg+AOYjDKKd5W7TLRUxWQ
         tPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgszxiMh7UVkNVfekl9HVziiNCKJdcqkbKDqES3JS2E=;
        b=nGbLx6JEbHZJdRMRmMSY1g2P9QbxogNYWXBcSQ2At4F8U0sRtp+cU/dNRghlsmj2Eb
         0vz+FudFiCQAmXWYfqDMSBYNzN7VF99te/lFTJ/Pa8N1YL64R5ck4s4Qq7m+LeZ6y+j9
         XTOJWnpLcE82wRPuFTRX+Suo1hQibRH3jxubVeVlWuE8aFURqvGhxziDvbxyf65O8oKG
         VKgEAr3SChfkeCBnwPQk8U9yTgZ0bWHaLnYyxVQw1IN7fa5Lf4E7IiFj/mvnKOlp1mYF
         uzK1TKJefOBGRWhwZKxmc013ThE9B5Ulkk7tm2hU7RfXTAsdGqm2kT8ji1jXJTd75jZ/
         eCdA==
X-Gm-Message-State: ABuFfoic9BgRYgnR1zl0wG+NmEKGslYLI8FbFiRZbdRWIR7RfDpDQYKR
        89BiXSVybplE+XvxSDO+Y5I=
X-Google-Smtp-Source: ACcGV62vMgRK4yc9TMrankAW6e0MueWfOvXEsQhFo5i1xY7Fzx9REi1eHY1+vhX5oZQKhdQh1fv/rg==
X-Received: by 2002:a1c:7412:: with SMTP id p18-v6mr1788391wmc.49.1537898928946;
        Tue, 25 Sep 2018 11:08:48 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:48 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] MIPS/head: Add comments after #endif and #else
Date:   Tue, 25 Sep 2018 21:08:22 +0300
Message-Id: <20180925180825.24659-2-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes the code more readable, especially in the nested ifdefs.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/head.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index d1bb506adc10..fef2f61c5394 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -77,7 +77,7 @@ EXPORT(_stext)
 	 */
 FEXPORT(__kernel_entry)
 	j	kernel_entry
-#endif
+#endif /* CONFIG_BOOT_RAW */
 
 	__REF
 
@@ -99,19 +99,19 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	li		t1, 0xd00dfeed
-#else
+#else  /* !CONFIG_CPU_BIG_ENDIAN */
 	li		t1, 0xedfe0dd0
-#endif
+#endif /* !CONFIG_CPU_BIG_ENDIAN */
 	lw		t0, (t2)
 	beq		t0, t1, dtb_found
-#endif
+#endif /* CONFIG_MIPS_RAW_APPENDED_DTB */
 	li		t1, -2
 	move		t2, a1
 	beq		a0, t1, dtb_found
 
 	li		t2, 0
 dtb_found:
-#endif
+#endif /* CONFIG_USE_OF */
 	PTR_LA		t0, __bss_start		# clear .bss
 	LONG_S		zero, (t0)
 	PTR_LA		t1, __bss_stop - LONGSIZE
@@ -156,9 +156,9 @@ dtb_found:
 	 * newly sync'd icache.
 	 */
 	jr.hb		v0
-#else
+#else  /* !CONFIG_RELOCATABLE */
 	j		start_kernel
-#endif
+#endif /* !CONFIG_RELOCATABLE */
 	END(kernel_entry)
 
 #ifdef CONFIG_SMP
-- 
2.19.0

