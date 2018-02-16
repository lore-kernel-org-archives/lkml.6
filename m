Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x227MGKf5uxgkoRwJBNNEUifBXS+xoct60pvvCtwq+NDd2ec6DR+LkP6uHRcZeg0kbQrM2B9t
ARC-Seal: i=1; a=rsa-sha256; t=1518817330; cv=none;
        d=google.com; s=arc-20160816;
        b=WsJYIMfsxRetV/lUDed9RzjcG4cahIcTTdIE7hnpZu14lZsmq8YEjA7LSHuBBvs660
         FPzDipaTDxjtUOg9V/kfQ0hvyk6cYLz7TnAR8la7uTufKBF+hn1LH8SbYuBxyXplgYR7
         rjhX4N/hts78egHTNKvy5P7YHzQoOaq2LhYRVPvsubE4iPct+RTqZfL71GxstMvEB7T8
         Uc7VhIpIEKlwKXvFpiY1eo8S2OoNEbMMfKaHFI2kc5n84b50S0GnfbqRysRpxokV0x6w
         82t0DdfgpOAJhkCCqUvT8s80+M39DfLsfhrm4SeOqgsuKZBuEsA22BOyN4u8SN2p3yPS
         lvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DTqi3CMU/ToVfRI+3i475iV1ZutcOqKhVz0BKjGKyhk=;
        b=PztYRey7oN3c1F2QWHollY8aBgb9xOrOcGsURObFfRP5K5fOpJdjw9RdszPLY70IdU
         09a53gPQgHBZX8I9qGj+YnC1t7UDOfykh411d8yq+BJxswd/fTwra/quFQ1yRwyIl0eT
         +7BB0I0zxa5U5o8333y0P08ybTN0MnAJoBAUr7a2ZhILNRjAbMRRH0JV+b3z5pvY+/CB
         bwMI7xWcx+B0SqfxORPLRB0JIvzxBzm1MdKUKRvBQtMYACD6+11gu2kswsdC/Kx81UJk
         vJNCIG4EWFz9vEl3r4Q1yiPfwap+/en5iZ64qPtwGno07DI/s4S/wGy8p3JmxNgI4Y+k
         rS8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.13 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kbuild@vger.kernel.org
Cc: "Yann E . MORIN" <yann.morin.1998@free.fr>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <mmarek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/3] Kconfig: disable PROFILE_ALL_BRANCHES for compile testing
Date: Fri, 16 Feb 2018 22:41:11 +0100
Message-Id: <20180216214117.1947175-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180216214117.1947175-1-arnd@arndb.de>
References: <20180216214117.1947175-1-arnd@arndb.de>
X-Provags-ID: V03:K0:fmoMXGGJlTzOB4cQs/MTrS865pX8OurSmi24tep6rOdajbPcgdl
 LWdXsrFm2Egd/k37n5gWN9yj7PA8OXTaCkEVfusg1X4jL/GzwNJoh/WxyPEKQlKqq9o5rcT
 6/JYHL9FiquWul0Jqko2Tei99pw6biWmHa8oTVIq8GbO16pbBVqKXxRE1XHUMn0RiE34hNQ
 /hpAeUPzD3lezwgulVDpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NanqIWh+AxY=:TIukbxs8gEyxQgGMCF+DbU
 c0hjeb35U1oGhmLHd9dwijue79wIWjwQtYkuyZITKebtR/0Ty7S59J7YIrwnaT0SMO6NNAESX
 KmUkjdY464ry3v23CzpeaeB51irDDxaGATIUTodRY1qxBMAST0IqDdrGu7bqLvKdEz9Fd38fs
 Zr4BJ46eXmtbTFWwQDV1NcvGO/Xec36AWSTsUImYkJjTTK1micjYxoaKfnL69YwHQzROJTnhE
 2R8SHFMitTOlGHWBPEAcnVcUWAsD0nBcLoPu9kIH7F4W2NJfhR/CLTGPtXxhyAHoUDo+ONhUt
 5Bq351b+7tSDBchS6BYATrc2xH6oijz2z5jb5UP79ysGDQfjnbT7ogKkAfCZ2YtXuZYlp88X1
 RkJMWlgZ1eZdgz/MeuJHFDXGTDybONgfmiIz8YBStXERlw50V8MsnfeSwXrg43QK7d3qIWbsH
 M3b1u68kzvZoUYIBzQDTZFkLx5U+HMCAVPYA3WJswEoMYze4f6HBux1RvgTxeVv94KH0x/eyA
 CcGvf951yT9Mt7rbJHoF21UjrRNJjAO6r6hJx+3vyfqxp92JqxpO746htpjijQevrFXkubizT
 cY4nKPnyuirBeHH4dg3+dmu05kq7Cyf1eXEH/XTE4Osy+edEXIXgszGZOUysBj/kwHyywdF95
 zZbRuOnTAi1wyKr2rvInJ4nX8R2SLtWnPWKsio8FVjwMvOMgXbmYm1iZ4NjXh3Tgduz48P4uT
 mA69oZtaGPNAq7m4Ljd3EW9FmJbwWpMEvo98lw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595400950841912?=
X-GMAIL-MSGID: =?utf-8?q?1592595400950841912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This can easily double the time for compiling a driver but does not
provide any benefit for the compile tester, so it's better left disabled.

In addition, any 'inline' function that is not also 'static' and that
contains an 'if' causes a warning like

include/linux/string.h:212:2: note: in expansion of macro 'if'
  if (strscpy(p, q, p_size < q_size ? p_size : q_size) < 0)
  ^~
include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static

without this patch, and I could not come up with a nice fix for that.
In combination with my patch to always enable 'CONFIG_COMPILE_TEST'
during 'randconfig' builds, we can at least hide these warnings for
most users.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 434c840e2d82..faaf687b13b1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -345,6 +345,7 @@ config PROFILE_ANNOTATED_BRANCHES
 config PROFILE_ALL_BRANCHES
 	bool "Profile all if conditionals"
 	select TRACE_BRANCH_PROFILING
+	depends on !COMPILE_TEST
 	help
 	  This tracer profiles all branch conditions. Every if ()
 	  taken in the kernel is recorded whether it hit or miss.
-- 
2.9.0
