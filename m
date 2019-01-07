Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BA12089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ag2NYCPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfAGJxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:53:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33410 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfAGJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:53:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so287521eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNlqm1X3Atjb25AV1tWHXoXpMEFSSSDH/PGAPmX/AtU=;
        b=Ag2NYCPIpVkZH2b+oJg0P28I5ij8lt4XNPUPnEO/83l2dqPs5NM4yCtzgYM99YJZkL
         RQ4S5KrfjUQIVr6VYqZ9ukssDf8laDqARiKxDJnU2TvwlwoxnIttqzL/9ci81lmexa3h
         WJJxBMIiz56vx3QAdrtfhJqehVBYzSgDx/jzBgghguKfYqEfufG7ECrNvQYXoDE+0obY
         EZECO77DEtxipxj7Kk9dztUEXRvR1asRsC7vpgifeVC7J1w07hqhdJ/rqzPkWwdF+xyC
         wdgvEw9aq1WxoxymZIzWTVlVI5uI9nSSiDX4xnJEe/B85yL1pGBPbQgTHHOaJf+WQ7rd
         QFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNlqm1X3Atjb25AV1tWHXoXpMEFSSSDH/PGAPmX/AtU=;
        b=oQNpP3REKKmL81MlX4n1SFF6+eY5eRV2JAbGJIZiJVjUhPbcZtoDDfyu87H1Bfb7QB
         hHEfMrgXM1mxK1mgpaCnNGr5ZQo2jUQwCxQc2p4AdDoyZTh69/ZBMdv4neDNWvAtHYDf
         cei8ob3uKWnjQCa2uxjxs3rf4pGlp7vAah+g5amxxEgtb/WzRhN46qMLOlB7C8lv92Ns
         HA/yDFhstpc+Ige1R5qWHwr70ZpjkpRbb6vDLSURfIqduQxNpCjULJsd98w2G76iCWLs
         Ah98gr9yr+Zcw1GXISBOLiYMnSzo0sD8u6fnykrxU0y4hJQa2eaAT3lg5c4KpbU8gFea
         UAAg==
X-Gm-Message-State: AA+aEWYKM1IP8mhLyVkXgJltZpUpRjCMNokZustYNZiCf0JePRUoax9X
        seDpRRJQU/yYawsmNewseOemHQ==
X-Google-Smtp-Source: AFSGD/VB9Kh1/gVWE4gr/W1wMTPUn9+Mkxk4vTMo7msLAcnrwKTjwXOz2tN9CVZUKTeNW637/t4Dlg==
X-Received: by 2002:a17:906:4c94:: with SMTP id q20-v6mr46459042eju.26.1546854798987;
        Mon, 07 Jan 2019 01:53:18 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id f6sm35737049ede.53.2019.01.07.01.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:53:18 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: meson: add specific simplefb bindings
Date:   Mon,  7 Jan 2019 10:53:06 +0100
Message-Id: <20190107095307.15233-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107095307.15233-1-mjourdan@baylibre.com>
References: <20190107095307.15233-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to simple-framebuffer-sunxi, we support different display pipelines
that the firmware is free to choose from.

This documents the "amlogic,simple-framebuffer" compatible and the
"amlogic,pipeline" extension.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
new file mode 100644
index 000000000000..aaa6c24c8e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
@@ -0,0 +1,33 @@
+Meson specific Simple Framebuffer bindings
+
+This binding documents meson specific extensions to the simple-framebuffer
+bindings. The meson simplefb u-boot code relies on the devicetree containing
+pre-populated simplefb nodes.
+
+These extensions are intended so that u-boot can select the right node based
+on which pipeline is being used. As such they are solely intended for
+firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "amlogic,simple-framebuffer", "simple-framebuffer"
+- amlogic,pipeline, one of:
+  "vpu-cvbs"
+  "vpu-hdmi"
+
+Example:
+
+chosen {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	simplefb_hdmi: framebuffer-hdmi {
+		compatible = "amlogic,simple-framebuffer",
+			     "simple-framebuffer";
+		amlogic,pipeline = "vpu-hdmi";
+		clocks = <&clkc CLKID_HDMI_PCLK>,
+			 <&clkc CLKID_CLK81>,
+			 <&clkc CLKID_GCLK_VENCI_INT0>;
+		power-domains = <&pwrc_vpu>;
+	};
+};
-- 
2.20.1

