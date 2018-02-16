Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x22436MwG4rx8iV0OSuKdl8opyHLPL/hF6JGJrDMg/97NVeI+ua4sJaeZa2Oxbs3FwmOvrF0/
ARC-Seal: i=1; a=rsa-sha256; t=1518806414; cv=none;
        d=google.com; s=arc-20160816;
        b=WtU3lI77HAFjphGWr9zOdTxGQK2XarKph6yW+RivQ3aYwldjL+HjaCWozTtvERcAvs
         yHGO1RSsXHm0OaWixwMQcR9hk8r7D/2y2fsxIB1lDQvHDGaqOhyzBe2NRQVAUX2iw72R
         6ZAkcozgRYBkIqmvlk9nqzw9ubQ0yg4DMlhIc42sa0ae6jp40zDK60SA85t+rvvi2XGl
         75D/qG55qOZwkCjoSjyItxXpp+UZ1V8GSFDxWCX9+3qp0zlxMASxECgPYVXSPz0U4bcW
         VJwK3BuVDhiKu1n7bTojKp8yHCRBZKkuZoQ9onABPvbc8qpnWeqgAmPh5ALYCuiOUNJ2
         pCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=Lau+sX5Xfd97pBT4xPSqZK1OIR5DgA12mp5Ps116g7M=;
        b=xb+Tdo56f7l8VTu+w/5XoQDc0xj0v/IUDSCD/wdDrgDFhiOiHq/5KA4Clmxr6qa2Pv
         G1hvZYzDGG/KRk0voDAJNh9Xvc0qpBcfAoGYtq0rr7MX4F54pT4P6nrdhWKYbzHID5ON
         6KEWSaLXYPwmkjetkx0VT2wtoZCnZvqPWjChCU/3ywGmpdWDOEBnQE7sSzhxWj9ElxU5
         gpTAnHqHQArwHlIHGemaqJkbgFVUAlXtuWdksPdBYoVfUhXLcKZl9QHrhMwEARU6XD90
         jQU/r6UXzN91OJPIgwy7OR/SCHI3ZGvrWltRdHX/EUb4X8qYikL71T0kPP5SMgsho/GB
         SXhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=YxRw0GLl;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=YxRw0GLl;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTQ013418
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
Subject: [PATCH 23/23] gcc-plugins: enable GCC_PLUGINS for COMPILE_TEST
Date: Sat, 17 Feb 2018 03:38:51 +0900
Message-Id: <1518806331-7101-24-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583954792488725?=
X-GMAIL-MSGID: =?utf-8?q?1592583954792488725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The plugin availability is checked in Kconfig, so all{yes,mod}config
will not be bothered.  Remove 'depends on !COMPILE_TEST'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d567bd1..5b5610b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -415,7 +415,6 @@ menuconfig GCC_PLUGINS
 	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
 	depends on CC_HAS_GCC_PLUGINS
-	depends on !COMPILE_TEST
 	help
 	  GCC plugins are loadable modules that provide extra features to the
 	  compiler. They are useful for runtime instrumentation and static analysis.
-- 
2.7.4
