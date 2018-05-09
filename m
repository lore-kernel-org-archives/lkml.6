Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZrIp2Kjk541ML+NqeA5AT3XfBpwmxUHjbsywKcErY56WlxCTpN/3wbZ4ox/yMjTdgo+XCY9
ARC-Seal: i=1; a=rsa-sha256; t=1525852030; cv=none;
        d=google.com; s=arc-20160816;
        b=JPcEOpOkeEwnpUvjYpkwxlSCN6AydZUOnW00BXrqCBHuoSRXsRv7tZL5awvJFIui2H
         ChNv/mbJKSJk2lfHyJWBWr8vYRBYG9qJpISWR9OwUk/HNj/5R1fUiaacKQhy/efiI5RT
         1/kQfYL8lfgQVQW7B0mJ1uf16ftR7htvWmWCs7/RLFHxgSd0DCsjK/HdNBfZ2VWpf8t3
         vfRj6SNf6E5UExJUaq1a12HaX/7e/k+KxoG8Z3t9Lrm1pgni+tlY861ouiX9+DD0ofAc
         j66icPgfapGXv7UXVBBoJn7X5Lnpnf3hjGSz6qf3rUvPUxY8oyQerteY5pus5/GL7bGQ
         2qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=RX3a3UJOmmfU0tNe4WQ9FVqyg7+w8LLTEkZrC3ohPA8=;
        b=BwP1IzPnGEuv0JzKoTnBdkkUI4aYkBpFUZjdkvF9yuZAYgLK3RFmoRqQ2KEOzAt8B8
         6kHlBGpLHWveKAmBTyLeLOk4omLT2OS5Q3jjl77sVtm+R1CTMnz7yshksvsrU+YNx0LO
         ItCozIJixDr5X9pC+CKXct8Pp4kSWe8P6op17bXekPEV4j3fbHA2Z1jxjzkpqN8zxePl
         WHgSFhCeYQtKDtauzMEtC999NAGK6hg/wjWhFIxBEK99KecVr8MHmJJXYq/G5jWX5ENj
         x70C94//WyvA6tN3p1KaYunlmS+jixpdk1eqU99/eu+69AQ+8L/nI4WHjM0iJ/G5RKr5
         fL9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=We4LOKnp;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=We4LOKnp;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w497kc53022551
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Steve Capper <steve.capper@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:46:26 +0900
Message-Id: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599971818353626759?=
X-GMAIL-MSGID: =?utf-8?q?1599971818353626759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for ARM64-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0221aca..605d1b6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -34,25 +34,25 @@ jiffies = jiffies_64;
 	 *    4 KB (see related ASSERT() below)		\
 	 */						\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;	\
+	__hyp_idmap_text_start = .;			\
 	*(.hyp.idmap.text)				\
-	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;	\
-	VMLINUX_SYMBOL(__hyp_text_start) = .;		\
+	__hyp_idmap_text_end = .;			\
+	__hyp_text_start = .;				\
 	*(.hyp.text)					\
-	VMLINUX_SYMBOL(__hyp_text_end) = .;
+	__hyp_text_end = .;
 
 #define IDMAP_TEXT					\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__idmap_text_start) = .;		\
+	__idmap_text_start = .;				\
 	*(.idmap.text)					\
-	VMLINUX_SYMBOL(__idmap_text_end) = .;
+	__idmap_text_end = .;
 
 #ifdef CONFIG_HIBERNATION
 #define HIBERNATE_TEXT					\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__hibernate_exit_text_start) = .;\
+	__hibernate_exit_text_start = .;		\
 	*(.hibernate_exit.text)				\
-	VMLINUX_SYMBOL(__hibernate_exit_text_end) = .;
+	__hibernate_exit_text_end = .;
 #else
 #define HIBERNATE_TEXT
 #endif
@@ -60,10 +60,10 @@ jiffies = jiffies_64;
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define TRAMP_TEXT					\
 	. = ALIGN(PAGE_SIZE);				\
-	VMLINUX_SYMBOL(__entry_tramp_text_start) = .;	\
+	__entry_tramp_text_start = .;			\
 	*(.entry.tramp.text)				\
 	. = ALIGN(PAGE_SIZE);				\
-	VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
+	__entry_tramp_text_end = .;
 #else
 #define TRAMP_TEXT
 #endif
-- 
2.7.4
