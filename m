Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2081346-1523311446-2-539086539956585886
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523311445; b=oe3yJVCVhZm4BSMY2jL4+sKlP2b1TeaJzY2UDXtjhGPfvdMq8I
    E3V6CboY2flCQjpPaEppVA5usfhBxLbEVtHS3tLjI8O3jJHCDUOwJeVEFoLfghmf
    bwWJm7IRG8C5kwQL3Zc8HFysxVbzZA8+lCH1mDxneBrngRjYgWSYYl09yINz6Onj
    2iNUoGK7kNg/HwLBVJsOzWBnG9LTLGO1k0PWZNRB01YiQtB9lraQJllzmezM4TOe
    lEpMlfY1fNotXhu7j9pf9cqT/DUw7k5wZaA+79YoM8wAFAbFj13uGtgszgzBSuCr
    gqFa8dA3DSGzgoJ01rVT2eZxxqs7x4vW4r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1523311445; bh=esy7sSNy9+07rKY1xcwo5GKZbAlDV30D0DyVksu
    t1oY=; b=l3qTUWcPw2OAoBYIGFPj2+fzfCqwHpMAtDCVfYIU+1hzT8vRdzgxv+w
    5rBlhgpFd/EEBY4HccrUOpilZ7ZzZHxeuRK1Txdvh3j/u1dCNWkDOWEWy3f4DVB8
    ZkrIlvw8cvimstLsybOO8gD8l9S58JjE/cdguvB1LdhNYO7JSTotNGSVGgSstKtV
    tO5x5s47LVuSk6/xKw7JBsVpqstZkX24mTMpD/Cb3e5qM2K6zG8X14YsbfgLbEdo
    O6Ny5fUuG2PfTMcWJk3hhHl4mi5PlfNpQRnOzDwH1cnSgHmGyHLYtYBgbvArtDz2
    IHS+BDOqe8cO66Be52JbJ4kP//V3iAg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FoRl3oMX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rP34M+fM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FoRl3oMX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rP34M+fM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrYCpPOOt2X0lK7J5NVRy6RUcc90lSeafjG5fivrzCH1ExKfpqdmzNjAU2M54kfudl0rb+gZkdTIsuFHJWf/Vvbj1GbxFyqGFfagU5ZQZEYmI7W4iW1
    fbkzqHwS/3W5e5phrbjcpYqRAxou1c8sEY2j8jjowY2diw4mOPsZl32ErimlPht5JwR0IKyXZXcsWeHkXQpxWQ6Rx3U3NX/nL59bApHPyQv697IQgzh609kt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=YhKUcPloZ5QA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=9PItq2mnR2aaobpVnzMA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbeDIWDg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 18:03:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54008 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeDIWDe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 18:03:34 -0400
X-Google-Smtp-Source: AIpwx48ffkDlr+r9heKNSiHkMX6vvyXFF6nXuQ3JT/j/xB+6qR0DREMgk7lypN36prge9uZCuDHQqw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] usb: phy: tegra: Cleanup error messages
Date: Tue, 10 Apr 2018 01:02:57 +0300
Message-Id: <c08393c7ac6964d14750e8a4b0ffa34884b1416f.1523307883.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523307883.git.digetx@gmail.com>
References: <cover.1523307883.git.digetx@gmail.com>
In-Reply-To: <cover.1523307883.git.digetx@gmail.com>
References: <cover.1523307883.git.digetx@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tegra's PHY driver has a mix of pr_err() and dev_err(), let's switch to
dev_err() and use common errors message formatting across the driver for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 69 ++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 0e8d23e51732..e46219e7fa93 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -236,10 +236,14 @@ static void set_phcd(struct tegra_usb_phy *phy, bool enable)
 
 static int utmip_pad_open(struct tegra_usb_phy *phy)
 {
+	int err;
+
 	phy->pad_clk = devm_clk_get(phy->u_phy.dev, "utmi-pads");
 	if (IS_ERR(phy->pad_clk)) {
-		pr_err("%s: can't get utmip pad clock\n", __func__);
-		return PTR_ERR(phy->pad_clk);
+		err = PTR_ERR(phy->pad_clk);
+		dev_err(phy->u_phy.dev,
+			"Failed to get UTMIP pad clock: %d\n", err);
+		return err;
 	}
 
 	return 0;
@@ -282,7 +286,7 @@ static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 	void __iomem *base = phy->pad_regs;
 
 	if (!utmip_pad_count) {
-		pr_err("%s: utmip pad already powered off\n", __func__);
+		dev_err(phy->u_phy.dev, "UTMIP pad already powered off\n");
 		return -EINVAL;
 	}
 
@@ -338,7 +342,8 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 		set_phcd(phy, true);
 
 	if (utmi_wait_register(base + USB_SUSP_CTRL, USB_PHY_CLK_VALID, 0) < 0)
-		pr_err("%s: timeout waiting for phy to stabilize\n", __func__);
+		dev_err(phy->u_phy.dev,
+			"Timeout waiting for PHY to stabilize on disable\n");
 }
 
 static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
