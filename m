Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDCFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FF420862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzsSTBwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FF420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbeKHCWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:22:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34590 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbeKHCWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:22:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id f1-v6so11740073wmg.1;
        Wed, 07 Nov 2018 08:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FH1CRg9zKXdmOnTWJLsZTHhhSYiFD57sq5PuBYc7CFk=;
        b=UzsSTBwGZrTJUGDxk1awqN5vfVAiIoBgsRRDaIPBLgEtasDu6fhWBDvoZV+L2m7vOv
         JRi+/N40C5hwRy1wiIvciufvciS8Hqrw3WdJM4YfjPLOARbr0H51nsKYsDttuUuBeu/K
         HrQViT2pZmi6cVv8UpodzL7xMXuBH0dTk0aqb3xEHhcdlixcD3i+ssZ5TaQ+xvVpwpTQ
         1owcd38Y3dTzSKGu/DxA+jTUi19W20vAeYNTr7hKHM0pCSWm0kShgs3JCPGCk2jq8xVo
         x2iHU0PWCmXioAjjLHvonfobQiuyelgBlEObd73TFoVwf6oeGCxrMT6QgXODXnyNbl2l
         rXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FH1CRg9zKXdmOnTWJLsZTHhhSYiFD57sq5PuBYc7CFk=;
        b=hbtFumg9dwfUczZgebiLvj/wKHKgGG8IzI5dw+ymBOT4kqcuajQ69GYTUyflL9Jw/A
         1U+i0dV7YxPOKvdJJqAadavWg5yFZnFXeI50NIoYsQMQUQu/2bQ3YbRvZGb5Cc+b445G
         vUMwR/vqe5d8vS7/n/ZUU+cCVEd39172KD7YEHZGI1UmgxWDVuHf4gSJbto6dwjlFDl1
         EVjh7k66WtTO/eaGFmtajyci+wfVysQXmQDN5mWelVb2QS27LWCS5N7808WK1c+V/thk
         pgvaF/0aa/W5zq2/Z7vEvBTJsSza4s+I000OECIqBTi50KWjre5Pb2kWCrA9lrtOk5ch
         P1jw==
X-Gm-Message-State: AGRZ1gJO4iaFF17SSd6VGTsm8GWYTnOvOwRgdZ+dD9kVOd1hevGABRqz
        e5vayIV4B69o2nd+EbiBPig=
X-Google-Smtp-Source: AJdET5c2seQF7/Aip/jfzXfhwX1j5YBXvbk/ujJ5944RKW4+bWpbv9/OeEE0H9OcHGzDrBnsZDe7Tw==
X-Received: by 2002:a1c:ee89:: with SMTP id j9-v6mr830950wmi.58.1541609458572;
        Wed, 07 Nov 2018 08:50:58 -0800 (PST)
Received: from gmail.com (net-2-42-72-229.cust.vodafonedsl.it. [2.42.72.229])
        by smtp.gmail.com with ESMTPSA id y9-v6sm613127wru.70.2018.11.07.08.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 08:50:57 -0800 (PST)
From:   Paolo Pisati <p.pisati@gmail.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [stable, netdev 4.4+] lan78xx: make sure RX_ADDRL & RX_ADDRH regs are always up to date
Date:   Wed,  7 Nov 2018 17:50:57 +0100
Message-Id: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[partial backport upstream 760db29bdc97b73ff60b091315ad787b1deb5cf5]

Upon invocation, lan78xx_init_mac_address() checks that the mac address present
in the RX_ADDRL & RX_ADDRH registers is a valid address, if not, it first tries
to read a new address from an external eeprom or the otp area, and in case both
read fail (or the address read back is invalid), it randomly generates a new
one.

Unfortunately, due to the way the above logic is laid out,
if both read_eeprom() and read_otp() fail, a new mac address is correctly
generated but is never written back to RX_ADDRL & RX_ADDRH, leaving the chip in an
incosistent state and with an invalid mac address (e.g. the nic appears to be
completely dead, and doesn't receive any packet, etc):

lan78xx_init_mac_address()
...
if (lan78xx_read_eeprom(addr ...) || lan78xx_read_otp(addr ...)) {
	if (is_valid_ether_addr(addr) {
		// nop...
	} else {
		random_ether_addr(addr);
	}

	// correctly writes back the new address
	lan78xx_write_reg(RX_ADDRL, addr ...);
	lan78xx_write_reg(RX_ADDRH, addr ...);
} else {
	// XXX if both eeprom and otp read fail, we land here and skip
	// XXX the RX_ADDRL & RX_ADDRH update completely
	random_ether_addr(addr);
}

This bug went unnoticed because lan78xx_read_otp() was buggy itself and would
never fail, up until 4bfc338 "lan78xx: Correctly indicate invalid OTP"
fixed it and as a side effect uncovered this bug.

4.18+ is fine, since the bug was implicitly fixed in 760db29 "lan78xx: Read MAC
address from DT if present" when the address change logic was reorganized, but
it's still present in all stable trees below that: linux-4.4.y, linux-4.9.y,
linux-4.14.y, etc up to linux-4.18.y (not included).

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 drivers/net/usb/lan78xx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 50e2e10a..114dc55 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1660,13 +1660,6 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 				netif_dbg(dev, ifup, dev->net,
 					  "MAC address set to random addr");
 			}
-
-			addr_lo = addr[0] | (addr[1] << 8) |
-				  (addr[2] << 16) | (addr[3] << 24);
-			addr_hi = addr[4] | (addr[5] << 8);
-
-			ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-			ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
 		} else {
 			/* generate random MAC */
 			random_ether_addr(addr);
@@ -1674,6 +1667,11 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 				  "MAC address set to random addr");
 		}
 	}
+	addr_lo = addr[0] | (addr[1] << 8) | (addr[2] << 16) | (addr[3] << 24);
+	addr_hi = addr[4] | (addr[5] << 8);
+
+	ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+	ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
 
 	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
 	ret = lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
-- 
2.7.4

