Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225vnvCDJJ5vYRjfpIzY5WRxUo6ri8FUbDJtw/eh8i+ujz2VZ5/3N3b5zkpoYYa9uBmZhPGv
ARC-Seal: i=1; a=rsa-sha256; t=1519411188; cv=none;
        d=google.com; s=arc-20160816;
        b=xX07c0Ihp4XF+JyPJLWtKIB/J6d/iQrDJXA+Ou/TrKhbuI8IKEawA2uiFV4V9RWuJn
         34gv1Vo0OsjM7nFkIHZa0mt5lhUjETuQthr1V2GdM1VLAJNnfa30X80sUDiFpTnaK+Jm
         kbv13nPF5tcpUuvaJ5rAtceMr4PdIIUYqQskDbRJUhbT8NJZ9XW39w8j0GxXPFI+UmK+
         GLsvNXt8+DxoMSPpvjEV4UDqy4I4DHw30woZsst/MBR1jqNTJN7RzSlfQEgPL18f2Mai
         c/aCU0ayPSREkJaKbNa2n0L5qsGOpX7mjkZu3eMl5ogt2Ikh8OnL7GJuWf2/wEQ+ozqv
         a+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o85u9QsjRI9naKUhDN5ZwS4H4+p4pPG6FW3DFqgoZpI=;
        b=wes86Ngzws+kV0GvldI5I036zOq/7BGgTzbpK5mWH+5MkGqESnXCykrB56eOCYjc1l
         uAeOyQSkiR2YtX1ekwS/H433eMpdHO7lqs4y4jyjSMr8LSqZt1l8LxdmJZL5n3bvMH74
         5v3FPFzPdJvpa9V0v15L5yllFbKxuau+oDwRDbB6B7l+UMf54Or9FgqH/UVI/dEMjbC/
         LnAAEhh0+fb6PXcKXIycO1WmKOBIu2uopvH7qXCJt8KKWqmp71qT9xbKh7vplSQR298O
         q8A6noFER5KdiePIyl1aUa7HhkmAzfsBe5j+LhxZlPuuZEz7mvi+xqFjdhoM1hmP8Nc/
         tWew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 150/193] power: bq27xxx_battery: mark some symbols __maybe_unused
Date: Fri, 23 Feb 2018 19:26:23 +0100
Message-Id: <20180223170349.449642834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218106636561784?=
X-GMAIL-MSGID: =?utf-8?q?1593218106636561784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

Without the I2C driver, we get a few warnings:

drivers/power/bq27xxx_battery.c:288:12: error: 'bq27xxx_regs' defined but not used [-Werror=unused-variable]
 static u8 *bq27xxx_regs[] = {
            ^
drivers/power/bq27xxx_battery.c:994:12: error: 'bq27xxx_powersupply_init' defined but not used [-Werror=unused-function]
 static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
            ^
drivers/power/bq27xxx_battery.c:1029:13: error: 'bq27xxx_powersupply_unregister' defined but not used [-Werror=unused-function]
 static void bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
             ^

In mainline kernels, this was addressed by a larger rework in 703df6c09795 ("power:
bq27xxx_battery: Reorganize I2C into a module"). We probably don't want this backported
into stable kernels, so instead let's shut up the warnings by marking the symbols
as __maybe_unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/bq27xxx_battery.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -285,7 +285,7 @@ static u8 bq27421_regs[] = {
 	0x18,	/* AP		*/
 };
 
-static u8 *bq27xxx_regs[] = {
+static u8 *bq27xxx_regs[] __maybe_unused = {
 	[BQ27000] = bq27000_regs,
 	[BQ27010] = bq27010_regs,
 	[BQ27500] = bq27500_regs,
@@ -991,7 +991,7 @@ static void bq27xxx_external_power_chang
 	schedule_delayed_work(&di->work, 0);
 }
 
-static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
+static int __maybe_unused bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
 				    const char *name)
 {
 	int ret;
@@ -1026,7 +1026,7 @@ static int bq27xxx_powersupply_init(stru
 	return 0;
 }
 
-static void bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
+static void __maybe_unused bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
 {
 	/*
 	 * power_supply_unregister call bq27xxx_battery_get_property which
