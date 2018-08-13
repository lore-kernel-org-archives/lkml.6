Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0586C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF0F216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF0F216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbeHNAlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:41:32 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbeHNAlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:41:32 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MbgsX-1fYUPL1amT-00J4E4; Mon, 13 Aug 2018 23:57:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Johan Hovold <johan@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawn.guo@linaro.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: of-simple: avoid unused function warnings
Date:   Mon, 13 Aug 2018 23:56:55 +0200
Message-Id: <20180813215717.3903813-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:wUqf3N0ydJl8a7zthaPEY1pduLfA65wwDT27xaM8sIVLncnOX8b
 1iUEL4gi9dDlBkVM1xY2jR2qgrezsMmUYE1vlbptu0HzIFW9O4iHYzSSQss9KirnvthnzQw
 lnO4xlbdvYs3gMigfhZ4RKc/cBTU3M22+mTCO8vv9GgrJNZT5CsMwdrf3b8EFrtyriKEYAI
 fw/tDJ5tsHYEZcXE7Zuvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zFFLfxh5b9Y=:Oh3DV5+/h264TY2IeYfGZR
 kV3KcBBtAFMoxajYiao0+gyp9HcbAHP83p+qOoOTB9RpvX4dIdCA5fKxq8BMKJbUapr38+mLF
 SUeQQ3iAGGBUWA1Jnq3KCkB9yoGcZHZEyqwbsBD7ePE76zzIpmmvvWoQvVQdJGkiS3o1P95a1
 PmKAGseIrfFIMaZtKogkZlCMsZ1TLXArHuzzjoixO2Hr8DX/iMvXoLzEUKsnQobvSzYRQzOTI
 xrBgSMMPaBXkPfQ+i04rojVKp26oKlT04R7L+wAN+hTuleM7tJaNWR6b7GXcMRiUwb+tFmgPd
 8U1flLrH+HSneLfVepB40mHZQDOp2Fy+JmCxuaVBdMsIVpt1bDwx3YSxUeLifYU1eKrkACzks
 IS67CE/E951rphLB70UoSw8mmndvyVxZZCcnlt4W1kNSu8Y/XOZp+cgcW+JZ7OrwKagq3b6MH
 FuM6oh7d/mVJCqBCD1AXONwggH2/HR3wLvOdhlv0HDfIweD94dfB6hz7T3hQCNbrIUxu+xUyd
 +pbf85S1dl72IR+IXBKXG71ybq8AsfyJh6g3KN3kN+DT2/2xIWb2o8cMJx+H314uMnTFjLHHS
 GawyyT1miyjKqgRbbe696K/gaMZLJ/xPpy/z7WVeuiZYjZF+K0JxirD4076ece2+IODJGpsdO
 P16g0Fg/OxBrTEVJgAsqYo47IYXuu5CsCVSvWDoIL3QKAXNB9pHJiq5k3zdrWvr0yaSA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An incorrect #ifdef caused a pair of harmless warnings when CONFIG_PM_SLEEP
is disabled:

drivers/usb/dwc3/dwc3-of-simple.c:223:12: error: 'dwc3_of_simple_resume' defined but not used [-Werror=unused-function]
 static int dwc3_of_simple_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~
drivers/usb/dwc3/dwc3-of-simple.c:213:12: error: 'dwc3_of_simple_suspend' defined but not used [-Werror=unused-function]
 static int dwc3_of_simple_suspend(struct device *dev)

Since the #ifdef method is generally hard to get right, use
a simpler __maybe_unused annotation here to let the compiler
drop the unused functions silently. This also improves
compile-time coverage.

Fixes: 76251db86561 ("usb: dwc3: of-simple: reset host controller at suspend/resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 40bf9e0bbc59..4c2771c5e727 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -180,8 +180,7 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int dwc3_of_simple_runtime_suspend(struct device *dev)
+static int __maybe_unused dwc3_of_simple_runtime_suspend(struct device *dev)
 {
 	struct dwc3_of_simple	*simple = dev_get_drvdata(dev);
 	int			i;
@@ -192,7 +191,7 @@ static int dwc3_of_simple_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int dwc3_of_simple_runtime_resume(struct device *dev)
+static int __maybe_unused dwc3_of_simple_runtime_resume(struct device *dev)
 {
 	struct dwc3_of_simple	*simple = dev_get_drvdata(dev);
 	int			ret;
@@ -210,7 +209,7 @@ static int dwc3_of_simple_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int dwc3_of_simple_suspend(struct device *dev)
+static int __maybe_unused dwc3_of_simple_suspend(struct device *dev)
 {
 	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
 
@@ -220,7 +219,7 @@ static int dwc3_of_simple_suspend(struct device *dev)
 	return 0;
 }
 
-static int dwc3_of_simple_resume(struct device *dev)
+static int __maybe_unused dwc3_of_simple_resume(struct device *dev)
 {
 	struct dwc3_of_simple *simple = dev_get_drvdata(dev);
 
@@ -229,7 +228,6 @@ static int dwc3_of_simple_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_of_simple_suspend, dwc3_of_simple_resume)
-- 
2.18.0

