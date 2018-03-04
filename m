Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1440301-1520126452-2-17463900004845991504
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520126452; b=hdyz59lxgoSXPvnP48ls8KKsD4uysCr7uLuwlRlaKuds2Vy
    ML0noijvCDEx4o7GmhhAwU5wa03m2rc2WWp5iXHVJYCRs3JMM4dyXuOxeHQE6dTT
    hYQHhisWNriQE5i5O4EJDrBrFCf/A/8UdCxkMdDJaPpNF1oim0OMLjhhCLhwZmg5
    eThrW4Ezj7gOZQViONnkiIKhEosBrPR+8SMJgm3CJV0tTKMpitjvBJYt3I/IW1Ok
    SLl86WhJ/XasEZYPE1n+8h96j/zTs9Ix1lzGojqMlz2c9+JLP1HJjVtn6q4ls2SR
    aiyfDFuYGQAVJPGbR6CQVTCZmzwAvBCjoGGi+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520126452; bh=0fSDgtZ5gAFWOdUw3eVaaKEEfw
    1l6vn6qHqNoAvSpjc=; b=g1LlgmJeSiui2KCARLUiBwg7q7aM0FsHFWRgasFi/v
    X+UQs3xLWiUijhycDkKJ0Wv1sBy14qeL+SPD+vS1MiS4eoOHQFsgFJPEywOAqWSt
    5tI6zmJVQfNPRKpThF7YzdqPFSGqIhOdnp5GFhdDTBHGV1cHRwauH88+aWhV/v14
    MsJ4p3BRxcsAZ0kaAy4+MxmWUHkk4uqKXRcVpAbDbtk1YAjCFxRx35GKQ/cwdA/K
    3rHqWxwUGCsPnJuZC+RFV87XErhE6y3XjuUSJanEfRkN7OwrKAmZl6bAwdwSSlBx
    OpQCJPO4kZJJgWrc7KJgY7u+eLXI31Ilor2pNV6Th9qg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=adirat-com.20150623.gappssmtp.com header.i=@adirat-com.20150623.gappssmtp.com header.b=naXFH8sS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=temperror (dns servfail);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=adirat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ffa5WaPh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=adirat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=adirat-com.20150623.gappssmtp.com header.i=@adirat-com.20150623.gappssmtp.com header.b=naXFH8sS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=temperror (dns servfail);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=adirat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ffa5WaPh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=adirat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeCDBUn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 20:20:43 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40506 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeCDBUm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 3 Mar 2018 20:20:42 -0500
X-Google-Smtp-Source: AG47ELuZ9ke01cFzpi1bpDHDzSdF65SzjPQ755FIY8Iah6OtYNATBbXUrfqEMjvzb5lPriLLPX/a8Q==
From: Ioan-Adrian Ratiu <adi@adirat.com>
To: johnyoun@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: detect power supplies to reduce spam
Date: Sun,  4 Mar 2018 05:20:18 +0200
Message-Id: <20180304032018.12238-1-adi@adirat.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

By statically hardcoding at compile time the number of supplies
("#define DWC2_NUM_SUPPLIES ARRAY_SIZE(dwc2_hsotg_supply_names)"), the
driver assumed that every controller uses supplies and issued a
warning if none were detected via the device tree [1], even though the
vast majority of devices (with 1 exception from Samsung) don't need
nor use them.

So to return to normality and stop warning everyone unconditionally,
detect if there are any supplies and no-op just like the dummy
regulator which got loudly auto-asigned does.

This issue has been previously discussed based on an alternative fix
at [2] a year back but nothing came out of it then.

[1]
dwc2 3f980000.usb: 3f980000.usb supply vusb_d not found, using dummy regulator
dwc2 3f980000.usb: 3f980000.usb supply vusb_a not found, using dummy regulator

[2]
https://www.spinics.net/lists/linux-usb/msg153010.html

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 drivers/usb/dwc2/core.h     |  5 +++--
 drivers/usb/dwc2/platform.c | 46 +++++++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index cd77af3b1565..c50b9fc4a162 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -128,7 +128,7 @@ static const char * const dwc2_hsotg_supply_names[] = {
 	"vusb_a",               /* analog USB supply, 1.1V */
 };
 
-#define DWC2_NUM_SUPPLIES ARRAY_SIZE(dwc2_hsotg_supply_names)
+#define DWC2_MAX_SUPPLIES ARRAY_SIZE(dwc2_hsotg_supply_names)
 
 /*
  * EP0_MPS_LIMIT
@@ -921,7 +921,8 @@ struct dwc2_hsotg {
 	struct phy *phy;
 	struct usb_phy *uphy;
 	struct dwc2_hsotg_plat *plat;
-	struct regulator_bulk_data supplies[DWC2_NUM_SUPPLIES];
+	struct regulator_bulk_data supplies[DWC2_MAX_SUPPLIES];
+	u8 num_supplies;
 	u32 phyif;
 
 	spinlock_t lock;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 4703478f702f..3acf658af4e9 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -126,10 +126,12 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(hsotg->supplies),
-				    hsotg->supplies);
-	if (ret)
-		return ret;
+	if (hsotg->num_supplies) {
+		ret = regulator_bulk_enable(hsotg->num_supplies,
+					    hsotg->supplies);
+		if (ret)
+			return ret;
+	}
 
 	if (hsotg->clk) {
 		ret = clk_prepare_enable(hsotg->clk);
@@ -186,8 +188,9 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	if (hsotg->clk)
 		clk_disable_unprepare(hsotg->clk);
 
-	ret = regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies),
-				     hsotg->supplies);
+	if (hsotg->num_supplies)
+		ret = regulator_bulk_disable(hsotg->num_supplies,
+					     hsotg->supplies);
 
 	return ret;
 }
@@ -210,6 +213,7 @@ int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 
 static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 {
+	struct regulator *reg;
 	int i, ret;
 
 	hsotg->reset = devm_reset_control_get_optional(hsotg->dev, "dwc2");
@@ -290,16 +294,30 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 		dev_dbg(hsotg->dev, "cannot get otg clock\n");
 	}
 
-	/* Regulators */
-	for (i = 0; i < ARRAY_SIZE(hsotg->supplies); i++)
-		hsotg->supplies[i].supply = dwc2_hsotg_supply_names[i];
+	/* Regulators, vast majority of dwc2 devices don't use them at all */
+	for (i = 0; i < DWC2_MAX_SUPPLIES; i++) {
+		reg = regulator_get_optional(hsotg->dev,
+					     dwc2_hsotg_supply_names[i]);
+
+		/* All or nothing (bulk): regs either are or aren't present */
+		if (IS_ERR(reg)) {
+			while (--i >= 0) {
+				regulator_put(hsotg->supplies[i].consumer);
+				hsotg->supplies[i].consumer = NULL;
+				hsotg->supplies[i].supply = NULL;
+				--hsotg->num_supplies;
+			}
+			break;
+		}
 
-	ret = devm_regulator_bulk_get(hsotg->dev, ARRAY_SIZE(hsotg->supplies),
-				      hsotg->supplies);
-	if (ret) {
-		dev_err(hsotg->dev, "failed to request supplies: %d\n", ret);
-		return ret;
+		hsotg->supplies[i].consumer = reg;
+		hsotg->supplies[i].supply = dwc2_hsotg_supply_names[i];
+		++hsotg->num_supplies;
 	}
+
+	WARN_ON(hsotg->num_supplies &&
+		hsotg->num_supplies != DWC2_MAX_SUPPLIES);
+
 	return 0;
 }
 
-- 
2.16.2

