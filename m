Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2124738-1523311459-2-4085679829562159688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523311458; b=D48pYpaUZOtKu/+GSH/dZ/CKprsYvkvEftWhZ2gFI0Um70+hNf
    Hpoq8v+QIhz0Anil2SlYmEN2M3vawokvj1jlSgD5pa4Nv6xpEkE5Zo6cY0/CHhIv
    pVL2U3FvNsAgED6iNQ+u//c8hHJG61P8IlmbVG+DqX96NyfNwTdlDjoYeVXPC7uS
    Fb5p68xv+UvmL+KEo+PCTdk4sj11dIrotkbCLXIq9MFfWVh/wc9Nhm3iOIfXl2yl
    vuWtWdauJkz7Gp4DCipkplz8hIPS3nrCLDtDIAoL+luATtmo1aij9mh6T0kV7Fck
    G/+JRCv+CTt9jdJTbniw7UTqyLWwuuOGqPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1523311458; bh=+zo5IzoasbDc5IFz6w1ZpPYsdPGTdNQwSP3YQU8
    tfn8=; b=aHPQPF99WutXIWejhDtKc0sNcDJ7/SPEfBzPR4mBGIQNiDJSGfBCu+D
    mwvhBJxn4rJNIp7E9T6LZkq0t6RbIIbXhmkmdJ8U3Wpx0TSmt5XseVmQRZ9gNXEz
    A1G9VsDU5tlcPOdP8C8QmhDovRq5XBA8L28LQLlVJb3wmtK18KG20ipA0bEuIrwG
    g6VU1O41LI+rNB7VpwUH8tY3JtLOF5wognqThksazODR0JKhOl2dM62bZOGo4xJB
    WDx5qmWxU6SPr4eDeIAmOvgVx9CJIeaeKeOH0QVRmHFzDyw2WcOgyXV3WliqNdJV
    P8mRgOmknwlsEnVODMhzFrrD8XTgisQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=khiCdcha x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mv1hnIdR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=khiCdcha x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mv1hnIdR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHFj8qy6Vr7N8mwkm0vT5OUnT8RKhcMmVn2CcaJ8lITvn1k5ocXcPfEtisQSrM1t49d7+aHVOiAhPFXZH4IjXZg63bi6zH+F/9ZJEp2jrEL3maXmxlW/
    EtWxzm4mdTxXyBGhNA/ekAzY2sqra/ZewjXOjvYCXSW2Se3o+mwlN9XbmdsRZIDo0ShiDE7H5Z/+8wyA3SqDO98wPL19MVqS5AbNUVcZPyjguZex4mnujo+T
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=YhKUcPloZ5QA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=RaYQRs1hl46zn9nBMLwA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeDIWEG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 18:04:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52803 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeDIWDg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 18:03:36 -0400
X-Google-Smtp-Source: AIpwx4/JXKFycPlgSbmPgU5A3JK6qaLsc+/B0r+5zya0oSn+QzeDA5LX62vBByfsqDufPH6ML7BcgA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] usb: tegra: Move utmi-pads reset from ehci-tegra to tegra-phy
Date: Tue, 10 Apr 2018 01:02:58 +0300
Message-Id: <66330166c6a53e8f463ec231e3cb8195fa3036cc.1523307883.git.digetx@gmail.com>
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

UTMI pads are shared by USB controllers and reset of UTMI pads is shared
with the reset of USB1 controller. Currently reset of UTMI pads is done by
the EHCI driver and ChipIdea UDC works because EHCI driver always happen
to be probed first. Move reset controls from ehci-tegra to tegra-phy in
order to resolve the problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/host/ehci-tegra.c     | 87 ++++++++++++++++++---------------------
 drivers/usb/phy/phy-tegra-usb.c   | 79 ++++++++++++++++++++++++++++++++---
 include/linux/usb/tegra_usb_phy.h |  2 +
 3 files changed, 115 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index a6f4389f7e88..4d2cdec4cb78 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -36,7 +36,6 @@
 #define DRV_NAME "tegra-ehci"
 
 static struct hc_driver __read_mostly tegra_ehci_hc_driver;
