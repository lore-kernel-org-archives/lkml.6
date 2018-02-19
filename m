Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-96826-1519046451-2-15269877926985905670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519046450; b=ozDqTS79JfuLqBHMq7edEVD0qRD8HZollw25/g9fEiA5N/R
    sm3qqI32esrsimtBEJYAaT3YUrVg01mrTbkiel0Wb99g9l2IWuYEmB33OkHiAjl3
    HtvHmZzBXGCxellvXfPZaLD0ui440H0JupH1tTrrgtsEC7Y/1n9T+vprdE5SHCrp
    Rt+Ea6MrXJU8xhfB2wFy/h3/BTomXxiWelWrPe8Bk73oryztzrJXsUB3ZiFRaeIT
    ZIxA9C14pf4yaUv8Iixy1dQzk12NaNXAu2e1aHOMt0SBBNBC+blaOCYiq8LQpDw1
    TQ0BLWqRtP4CAVJLv4ntsWPWMtkjR/g2g/xHh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519046450; bh=rvVAckf6zYrvXt4j9pNCKzgIKL
    mnUcjIRxDGNuV4kL4=; b=M95SvuOT6UIrh0Yv120d+yg3cySKFGSG8cyxmyF2l3
    JgU7+fHBTuOkAcVwt6lhyaLPt408irBGB5gvp7tBizJ3UwWBD2RuwTWtU7xGpcYd
    sWqbSKqBD0wDybxZASSLzaktbxT4UwynVDnnBzCtKqh0mBMQfS2bSjBCHTx84NbX
    ewAkWmQjoKaA4eDJ0kTEtNeXvEWNTFK0BTtvulkVIPcPMfnYW3zdm4uAJ0JsVeRp
    GI9Y8V7NJV+y0E66tDWB1Tz9uqo/uN0NkbaERr3HeGh2Zglkf0Luk4Y1lknxBbn6
    clJ2AvfMHitrd6OPuuCC1WwgzDhEySPAN7JUli48wEVw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeBSNUt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 08:20:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752666AbeBSNUt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Feb 2018 08:20:49 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] extcon: intel-cht-wc: Also set direction and drv flags for V5 boost GPIO
Date: Mon, 19 Feb 2018 14:20:46 +0100
Message-Id: <20180219132046.13450-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes (firmware bug?) the V5 boost GPIO is not configured as output
by the BIOS, leading to the 5V boost convertor being permanently on,

Explicitly set the direction and drv flags rather then inheriting them
from the firmware to fix this.

Fixes: 585cb239f4de ("extcon: intel-cht-wc: Disable external 5v boost ...")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Fixes tag and Cc: stable
---
 drivers/extcon/extcon-intel-cht-wc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 7c4bc8c44c3f..b7e9ea377d70 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -66,6 +66,8 @@
 
 #define CHT_WC_VBUS_GPIO_CTLO		0x6e2d
 #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT	BIT(0)
+#define CHT_WC_VBUS_GPIO_CTLO_DRV_OD	BIT(4)
+#define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT	BIT(5)
 
 enum cht_wc_usb_id {
 	USB_ID_OTG,
@@ -183,14 +185,15 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
 {
 	int ret, val;
 
-	val = enable ? CHT_WC_VBUS_GPIO_CTLO_OUTPUT : 0;
-
 	/*
 	 * The 5V boost converter is enabled through a gpio on the PMIC, since
 	 * there currently is no gpio driver we access the gpio reg directly.
 	 */
-	ret = regmap_update_bits(ext->regmap, CHT_WC_VBUS_GPIO_CTLO,
-				 CHT_WC_VBUS_GPIO_CTLO_OUTPUT, val);
+	val = CHT_WC_VBUS_GPIO_CTLO_DRV_OD | CHT_WC_VBUS_GPIO_CTLO_DIR_OUT;
+	if (enable)
+		val |= CHT_WC_VBUS_GPIO_CTLO_OUTPUT;
+
+	ret = regmap_write(ext->regmap, CHT_WC_VBUS_GPIO_CTLO, val);
 	if (ret)
 		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
 }
-- 
2.14.3
