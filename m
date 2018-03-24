Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521851494; cv=none;
        d=google.com; s=arc-20160816;
        b=KWoMb6Mn6GLgdEjAji+rVdyL9VsNUcthpmMrIdRdTvOUwj5dq+jsN9KLPdWq+AfxiC
         ZjeHeQBzqbWCw7iKa+HXvVT1OwrkxHRPQ4ynnHfyE3Hozb04yeGpJL/uyI9eNhh78N8B
         UiIx/ZXGylxQd1os7pH3S9yyXohF39h6bpsQhp7O8QN/DqjpkY2GsTsG6DTjH2cMiS+r
         Crj7sUeGllmWVPCImY8xPUsLeATngCbPLsvSmLjx2EFkCcPAr5KnbBVUgr+MOFyMfwUk
         jW/d1zwBUXuJdeQakhiZ9Z4GbcWwvVG4SYKuz0ZX7lE07m3mhcxfGwKXgv/J4Zes/6gd
         Lgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=JyCEgzCvNUfWMpZlp+snDKCa4ZcXShjthbWsBzwewYw=;
        b=aagsRJZvxdaR2sqlhw1IkW4AUj0tKturB9XMDGmbGKPhKbkcXWLdwjyPXYiAIX8d2+
         NvgTZLGZYN1Sqp4/9gLc91juWPnI/vg6fuPWP4G8B8dj0V+idOZqv3Kq5H1XLbKI5ISZ
         vIfNDBGxUHEivkd1FtW6i0eudAsXVRF/uZQZUjsvJXaobN62WuLSBRYD+Ay08TR18TUJ
         nT0c3dZXbdYRT4D7MhQSiUODP+0O7BtSCwR0OD5n6Ti4Tf7c1b8yOgQ7SH+GnYso3hNB
         6oTuZGsx5TL/LwiGyxLIpCZYIM7zb6VXth7XRDhGBjcgqT+/p5omIgeXL/GS9NDkxDyR
         XxQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CT5CPoZz;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CT5CPoZz;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu2o5X/E7iNV+IuqcZ+i2qG12r6xv1dFTHJnTPjinSGG5525sUF8TSa2mwnwF/aFIvo3ZUK6w==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>,
	Tomasz Kramkowsk <tk@the-tk.com>
Subject: [PATCH 0/4] tty/nozomi: general module cleanup
Date: Fri, 23 Mar 2018 14:31:23 -1000
Message-Id: <20180324003127.4287-1-joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595776952281826235?=
X-GMAIL-MSGID: =?utf-8?q?1595776952281826235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The nozomi module code has a fair amount of sections which could
use a bit of improvement; both style and clarity could be improved
while maintaining equivalent semantics.

Cleanup messy portions of the module code while preserving existing
behavior by:

 - Replacing constructs like `len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__`
   with `min_t(u32, len__, TMP_BUF_MAX)` and function calls like
   snprintf(tbuf, ..., "%s", ...). with strscpy(tbuf, ..., ...).
 - Rename identifiers more descriptively (where appropriate).
 - Simplify deeply nested conditionals by replacing them with shallower
   (but semantically equivalent) logic.
 - Coalesce return paths / loop conditionals.
 - Remove pointless initializations and redundant parentheses/break
   statements.
 - Correct inconsistently indented lines and extraneous whitespace.

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Jiri Slaby <jslaby@suse.cz>
CC: Tomasz Kramkowsk <tk@the-tk.com>

Joey Pabalinas (4):
  tty/nozomi: cleanup DUMP() macro
  tty/nozomi: fix inconsistent indentation
  tty/nozomi: improve code readability and style
  tty/nozomi: refactor conditional statements

 drivers/tty/nozomi.c | 362 +++++++++++++++++++++++++--------------------------
 1 file changed, 181 insertions(+), 181 deletions(-)

-- 
2.16.3
