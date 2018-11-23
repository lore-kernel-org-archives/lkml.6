Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F36C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B29B205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oWr9/8lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B29B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633207AbeKXGjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:39:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42872 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbeKXGjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:39:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so13331465wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BoOn6WTxlwavf65DbwHydv4Xd7ja4A3o1y3Q9+BXoUc=;
        b=oWr9/8lWcfbP1NgcvUYxiLWASzyptweuU7b1ABtqtlf28PrNPXSmhoLG8e+6Zz446x
         JR77fpYnXmeV5yuyaSW++DMo1tFbXo7bOXHeiMmh5HXp6KX3t/SursOJt2l/YBQjBALw
         wBONO5l6Xq+ljXa50hJH2/q4Z1rRr8Kycj8JduTvT/JqB+2lwlNKFGRD2FifVgk1Tj5B
         oflt24QE6++lpCf7H2L6NPu8r5ZIuCw4Mk8IJ6zvvXsneCS8FiAfV0flRzLYe7VFEc/g
         3yQc0VLhG9fIgrNAs4ZbLEGwdxU2LELOyrG1Z1zlDkjOYT/GO0O3SYE+0b/xFEKfVYiQ
         /VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BoOn6WTxlwavf65DbwHydv4Xd7ja4A3o1y3Q9+BXoUc=;
        b=S0aVmxEMB6HhSIRVuIHQ/i1WmCaTZHNVAOb0hssSXDkFJ5UEGf9+zZ078BZM2RW6yv
         ABn6x9xcROHi4ZorYDs5gPXfKABrVyqnV9TyWR8t2u/fa9FZBlFP01Q/YM8uDNb7WEaV
         7nKPIXTPDmCFNZZPqwk5louJunYWJNJPRqhTfnF0P3EMz53sCxUaITdYO0CBR2hhmyMy
         /9AIu7L0UheLAl6uXVZcQa9is3nuCVg6jOW42uXqWY16jKWJj1FBhfgOJkVPhm9Aifmc
         3Ejmtd1eN2LYAvqL8bTvzIyAG0v5a7enYWpKRjJqrCARdodVmneB4jZGzwojeZgUr8+w
         hAJA==
X-Gm-Message-State: AA+aEWbHcwtM1kAhw+QUIdQFSg7Kl1T0iBN2bXNR7wpVi4YkUzdA8VOm
        kP0NyhcGiUPUxGuUafSLy5M=
X-Google-Smtp-Source: AFSGD/WPpPun6H0bsMadmb9/+iZ4oiq8FDm5jX2mjw7Ginr5bCq9cCGOj4U/G2f70sp/9VBzGr3PCA==
X-Received: by 2002:adf:c6c3:: with SMTP id c3-v6mr14724361wrh.243.1543002808790;
        Fri, 23 Nov 2018 11:53:28 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F500597D16A631573221.dip0.t-ipconnect.de. [2003:dc:d732:f500:597d:16a6:3157:3221])
        by smtp.googlemail.com with ESMTPSA id g198sm11495337wmd.23.2018.11.23.11.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:53:28 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/6] ARM: dts: meson8: add the Cortex-A9 global timer
Date:   Fri, 23 Nov 2018 20:53:09 +0100
Message-Id: <20181123195311.4578-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8 and Meson8m2 SoCs are using four Cortex-A9 cores. These come
with an ARM global timer.
This adds the Cortex-A9 global timer but keeps it disabled for now. The
timer is clocked by the "PERIPH" clock whose rate can change during
runtime (when changing the frequency of the CPU clock). Unfortunately
the arm_global_timer driver does not handle changes to the clock rate
yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 2b0b3edbd896..2575a5835567 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -363,6 +363,19 @@
 		reg = <0x0 0x100>;
 	};
 
+	timer@200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x200 0x20>;
+		interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
+		clocks = <&clkc CLKID_PERIPH>;
+
+		/*
+		 * the arm_global_timer driver currently does not handle clock
+		 * rate changes. Keep it disabled for now.
+		 */
+		status = "disabled";
+	};
+
 	timer@600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x600 0x20>;
-- 
2.19.2

