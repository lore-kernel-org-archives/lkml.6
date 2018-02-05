Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MSfv1CKOTe7IZtqTF3TnPgkLtKzZWnf1k/bSIa5XCHQ87hfLZJE0WoXIL5NAV96uZa48f
ARC-Seal: i=1; a=rsa-sha256; t=1517855022; cv=none;
        d=google.com; s=arc-20160816;
        b=V8BagSYXBPspyOTnT5jZ1RvvTUwa37f/qhAz1EvYZr4NnZY/IRTuLT942zszK0/fLK
         OVM/iFMH76sk8jF0SGU/XrGhkjqGucN5Sl0lqzjk9tylBb7yzTNOC+olgf0s7jNTEEF7
         esL4HP7kbZ0dpZmggCG69GslU4YIWHMx3+haFgMGWLUq9Kd0T4RnTDl6LjHJEpGuAvf/
         TwlUd3UmAn5vYAwuEnD6n91fw3pmP+/VuOKWqPMihAyRJHG+ItJahPjEd7jY8am1cUMo
         WLVaPDjrYRb1vp12Uz3p8QomUZO9+TFg1ZKCYpjSH158jyo24iag41lLvoQ+WHELMt6D
         KdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jnPVlb3Jg2P8xebkccNB+kLLEXYOFQWsYBR3Z/m9B94=;
        b=LD7KLCqOwHKkPaONAsaCBpDDfgQzsEzqIqUC6ByQoafGsOKvmzlHQr5CscLswMBwch
         4cFdppj3uM9OBNERfwYaRQ6o9pTSgdOBR4hhNo8mVKQos6A6fUuRJGF2aC5HJgjbReVb
         /fwHTCAN8TBBc+ZtARU8SmbkKceHUF1JCQiynV+V/tKzcZ3Gfn1W3QcUoLoIxxJfdyDk
         XLW75+QezxQT3oKUb5x1WOqsLC/SxkTIMkzsfvYGiV8rfIwlhY5NEiCFp3o3gQnOml4h
         YvyvuGdMjjrpoufa0s/rEZM8bFtmA0HBwgFdOE0Ihg9B54fAYNVVvcNl6XnnV4xV0Mnp
         Zhmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 22/64] auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon,  5 Feb 2018 10:22:41 -0800
Message-Id: <20180205182139.469036276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586348565621781?=
X-GMAIL-MSGID: =?utf-8?q?1591586348565621781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 09c479f7f1fbfaf848e5813996793966cd50be81 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o
see include/linux/module.h for more information

This adds the license as "GPL", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/auxdisplay/img-ascii-lcd.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -443,3 +443,7 @@ static struct platform_driver img_ascii_
 	.remove	= img_ascii_lcd_remove,
 };
 module_platform_driver(img_ascii_lcd_driver);
+
+MODULE_DESCRIPTION("Imagination Technologies ASCII LCD Display");
+MODULE_AUTHOR("Paul Burton <paul.burton@mips.com>");
+MODULE_LICENSE("GPL");
