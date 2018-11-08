Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D5C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15902086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FuL4yb2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15902086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeKHTbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:31:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50710 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKHTbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:31:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so613875wmw.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hc6OuGb0DhAp/nFNZp+ZqxOBz1Z4qSKKsbvg26kvZxM=;
        b=FuL4yb2Ny50POrTQul4jVSHX8YlYY7iMMitWh7pH8FNaANZJvoEKVfop+mcaiSpm/D
         fAEJ30Yk5RkiLjTF3WO4XLBq76hWNh8iGOD3GZQeWzHdbsYZJ24CXvJ5/rCvaZYTkaL3
         y0b4AVaH5Pg5/9rXWvDFlZL0vG50nmP5hC3898vDqNeTcXpPbbPxaIO7ZoUeAruXV7z8
         MT3vFvbR/nweirTU5a+1RBxLV9ELfe2uvCNDrJxfgXVEyUhSS5FUPUGp6PVtj/PWEbRr
         DVOf28C/OQj1A7d6QGiyavxHrS/swYVm1gSBD0Je3tTVVn9VZfNwoWXIgheXSXCvGjog
         q4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hc6OuGb0DhAp/nFNZp+ZqxOBz1Z4qSKKsbvg26kvZxM=;
        b=m1BANxZLx3kvFGqlHu5eU//grR4GpnbPv9ygOKLFdLCLaB9sOENORmgBTlhCj97RFH
         9GTCJb0ERaBoMkUnYuwruYUCMmV6PAhncGcos9aishEWrJzXd+hOvdVSKbD6rsAoeFBB
         EdgfGNNgXq5n10ZWnU9GpuBRKBOLwrE3N/DhpIDTE+Y6kmFyVbipJtq8s8ox4T0sJ3mz
         8elDgrqcqaviIu4ehnLykTf862Wyfx7IlFvoUwWaIdtpBzYc0D4k1QXOSDZGDsg4AgBC
         BXBCq76aGWlSTLOt2t/aC63tPpFp8bbdru6aVkTl/x9JVCp/EuQVCBuAnIsTqAY0yHrI
         IgRw==
X-Gm-Message-State: AGRZ1gIV8TK9UqKgsXS9/dXJjY3obkiYWrPhD9/VztbBbiJbZ6GcAXWX
        9NwoqIeO/DLjEEmb3hdnTbv+IQ==
X-Google-Smtp-Source: AJdET5fhiVUDn9iNhj/KargwaYroNhXyhZi7vTMCJ2BAV0MNV2je9A07lninQILjeO8TUpljrYoFow==
X-Received: by 2002:a1c:e004:: with SMTP id x4-v6mr575419wmg.71.1541671014468;
        Thu, 08 Nov 2018 01:56:54 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id g8-v6sm3811553wri.58.2018.11.08.01.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:56:53 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-axg: s400: add cts-rts to the bluetooth uart
Date:   Thu,  8 Nov 2018 10:56:40 +0100
Message-Id: <20181108095640.27876-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uart used with bluetooth chipset on the s400 has flow control
available. Let's enable it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index ba44b0419404..29ccb8ad0de6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -543,8 +543,9 @@
 
 &uart_A {
 	status = "okay";
-	pinctrl-0 = <&uart_a_pins>;
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
+	uart-has-rtscts;
 };
 
 &uart_AO {
-- 
2.19.1

