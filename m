Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/XViP+ani9bNjSdGPwnFIVewrbP4jtPWLKjAL/b2/9pvd79A2X/bdr3OsAuOw9g/gVVRew
ARC-Seal: i=1; a=rsa-sha256; t=1524406197; cv=none;
        d=google.com; s=arc-20160816;
        b=Rc9HqnUDjei0F6yiGPosk69vKJ8DePhY6f4BYcLuxIQ2T+DzApwgxx6Vp1sKOBhbLI
         +GJdPQWXYXp4wA1pNbA1rFQn0nFwoI4ODAfdtNoPz1YnHv0UEUzGX9lI0Knyg8YxvYCU
         dv3W3xrrbGh27mdiyPl1fc6KXcCftUSUGelkUImb96ZP8B9PO0G4HOZsCS8ZfK/uy7h9
         gqUTBxJVpNqDWBYF1gBkvSyGbLrn6enp1j2apyyJBlmUeGoPR6NFRIf85MEkxkrAlg9i
         QHQWaoi9GLnnssD42zvP620gNJGkURZ0Uq1gaMpWAo5vWBOl5+wvYaCrlhiariduBO0z
         Hw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wq+rqa9fnwGJRRqOPUD8pu14fkCpk+C/X/tJU9kcc14=;
        b=QmQfDjXC3wGT5DbciF9No4jY5Lv7gS7aJmDjfnSYjiL2U3PU6vG1cUULJ31l9nx9yZ
         CNbUK2jnlKf/IH4OO2ex9Jhi4nPdTbl1fquCL0LVcCIe41Mj8BKnP9Qf61jNsrX0POM8
         nMSpPgNEfOFtgU7fjpx3P0s4yqtQvxGaMmp84/c8VDsRjMfHK9GqLBoetdzZOwlPn9Zw
         hn5LNUVyeMfiYoU5VWw5TSSqqQEF9IGHIWA8zphyRj0M2AR8W1B23O5KdKl2hFI51Qot
         R+9WD3k3HUqrCJOjy4bD9WplNgTRh/rsdMbRHvrx/nSux/DcovvimoZf5HgEYhtcvbg7
         CN8Q==
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
Subject: [PATCH 4.14 113/164] watchdog: f71808e_wdt: Fix WD_EN register read
Date: Sun, 22 Apr 2018 15:53:00 +0200
Message-Id: <20180422135140.044262653@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455198087406463?=
X-GMAIL-MSGID: =?utf-8?q?1598455752861506566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
