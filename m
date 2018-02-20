Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519127944-2-10552331875952408621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127944; b=nQLrw7/DscfW6xBM23FZ9CXuAnH1z99MQusX80TuO970rmh
    AuUDYv9LbxXb6IhIOC1cGRYNrppcUWr0hwq8oRzJGaOvd6sKp5EFZX9O+1i7iLgv
    1nnjKE8iN8vWPvkkSl9PJrkwAKmN4Brh/bhRTJv7QDCNN3Mbsm+u05LbG0Q4ko86
    V5goGWBPWDBI0dw754tdwV+z/rnz2Iq9YjpB4GbwsoolOg9fAlKnbHmQpW4EErr1
    U/VdJf05ASv2rjyXjgJbcdS5rclexqSMyTMVwRc0CypJPAlVDdO5bIL+3YC/yiI2
    ghuqmsLsZO2nezOGjLECbEP/2iW9fseFN2FMfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519127944;
    bh=TsQbhM6llL7bRy/pwFUnSs079+HvHOB8CRLe1iYWtIk=; b=f7RvK9L7Dv3p
    +v/Bpu0pXw7e31tgO3eXMeYd00yaE+lbJZXODOoJzoiqwhSvfUnUrIp30swIktzz
    MJUQvWj4Z22wS5DenY29Sn6tqgA/414Td640hwjFHUoazHzvloN/BDtTRHDS4bV4
    IpZ0zGkeqI5fjSckDKd++44GpQml0te0p4Ul5NwQwJo8SLz/hPg3zJg9pJ2y3Jdx
    0lxHn1+COMzS+YHpFdLhU+MRbowW75OZ5M6jV7XLzfOhP604xZplk4yJYnfJhsWz
    UsIfjlYc3oyhwFYgHsBNzkgXdulLuxP9ig3AUIzLjYubeFylQFcxECi3JOvJmtfA
    DRVK2Ejtzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeBTL6w (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:58:52 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeBTL6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 06:58:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Subject: [4.4-stable 03/22] power: bq27xxx_battery: mark some symbols __maybe_unused
Date: Tue, 20 Feb 2018 12:54:50 +0100
Message-Id: <20180220115527.1806578-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Tq0dvcL5vtituVD2A19RseXktrCZb+tqGpX/7/6gkIfooUZDhNw
 og0Y+yK0FCXpJuKCoj6rbFeHDmGwAlIjHvS+ivfhp/gSJErAHVxPI1Yjz3wrDyPjYbtogzV
 x+rhY9JSBQ/OaC81cXe61eWFHvcgT30Lj67kaLJbksvLZ2pUUfktEz3alVusXnMZ1QClqFg
 dW+vxg7aaeYMtaM9p9Law==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3I55pnsjVAY=:UrBUrNuCs7yMA3NVlmd111
 3dwwJuKU+21l55TaRio460GMOLtAwnvxV0nxmRIV7a2iSg5BpEhH746V3yLlklromNO2HXqwk
 t/eaOm39O+3+i58QBFhHMMRp3Latl5TINBol0DcDFkjjYZf4kY9mbHwSaJicF3VCO3GtqRd5h
 UTfLhBdCn4qfPbS58ZS/XGJKtoUkdWUdWLtYArZMgOQh1bRIqQhUQlP2ndShBtRL6FvssY7Ib
 0OWHUcYH/juNuXPfGQdV2B4p5Z4pHIDE+0kxhhWKae4NcpN+piGspkldKHdrOKL3wYPD3tePd
 8Jnno8PtOWNp0z/AE8UxpD32KQ2QMda7IvnNvtjm/3rHRtEuvt45Pd3sFtLD+8FL6bldnoeeu
 Fd+tCxylfef8hcR5zhpB6NLSkh/gtOXX7ozl9Vx7OlyN2g6/nMT0uSknH76CA7BjPb2Tgxrh5
 raLJGcJxQYu00iJd2HngA6OXfO9iBNfNp5DonydaXMg4aCNFv5d1hkFRSJybwDBCui0RexT2n
 SwKRk3j6AQ3I/aeeLYkHE+YHNZ8eDLqi5ddM6hTYFh7KpYpIeKUMk7fagp3B48VZrLEZdwpCn
 4rMS3m6c/2ONoApOz0F61oEPitMJYDaNZ3CLSbwtjRDvFXrFkK8en79BBGi5dYzXdA4VvOkrd
 LkZGfEaA+Au8+6RLoE31D9HK0sSgE9ZSPP4+HfxjZHCy9uvIiJC5POql1p5yT34n8bCNjNTCj
 ZqYteusBj4VsIEnMa38ZE+vU7tBJSduJctj7+w==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/power/bq27xxx_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 880233ce9343..6c3a447f378b 100644
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
@@ -991,7 +991,7 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	schedule_delayed_work(&di->work, 0);
 }
 
-static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
+static int __maybe_unused bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
 				    const char *name)
 {
 	int ret;
@@ -1026,7 +1026,7 @@ static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
 	return 0;
 }
 
-static void bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
+static void __maybe_unused bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
 {
 	/*
 	 * power_supply_unregister call bq27xxx_battery_get_property which
-- 
2.9.0
