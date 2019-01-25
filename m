Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B22FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F212087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="caB+2KxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfAYTWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:22:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34093 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:22:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so4599915pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szGl+82zV5PheiGr3K09m5lJ0P6dvb1tBJjcTMBUukQ=;
        b=caB+2KxCgRVdZ5TKNlpcjJthfS0X8+2p/RiRjRNamsFwoHW4sKc7IiW48BP24FbJYn
         W4MaIUXvFMAmSQ1po7Rz7AqcFcvUqrjG4eR1NaV8vmmMORwSqmiyRYopBFGcDVr9B/og
         9qfAHdy5UkHcZ4NNZ3+Uqn/FO/M25EGd5QRas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szGl+82zV5PheiGr3K09m5lJ0P6dvb1tBJjcTMBUukQ=;
        b=MMENWFNoOlt/Mg73iAgsh+S0ZLdKcX81pzfFKXsSHUwBk2hZSiZSmwhIo0xyeR8+qp
         8XlLpjLpQzNtwDdxfZnc6M1R6EONznqGJReusgh5dfNnJFu3YdTa3rpI593Q2jQY5+me
         eIpilJOLcfmwFJQHkwB8B3tfNgR1pPXYMXTtS/wNE4aNkhqkfWDkVaB/BUUC7ZkXRRxw
         twnFZm5ysDKQqjAnn4yd0Iz7145LsjaNoasFfNMhbKv9zzruXvVq/Wd6cwHJZVcF4zIp
         oqd8WLCrhBlHMCbk+LzgBNQhnkUI+k6yS6DGFm26Z9YVFEQZ0wpAz8DfGQPWluzEvePC
         cuuw==
X-Gm-Message-State: AJcUukeOW1sSE5bGKYKXDRBUEB8Go8pcH4/lULFNKKeIMcT4S96Y54EA
        2EZ20Lg/fwK2bnMQzyOl/sBxkl4nZv8=
X-Google-Smtp-Source: ALg8bN5LVEOsMYD0fpk10RWXA3PF/yzlGpfJ2u75rxVTOy53l6MaENcHbueE7LLsEKGJSZo+muPltg==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr11052456pga.237.1548444162858;
        Fri, 25 Jan 2019 11:22:42 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id s2sm49828182pfa.167.2019.01.25.11.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 11:22:42 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 1/2] dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Sat, 26 Jan 2019 00:52:32 +0530
Message-Id: <20190125192233.10019-1-jagan@amarulasolutions.com>
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
Changes for v5, v4, v3:
- none
Changes for v2:
- new patch, derived from another dsi series 

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

