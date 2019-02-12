Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E40C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DB62075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mrPl2XTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfBLPPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:15:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46303 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbfBLPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so3034845wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lEfvGeOk1usEAZ8llxjKkiOzQN+ahvtkYpFJPi6soxQ=;
        b=mrPl2XTA02ZrZOTTKOV6YbwerRpbdV9CMe3BnIq9Qfgh0nKxk5t98JZb1RtPnsYCbx
         ohG+Nv9qn+h1EYsa65ywzS6VFgoAN/ngyjBg1sB2fgIGfT8oYzm+GebourW72INdf5FJ
         oz4nk78cufgfWoZhy/mtB06VdJcg1n6ArWqQ+36geNiP3oaKcrEdT0Di13cFTH1UkC7m
         xviVkV/6Qj+37fy6ivzkYUWtD1aXC4ib3w49aWohJ3cj4pmwEW3yBKXX2igS1bmjjg2q
         4+lxqoT+8zT+rii/ST8SGKlurSxrY2PmIz7JhKUAf4oR8gBKrYW7aqY32G+jIMcV+guK
         YRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lEfvGeOk1usEAZ8llxjKkiOzQN+ahvtkYpFJPi6soxQ=;
        b=RLk+b+Ck9WOOnF9FvvUR8GrNxbjJRhc5jSa90UMAN07FetkN9eFBQQpPwIVk0Q8dgL
         YWn3R0UdHOe5tNd3WjPdWqdbeYy6gIGDAdehBDHHkfUqhLIG4atub1SUqJoxo/lg5D1M
         pPSTbmKv3mAu0IAK46hXqKfAVdnLrJ67SPgWapDRdTL5Ms2KxrwaONYduHyBsTMrEyCz
         MiDJFaD5/QmfkXy5l7m5qR3ve4YREOOPGIgUA1GYcc3I6j9whITvi6IP0XhKXAMFq1IC
         ybJV9dYRLzYSWXnkxhULwV6dZ3ShSHGW93xMa5B+wQL/FYuKYBZjo202XgQOBxToO/OR
         70ig==
X-Gm-Message-State: AHQUAuaHzGls9OsXYxkY0HCugr536XJwIG+D3qh9cy0l9zJtXhJqJjF0
        ZMKkUJKvr72ZNCoPzqmBxYSYqw==
X-Google-Smtp-Source: AHgI3IYxKnd8AIHCEYlPT+DtsN2774Su5ayDJJB6gxk5G6/KEOGgxjSfhqycSOtgD5LnRxuJc++F6g==
X-Received: by 2002:adf:9123:: with SMTP id j32mr3464508wrj.122.1549984457297;
        Tue, 12 Feb 2019 07:14:17 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 07:14:16 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
Date:   Tue, 12 Feb 2019 16:14:06 +0100
Message-Id: <20190212151413.24632-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic G12A Family USB2 OTG PHY Bindings

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/meson-g12a-usb2-phy.txt      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
new file mode 100644
index 000000000000..a6ebc3dea159
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
@@ -0,0 +1,22 @@
+* Amlogic G12A USB2 PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb2-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+- clocks:	a phandle to the clock of this PHY
+- clock-names:	must be "xtal"
+- resets:	a phandle to the reset line of this PHY
+- reset-names:	must be "phy"
+- phy-supply:	see phy-bindings.txt in this directory
+
+Example:
+	usb2_phy0: phy@36000 {
+		compatible = "amlogic,g12a-usb2-phy";
+		reg = <0x0 0x36000 0x0 0x2000>;
+		clocks = <&xtal>;
+		clock-names = "xtal";
+		resets = <&reset RESET_USB_PHY21>;
+		reset-names = "phy";
+		#phy-cells = <0>;
+	};
-- 
2.20.1

