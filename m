Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+1HbJtEDKtvi5mqcvE6Aj0BZz9ZgCv3TtNj1A35XIjd8l11lsT+yhqbmoXlOoDlAd96H+M
ARC-Seal: i=1; a=rsa-sha256; t=1524406683; cv=none;
        d=google.com; s=arc-20160816;
        b=astALAHP86rno48v+n/RRS/lJ/64Qf1KIswZGv3vlV7/UotNmxDuxjjyEie9hJW3wQ
         6s4Be3tkf2CM/WA0D/cWjGOAIcnr5XW4jlFtxVoB87jV8aVMdeb8SBK1IVGg5KCM2Ij6
         qGmGN+gwlY+WlSb2eqcMiEs0M4xKF7p89P277oh8KKNPCcBNGTFwNiSZ5kdTiWCUTPCy
         qGxyrFmPedpin51O66QIRFrvZMw+/bNuuldUr5BA+y4KBIM4VcjrUG7K15sWp2cL6pde
         HUjKe0mRDLAGXqPDNR/orjbv5idkFpsGptNdD7/sSzFGG056Hx4boU39MedWi6XzcSYk
         RhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=09baIaYXAnr5gJaLZ/PnuarlOSliItqsDJCOs6oUGdQ=;
        b=gpfM9kRRx9alIK4JHAZbAIsNoE1HijD9uZAhGlCrZdxpzD5jow0ZVgtjbwJXorB7/E
         3X3dEexfS8nF0Y2ErJ+SGyhnHM8r+/dLFK5ojbrnZoRLvzL/2LfoGGJZ+hN+V3V9tuIZ
         lubawiUHg/1mNywaFihUwVXdLQJjyvHtuwmidhiORcherPcJOUwuxQu+8yIEzeDgp7SX
         9/g283KpfJnn10S0JQOXNbJoNEGv+TyNUtfHtPlF/I/018IQmvlTHS/RIVBlhp+MYVMf
         YjAn3YDevp6locNb+LTUC9JSUMYn4BktmP7sCQSkd5AaZiaKrDmbnLead8FqDnXlGNdk
         B/Xg==
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
Subject: [PATCH 4.4 64/97] watchdog: f71808e_wdt: Fix WD_EN register read
Date: Sun, 22 Apr 2018 15:53:42 +0200
Message-Id: <20180422135308.788149774@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455198087406463?=
X-GMAIL-MSGID: =?utf-8?q?1598456263248704139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -450,7 +450,7 @@ static bool watchdog_is_running(void)
 
 	is_running = (superio_inb(watchdog.sioaddr, SIO_REG_ENABLE) & BIT(0))
 		&& (superio_inb(watchdog.sioaddr, F71808FG_REG_WDT_CONF)
-			& F71808FG_FLAG_WD_EN);
+			& BIT(F71808FG_FLAG_WD_EN));
 
 	superio_exit(watchdog.sioaddr);
 