@@ -370,7 +375,8 @@ static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
 
 	if (utmi_wait_register(base + USB_SUSP_CTRL, USB_PHY_CLK_VALID,
 						     USB_PHY_CLK_VALID))
-		pr_err("%s: timeout waiting for phy to stabilize\n", __func__);
+		dev_err(phy->u_phy.dev,
+			"Timeout waiting for PHY to stabilize on enable\n");
 }
 
 static int utmi_phy_power_on(struct tegra_usb_phy *phy)
@@ -617,15 +623,15 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 
 	ret = gpio_direction_output(phy->reset_gpio, 0);
 	if (ret < 0) {
-		dev_err(phy->u_phy.dev, "gpio %d not set to 0\n",
-			phy->reset_gpio);
+		dev_err(phy->u_phy.dev, "GPIO %d not set to 0: %d\n",
+			phy->reset_gpio, ret);
 		return ret;
 	}
 	msleep(5);
 	ret = gpio_direction_output(phy->reset_gpio, 1);
 	if (ret < 0) {
-		dev_err(phy->u_phy.dev, "gpio %d not set to 1\n",
-			phy->reset_gpio);
+		dev_err(phy->u_phy.dev, "GPIO %d not set to 1: %d\n",
+			phy->reset_gpio, ret);
 		return ret;
 	}
 
@@ -661,13 +667,13 @@ static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 	/* Fix VbusInvalid due to floating VBUS */
 	ret = usb_phy_io_write(phy->ulpi, 0x40, 0x08);
 	if (ret) {
-		pr_err("%s: ulpi write failed\n", __func__);
+		dev_err(phy->u_phy.dev, "ULPI write failed: %d\n", ret);
 		return ret;
 	}
 
 	ret = usb_phy_io_write(phy->ulpi, 0x80, 0x0B);
 	if (ret) {
-		pr_err("%s: ulpi write failed\n", __func__);
+		dev_err(phy->u_phy.dev, "ULPI write failed: %d\n", ret);
 		return ret;
 	}
 
@@ -728,28 +734,30 @@ static int ulpi_open(struct tegra_usb_phy *phy)
 
 	phy->clk = devm_clk_get(phy->u_phy.dev, "ulpi-link");
 	if (IS_ERR(phy->clk)) {
-		pr_err("%s: can't get ulpi clock\n", __func__);
-		return PTR_ERR(phy->clk);
+		err = PTR_ERR(phy->clk);
+		dev_err(phy->u_phy.dev, "Failed to get ULPI clock: %d\n", err);
+		return err;
 	}
 
 	err = devm_gpio_request(phy->u_phy.dev, phy->reset_gpio,
 		"ulpi_phy_reset_b");
 	if (err < 0) {
-		dev_err(phy->u_phy.dev, "request failed for gpio: %d\n",
-		       phy->reset_gpio);
+		dev_err(phy->u_phy.dev, "Request failed for GPIO %d: %d\n",
+			phy->reset_gpio, err);
 		return err;
 	}
 
 	err = gpio_direction_output(phy->reset_gpio, 0);
 	if (err < 0) {
-		dev_err(phy->u_phy.dev, "gpio %d direction not set to output\n",
-		       phy->reset_gpio);
+		dev_err(phy->u_phy.dev,
+			"GPIO %d direction not set to output: %d\n",
+			phy->reset_gpio, err);
 		return err;
 	}
 
 	phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
 	if (!phy->ulpi) {
-		dev_err(phy->u_phy.dev, "otg_ulpi_create returned NULL\n");
+		dev_err(phy->u_phy.dev, "Failed to create ULPI OTG\n");
 		err = -ENOMEM;
 		return err;
 	}
