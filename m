Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524609560; cv=none;
        d=google.com; s=arc-20160816;
        b=frNZaMh3koo9UkpKdC9a5VB96A8vAW/e+kRO9smPVVRj9JNrMkq8vaFC54KU3EE/ba
         paPK0iJ99/fGygXMGB5ARIyUiRT/cH4GMx4RZxZdKdi2ogS0pbIWRRg/2T7EfR9TzlUX
         4kVB1/OhRCVfM7ORA4h/2h+REu9oafYuz8ivMNyY/OCm7bYOMMHaHoFO9SuRz5nUvXC5
         wUvs5Koy/Svgh9o5BCc7bO1QeaZSWuHJv3PDfKoKhOcnjojkRZB+SkM4f3Sk4jP2TBgO
         uBqbe84VhhSe15Wbgp5sblCjUzdYtOWiZCT3ysMp1UTPj6MgFZk9gn09qrnpz7aLup4P
         3pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hRbI88s0398+vs/dN8tr4temAb9U7AmbjomqwmNNWys=;
        b=s5qRgakcM7aiV0BA+la8qqmFNxoF/1nOqWyCnm2UCnhycMDU479uzKujad81n8sl+j
         oYM5uTCE2pn7uxCFqhrpqUvQRCtoTD4gOVD8KYeBLBROGs8m9h3qRo2Gwu28gL5YMtGG
         c/JX35Ig0/wC2VTxKHbz5+hP3Zjvsust4tlnf4ZqZs4xOhaxP3soO6ptzkATOwPESLwc
         VMYa6wysnHaA/btaBm9Fk4gvrLSB4jfP85NOi8a0llwsi5UV33hjjc+PfXKy0jCwbghm
         p6ZiBLWyjw59LS4lNrfUzy0USnkOq2gcHSxcdnnspT0iTZgEU0wb8+gHF5pBYMMtfNXd
         zNww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R4jSLKgp;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R4jSLKgp;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoD0Udo8JxYrlbUKHZSgebeRvAS6m55WHKPUiacHbvQF4wBlqdIHz+jmZabgsLcMYnX5/SRQg==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 0/2] tty/nozomi: general module cleanup
Date: Tue, 24 Apr 2018 12:39:13 -1000
Message-Id: <cover.1524606061.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668994395676905?=
X-GMAIL-MSGID: =?utf-8?q?1598668994395676905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The nozomi module has a few sections which could use a bit of cleanup;
both style and clarity could be improved while maintaining equivalent
semantics.

Cleanup messy portions of the module code while preserving existing
behavior by:

 - Replacing constructs like `len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__`
   with `min_t(u32, len__, TMP_BUF_MAX)` and function calls like
   snprintf(tbuf, ..., "%s", ...). with strscpy(tbuf, ..., ...).
 - Correct inconsistently indented lines and extraneous whitespace.

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Jiri Slaby <jslaby@suse.cz>

Joey Pabalinas (2):
  tty/nozomi: cleanup DUMP() macro
  tty/nozomi: fix inconsistent indentation

 drivers/tty/nozomi.c | 100 +++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

-- 
2.17.0.rc1.35.g90bbd502d54fe92035.dirty
