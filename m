Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELsyPOdljCxAhTmWKnt74Lsn8mqZHItNcEd9oYsP8MrBhawGB1rkipVg3OBBbrum3Y/Uicfm
ARC-Seal: i=1; a=rsa-sha256; t=1522128647; cv=none;
        d=google.com; s=arc-20160816;
        b=Dw5OnJ70pRHJkL8k0x0QAf0bGbUozE8jWuO1Qe+zmLM6lcc7PhUygCdUm+pyR615iz
         BrLFBVy7Ztnv1AtUY6A4t3tSb53o5SAVCW/CLQSZw4WPaoY+ELTy+dw4dKqkVZL1QkUL
         HRU0uk3tsBtTX8zHpztlmfskDlmutUItjldF+7zmrnQJ6zkV0OfaG3gFglAnDVNIlRAB
         SZyns76F6vKOaSJ+oP3zFuFlxFyfiYpPUE7NRDq4SMBcfiL4xmXy1mts2p946z/Gvm0z
         Gf7Wg/27TOCnGee9UCHZ+5QMG6Yh24N9NaJd3QdZGazIzhIv1v47c6v0aBzAY7HIU8/D
         sb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=pm4buBS4qJN6Q1E4e28WuspeqHQ+lHRth0G3klYbkDo=;
        b=ujywOr3/RSjWDzjwgFo0gOac0ZcH94L+qCf4tyZjWAux1Wx54vZ0rfW231ZB0sf9tu
         WqVWDFw7MAEzQBezXar+gRgYAkSPyp/LwkDDB42GJvjIrE8bn2wux3YKuoIW6RKTRujm
         FELjao8T5edK1sTfmMai7IXF2S0MCA4/ICFmdaXyhiv5wL5KqBXCropEdtSc5pnHuhm3
         r+6DUBZ76vfQ7ClPYt6to/xJwqZb7NyVb8BySc9St1Dedo95pfK+JSLdcSw+eSmkyjVw
         CgAoD73JToWx7HKBonm/nEn+FUUAOvHhr4lG2+s2s/6hXZ5HwzqKszvHkkV95jyNpkVu
         9X4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=LUG7XqQZ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=LUG7XqQZ;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaM5011947
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/21] gcc-plugins: enable GCC_PLUGINS for COMPILE_TEST
Date: Tue, 27 Mar 2018 14:29:34 +0900
Message-Id: <1522128575-5326-21-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067568210936951?=
X-GMAIL-MSGID: =?utf-8?q?1596067568210936951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The plugin availability is checked in Kconfig, so all{yes,mod}config
will not be bothered.  Remove 'depends on !COMPILE_TEST'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Remove more 'depends on'

 arch/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 88cc925..b07094c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -414,7 +414,6 @@ menuconfig GCC_PLUGINS
 	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
 	depends on $(success $srctree/scripts/gcc-plugin.sh $HOSTCXX $CC)
-	depends on !COMPILE_TEST
 	help
 	  GCC plugins are loadable modules that provide extra features to the
 	  compiler. They are useful for runtime instrumentation and static analysis.
@@ -424,7 +423,6 @@ menuconfig GCC_PLUGINS
 config GCC_PLUGIN_CYC_COMPLEXITY
 	bool "Compute the cyclomatic complexity of a function" if EXPERT
 	depends on GCC_PLUGINS
-	depends on !COMPILE_TEST
 	help
 	  The complexity M of a function's control flow graph is defined as:
 	   M = E - N + 2P
@@ -487,7 +485,6 @@ config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-	depends on !COMPILE_TEST
 	help
 	  This option will cause a warning to be printed each time the
 	  structleak plugin finds a variable it thinks needs to be
@@ -527,7 +524,6 @@ config GCC_PLUGIN_RANDSTRUCT
 config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
 	bool "Use cacheline-aware structure randomization"
 	depends on GCC_PLUGIN_RANDSTRUCT
-	depends on !COMPILE_TEST
 	help
 	  If you say Y here, the RANDSTRUCT randomization will make a
 	  best effort at restricting randomization to cacheline-sized
-- 
2.7.4
