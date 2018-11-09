Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6537CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2716720818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqx7TaJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2716720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeKJC7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:59:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46781 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:59:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so2662289wrb.13;
        Fri, 09 Nov 2018 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LmbqCAt3QEZD2DS8H4d++PSKqoBu8Rx42ipbGvjFVfA=;
        b=Cqx7TaJlD19Qjmw5q43FvEOE/g9oqb0PFC+AeffJJOi2HPAxiW//P6vXbosdhGO58g
         545GLR/cbPWwLWMaBA8up1rowP+7tKiLlu8qu/t9xLscXY/eBqDea2uw5QQ0Y/Kj1nth
         vMfnUr3y1stv52A8+YuIJyuSHlAfNftOf2OwFQrvI4R3slAn4YuDF4lQjnCfEdQf2xk2
         msHWonzm2MnZloNVl2Go+4QEh0+2zthkclKlKLprLIXxVF6U1UHmleYqIlipGLM1h+Ba
         xIC8kNgzmzYGV7djd16obIMbjxcEof5cZFK4avstzX2ppYgj1e9hmalvNqVu68Oc4PFv
         gKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LmbqCAt3QEZD2DS8H4d++PSKqoBu8Rx42ipbGvjFVfA=;
        b=Kc/+2aumdnxVDbLQOFnqC9c5uZuD1lycj/sp47bQOkC1Aar2ReZ8FAwxHbZVojXooW
         smGXC4Api10andTFdSy6ojvUqTMV3YVMWC2Eu2nZV3oBfUgADujwEXEKP2h72+/2SrSn
         K8qoNRK4Xf9xC8fUIezeluIsbPP9+mcm9XTvQ3QEUH1WxPOK0rJHkBoBU6TZEB/IAaEo
         Msfz8FfZsbGk2/pIaJbeUPruuFdYo2myIsegq46GkAkOYDxyeRvQhAOeGH0o0RzgLErB
         j9CVUe2kHtxobm1YXL1RaZ+U9Y4QtwgJGo/lerj0fdInZS33Hf+ZhZtQkgugC6WEsxGL
         szJg==
X-Gm-Message-State: AGRZ1gK2kUmkHOAW1WJN/vBO73SGGGZRoE84RJb3ZYDLzYj6s32hSpXm
        YV2564aKvYAGNsHmvzryb18=
X-Google-Smtp-Source: AJdET5djL/QZGaeslDbmlAaqJbrshW6GRT63R98VDVJg2UI/167AW4UU69uhj6dN+96GayWo+ud1dA==
X-Received: by 2002:adf:c7d1:: with SMTP id y17-v6mr8763477wrg.230.1541783849760;
        Fri, 09 Nov 2018 09:17:29 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:d5f1:833d:6c7e:a28? (p200300EA8BCFE300D5F1833D6C7E0A28.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:d5f1:833d:6c7e:a28])
        by smtp.googlemail.com with ESMTPSA id l140-v6sm4058228wmb.24.2018.11.09.09.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 09:17:29 -0800 (PST)
Subject: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with a
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
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
Message-ID: <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
Date:   Fri, 9 Nov 2018 18:16:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
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
v3:
- no changes
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ab33d1777..00a46218c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2074,6 +2074,11 @@ static void of_set_phy_eee_broken(struct phy_device *phydev)
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
@@ -2095,8 +2100,7 @@ static int phy_probe(struct device *dev)
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
 	 */
-	if (!(phydrv->flags & PHY_HAS_INTERRUPT) &&
-	    phy_interrupt_is_valid(phydev))
+	 if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
 		phydev->irq = PHY_POLL;
 
 	if (phydrv->flags & PHY_IS_INTERNAL)
-- 
2.19.1


