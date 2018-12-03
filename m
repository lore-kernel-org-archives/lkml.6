Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F73C65BB0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EDE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EDE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeLCO7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:59:31 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50876 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbeLCO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:58:36 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 6DD975FD95; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 04/14] dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
Date:   Mon,  3 Dec 2018 22:58:15 +0800
Message-Id: <20181203145825.20511-5-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Experiments showed that on at least the H3/H5/A64 the RTC's internal
oscillator also feeds the CPUS mux in the PRCM.

Export this clock through the device tree, instead of having to use
a dummy fixed-clock device node, for the PRCM to consume. This will
properly describe the relationship between the clocks.

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
index c7aed31210bc..6b732c41392b 100644
--- a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
@@ -24,7 +24,7 @@ Required properties:
 
 Required properties for new device trees
 - clocks	: phandle to the 32kHz external oscillator
-- clock-output-names : names of up to two clock outputs. See below.
+- clock-output-names : names of up to three clock outputs. See below.
 - #clock-cells  : must be equal to 1.
 
 The RTC provides the following clocks at the given indices:
@@ -32,6 +32,7 @@ The RTC provides the following clocks at the given indices:
 - 1: LOSC external output, known as X32KFOUT in the datasheet.
      This clock is not available on the A31 and is deprecated for old
      device trees still using the "allwinner,sun6i-a31-rtc" compatible.
+- 2: InternalOSC, or internal RC oscillator (A64/H3/H5 only)
 
 Example:
 
-- 
2.20.0.rc1

