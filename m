Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B902AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FD220C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XUiJLkyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FD220C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbeHWPaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:30:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38861 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbeHWPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:30:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so4414565wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooE/rkkGa8uBIKT5dxhX97Hba4/zd5ds4uMb7/j7SJc=;
        b=XUiJLkybbVMSLQJd8RsuZ0Jb6ZmYnYb1osK7qVJEQNwfGmlduUpr1X4uIQ04rXIqSA
         j1xun2ZnVNjhwrWJY3AA5TLBk/GiE5l5KhMV4T+hz9dgfUeak8zyNnONkmQe62ul9wfg
         5kbXBTTN5JepJ9P4kkGljFWx3ysRajwpFPWNcxe8i16n85pP9+Ck28hEGj5nle3nYk5A
         LPyUkHeA9TwbGR5Rzjw+7f4q8c9LTRcLxlojawxfW1V0Hz/C9OnQAwtSlo2XoptYLJyP
         nWbJWEzEYnB5Y1UtBXCPJM7s+fvf5A/S4mB1VOSC00vwMkCRnlXr0N2fjYaXjpekjbOq
         c2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ooE/rkkGa8uBIKT5dxhX97Hba4/zd5ds4uMb7/j7SJc=;
        b=VmerE+xm67eSKqdwXoiOqsVC5t+7XpZGomIkACeqNCE1H+K1CHFTcj7txQRo79bgmX
         DQ5PA+F58QLqVow4Gwlv4KSc1RRuR5SABcjIzsHWn7eKK9B1iLAHFliQTWv/cDS7Vo68
         UX1vgmY4mXmisO6WE/q9adfBecpi5xEpgFqIekZ6hwBzVdCTwSfFAqeIBIBkrZTjGjlJ
         niwimeQIBfAIvjWrY4XnmDVxdL9GZay5Gg1OF0PoX9+pBhs08xkPNEXeMUGhpMC/2m/Z
         MVl/912wmYPjE8r2asm8/CrLTJInNxZcXp6kHZh9yEHWLgmfP9flybpP/48P/0NX4tdu
         ybcw==
X-Gm-Message-State: AOUpUlGm3XUJYh22y7E5df8RZAp/LzGGlcWk6x21gbgl5PY0d6wVJYuw
        bi0Sk1l/8DtoKQVe4emX2BCRSQ==
X-Google-Smtp-Source: AA+uWPx4fhoRuT502dF3E53cCuB/y7UMgew04mgF6FMdXMN+lz81BI4PTK+Dxu1OX7eiNhOVmMQ2TQ==
X-Received: by 2002:adf:f410:: with SMTP id g16-v6mr37555121wro.256.1535025645513;
        Thu, 23 Aug 2018 05:00:45 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id y10-v6sm2830419wrl.87.2018.08.23.05.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 05:00:44 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: soc: amlogic: add meson-canvas documentation
Date:   Thu, 23 Aug 2018 13:49:52 +0200
Message-Id: <20180823114954.30704-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823114954.30704-1-mjourdan@baylibre.com>
References: <20180823114954.30704-1-mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings doc for amlogic,meson-canvas

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../bindings/soc/amlogic/amlogic,canvas.txt   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
new file mode 100644
index 000000000000..436d2106e80d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
@@ -0,0 +1,29 @@
+Amlogic Canvas
+================================
+
+A canvas is a collection of metadata that describes a pixel buffer.
+Those metadata include: width, height, phyaddr, wrapping, block mode
+and endianness.
+
+Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
+rather than use the phy addresses directly. For instance, this is the case for
+the video decoders and the display.
+
+Amlogic SoCs have 256 canvas.
+
+Device Tree Bindings:
+---------------------
+
+Video Lookup Table
+--------------------------
+
+Required properties:
+- compatible: "amlogic,canvas"
+- reg: Base physical address and size of the canvas registers.
+
+Example:
+
+canvas: video-lut@48 {
+	compatible = "amlogic,canvas";
+	reg = <0x0 0x48 0x0 0x14>;
+};
-- 
2.18.0

