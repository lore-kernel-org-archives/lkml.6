Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49EJ1KLbIBjX+ffE/iU6Wpiix1y9n7C4wYGUUNVCH+jPoVRJf79mhAPFW6weQMlJ8lKamUM
ARC-Seal: i=1; a=rsa-sha256; t=1524406405; cv=none;
        d=google.com; s=arc-20160816;
        b=eYyb4wiZJU1kqn58worOHmX//SLvDDox9GRPpbBeICGeVUtKIHuu9uNiK645sTIxGH
         Rr82bdUkSA3ijUF1gETtUSdGHvvaPV/e8H0pquEINMSw9785oKiY0+Qdou23WN6p8JOZ
         IaSQVtjkDA40NfWRZXsY3+qSHrUrX0zseg6I4wbFKxlBdnbMURsp1YYX4b5KdACufQ5H
         Ve5CJqc/n2yjVVMa1b9J5DDXh5S5/OLN2JewdQAzXKiDd0EcmIkhzCbxJgPXf6p+09u1
         UROFkSVZ4PgfUkySdSgjyMhKShnHYfHqMs6oIV+f7s4B5eSudayXPl92DDvnPYLq2c5C
         aRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rGtqrp2d5bZMu0IRUkdJSoOcPczil1MMAC9KqE5BbSg=;
        b=rOSURbfBGKEEZkT8bLwGjb2anCIEX01EErAyN0sD6b1Ty60IN90i/fph5oESLz9/67
         lezrQwt1hBDRR6RKKcTjtaOlDrNULsp5KNiCK20G98V+xTnyu8Gj2B5nfUW5+nPmmqVJ
         OS7f/b5XzdqouubkGfE/jA5209wb+JVmB9DJLtTEMydfsDgOUeUD7s//zf8ob38mH4C/
         IVc2s89rqkpuDUzlXB31NEsBHGkDiKouY2DNyeyh+b2dMlttU/sDT03pF+ykbMTleCNE
         BvpF6dm+SPHC22+zQAHNciOEO9/itLFQ3MeEhHt9U9F2OZ5jW8kY1WNzNcaFWTtE+6hL
         +Xeg==
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
Subject: [PATCH 4.9 58/95] watchdog: f71808e_wdt: Fix WD_EN register read
Date: Sun, 22 Apr 2018 15:53:27 +0200
Message-Id: <20180422135212.796176952@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455198087406463?=
X-GMAIL-MSGID: =?utf-8?q?1598455971272829135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
