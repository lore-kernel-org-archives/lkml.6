Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274038-1524147018-2-14299763394087656140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524147017; b=nhTX1iGs9HLpeSFaYb+EmvlarfQrdSk/BHNu3h9shaL6yZ4HL9
    Ab3ygAHlNUygPsAndhxCbaaztrE5I3NqSg0gpxbkyD95IERS8ux0mKkXq+xZPtam
    YAwdFG7h29Jy9zCrm6yl+uACTRni8jgkk8kfLEeKqfcisLxXo6J/WiWmqV6DAfKt
    XoHRKDokPJGVXUYsBwXB+1YbDmehYrOF/4GFczpJGKcjKnloYSEnMZyx3zo2zWrV
    vj6duHSQ1YwJST5i1u9HKasozLrOh7Pz/HskHhUtD6Himny2P4PDyO1XuU81CZ+f
    mEmzmQNR74mDPy+CKggBfSUYC4V+IrD+CB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524147017; bh=
    fyoSvTjS3jwfKr2oKvwnP4llRBmGO2tnTmuj4hSGERg=; b=vDzAjEq6ZKnaxDa8
    kpBARhbU22ujE7hV4noVvN78AAa0jE/R/sFlRoPJXksWfy5cFHwurxUQdE4FB4ky
    DjiQ6QsHWtNnls2MQu10yBXsWUXE39oPjMLjLsO7Xq3MeCRDsbnZXf6t6icOAJNe
    njt9ea2Uwn5bqyrg1pSbAOzDGRGpFUvmygB0FV2gfPJQq/g+8SE3zsx2wbsfOtxG
    n6pMajfj+wqV/IkqnckDB8RiGOKnRtt6zosdZVdx6F6UIxFjlMNoxk4oU7ZQzcyP
    iO+/RuiIMHSTmwKu2/f6d+dXgXP+4h3IXS6VtaA8cn056Gisu3oobyil7o/7ikdp
    6u8SGw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sang-engineering.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sang-engineering.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9KM57n0iGpzSMmrjU9xjnE6LAwrmOBLNYJCfQieO9L9IvGZF5mZ7wG2pMwkxHj+HknveAohKl4EtvuM4OBfzxPCvpq1vunBHsKrGMk9VHYKVIE1tC+
    vch0uRtHQhOxBnVfhIJJ2m2ER+L8oR+moqAyKQMtUqtc+2BdS51NE+mQAFMfyvjvnRJ+T2uZjkGsSGh7/QjSikVD4qaqXQr2BxSSJpL5qIlEUEPJ6pG4hLOT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=LDBv8-xUAAAA:8
    a=VwQbUJbxAAAA:8 a=TfsKkDOJGvE6wVcqPHgA:9 a=x8gzFH9gYPwA:10
    a=DZeXCJrVpAJBw65Qk4Ds:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeDSOJz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:09:55 -0400
Received: from sauhun.de ([88.99.104.3]:45608 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753542AbeDSOHP (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:15 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 56/61] usb: phy: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:26 +0200
Message-Id: <20180419140641.27926-57-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/usb/phy/phy-am335x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index b36fa8b953d0..27bdb7222527 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -96,8 +96,7 @@ static int am335x_phy_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int am335x_phy_suspend(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct am335x_phy *am_phy = platform_get_drvdata(pdev);
+	struct am335x_phy *am_phy = dev_get_drvdata(dev);
 
 	/*
 	 * Enable phy wakeup only if dev->power.can_wakeup is true.
@@ -117,8 +116,7 @@ static int am335x_phy_suspend(struct device *dev)
 
 static int am335x_phy_resume(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct am335x_phy	*am_phy = platform_get_drvdata(pdev);
+	struct am335x_phy	*am_phy = dev_get_drvdata(dev);
 
 	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, am_phy->dr_mode, true);
 
-- 
2.11.0

