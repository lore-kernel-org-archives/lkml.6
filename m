Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0609C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A951F20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RIh5COZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A951F20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeKIXEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:04:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56129 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeKIXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:04:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10-v6so2004661wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 05:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+I5j1v2uhrYp7a+w0JrmnanyqcZu1QHnwhGzP3MC8w4=;
        b=RIh5COZlnAuI6Yol3RMa21lAYly0ocuHRCJEWnW4ui1D9MdODGKznyZENk7vOI6gPj
         gg+84pTHSAeHo4rrbikWz2EZLyWLEUeH6ab2lD8YP3BAYY0Qcf9guVjxKblFtUvx+s45
         2dwfi9AHCcScM4004ZegSCH9cmbygTEWN7JK+4735en5rlNCGOe3mx5VH/+osvHmPceD
         PP5vcbRm/wVBRL7TP5uuiXN9eTpKjMwdezPFdVDYVILbnhijXtARZagV2N6J1CvLQaCB
         85jQ0xfBgtoWCWoGvaY6wkkfIW6SznnZ3k3a0z/nUf2xaiElhVg6qZBqTxqwT/6WJNm3
         ivbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+I5j1v2uhrYp7a+w0JrmnanyqcZu1QHnwhGzP3MC8w4=;
        b=oUZW96OdiaCXfWPpU09QU2Iht1X2Wj56ZQDXm15nrS/hNC4+zQWjUfhGsx+J9VvMrI
         HJikv5+M0SgAXdFiWYHa29SJnmGWqOuhhlWyiRBqfpd3aUlCba+amcnLow71Y7MAbGQH
         5dLbxPQ9crJ8rFKNqGxqnph71FpY2BrQfTK57GYdVr57r/EEXPlcXyh7iT2yxgWQ0SUO
         Rii3T2KahoLM86TsozipRACO0TSXnjfFIdTs28iYeQqug3e96ctX6viDQ4FyUsSqxKvi
         BP66edSauFwBlgs9ktUwbBeur7DC08LLcl/9a4RnHTGM1aHAYBL08NXYKCGj6UnhvM+u
         JQZw==
X-Gm-Message-State: AGRZ1gKywtuY7kUWDTEVfWxCFzXFvgr5gSxhWtquYrALtBLYeJKzdq0/
        tkQZpwE/RYG5DL2Kl4arVQS4+A==
X-Google-Smtp-Source: AJdET5caYS6SZm/Zsf93t4O1fQQJE9vYKsTlpNg4KbJPUoWFCXoL/pM03MQO/g+K8K/zv6rlwyyVGw==
X-Received: by 2002:a7b:ca56:: with SMTP id m22-v6mr2866097wml.1.1541769825182;
        Fri, 09 Nov 2018 05:23:45 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id t129-v6sm2003123wmd.14.2018.11.09.05.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 05:23:44 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: s400: add bcm bluetooth device
Date:   Fri,  9 Nov 2018 14:23:31 +0100
Message-Id: <20181109132331.12010-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add broadcom bluetooth device on the s400

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 29ccb8ad0de6..7759fda3ddfd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -546,6 +546,11 @@
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
 	pinctrl-names = "default";
 	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_21 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &uart_AO {
-- 
2.19.1

