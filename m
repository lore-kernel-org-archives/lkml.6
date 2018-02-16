Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224+Ex7gQnkk7giuuYirWwaaUZ4m8A68zJHxLhdMtnNcUD0qXkdJFlls+0huYQthtrxEfRq7
ARC-Seal: i=1; a=rsa-sha256; t=1518806425; cv=none;
        d=google.com; s=arc-20160816;
        b=p2sjpiDyD0szDRGCD2B0LmKTxdNJ3YIDnSz3CQBIQ1WzAQHirZwJzSLSk3TanZCYjA
         T87p1HI5dRF7s6jlWMDuf50Xg+9HY5oA0Q0MBkVjkEoy/umhFe5CG6GDeMbVSouudMon
         /fiF+l6fOWSzvJWM8ksmWEf6OAjQ9Y9upUo6uIcK3wZAVcgqbVpkzzYsGfQpVbRBApVh
         hgs+7ulzZvVXOn6uDpaDsLXqAO5zfV+AiJO+PnOIbGT/kRyJ6hjS9eo8XjyARUNiZcmb
         caYLR3RF5wPoepFWTs0cwW8z6uumiDSqpOMte+rmkEXPrWuCIXuCNRXkvEE49+1MHTBe
         tjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=3HaRTIPTfu2Ud13Hd7mnMb61C3Dpjxmhm9k9d1jW2xQ=;
        b=p+84ehUtVqpHUveU1edT6a0PXw6daL2Vkz14jKA7xZPrPMB/GLwD7dqrrNCZuKfLE6
         Q9vsDPHRbmO3MPLve9id3F45bBZgCbC3njUQQW3bTqx9MGoRwCDFn21ciAC6Fo5BnU4S
         fMTQNlvxyYLtnNYriowV2XAbo23ddrBdHYUCMh1dUiKbOUmThd74+CyQ9hnzAwDOBg4i
         iZfGGmpPfvUiFxqTCFaUNrZgZmr7gOa4dQHv9TkTZ55wVuR0aThiUzopUxzsLGdyOKRb
         JXmWrV9vSFF6ZTqFUhZxmlsB5hbD/Gqum2zMfmwYCIsl+ZsLD0TSjx2uQow1xuz0OFtf
         VlWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=cE5poFrQ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=cE5poFrQ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTO013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        kernel-hardening@lists.openwall.com, linuxppc-dev@lists.ozlabs.org,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH 21/23] gcc-plugins: move GCC version check for PowerPC to Kconfig
Date: Sat, 17 Feb 2018 03:38:49 +0900
Message-Id: <1518806331-7101-22-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583966587160567?=
X-GMAIL-MSGID: =?utf-8?q?1592583966587160567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For PowerPC, GCC 5.2 is the requirement for GCC plugins.  Move the
version check to Kconfig, and remove the ugly checker.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/Kconfig         | 2 +-
 scripts/Makefile.gcc-plugins | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd..b8474c2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -195,7 +195,7 @@ config PPC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_GCC_PLUGINS
+	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200
 	select HAVE_GENERIC_GUP
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IDE
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index b0f9108..25da4c0 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -56,14 +56,6 @@ gcc-plugins-check: FORCE
 ifdef CONFIG_GCC_PLUGINS
   ifeq ($(PLUGINCC),)
     ifneq ($(GCC_PLUGINS_CFLAGS),)
-      # Various gccs between 4.5 and 5.1 have bugs on powerpc due to missing
-      # header files. gcc <= 4.6 doesn't work at all, gccs from 4.8 to 5.1 have
-      # issues with 64-bit targets.
-      ifeq ($(ARCH),powerpc)
-        ifeq ($(call cc-ifversion, -le, 0501, y), y)
-	  @echo "Cannot use CONFIG_GCC_PLUGINS: plugin support on gcc <= 5.1 is buggy on powerpc, please upgrade to gcc 5.2 or newer" >&2 && exit 1
-        endif
-      endif
       $(Q)$(srctree)/scripts/gcc-plugin.sh --show-error $(HOSTCXX) $(CC) || true
       @echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
     endif
-- 
2.7.4