-static bool usb1_reset_attempted;
 
 struct tegra_ehci_soc_config {
 	bool has_hostpc;
@@ -51,67 +50,54 @@ struct tegra_ehci_hcd {
 	enum tegra_usb_phy_port_speed port_speed;
 };
 
-/*
- * The 1st USB controller contains some UTMI pad registers that are global for
- * all the controllers on the chip. Those registers are also cleared when
- * reset is asserted to the 1st controller. This means that the 1st controller
- * can only be reset when no other controlled has finished probing. So we'll
- * reset the 1st controller before doing any other setup on any of the
- * controllers, and then never again.
- *
- * Since this is a PHY issue, the Tegra PHY driver should probably be doing
- * the resetting of the USB controllers. But to keep compatibility with old
- * device trees that don't have reset phandles in the PHYs, do it here.
- * Those old DTs will be vulnerable to total USB breakage if the 1st EHCI
- * device isn't the first one to finish probing, so warn them.
- */
 static int tegra_reset_usb_controller(struct platform_device *pdev)
 {
 	struct device_node *phy_np;
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct tegra_ehci_hcd *tegra =
 		(struct tegra_ehci_hcd *)hcd_to_ehci(hcd)->priv;
-	bool has_utmi_pad_registers = false;
+	struct reset_control *rst;
+	int err;
 
 	phy_np = of_parse_phandle(pdev->dev.of_node, "nvidia,phy", 0);
 	if (!phy_np)
 		return -ENOENT;
 
-	if (of_property_read_bool(phy_np, "nvidia,has-utmi-pad-registers"))
-		has_utmi_pad_registers = true;
+	/*
+	 * The 1st USB controller contains some UTMI pad registers that are
+	 * global for all the controllers on the chip. Those registers are
+	 * also cleared when reset is asserted to the 1st controller.
+	 */
+	rst = of_reset_control_get_shared(phy_np, "utmi-pads");
+	if (IS_ERR(rst)) {
+		dev_warn(&pdev->dev,
+			 "can't get utmi-pads reset from the PHY\n");
+		dev_warn(&pdev->dev,
+			 "continuing, but please update your DT\n");
+	} else {
+		/*
+		 * PHY driver performs UTMI-pads reset in a case of
+		 * non-legacy DT.
+		 */
+		reset_control_put(rst);
+	}
 
-	if (!usb1_reset_attempted) {
-		struct reset_control *usb1_reset;
+	of_node_put(phy_np);
 
-		if (!has_utmi_pad_registers)
-			usb1_reset = of_reset_control_get(phy_np, "utmi-pads");
-		else
-			usb1_reset = tegra->rst;
-
-		if (IS_ERR(usb1_reset)) {
-			dev_warn(&pdev->dev,
-				 "can't get utmi-pads reset from the PHY\n");
-			dev_warn(&pdev->dev,
-				 "continuing, but please update your DT\n");
-		} else {
-			reset_control_assert(usb1_reset);
-			udelay(1);
-			reset_control_deassert(usb1_reset);
-
-			if (!has_utmi_pad_registers)
-				reset_control_put(usb1_reset);
-		}
+	/* reset control is shared, hence initialize it first */
+	err = reset_control_deassert(tegra->rst);
+	if (err)
+		return err;
 
-		usb1_reset_attempted = true;
-	}
+	err = reset_control_assert(tegra->rst);
+	if (err)
+		return err;
 
-	if (!has_utmi_pad_registers) {
-		reset_control_assert(tegra->rst);
-		udelay(1);
-		reset_control_deassert(tegra->rst);
-	}
+	udelay(1);
 
-	of_node_put(phy_np);
+	err = reset_control_deassert(tegra->rst);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -440,7 +426,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		goto cleanup_hcd_create;
 	}
 
-	tegra->rst = devm_reset_control_get(&pdev->dev, "usb");
+	tegra->rst = devm_reset_control_get_shared(&pdev->dev, "usb");
 	if (IS_ERR(tegra->rst)) {
 		dev_err(&pdev->dev, "Can't get ehci reset\n");
 		err = PTR_ERR(tegra->rst);
@@ -452,8 +438,10 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		goto cleanup_hcd_create;
 
 	err = tegra_reset_usb_controller(pdev);
-	if (err)
+	if (err) {
+		dev_err(&pdev->dev, "Failed to reset controller\n");
 		goto cleanup_clk_en;
+	}
 
 	u_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
 	if (IS_ERR(u_phy)) {
@@ -538,6 +526,9 @@ static int tegra_ehci_remove(struct platform_device *pdev)
 	usb_phy_shutdown(hcd->usb_phy);
 	usb_remove_hcd(hcd);
 
+	reset_control_assert(tegra->rst);
+	udelay(1);
+
 	clk_disable_unprepare(tegra->clk);
 
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index e46219e7fa93..ea7ef1dc0b42 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -236,17 +236,83 @@ static void set_phcd(struct tegra_usb_phy *phy, bool enable)
 
 static int utmip_pad_open(struct tegra_usb_phy *phy)
 {
-	int err;
+	int ret;
 
 	phy->pad_clk = devm_clk_get(phy->u_phy.dev, "utmi-pads");
 	if (IS_ERR(phy->pad_clk)) {
-		err = PTR_ERR(phy->pad_clk);
+		ret = PTR_ERR(phy->pad_clk);
 		dev_err(phy->u_phy.dev,
-			"Failed to get UTMIP pad clock: %d\n", err);
-		return err;
+			"Failed to get UTMIP pad clock: %d\n", ret);
+		return ret;
 	}
 
-	return 0;
+	phy->pad_rst = devm_reset_control_get_optional_shared(
+						phy->u_phy.dev, "utmi-pads");
+	if (IS_ERR(phy->pad_rst)) {
+		ret = PTR_ERR(phy->pad_rst);
+		dev_err(phy->u_phy.dev,
+			"Failed to get UTMI-pads reset: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(phy->pad_clk);
+	if (ret) {
+		dev_err(phy->u_phy.dev,
+			"Failed to enable UTMI-pads clock: %d\n", ret);
+		return ret;
+	}
+
+	spin_lock(&utmip_pad_lock);
+
+	ret = reset_control_deassert(phy->pad_rst);
+	if (ret) {
+		dev_err(phy->u_phy.dev,
+			"Failed to initialize UTMI-pads reset: %d\n", ret);
+		goto unlock;
+	}
+
+	ret = reset_control_assert(phy->pad_rst);
+	if (ret) {
+		dev_err(phy->u_phy.dev,
+			"Failed to assert UTMI-pads reset: %d\n", ret);
+		goto unlock;
+	}
+
+	udelay(1);
+
+	ret = reset_control_deassert(phy->pad_rst);
+	if (ret)
+		dev_err(phy->u_phy.dev,
+			"Failed to deassert UTMI-pads reset: %d\n", ret);
+unlock:
+	spin_unlock(&utmip_pad_lock);
+
+	clk_disable_unprepare(phy->pad_clk);
+
+	return ret;
+}
+
+static int utmip_pad_close(struct tegra_usb_phy *phy)
+{
+	int ret;
+
+	ret = clk_prepare_enable(phy->pad_clk);
+	if (ret) {
+		dev_err(phy->u_phy.dev,
+			"Failed to enable UTMI-pads clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_assert(phy->pad_rst);
+	if (ret)
+		dev_err(phy->u_phy.dev,
+			"Failed to assert UTMI-pads reset: %d\n", ret);
+
+	udelay(1);
+
+	clk_disable_unprepare(phy->pad_clk);
+
+	return ret;
 }
 
 static void utmip_pad_power_on(struct tegra_usb_phy *phy)
@@ -700,6 +766,9 @@ static void tegra_usb_phy_close(struct tegra_usb_phy *phy)
 	if (!IS_ERR(phy->vbus))
 		regulator_disable(phy->vbus);
 
+	if (!phy->is_ulpi_phy)
+		utmip_pad_close(phy);
+
 	clk_disable_unprepare(phy->pll_u);
 }
 
diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index d641ea1660b7..0c5c3ea8b2d7 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -17,6 +17,7 @@
 #define __TEGRA_USB_PHY_H
 
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/usb/otg.h>
 
 /*
@@ -76,6 +77,7 @@ struct tegra_usb_phy {
 	bool is_legacy_phy;
 	bool is_ulpi_phy;
 	int reset_gpio;
+	struct reset_control *pad_rst;
 };
 
 void tegra_usb_phy_preresume(struct usb_phy *phy);
-- 
2.16.3

