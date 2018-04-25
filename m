Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524635288; cv=none;
        d=google.com; s=arc-20160816;
        b=d2HoaX2HAxQsLY0Vro0Tg7SFR0RrHNgBgJCFxJpS/8OOjkjXmnztriBpcroD3rjcPa
         aS0HXPg1f4mCwFGvoPv2bqmKfHjeDBDAhGJ13S91pQT7ddq98ETRM43+vVPoopsc9gxx
         FeKPRDkmReGvFH0L60OCOh8maObvrfYSAJ1IABTchPiwLo2xTGrhrtgGZDJG5MXTo5UC
         XRmfVHfwsyCADOb68Zaa9zKkNn/nr05KecbTJjQABB/OEIp7ngFrJGcxC0GADbLAjn8a
         8U6SRWSW7eKvpqF9We5uLXmVCiGv7FCc4T/3wb9bZGNm3K535j+WAM2UKL042354uYfX
         33Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hRbI88s0398+vs/dN8tr4temAb9U7AmbjomqwmNNWys=;
        b=TVcCKL8qIB+gXDCCmSznYiJwlZG1cNuDtHDcKhU/M6vRT4uXYcUhN97g23tsaXug1x
         /1zkgUg4dmau8Dme9vvyEfeAy8mbEFm2ma+tLV+tO4Lsay4qSr/W/sa+D+anEZpMvUZ2
         VU+HUvbRgo7orptZp5173Ula8XFcXYLXk3ii5tQcXl1zY+VtW7Y6MAQuxASgH8LNLUxU
         ezS3C3qE/iEU3sKxVNM9AjLwcYFVJI3BJqRozq9U0XMvL572sql5h3JgjMR5eCdm7O42
         14XU90DEVwfVSYjHm+GrBm2e3d3843yE5rdBz366bBAmaWxq3yS6KTu0hYwETgtG4Q5P
         fbMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lUp4CRf3;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lUp4CRf3;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48osfXSnkOZ7WvPEdkSvm6RLRtNNVTIlqcMOJCTWjuI+LGvB9zckAhpaQ6Wqs83JBcxV6HfAQ==
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 0/2] tty/nozomi: general module cleanup
Date: Tue, 24 Apr 2018 19:48:02 -1000
Message-Id: <cover.1524634929.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.35.g90bbd502d54fe92035.dirty
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668994395676905?=
X-GMAIL-MSGID: =?utf-8?q?1598695971550090410?=
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
