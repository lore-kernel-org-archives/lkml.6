Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803254-2-10912180820466206690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803253; b=Q4gy9KpAGyY5nggOk+FcKkSYd4YlZD8Cg5hpCvlC/pbJ/p/
    fkjOkQ6DUhygQrm/u2OQt5lv+y1/mt2+YWS9d7takdFMX7zVaKmqBKibptRVscrU
    V5R7BOp95Vk8RRVfoupVLDlXPzzP/0jKS+FDqAmpxNN3NrzOX1g2kuytSu6pBUlx
    +Jd/CzKlbyprKrMzHE0nlx7JHz2ppMK5zCI1vl6MJbvR3Mu6n2yVCUYFf6yDO5VV
    UKFHuynT9zyH/1r20U7B483FZ1uekDcMebvt6rg8NqNOdLClZuX6IP5kuAFBAGlP
    bHgFG6vsMpxPGcsdZ+1a2KpNHLDG6WTSAxwvq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803253; bh=j/ICMhERpKpXZTnX406Dk85ohp
    XVvcwscOV77hhqS/A=; b=LT9ikHogx6b+zV88iccIo2u7BPyMoyUBpAQxwxWPHb
    U2bEpJbbEyRfw8LocPAs+Q8KbcHMXjba9GB8SF3KXKxl+aYScodhcmVCMO9jbj8h
    +skxhlBNlrhHGWnW8t9r7wiodpKlysT7UBqxuJ9pt6GKmk1oQ5HYSY7pRGieooYf
    BkwbaUYQm3vlubbD9LImiF4reOMHi27F0oyNJ4QrZ1bs+Aug5HSMk4WnEshFv519
    7Wi8w+j+txQRkpM7E8b+h2dpumTItC1Fy8FYymvDl6X9EsilzIyoluxRs/E8Uo4l
    0F8/QQH6nqM20v6r2OUtyhFSIuvPf9hDfPSsgt0u8KBg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754399AbeCWLHI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:07:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeCWKMI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 157/177] omapdrm: panel: fix compatible vendor string for td028ttec1
Date: Fri, 23 Mar 2018 10:54:45 +0100
Message-Id: <20180323094212.115158834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "H. Nikolaus Schaller" <hns@goldelico.com>


[ Upstream commit c1b9d4c75cd549e08bd0596d7f9dcc20f7f6e8fa ]

The vendor name was "toppoly" but other panels and the vendor list
have defined it as "tpo". So let's fix it in driver and bindings.

We keep the old definition in parallel to stay compatible with
potential older DTB setup.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt |   30 ----------
 Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt     |   30 ++++++++++
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c                |    3 +
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c       |    3 +
 4 files changed, 36 insertions(+), 30 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)

--- a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Toppoly TD028TTEC1 Panel
-========================
-
-Required properties:
-- compatible: "toppoly,td028ttec1"
-
-Optional properties:
-- label: a symbolic name for the panel
-
-Required nodes:
-- Video port for DPI input
-
-Example
--------
-
-lcd-panel: td028ttec1@0 {
-	compatible = "toppoly,td028ttec1";
-	reg = <0>;
-	spi-max-frequency = <100000>;
-	spi-cpol;
-	spi-cpha;
-
-	label = "lcd";
-	port {
-		lcd_in: endpoint {
-			remote-endpoint = <&dpi_out>;
-		};
-	};
-};
-
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
@@ -0,0 +1,30 @@
+Toppoly TD028TTEC1 Panel
+========================
+
+Required properties:
+- compatible: "tpo,td028ttec1"
+
+Optional properties:
+- label: a symbolic name for the panel
+
+Required nodes:
+- Video port for DPI input
+
+Example
+-------
+
+lcd-panel: td028ttec1@0 {
+	compatible = "tpo,td028ttec1";
+	reg = <0>;
+	spi-max-frequency = <100000>;
+	spi-cpol;
+	spi-cpha;
+
+	label = "lcd";
+	port {
+		lcd_in: endpoint {
+			remote-endpoint = <&dpi_out>;
+		};
+	};
+};
+
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -456,6 +456,8 @@ static int td028ttec1_panel_remove(struc
 }
 
 static const struct of_device_id td028ttec1_of_match[] = {
+	{ .compatible = "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible = "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -475,6 +477,7 @@ static struct spi_driver td028ttec1_spi_
 
 module_spi_driver(td028ttec1_spi_driver);
 
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -455,6 +455,8 @@ static int td028ttec1_panel_remove(struc
 }
 
 static const struct of_device_id td028ttec1_of_match[] = {
+	{ .compatible = "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible = "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -474,6 +476,7 @@ static struct spi_driver td028ttec1_spi_
 
 module_spi_driver(td028ttec1_spi_driver);
 
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
