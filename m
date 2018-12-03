Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D29C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806CF206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PojLIeY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806CF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbeLCNUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:20:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeLCNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:20:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so12156727wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kB5h7/Rv1D1xOyHHlP5vWdrL7/AqkFtz/4BXIM0rK9U=;
        b=PojLIeY3MW0adsgpleN5wGL91ePZiK4bHuEPzWbp8iRQf9aOBjXrjkuJjgj0XlEg/b
         KWVx/quw7zUfLbHi8w53zvLr8asluoOFM38tJU6sE/YojRqOVV3SFa5QDrNR5OaIOjtg
         +g2ADTdPlkRBmbpCCqwdFhgdPtdXwejPIMXYWFsfUqiqX2wWGVFfMqT7SdsBblRGJXYo
         sQOkIq6lo6eg+GZ5T0OOMTZG5BcNIgFbo0/KVp49qmlZxEC+wxLwzFZb/bS4QTT+S/6G
         FAA9c7h5lqqG2znsuCzgCHC+3Ij/Ou9YxjiNh8745npYVHKJf9gBUaDI4lMmWzHuNyZw
         /lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kB5h7/Rv1D1xOyHHlP5vWdrL7/AqkFtz/4BXIM0rK9U=;
        b=IIH5CdvmaN72dM/NaEkd4IHLmyvX0/Z0Ewl4UI2nhUi7XfkjfIQmmmKL+mBvBE/rHN
         rZ6hq5JczYWo2W/u7+9DMIr3NGLHPl1yHmTQjcHFRBIoPcpS98gWcpF/CmXKQWnU4nRx
         hUhdLjN65WgypPOfvQyypeMdEsgjywVt7Z+t+42n1hX2KvHD8neWOYpXMokNDvuwpLTl
         E1UhEKC94RL52omdMkBYHXUqi88vCsgskgc7bta6Bn0PncS0opqCwsQKAKTKjdPzsUtc
         KJHyDAXxNES/fvnmL9AyC+72XystVY6ZWK0RgooS4xCZsZjWzr4mFDW3mgCwC0pBJMSo
         H8nA==
X-Gm-Message-State: AA+aEWaQq3zve/JJQ3Z9RyyIyuICmYIiwlOvYBrfVfbjH01Ux2XEBl8K
        egke0TNYxsB482jr9im1vYiKdw==
X-Google-Smtp-Source: AFSGD/UZF9UuEkYeIdajIAI7B7XhcajFUllHFzFJcGmdcIDTGR5C8gZ9gaClJ87PzrGgYeZqqPdjrw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr13759344wrr.155.1543843143160;
        Mon, 03 Dec 2018 05:19:03 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id n19sm6371063wmh.26.2018.12.03.05.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 05:19:02 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: clk: meson: add main controller clock input
Date:   Mon,  3 Dec 2018 14:18:49 +0100
Message-Id: <20181203131850.31388-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203131850.31388-1-jbrunet@baylibre.com>
References: <20181203131850.31388-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock input of the main clock controller

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index e950599566a9..a6871953bf04 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -9,6 +9,9 @@ Required Properties:
 		"amlogic,gxbb-clkc" for GXBB SoC,
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
+- clocks : list of clock phandle, one for each entry clock-names.
+- clock-names : should contain the following:
+  * "xtal": the platform xtal
 
 - #clock-cells: should be 1.
 
@@ -31,6 +34,8 @@ sysctrl: system-controller@0 {
 	clkc: clock-controller {
 		#clock-cells = <1>;
 		compatible = "amlogic,gxbb-clkc";
+		clocks = <&xtal>;
+		clock-names = "xtal";
 	};
 };
 
-- 
2.19.1

