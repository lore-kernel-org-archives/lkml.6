Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /J6pG9kdGluiMAAAmS7hNA
	; Fri, 08 Jun 2018 06:10:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4E150607E4; Fri,  8 Jun 2018 06:10:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZWCCQmV"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D146D606FA;
	Fri,  8 Jun 2018 06:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D146D606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeFHGKa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:10:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34293 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeFHGK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:10:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id q4-v6so4822272pgr.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 23:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hhV5vWoo5ePHMj9IBbOuABU1BsFptz9gvkEO36iHk/0=;
        b=gZWCCQmV62lEL9iUngjzK6fVsGIzXTG853kf4o0+VzUa2bnWwmurynxmLtWEBH4gde
         eA72MrgBwboEkzaW5pL4jKHME9+ZmKg22NwJAitJjuMcgm5NP7FCcgMJ6pHXjvPM7RiW
         Ue7YyH4MzzoN0PxuI8NFhA//FVFqq22WTtAwkFcHGL04hkLQCinIExGObVBuA0Unhrun
         f9wW/+qUqdmd0IYRQ8NCMeo89NB+Or4nJJVOJIMYjcwrt55gVXs7NFw3I9HP89nrHEH9
         hniMZeY/THgfkiUq0D+VgJuZLBKTNI3CJ1R0OgdbB3DdNk2uhkhukOTXwvo3VOyK9SMK
         Q4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hhV5vWoo5ePHMj9IBbOuABU1BsFptz9gvkEO36iHk/0=;
        b=XKiM67hTSUNrbxTjbvvf0oDzyjP9NdsgSg2mp/mL6FPpmVgWr6v2UibFks7SRTCWu2
         F5pQBImYStEvvBqf6miG62h2w/9hjRimkIIrJvfOBbglZv1iyg/ebjcah2fV/Wg9Wok2
         cUFAqmHL/Jy5JUQevjM8mU5eb3KUKaGWEF4dx4/sMpVA+EF2PgAy+TnBV0/thFddCZbc
         gzMtxjf4yLRXWknCT6FodxZgfrtABWWStbSDEHPD8y6Qh3vhN446TH40vyPok/9k3t8m
         EQJ9w67bAJFHpf6GB89kN8LVFSpy2DN9sIZi6X2XwJrhcdKYAYtNhhMHp0PGU5zbsZgU
         /Z8A==
X-Gm-Message-State: APt69E0uzoMu1NWciguhOcfqsoyb6Epw0Pws/LAF3NtCiD1SFT/WyOMw
        LW9oswJgZwBC8fQeyFh9Zug=
X-Google-Smtp-Source: ADUXVKI++gEWwDREluPMolbXGucqRC4mLCHSoKEXWFRi2PZoSas9RTNHexI6iejaHzwF1+LKXO78oA==
X-Received: by 2002:a63:84c6:: with SMTP id k189-v6mr4171041pgd.49.1528438228645;
        Thu, 07 Jun 2018 23:10:28 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id x72-v6sm51953069pff.176.2018.06.07.23.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 23:10:28 -0700 (PDT)
From: Jaedon Shin <jaedon.shin@gmail.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] phy: phy-brcm-usb-init: Fix power down USB 3.0 PHY when XHCI reenabled
Date: Fri,  8 Jun 2018 15:10:15 +0900
Message-Id: <20180608061015.5399-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unset is required to enable USB 3.0 PHY when XHCI reenabled in response
to setting PHY3_IDDQ_OVERRIDE in uninit().

Fixes: cd6f769fdea7 ("phy: phy-brcm-usb-init: Power down USB 3.0 PHY when XHCI disabled")
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index 1b7febc43da9..29d2c3b1913a 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -962,6 +962,10 @@ void brcm_usb_init_xhci(struct brcm_usb_init_params *params)
 {
 	void __iomem *ctrl = params->ctrl_regs;
 
+	USB_CTRL_UNSET(ctrl, USB30_PCTL, PHY3_IDDQ_OVERRIDE);
+	/* 1 millisecond - for USB clocks to settle down */
+	usleep_range(1000, 2000);
+
 	if (BRCM_ID(params->family_id) == 0x7366) {
 		/*
 		 * The PHY3_SOFT_RESETB bits default to the wrong state.
-- 
2.17.1
