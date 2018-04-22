Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48YtuC1hoLhThVlTsOeedkjcSzQdU3rGJCLvzw5XqEEjyYC836W5BSwWQUpOqTYGjI4p3zA
ARC-Seal: i=1; a=rsa-sha256; t=1524405667; cv=none;
        d=google.com; s=arc-20160816;
        b=F596UC/0zFyZDUesZkIc66TdbRCTeBTmcr5FKXMMrv3cQJOxAW7hyZa9971g96Zq6D
         hWLwO5RZQbRcM0tV/NS0n2x2YRMG3oOjO32x3fjwnP9XkSFQ5jIy1rqXGW1rxG8k0ziQ
         bRYMv0FJALzTcHi6Zxr8dl3eLsINtYDfgCsObplxbdc8B87q0B1UEvdlMflbaRD+AGN/
         v93dkon6tPE+MF08sUh4jx/pOrWVd1QhgbpvvIwcr346ZzQkQxk1bk4YawCz1TQlhs9y
         PcEVOw5p21ywEOSiN6hfyrBcceNuyXNjSjxgEFh1WngR9w/UK3QbjFsjuL2Zu7lDlxX3
         cPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aExTl1t5woXD5tGlN6dJIN/TGlJOE7E/KI5HOQ4kVoA=;
        b=1CluaHqNZhN7nJox4ubVt3d4yTQW2LlCwC/XMKcLpwnVcLcYH2cJG//FaTyR1wMuNB
         r0O5sPDB7kFUoaiNzMRbgyJ6ctClf8JjBeWggHFG+4J1FLVR/q+IbrdxIjfrwwjXKmTd
         y+ZoSrmBz1lSi6A+78fiz59bq7eolzPybTpZHj1Fchu2wgs8z3e6ptHhV0qaR2qflBUL
         Sv13BDeQp6BbT3YSPPvcIpcd6laQ+kE7tRVJOw+5yzr52cowMFRfhxOOiGoOM7+YWhaj
         KEVx4PYVCDXATMyPhfVqB9X0NZhdDXc0lDAf18oaXafEE2HbLrCtw2X61pYjReDSY8G+
         RoQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Igor Pylypiv <igor.pylypiv@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.16 149/196] watchdog: f71808e_wdt: Fix WD_EN register read
Date: Sun, 22 Apr 2018 15:52:49 +0200
Message-Id: <20180422135111.941117560@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455198087406463?=
X-GMAIL-MSGID: =?utf-8?q?1598455198087406463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Pylypiv <igor.pylypiv@gmail.com>

commit 977f6f68331f94bb72ad84ee96b7b87ce737d89d upstream.

F71808FG_FLAG_WD_EN defines bit position, not a bitmask

Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/f71808e_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -496,7 +496,7 @@ static bool watchdog_is_running(void)
 
 	is_running = (superio_inb(watchdog.sioaddr, SIO_REG_ENABLE) & BIT(0))
 		&& (superio_inb(watchdog.sioaddr, F71808FG_REG_WDT_CONF)
-			& F71808FG_FLAG_WD_EN);
+			& BIT(F71808FG_FLAG_WD_EN));
 
 	superio_exit(watchdog.sioaddr);
 
