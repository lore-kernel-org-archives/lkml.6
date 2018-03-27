Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELv6ZBHdbck7LnhmSo+qakliGkmOsItx4tR6UtbJTMgxIMBXGPW3ypPYZrlLHzx8FYYqntbP
ARC-Seal: i=1; a=rsa-sha256; t=1522128659; cv=none;
        d=google.com; s=arc-20160816;
        b=ivSz5mDxypOZb036PerPcNFheekllL2I3+lfrAkEJf2Pj5jGsITGfa10DTLJatuQ7m
         +nY3Z/dGAX7Lu8c+i3nnDbJR5l0ij2zpyZ0ICG1wdkLBaP0NOIqwYXkdrNVk4bRQlZMS
         YDMAFzpdIWEAuFnDraCE5LciJM9dqsL7MLBeLgsJOtCLhCUS6DQaf8iGXsZSEvhs+xxw
         6+EQBw+wFTL6Dq9Hn1dicaHSX4ihGgdcrvxMgqHM7fsaX7gKyzk1cwThY1CEJm9lziaa
         duEoiSqaVgoLhfHO5iQGenJJqhPgEueY+n5M37QyJ9aKK1dvaFIbPnIjUYYJd9VrG5+y
         aUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=E9yvcp/H6UoCgWpztkUxVXZwnZ0sa369vAzIJ0+As4M=;
        b=gl8bXUygjza9j5iBxfXvFAiKA2227RS6f4VVXVQZrt33mKLRP56IiEGOY+0vZtZGuK
         vZylNc2U+LCvUFEg11Of0QKW9aA4O8gKuecT9wU14nQ+OlPfjE2Hvr5jHzJ3aVpqFl0r
         ptbuLSQE1zWyIBGO9balEEY+UuQEMuaF72UzLxvu8zse8OAnLeQxhHIeWWYwIa18tzW5
         +qbQH3Czsws44WNvgnFm5e3qbIuuNLtUQpgQGuzyb3ev7tNlx7XfPCGijImiMscjix7j
         pJ+cXpFxe+wzjmKSV4hCx/2rj2QKWdzR9coB3SB91bTSMl2KgRTtH+tQeTZMgPyq+j06
         pt1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Vn1WgzyT;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Vn1WgzyT;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaM6011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 21/21] arm64: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
Date: Tue, 27 Mar 2018 14:29:35 +0900
Message-Id: <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067581246942212?=
X-GMAIL-MSGID: =?utf-8?q?1596067581246942212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This becomes much neater in Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 arch/arm64/Kconfig  | 1 +
 arch/arm64/Makefile | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb..0c97f40 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -43,6 +43,7 @@ config ARM64
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a..7318165 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -57,8 +57,6 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
-KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
-
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.7.4
