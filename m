Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803743-2-5233097983486569462
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803742; b=PzcjweM4YSLFO5WCHuWj/cN+o+m+myx94xeTA9+FvWXPpRQ
    puNo60chbdeDuOf4QUrBIihWc4xg89a8LT6WA3kFDkkiJvLMZmisAH7rymh8v4ef
    8XifJhU+E9aahko53OsKKgDpNDACjDcD/lRCrGwvi/ecv1Tqt1oHYFVKi8M4LSbr
    lWAPbHXNp7LSlFjRBovbWfQNGdaeCSFtJBkR/bZQyee3PFlS0YbxeFXZ0DFVENgS
    p7HF/PhoIeOZwLlbS4dzTIxsTS/ANf0IYk/zgFsFw93SiwDAIW+5/UpGTgNaUUfG
    /eL6MOCasrfKzovs3RSJHSLwQYKCkOgXUYkIDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803742; bh=2v3/xjMXXUmxKKOAbJ43wZLXCN
    Ds3mNxMzCTPRNR07w=; b=EbLSyTk77GCVjaKrmACWiHJ635ew9mhc22Zzg8Q1+J
    fk2xZv6A/dPTYK52Q4P1VFfODpYkOl+g3ec0/oQlSkAMQGqkOmpOoYaUJ6KBW6Li
    ba9gfpF27MMIxBJ3N6JhGs7SZzB6xjvfOox7CKLRWpNnQjs8BfIcBa+oS8sjIepO
    VXrs2mrBYzWPGiAYddedjct+Bdib2AQrj6PbMSGm8DSeQxf61nPs896TRKLhthqt
    CK/egyPEYoznDvQfPqkKT5hCDz5FuwDmkDmKafGQGKw4qoLAybDlxHY6U8hSeDSl
    vl0nshTwbKLwli0KNrQVGtR3rYbDsLemMBrwCOIKExAw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeCWKJ4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932539AbeCWKJx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam Breck <kernel@networkimprov.net>,
        Tony Lindgren <tony@atomide.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 111/177] power: supply: bq24190_charger: Add disable-reset device-property
Date: Fri, 23 Mar 2018 10:53:59 +0100
Message-Id: <20180323094210.163452732@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 6cf62a3b97e78ba41d31390e59a1ddc98a9e3622 ]

Allow platform-code to disable the reset on probe and suspend/resume
by setting a "disable-reset" boolean device property on the device.

There are several reasons why the platform-code may want to disable
the reset on probe and suspend/resume:

1) Resetting the charger should never be necessary it should always have
sane values programmed. If it is running with invalid values while we
are not running (system turned off or suspended) there is a big problem
as that may lead to overcharging the battery.

2) The reset in suspend() is meant to put the charger back into default
mode, but this is not necessary and not a good idea. If the charger has
been programmed with a higher max charge_current / charge_voltage then
putting it back in default-mode will reset those to the safe power-on
defaults, leading to slower charging, or charging to a lower voltage
(and thus not using the full capacity) while suspended which is
undesirable. Reprogramming the max charge_current / charge_voltage
after the reset will not help here as that will put the charger back
in host mode and start the i2c watchdog if the host then does not do
anything for 40s (iow if we're suspended for more then 40s) the watchdog
expires resetting the device to default-mode, including resetting all
the registers to there safe power-on defaults. So the only way to keep
using custom charge settings while suspending is to keep the charger in
its normal running state with the i2c watchdog disabled. This is fine
as the charger will still automatically switch from constant current
to constant voltage and stop charging when the battery is full.

3) Besides never being necessary resetting the charger also causes
problems on systems where the charge voltage limit is set higher then the
reset value, if this is the case and the charger is reset while charging
and the battery voltage is between the 2 voltages, then about half the
time the charger gets confused and claims to be charging (REG08 contains
0x64) but in reality the charger has decoupled itself from VBUS (Q1 off)
and is drawing 0A from VBUS, leaving the system running from the battery.

This last problem is happening on a GPD-win mini PC with a bq24292i
charger chip combined with a max17047 fuel-gauge and a LiHV battery.
I've checked and TI does not list any errata for the bq24292i which
could explain this (there are no errata at all).

Cc: Liam Breck <kernel@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Liam Breck <kernel@networkimprov.net>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq24190_charger.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -506,6 +506,9 @@ static int bq24190_register_reset(struct
 	int ret, limit = 100;
 	u8 v;
 
+	if (device_property_read_bool(bdi->dev, "disable-reset"))
+		return 0;
+
 	/* Reset the registers */
 	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
 			BQ24190_REG_POC_RESET_MASK,
