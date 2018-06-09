Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Zr6fMq8gG1stGgAAmS7hNA
	; Sat, 09 Jun 2018 00:36:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 20CAA6089E; Sat,  9 Jun 2018 00:36:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmNpTZcA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7C822607A4;
	Sat,  9 Jun 2018 00:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C822607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeFIAgA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:36:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51970 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeFIAf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:35:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so5949753wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Siw6UHCbC9Hh9bQzcdUdc+28jpC1zkZ4CqHNxPMbF/k=;
        b=NmNpTZcAcRqmLR2akZ3SUcZpMoHlLgIL1fGbJufA03ANzryUSOFh315hbgdw/yTPxJ
         Y2M2GDd0V6ov5wc2Q+PR2WsM4w7u1ceMZztqomTEv5UOnTH/6gM97EBbbhhhjArmOHsK
         sCmdNjYszQ/M1ESVUXCwW9m/ob4NfF99T9NbLEbfF9TK+QHdF1jooPsanQ4dOfWtVuPD
         OKaj7OL12etWmTiEBFtDPNJSIwFe8/arPFRl4gcUoiAkWp0EQHIMsLRaZ28c1EWGf2V6
         +k/vZ5jR3TbBoq/lq/pn3S959J55/nb7IiBim+XB+4J0A6g5ssBsxCwY9QndCKlTd32C
         /JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Siw6UHCbC9Hh9bQzcdUdc+28jpC1zkZ4CqHNxPMbF/k=;
        b=syBjLQXQotAAnD0kSUBiHsvHcnAEyHk/hgLo8aqBhJ2HPHKScfaxIpbTDRbBJDlFuc
         ufVjCKgw19MMeKoFFWzAZv5CCRIilcSIRkNShuNL4itcDWKZHcKBFH+v362CVPOUg+nU
         S7U2a8msTqBWjMb4kVEo0JRTjjqDru/yg4Z+rXTKH/j+IFewtZw3oUh+Tip622pcQz+q
         QNk7OX2GVhztKdyArh/WGpAcwp1EIaAXnj9QeSyApEzuo4P/C5DQ4OoLYKlNNgD7MXmU
         MIRXRtZRu0fFpsi9zoQWfN8ZmT8ZjOU6bevDhWDTqZLblLt1tj4Txa7dntisWq1dyVwD
         JGsA==
X-Gm-Message-State: APt69E1mR2Cub1D3jmjoFjaS02nAkIwuiFlt2dLa4PFjHsUOSNoh5glp
        mUjkjNbt2lidjsNKaLOL5/p/QDyV
X-Google-Smtp-Source: ADUXVKK6CgFtNgcABzrFDmVXaRsahQmKCy/vozK22Zpdk9HVAaSNRKNPvXyPe3ZL+gvVAjEgvN0WiA==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr8915162edb.31.1528504557502;
        Fri, 08 Jun 2018 17:35:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:4108:7200:7966:ff62:c7df:1312])
        by smtp.gmail.com with ESMTPSA id t1-v6sm30038462edq.84.2018.06.08.17.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 17:35:56 -0700 (PDT)
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] riscv: split the declaration of __copy_user
Date: Sat,  9 Jun 2018 02:33:51 +0200
Message-Id: <20180609003351.25979-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <mhng-d06d9c63-3188-4e2e-abe6-2f62e3b35d48@palmer-si-x1c4>
References: <mhng-d06d9c63-3188-4e2e-abe6-2f62e3b35d48@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a single __copy_user assembly function to copy memory both from
and to userspace. While this works, it triggers sparse errors because
we're implicitly casting between the kernel and user address spaces by
calling __copy_user.

This patch splits the C declaration into a pair of functions,
__asm_copy_{to,from}_user, that have sane semantics WRT __user. This
split make things fine from sparse's point of view. The assembly
implementation keeps a single definition but add a double ENTRY() for it,
one for __asm_copy_to_user and another one for __asm_copy_from_user.
The result is a spare-safe implementation that pays no performance
or code size penalty.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/riscv/include/asm/uaccess.h | 8 +++++---
 arch/riscv/kernel/riscv_ksyms.c  | 3 ++-
 arch/riscv/lib/uaccess.S         | 6 ++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 14b0b22fb..473cfc84e 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -392,19 +392,21 @@ do {								\
 })
 
 
-extern unsigned long __must_check __copy_user(void __user *to,
+extern unsigned long __must_check __asm_copy_to_user(void __user *to,
+	const void *from, unsigned long n);
+extern unsigned long __must_check __asm_copy_from_user(void *to,
 	const void __user *from, unsigned long n);
 
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __copy_user(to, from, n);
+	return __asm_copy_to_user(to, from, n);
 }
 
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __copy_user(to, from, n);
+	return __asm_copy_from_user(to, from, n);
 }
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index 551734248..f247d6d21 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -13,6 +13,7 @@
  * Assembly functions that may be used (directly or indirectly) by modules
  */
 EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(__copy_user);
+EXPORT_SYMBOL(__asm_copy_to_user);
+EXPORT_SYMBOL(__asm_copy_from_user);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 58fb2877c..f8e6440ca 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -13,7 +13,8 @@ _epc:
 	.previous
 	.endm
 
-ENTRY(__copy_user)
+ENTRY(__asm_copy_to_user)
+ENTRY(__asm_copy_from_user)
 
 	/* Enable access to user memory */
 	li t6, SR_SUM
@@ -63,7 +64,8 @@ ENTRY(__copy_user)
 	addi a0, a0, 1
 	bltu a1, a3, 5b
 	j 3b
-ENDPROC(__copy_user)
+ENDPROC(__asm_copy_to_user)
+ENDPROC(__asm_copy_from_user)
 
 
 ENTRY(__clear_user)
-- 
2.17.1
