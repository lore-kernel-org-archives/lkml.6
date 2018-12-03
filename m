Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1823DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFC9206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vNGt/j06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFC9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLCNUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:20:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeLCNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:20:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so12140172wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPWsn16HihaqS/gJnLipzT9xenTcdp/r8TBEXkQVJFg=;
        b=vNGt/j06zioXmLqN7+O4N2/xxw43bBG4RDIvXHM2l8hwHjcgsiyfFjcgxdVmM9AbJF
         O6852rDf0+btUzp5XwE8v3NvXqInWQ0AfKxsEd1z/fzCpCRrnVuew/BjKbMUJd2z4tsb
         Lr1LDICFBuD6zyevW9g1GRkcgq+8WLXSSMptI0l9epPExeNKy0fnDDW+fRI3fCazaAm8
         tYjDio8gdOZtMq8vM4i4riSDM1LA7CDZO0bsyJwTRCk3tezk3vNGWuAiYF5fLMOdXw4y
         oUxltE6KXRuMY+sNTkbI4OiQgWD6ImmyyAWjVawAtbljC20OVD+SPnC0B9mDLkBDnMUT
         m2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPWsn16HihaqS/gJnLipzT9xenTcdp/r8TBEXkQVJFg=;
        b=XGrvdl8kCsGU4vZCQWngcWkvym5/H71KAHuOLGKWohOpiBDYVBcPui4eweBUbLQA1p
         SB/0ZVrEj77IWkyyhRClE12Kcvyxvaq5F5MvZ8KJpLAxklLRL4fEN8swWIx5T+eYjVf9
         UrmWCf7HXfhLNgrRQhIaW+1KiipBU+PhCot7aN5VE8mKxKg5ihoCehIY6HSHds6K7re7
         BiGOY1XomD+n4OK+UPjIZmlCqQ0S2xOqzuzvt7FFxF4n6maiM+VTrLkuvegA9RxNlRWS
         ihO8aDbNQlybLM7RRM0oGI7+KtVZEPRaQoNUuiMKJT6feXWB93/A2WkyPDGSKwC7AGX2
         HvgQ==
X-Gm-Message-State: AA+aEWYj/E6S/5eEYTBbwGJNoow9/Lk3Tw2K0F8D3sqiWhTwhBGbFEt9
        Jn81fwJkuadrxKVtJYKcm4u4IQ==
X-Google-Smtp-Source: AFSGD/Wr2vfY+7XmL4gftuGy4Mnt/MoiOvt8Vtp1ZtW1fAJh4B9fvGvZYtjugzQeaakwGff/x3XOhA==
X-Received: by 2002:a5d:5208:: with SMTP id j8mr14566353wrv.188.1543843141765;
        Mon, 03 Dec 2018 05:19:01 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id n19sm6371063wmh.26.2018.12.03.05.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 05:19:01 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: clk: meson: add ao controller clock inputs
Date:   Mon,  3 Dec 2018 14:18:48 +0100
Message-Id: <20181203131850.31388-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203131850.31388-1-jbrunet@baylibre.com>
References: <20181203131850.31388-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock inputs of amlogic AO clock controller

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt     | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
index 3a880528030e..c480db8f4793 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -11,6 +11,11 @@ Required Properties:
 	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
 	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
 	followed by the common "amlogic,meson-gx-aoclkc"
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "xtal"     : the platform xtal
+  * "mpeg-clk" : the main clock controller mother clock (aka clk81)
+  * "ext-32k"  : external 32kHz reference if any (optional)
 
 - #clock-cells: should be 1.
 
@@ -40,8 +45,9 @@ ao_sysctrl: sys-ctrl@0 {
 		compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		clocks = <&xtal>, <&clkc CLKID_CLK81>;
+		clock-names = "xtal", "mpeg-clk";
 	};
-};
 
 Example: UART controller node that consumes the clock and reset generated
   by the clock controller:
-- 
2.19.1

