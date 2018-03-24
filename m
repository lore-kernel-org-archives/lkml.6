Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521890857; cv=none;
        d=google.com; s=arc-20160816;
        b=LWzZdVJRJdQnKla4r99f4nINHWyC0On3XuTnnCBBBmgFVpcZcuCRAivPltDg156gSI
         jISefhTwFm5E71eqeevBqgacQZny8OopQOrATrkCV2VLdcQ0QvkeMBBE1VM48FNS/K4d
         ANIENz5z8X+J7dB99tUGhnU+Us/qxK+z4MaQkCyYvtI918KubISUOiJFc6acBZwypToD
         725nz1vuAPRV+sqRvoMD1H/omfeNu6Dl+6p9DDF/kQZbmr+NJGUmquBXsbQNva8CKMTK
         XNEpWVDVL1CeGRXZn3nds1M1oNkezvAO1aGTl58H+QTW0uC9t2rbvlHSR1L221YYet6S
         utLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=iZjILLBYCv3JAh08tb+VMuqiCOqZo48JjhUspyQ3Lnc=;
        b=g0bzv9UhpmTckkZU4tLhkYTBTQbVV/uEQe1t3aqqJImgDa7d4OPsUbTc4angWOC+q9
         L1Ea0Y3p+iLLeS+/2G5AQjO/QJMBO41XhxrHMBS/xDXvW7k2fLKBvdUOWdzYs5BjoljA
         KQuAraXKFEDiSDrL7wn5hLVOU7Mn2r5hgVR8GQiKZmcKVFwckxzJOGBXmaRdqSoYnqe8
         yuqgdDbbh4/knp/FRj/WP11/nT3DHV7u2PzNZkdqTjUxilL6Bo4JvQY0Jvj5HZIBa7K0
         2YXaXv4XwZJ0sIUEMPg6589+tads+laWLDlU/4hhYLGjThfJvaFDquIHR17/9w3srmRQ
         yfJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XZUEZ0ay;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XZUEZ0ay;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu7EaBq1Y9wom9uk3B1QTYjAipRKmg0CRq7QtyiFWH7zcGTRnlc4Ld8s02MFdxlXCKuMqMNyg==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>,
	Tomasz Kramkowsk <tk@the-tk.com>
Subject: [PATCH v2 0/4] tty/nozomi: general module cleanup
Date: Sat, 24 Mar 2018 01:27:28 -1000
Message-Id: <20180324112732.29424-1-joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.16.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595776952281826235?=
X-GMAIL-MSGID: =?utf-8?q?1595818227259285843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry, totally screwed up git send-email CC's there; resending
the patchset.

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
