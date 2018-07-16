Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A4D208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ryiD0Nb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A4D208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbeGPKin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41873 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731479AbeGPKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so24745879wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K0pMweO19QDHJMCEvav4THLtTQUf2jPJ7gEwdA6dlok=;
        b=ryiD0Nb4bu5mRvybl9S5Jj49+xl3AFPAIMJ1XHJi/+eop0FT1Dk9EWh/2sE8PJ7s86
         5p1Iwj59G1CNKsXi5SL7TT1a6+Otsagt9nhNEcBsTWwcbhDhBnbEtKWOZYem7LRKPLdW
         mhM6xJeY0Vh0Y5ien8f1cdbm5QpDreqb9p7I3l6UH2hXHQoZxg1E9wUvcJMzhOBJwJKI
         wa7oCNfFL63yGIFb26RbRVkmzonENRiKJtfH5VXEH1P7rpbYukRjXxBfwYKITDWQzPGA
         qNYW3Pe1dtapIteoPaipdcP+WNI9i+ra6+rc2daamNQYQWg0gNphmqQStP4MiOl21gde
         +j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K0pMweO19QDHJMCEvav4THLtTQUf2jPJ7gEwdA6dlok=;
        b=VAkQhqjsJdqXSZqu5M71dSrSZsmTnklpPPHR4dv9pyvXwAmTXH/1StTmufOd7AROCd
         VdcgJrwWbv5Ytju5dnZShlu9aOfm3wZPo8fMSUu3daeegqqadacuAp00+hNJT78szbav
         K1cd5VE+Rfectz10L45CGaTA92sIyg+0n4sx4qmKCP8sh6WVaZjnpqT580NJsFCGs1W4
         pCkZT/aPzEdDLzhb0p35NFjIcSXyFebLRRqgI0USLLjlEmaaqf/aUyDNR0YcqvO8ek2M
         bsJFV0pPRyxe+fc7WrqNQJfElHPx7BohrlJrZnqelHPhLZz8ggntVJHZFZOJ3/YfKG2t
         6HjA==
X-Gm-Message-State: AOUpUlE8+yFffGZUdhp5LVGk5eTIvKg4Xbbad3L7Ganvis1Vwpux6AO9
        hyShMFrcMDQClnRWH+9zqUwoLg==
X-Google-Smtp-Source: AAOMgpdNSVPyIKfhEXBPMJEPXTt6Zq5v4hOGl+i8BAGGV1xueV71TD4XIecYN9Vs5lQs080tn2KCcg==
X-Received: by 2002:a5d:46d1:: with SMTP id g17-v6mr3497260wrs.76.1531735920777;
        Mon, 16 Jul 2018 03:12:00 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h14-v6sm10219094wro.15.2018.07.16.03.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 03:12:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 5/6] ARM64: dts: meson-axg: add pdm pins
Date:   Mon, 16 Jul 2018 12:11:50 +0200
Message-Id: <20180716101151.31109-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pdm input pin definitions to meson AXG

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 277958ff516a..461be4a35f92 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -477,6 +477,48 @@
 					};
 				};
 
+				pdm_dclk_a14_pins: pdm_dclk_a14 {
+					mux {
+						groups = "pdm_dclk_a14";
+						function = "pdm";
+					};
+				};
+
+				pdm_dclk_a19_pins: pdm_dclk_a19 {
+					mux {
+						groups = "pdm_dclk_a19";
+						function = "pdm";
+					};
+				};
+
+				pdm_din0_pins: pdm_din0 {
+					mux {
+						groups = "pdm_din0";
+						function = "pdm";
+					};
+				};
+
+				pdm_din1_pins: pdm_din1 {
+					mux {
+						groups = "pdm_din1";
+						function = "pdm";
+					};
+				};
+
+				pdm_din2_pins: pdm_din2 {
+					mux {
+						groups = "pdm_din2";
+						function = "pdm";
+					};
+				};
+
+				pdm_din3_pins: pdm_din3 {
+					mux {
+						groups = "pdm_din3";
+						function = "pdm";
+					};
+				};
+
 				pwm_a_a_pins: pwm_a_a {
 					mux {
 						groups = "pwm_a_a";
-- 
2.14.4

