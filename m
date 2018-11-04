Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E98ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14132085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA1jdtvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14132085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbeKEBKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:10:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33517 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbeKEBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:10:44 -0500
Received: by mail-it1-f193.google.com with SMTP id p11-v6so5612756itf.0;
        Sun, 04 Nov 2018 07:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//0x2oVOwuQZBZM0sURDizLZKaOZ39yjCfNjkaCu9n8=;
        b=XA1jdtvGrjgC277XvUySLQpJ9soUdnIQHG4cH31RoqN7jAll6fynj6f60fsQq4sNba
         87H+BaNRYjglPE7tuypI1y12PCJH6JosydQR8dsN0t4N1+HIV1EiDXQaM1z7FuZne78K
         u0hhUQYyjOzK5aQ4br5XcRE0QrSNhUmvBP87kFBs57Ld/AsQcM4lqjJ7f/BSi4sloOQJ
         Ix6oh+A3t8hscbbxBKeIX0aO0g/LNBKtYgu10A0iQYWsnxPNbXFLbLq2PC92W/QXaypB
         c9/fx1IFjLtv/bGv0S66O9jJTWj9ykBhJNBK+5DdeEBg1Hon2Hft4KGsOKlOn5d5YnNP
         0bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//0x2oVOwuQZBZM0sURDizLZKaOZ39yjCfNjkaCu9n8=;
        b=ZZ5v99jTfVow2s6AJjudEZR+9kAI4U1BhkqLHyAxLm3+5w5RzV3k/v3C5nQAZjFcLp
         Y2LumZX/gxIgwuFrp/E0qNQz29kGqO3ePsOETTyRQEb2xta5QovOAbEuVsX4FDclJw+7
         ujzMQm0OPfV6rnd15QlVMqhHcLyWgjk0UZRZ9PIzmC9uzeec3zt5KJMjkR5tAb0nnWFU
         3YhbS62/GSzKYYyACv2x3WSMWMnRtp/iFPKf6vTLr1hzl34TRePF8yhkDA5QMQbq+yYV
         lY6svWlDHBbSLdKEBz47WSfDwwOE1eFWWQtMlGOyz3Qevp3/l1MqvyGIIt/od0ZVeDHd
         Wxcg==
X-Gm-Message-State: AGRZ1gLXxzSNGMWY2VeOl4S55nSbvv7fO/fpXRsVTY1LuUd7cgTDifOB
        9luJfuaOwxkQ5srh6wprRsfg8sML
X-Google-Smtp-Source: AJdET5dqzo5TsvISETLvJmR0FN8BaOzCBfgeNee+7CNjlgx8ppIgLBWBLhy5JePYFuu4oDufv+mxEw==
X-Received: by 2002:a24:140b:: with SMTP id 11-v6mr3966676itg.59.1541346917499;
        Sun, 04 Nov 2018 07:55:17 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id j13-v6sm2887482ita.27.2018.11.04.07.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 07:55:17 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v3 3/6] dt-bindings: anybus-bridge: document devicetree binding
Date:   Sun,  4 Nov 2018 10:54:58 -0500
Message-Id: <20181104155501.14767-4-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104155501.14767-1-TheSven73@googlemail.com>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

This patch adds devicetree binding documentation for the
Arcx anybus bridge.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../bindings/misc/arcx,anybus-bridge.txt      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt

diff --git a/Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt b/Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt
new file mode 100644
index 000000000000..cb801b7568b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/arcx,anybus-bridge.txt
@@ -0,0 +1,34 @@
+* Arcx anybus bridge
+
+This chip communicates with the SoC over a parallel bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the parallel bus used for communication.
+
+Required properties:
+
+  - compatible : The following chip-specific string:
+        "arcx,anybus-bridge"
+
+  - reg : bus memory area where the cpld registers are located.
+
+  - reset-gpios : the GPIO pin connected to the reset line of the bridge.
+
+  - #reset-cells : Must be 1.
+	this bridge is a reset provider to its two embedded Anybus-S slots.
+
+Example of usage:
+
+This example places the bridge on top of the i.MX WEIM parallel bus, see:
+Documentation/devicetree/bindings/bus/imx-weim.txt
+
+&weim {
+	anybus_bridge: bridge@0,0 {
+		compatible = "arcx,anybus-bridge";
+		reg = <0 0 0x100>;
+		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		#reset-cells = <1>;
+		/* fsl,weim-cs-timing is a i.MX WEIM bus specific property */
+		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+	};
+};
-- 
2.17.1

