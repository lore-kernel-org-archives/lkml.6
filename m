Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELsQOGvFL6lp4LO5viweZwnzWtlXssM6nkIluBooFgTY6vwMh/yftWMVnAWu4N4Qu53KBGmG
ARC-Seal: i=1; a=rsa-sha256; t=1522128625; cv=none;
        d=google.com; s=arc-20160816;
        b=GxAvk2WFnk092Xb4tjXp8i/utPi4GD0nTM7Z0EH78wFW7Lvn7oYX98sPCS7AKVV96K
         6rJHlIARjYCfyLt/YhY6TQCZ1PHxQNzzUksQ+K4w11uHceGjgDh7uw4j1b9Z66eGghlS
         dqLvL95EegJrjCiepu5ZLOBIPZ7SwcjkRRBYZTZXemKjYtJC8zG8k4nR5dNzfBp4JEmQ
         AuLC+tLJ8zz0iPqBIGHmL23LKM0Y2WWLZwJvu4+kg3WiExuOf5//ZzZtpQccKV+iLAX6
         Y3zZIaqqozC+dXZt1ubsjiSYY17ryXq5G0n7EtJPxo13AKy3aCWrBgI0KQgqEVkfYbP0
         A/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=CJKNAks6CUvPLpPMuNPkql9N1J3NIbKvOlothThoRbk=;
        b=Gqnj1j0jxyRlIlRJQ35xNiWqi9dvdmmfv1pDOL7fHRwqKPLoxBKnw6fkJoNf/Blbuc
         ePEYD3pT6+bnIm3ySWLLICOsVqrb9JhBrGXbNZCystA4h03leE01S1jy1iiAsghlogM0
         phcJJate3YdPBOavhAHa8KfnYaLPIs4khlcD0cl43N8TD3M5LdgJL4utiJssSDF8FvQC
         UO2atVR7wgL7iJv5uNZsMILKTwvwt5k88F6o7gyGsyxvAjTuNEaCbm7tIpp2e3Lddf/n
         zc7PcYISFH1bb0ZvOSurHiKMeD+2yAuLG9OIOiHJSj2BOR3er5o8AUZvW1UxwG9HNJHo
         jG1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=ELYMf9z3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=ELYMf9z3;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaM3011947
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
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH v2 18/21] gcc-plugins: move GCC version check for PowerPC to Kconfig
Date: Tue, 27 Mar 2018 14:29:32 +0900
Message-Id: <1522128575-5326-19-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545737829576?=
X-GMAIL-MSGID: =?utf-8?q?1596067545737829576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For PowerPC, GCC 5.2 is the requirement for GCC plugins.  Move the
version check to Kconfig so that the GCC plugin menus will be hidden
if an older compiler is in use.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---

Changes in v2: None

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
