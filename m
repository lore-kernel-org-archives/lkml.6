Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCED32080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kr0ZaYDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbeLNUlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:41:19 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39965 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbeLNUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:41:18 -0500
Received: by mail-yb1-f193.google.com with SMTP id e12so2798282ybq.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=665K/Cm6n9py6mesytNFhloDXdXhlW+DHJgvcuux1Qw=;
        b=kr0ZaYDunqAvr48N0h+e8zl/lr9mAc9lSsjUU0itjAt3rs/rMzbBbi+zMqI4OTSGCA
         3MG7MuYt35sQHs7L9Z6hxf2kI1Jc7HXRoVEg/1hiYwrihR4sqJWLaljE02XcE2P4Q1fs
         VYDu872RBOBvNVxaOs+g1oaxXrcZgUEgsqaFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=665K/Cm6n9py6mesytNFhloDXdXhlW+DHJgvcuux1Qw=;
        b=HSVgNd6WpwkNLcQqP7OqPaRfAsSXgh4wM/Cc38nD/Kujg6J5lwb4q+6NrVf0kxKT/n
         N/M9UdqKq2Spm83Xz3lYgMlSqLRgNpvgj6SCyh0FLMeWwTokKS0iad1Cfz8ZMUbuVeja
         1NHc6zKYnSbZjXzkBCdqxj52ebRh4vn7rieH0SenqWlff3EYX7aEksUSi5GhsQg4ROF2
         6wp6ITsbRojVSSAvod8hnsyeT6IdMOQXKeNbHiyZalXMvN+eYMOAOVZdFdiCWBSuE6bP
         n2xp1Adk4easgEIjxpUOHpPTISDqy0+CJrZfHE86kL7+3Blxp78B/LSMxEa2XjFmB292
         3hZA==
X-Gm-Message-State: AA+aEWaXIRgoSlZCBbRVVmWBUIdm4qRleJQP5F6Aq9W9Gr44jdxtV5q+
        yXXJBE7xz2BBqBOq+5VOY7de9Q==
X-Google-Smtp-Source: AFSGD/XPdr3tbrXi/2+U3CN8UwKzc9G9WLJsxxWvtg1r6XbnglY3sf4LXcEgMeUdwEnXNxaXu8pOhg==
X-Received: by 2002:a25:a141:: with SMTP id z59-v6mr4498883ybh.340.1544820077470;
        Fri, 14 Dec 2018 12:41:17 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host211-95-static.0-79-b.business.telecomitalia.it. [79.0.95.211])
        by smtp.gmail.com with ESMTPSA id k62sm16278ywk.84.2018.12.14.12.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 12:41:16 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/2] dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Sat, 15 Dec 2018 02:11:00 +0530
Message-Id: <20181214204101.9681-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.

Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
- none

 .../display/panel/feiyang,fy07024di26a30d.txt | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
new file mode 100644
index 000000000000..82caa7b65ae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
@@ -0,0 +1,20 @@
+Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
+
+Required properties:
+- compatible: must be "feiyang,fy07024di26a30d"
+- reg: DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "feiyang,fy07024di26a30d";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo2>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

