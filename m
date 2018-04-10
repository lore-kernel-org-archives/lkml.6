Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx4+lEDzCoojAk3r7MqXxOjx8X+elQbccWLlWnggA28h4jPD/IJF+JKBsgTPXms6X4773Zf/l
ARC-Seal: i=1; a=rsa-sha256; t=1523366515; cv=none;
        d=google.com; s=arc-20160816;
        b=sjhhLihp6l3icPsNS27SkFXhbqQvjzQH1bDhZt/mW+XG535RcrXCGYhlH1YI01Mfok
         DkZzij+Vjq0dAcZWdAuJ6SLwTJfZlUUXj/PoFzH8PYR8va52QPT748p89U9aYp2aPdNE
         StiS3qKL+gOhogEqaTEW796TsTWIrIMsckPJJDt2dUZ6n4urp1OVQRiWwLZiMPgDTuTl
         bhzqs3xfsTB75O+oEqry5lM9QezLvj6evc03eKe6Oji1ZkohNekA901yJoBhNdayVcwB
         9MQGlxYxT/CP/38Dum3EFz97KzmvS6hyK1ZLeHC+xB+/ocQiIwUw8oRSMCgFS/JMY+PR
         hOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3aZrGtGCdSB5uaA0uN3hkmsms0M+GKdZM5X3yoh7ZJ4=;
        b=nYNn66OtAYjj0vy79HIX9Du0nIBexsciyz7CgT2T5mo7OE0NjcWGsjiSonTxHhIT/S
         wVSzNRNxoSh71wNGLEQNJzzP7vyFkasFotBbhU/BDiTi8shqQYEqPRi0gohpjNiMRZfb
         rreKgC/9JZYSZ/NWUT7ylw0x07lRmV4CyVzu1mxcicK7YV+O5eysm4aeabQFv+MZVdwO
         OlTNegXC3OMwr0DtSo6Ot1dXnuitj7UhWbNwK8qxsKmJF8Jox7x66VO4lCLQ0dxhg3sh
         4HhoVEY527JuspyAXthdMjov4WVcVMXfrCAf92NwEiQw6K5q/3ThQlnbemEDPpTQWb6k
         pjxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/4] ARM: amba: Fix wrong indentation in driver_override_store()
Date: Tue, 10 Apr 2018 15:21:46 +0200
Message-Id: <1523366506-19832-5-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567255608617?=
X-GMAIL-MSGID: =?utf-8?q?1597365567255608617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Indentation is one TAB and 7 spaces instead of 2 TABs.

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/amba/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 4a3ac31c07d0ee49..842314a439fdd4eb 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -101,8 +101,8 @@ static ssize_t driver_override_store(struct device *_dev,
 	if (strlen(driver_override)) {
 		dev->driver_override = driver_override;
 	} else {
-	       kfree(driver_override);
-	       dev->driver_override = NULL;
+		kfree(driver_override);
+		dev->driver_override = NULL;
 	}
 	device_unlock(_dev);
 
-- 
2.7.4
