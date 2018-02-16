Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226IgL1gkfS5lOZFIIQO5VgxBuxuNfdRqqVSYXVoLIruiR6sGwVBBOZ6S66kAre8BGOR0Hjb
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=e8yBBeSHDZAdCk0ompp4p8eZjcgdfg+3AL3OAdLeNzFwuorOz8LiNcCDYH4WDa3z70
         jYQObHdYUVeeHtyf5jH32f5YbMBfhclNAIBPxJuGXILlOxNBLqvuj6DlfoyVRtZSgtZK
         kzlAkRMx+ZVfhapLz/GXFfcoC5QL7A3wj70LEsALfUVNpciF5tC2Wv7cCBsfgZ/Nd9X/
         Je4kVMY9OiwXdXK2JVnTXzCEk66WmhDqC0a8DyiQiHpN85Qc07JZDKzdrYmuYJexOibl
         nHiVwf4tPJ4943jhtzkiE2tC+eA+5b1DPELRerGDpTNNh0dMwUVeST4Jbw4Tcm2P2NkL
         cJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=G5hsOF43iRoT1pN7d/9mibt7V26nz0plYRyEv44rmrM=;
        b=kXRWB/r3yacvuAFnVOfXmiDtoBMslq+v4y520+64prL4B0JXBbUQX58C/1b5HEj/Qu
         NWgXEzuPCtlJCOOnsLi67TTOxq7KHue2HD9FMazXCvlu/oXJZrH4LD7/4zSMSYaElxgq
         e1jgrxLcoBQoipMKEl88jLLdgJ6FxYQtmJEoxWARfZNrnIA8WHtKdgHUcZBNyd02n5CS
         PMrvvv1x/DW5e5qQ3gO1uy31RaPpXwFxnuTGkg5bbn3A+Kz/PxfBPxz5NGNZtelWt2uv
         YN/NoR8LngezIlRynf1T0Wrd8YzdGeobTfc4oK2U7aONoioOPxSSmoBUAiD7ws70tofC
         9p1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=2QEWDR4H;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=2QEWDR4H;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTC013418
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/23] kconfig: add 'cc-option' macro
Date: Sat, 17 Feb 2018 03:38:37 +0900
Message-Id: <1518806331-7101-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935641236197?=
X-GMAIL-MSGID: =?utf-8?q?1592583935641236197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will be the most frequently used macro.  It evaluates to 'y' if
the given argument is supported by the compiler, or 'n' otherwise.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 init/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index b4814e6..f026a62 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -8,6 +8,10 @@ config DEFCONFIG_LIST
 	default ARCH_DEFCONFIG
 	default "arch/$ARCH/defconfig"
 
+config cc-option
+	string
+	macro $(shell $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