@@ -766,8 +774,10 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
 
 	phy->pll_u = devm_clk_get(phy->u_phy.dev, "pll_u");
 	if (IS_ERR(phy->pll_u)) {
-		pr_err("Can't get pll_u clock\n");
-		return PTR_ERR(phy->pll_u);
+		err = PTR_ERR(phy->pll_u);
+		dev_err(phy->u_phy.dev,
+			"Failed to get pll_u clock: %d\n", err);
+		return err;
 	}
 
 	err = clk_prepare_enable(phy->pll_u);
@@ -782,7 +792,8 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
 		}
 	}
 	if (!phy->freq) {
-		pr_err("invalid pll_u parent rate %ld\n", parent_rate);
+		dev_err(phy->u_phy.dev, "Invalid pll_u parent rate %ld\n",
+			parent_rate);
 		err = -EINVAL;
 		goto fail;
 	}
@@ -791,7 +802,7 @@ static int tegra_usb_phy_init(struct tegra_usb_phy *phy)
 		err = regulator_enable(phy->vbus);
 		if (err) {
 			dev_err(phy->u_phy.dev,
-				"failed to enable usb vbus regulator: %d\n",
+				"Failed to enable USB VBUS regulator: %d\n",
 				err);
 			goto fail;
 		}
@@ -855,7 +866,8 @@ static int read_utmi_param(struct platform_device *pdev, const char *param,
 	int err = of_property_read_u32(pdev->dev.of_node, param, &value);
 	*dest = (u8)value;
 	if (err < 0)
-		dev_err(&pdev->dev, "Failed to read USB UTMI parameter %s: %d\n",
+		dev_err(&pdev->dev,
+			"Failed to read USB UTMI parameter %s: %d\n",
 			param, err);
 	return err;
 }
@@ -871,14 +883,14 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegra_phy,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res) {
-		dev_err(&pdev->dev, "Failed to get UTMI Pad regs\n");
+		dev_err(&pdev->dev, "Failed to get UTMI pad regs\n");
 		return  -ENXIO;
 	}
 
 	tegra_phy->pad_regs = devm_ioremap(&pdev->dev, res->start,
 		resource_size(res));
 	if (!tegra_phy->pad_regs) {
-		dev_err(&pdev->dev, "Failed to remap UTMI Pad regs\n");
+		dev_err(&pdev->dev, "Failed to remap UTMI pad regs\n");
 		return -ENOMEM;
 	}
 
@@ -1020,15 +1032,16 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 		tegra_phy->reset_gpio =
 			of_get_named_gpio(np, "nvidia,phy-reset-gpio", 0);
 		if (!gpio_is_valid(tegra_phy->reset_gpio)) {
-			dev_err(&pdev->dev, "invalid gpio: %d\n",
-				tegra_phy->reset_gpio);
+			dev_err(&pdev->dev,
+				"Invalid GPIO: %d\n", tegra_phy->reset_gpio);
 			return tegra_phy->reset_gpio;
 		}
 		tegra_phy->config = NULL;
 		break;
 
 	default:
-		dev_err(&pdev->dev, "phy_type is invalid or unsupported\n");
+		dev_err(&pdev->dev, "phy_type %u is invalid or unsupported\n",
+			phy_type);
 		return -EINVAL;
 	}
 
-- 
2.16.3

