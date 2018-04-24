Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3617087-1524602041-2-1182073383948170873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524602040; b=SPpx6ksCmX71LSlDvbWhWijunR3HUTTFXzo3Hf1SCb45pT0KpX
    HdB4iU0CQZa3ibw0SoC/a+7bp7Gpy7rRdv7mTcFHfxurG9a3vTEhoZXrGeAXdInT
    XnyFH+P/p9mP/usjsgSQPvaeLMUAEHd5sshl5egiiOjb+0cuTbw0FAKtwzVTLoh1
    PlEY5KZexW+79XvdKz/Y3s5vK9p3k4ruPfbqAqqFHIESoi3e3MgdqAZfPs7ZcPBM
    JkLsDY8pQdVlhrocy5lmPCh9uUabBbSKspYZozHbz+5ECwBJl4fSBUxix36J267o
    w8q0fTh76wRoFEG7pM3NJCu9mTaeT9hDuQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524602040; bh=
    Rdiort31C+l/n+gyQFlSjIwlowDT52rfvzKwMOITqFE=; b=n6ORcZCteXlF2q16
    S3E0TnaR3+ynb133hW5YItfkujPi34sPemIAqjrp28ZDX30aWIPc0C7kFBI8ZAQU
    CyJG12bdAx7/wAMgaPclEAwF3lU5Do21KWBx5sn1WQvWcYFPfDoPCNvHdThpUGQ3
    0bVTmrSzxrI9tspxukf4hFjfehSN3Fh4gTqcKdaHNyaME55Yo+2q5dPZAknBauy7
    XEppnxyy1nVf9JY4FcVsmrM+AXctxxUEH2IwnDgE3UqiW+bo6KXU+e0BRIEp7eFV
    KPNhHBvXC4Pb1CmejwtUL3YA/fypr9LmsDDFjFn/v0arczbWqePbydgAE/ckua0j
    TsN1Ww==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGeBmQsKwIEqKV6ma4EyDjrB4TqA6tzyL4IZiR8H4sivC3+BKtBp9LRvpWQqnhmb3nt5emazT92hssVjvxyjSz6o4K0UID09TvmFTp88LKH1pivjtEoJ
    0ZwLwd0OlnmtEwVBrJNOTKQwGMNK6sBRmF9Od4/uRe5h0THyQVddgQ3uaqihXfCnaJlF5AVdK88PZXdf2HUUc6abA+JFpSn8Z2Bphgrv/z0JLKFG+9eo1w1L
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=cqNmB-S35C9VADX0hDMA:9 a=3bfSMcPGp4kkCNzc:21 a=ohtyR9fWUvmFO6MW:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeDXUd5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 16:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbeDXUdq (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 16:33:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4A821836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 05/10] i2c: s3c2410: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:34 +0200
Message-Id: <20180424203239.21885-6-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt | 4 +---
 drivers/i2c/busses/i2c-s3c2410.c                      | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
index 89b3250f049b..66ae46d3bc2f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
@@ -8,9 +8,7 @@ Required properties:
       (b) "samsung, s3c2440-i2c", for i2c compatible with s3c2440 i2c.
       (c) "samsung, s3c2440-hdmiphy-i2c", for s3c2440-like i2c used
           inside HDMIPHY block found on several samsung SoCs
-      (d) "samsung, exynos5440-i2c", for s3c2440-like i2c used
-	   on EXYNOS5440 which does not need GPIO configuration.
-      (e) "samsung, exynos5-sata-phy-i2c", for s3c2440-like i2c used as
+      (d) "samsung, exynos5-sata-phy-i2c", for s3c2440-like i2c used as
 	   a host to SATA PHY controller on an internal bus.
   - reg: physical base address of the controller and length of memory mapped
     region.
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5d97510ee48b..9fe2b6951895 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -154,8 +154,6 @@ static const struct of_device_id s3c24xx_i2c_match[] = {
 	{ .compatible = "samsung,s3c2440-i2c", .data = (void *)QUIRK_S3C2440 },
 	{ .compatible = "samsung,s3c2440-hdmiphy-i2c",
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO) },
-	{ .compatible = "samsung,exynos5440-i2c",
-	  .data = (void *)(QUIRK_S3C2440 | QUIRK_NO_GPIO) },
 	{ .compatible = "samsung,exynos5-sata-phy-i2c",
 	  .data = (void *)(QUIRK_S3C2440 | QUIRK_POLL | QUIRK_NO_GPIO) },
 	{},
-- 
2.14.1

