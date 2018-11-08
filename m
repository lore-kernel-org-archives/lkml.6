Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C9620857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxiTHy2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C9620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeKIJFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:05:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40910 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeKIJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:05:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so7927wre.7;
        Thu, 08 Nov 2018 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1hepCnQNsrg9aKtHaOWIVj4YcMJAb35t616uw/Dwv94=;
        b=sxiTHy2pew3eYXbXIjby6lt2MNXPKRmk06t76PkCHa0xAbJXdLbT+NLbGZgxvRTzxm
         pEoKjHnk9l5GjeEg4jkP4MH3YfLOBCNN+GsFVZ5GW6HcJDw2EtG2fHbSDOy573+mhCUk
         +scPpFr0jVIlMqyhfv2hyKmX3mKl+a0TuvpPxsgN9+g3QAuRLn4Xmmqbedw6ElMo0X2s
         CdIuItYG/yQYH79r8qNwRtkRjkd7ee/9ioudTpvd45N1IFTLzoqetvi7tD7KGNS7tKZz
         C1OkzzALkQtiJZvx7QGd89eICo+H9x5Fr7H51SH7NIX7jrgT4xpSmFiG0pBOY2Y2xZuh
         E7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hepCnQNsrg9aKtHaOWIVj4YcMJAb35t616uw/Dwv94=;
        b=PMPqys2XaUFLo0pgsF8qTwkjEPIMucCvgsKHkt0G4Jevs3zf0Ohb5Xv4gClRLLFCot
         CzPky6l6Iz1yTtDZgzXUfcyFVXhNEVkm4J3qhaKXxev1bw9FWtrynoKg0cchO9mNXk3B
         ZHvGl8t/Jh46H3sFELoL2ErF5hixV1gXCKbZBRNwjmEMBhAbWNOsWHkVivwLRIX8gmTi
         oNwAYY9XbuYamE/yaRoicRXlS76wwlc6XxCiX2SK3GDDZbeSe3Gxz4rNjj7VFrKRQmfw
         8JiJiuHRnyM6M9oHaY/8hRO6J+d8OlHqN9ij7zdiKqxHqVu7AxUJobAi+q4yKIMg2be1
         tHdQ==
X-Gm-Message-State: AGRZ1gK/O2IFD+cR66J8g1r1jnxmQ8IBT6QAv7cfGK61j1e8wFnXsNlR
        So0f2uR5jCX6dIvXhAPmM9w=
X-Google-Smtp-Source: AJdET5fxGPCwvo+/ApuPfLdhVZT7EXXHKX4qjHcw30kZGvcD2TIP0ZinFz2PxYMN0oSuuvxIb97mgQ==
X-Received: by 2002:a5d:63cf:: with SMTP id c15-v6mr5990007wrw.221.1541719668943;
        Thu, 08 Nov 2018 15:27:48 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:3cbc:a9ea:9ab8:4b19? (p200300EA8BCFE3003CBCA9EA9AB84B19.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:3cbc:a9ea:9ab8:4b19])
        by smtp.googlemail.com with ESMTPSA id r76-v6sm8210307wmb.21.2018.11.08.15.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 15:27:48 -0800 (PST)
Subject: [PATCH net-next v2 1/2] net: phy: replace PHY_HAS_INTERRUPT with a
 check for config_intr and ack_interrupt
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
References: <a02d084d-291a-dd62-c370-c1a2dec451c7@gmail.com>
Message-ID: <ec5423c0-32d1-b4a4-4908-dd46708dfab9@gmail.com>
Date:   Fri, 9 Nov 2018 00:27:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <a02d084d-291a-dd62-c370-c1a2dec451c7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag PHY_HAS_INTERRUPT is used only here for this small check. I think
using interrupts isn't possible if a driver defines neither
config_intr nor ack_interrupts callback. So we can replace checking
flag PHY_HAS_INTERRUPT with checking for these callbacks.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add helper for the check
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d165a2c82..70895bc3f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2083,6 +2083,11 @@ static void of_set_phy_eee_broken(struct phy_device *phydev)
 	phydev->eee_broken_modes = broken;
 }
 
+static bool phy_drv_supports_irq(struct phy_driver *phydrv)
+{
+	return phydrv->config_intr || phydrv->ack_interrupt;
+}
+
 /**
  * phy_probe - probe and init a PHY device
  * @dev: device to probe and init
@@ -2104,8 +2109,7 @@ static int phy_probe(struct device *dev)
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
 	 */
-	if (!(phydrv->flags & PHY_HAS_INTERRUPT) &&
-	    phy_interrupt_is_valid(phydev))
+	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
 		phydev->irq = PHY_POLL;
 
 	if (phydrv->flags & PHY_IS_INTERNAL)
-- 
2.19.1


