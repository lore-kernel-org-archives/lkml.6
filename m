Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AF5205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KyO8h6RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfAQQs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:48:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55861 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbfAQQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:48:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so1764518wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5kKnhrUsQPHyQ+0YJxeNdxVGK9txanOHvWzSakbx6g=;
        b=KyO8h6RYgoIqTOPoGdr/2d0Ia0JJ4qdN5Y94PTfhh8RxgLhziGNbbDZ53O4bfVGrrJ
         G3tHix/VFk6KEmq6i/YtidqB5woSuLCr+cHQgaztQPC6s4nUZOVzqXmaF4YjuNPWNxa3
         3LrcnixfmHBVO74tKCKgS3D2wTIS5klW+cLCEIRKN1lbLDEI7/39ks3Df6Rg+d9FqB3W
         xPYDPx539RHZdHPkulDGC6gZ2iVBnifxyR5A3yGhdGzzgBNWT8AbeO5Ecsl81fD0JJyO
         n5QddVNAXPV3bpNtiv+NvRoJ2W+Mn0SONODxrGklUepUP9ZLm24xJSkD9CynKB4MdSll
         LxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5kKnhrUsQPHyQ+0YJxeNdxVGK9txanOHvWzSakbx6g=;
        b=rdRl6EZ1ndm8aP+1th6ulYLTMnePJN4/YsLxAgc8bsOX0ri8+EMBfrKpD/psGWnx0v
         5jb6dGO/VRpTWYHmbzFndbhftZ2u63uL4EDb8tcOBH+u5upyLgP5eKlSkjNGu5alskZ5
         88s+olgTqNsAOx3C9UKJyBxqQo/B29OM8Rb9GbEF6IXiPWpTDE1FsuDy40PsLkRnNLOF
         ePyV3rim7IBeDQl+73oxa2OSbclIIeKxQdHuxGnl1UNw8jifyBUzycvIEu+hoFdACXti
         SQsqexyEmyyV7Z+DaYFYJWYtx4AXdG+O/Tyau5ok7otRlRK8YU+eoyP0mStxO1zBLcNR
         Lkdg==
X-Gm-Message-State: AJcUukdj1l7cTwql0CQ/qibb8dSOezJkyVL8BZV+Ayl+SHOqg/ujZWk2
        KWlnRt52H6nv1RRcI9TRWvb5uf6P3L0=
X-Google-Smtp-Source: ALg8bN5iLOBIeyg3tJAX6YLzPh9uz9NM17cF2SeHZAIopd7OFysZjCBuNSNtFaVCsb/mFDZEG/aOfg==
X-Received: by 2002:a1c:2d08:: with SMTP id t8mr10600578wmt.5.1547743731193;
        Thu, 17 Jan 2019 08:48:51 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j8sm99263199wmd.0.2019.01.17.08.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:48:50 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 3/4] arm64: dts: meson: axg: add clk measure support
Date:   Thu, 17 Jan 2019 17:48:37 +0100
Message-Id: <20190117164838.8008-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117164838.8008-1-jbrunet@baylibre.com>
References: <20190117164838.8008-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock measure device to the axg SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 0e0abb1a03e2..94ea36a2417a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1611,6 +1611,11 @@
 				status = "disabled";
 			};
 
+			clk_msr: clock-sensor@18000 {
+				compatible = "amlogic,meson-axg-clk-measure";
+				reg = <0x0 0x18000 0x0 0x10>;
+			};
+
 			i2c3: i2c@1c000 {
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x1c000 0x0 0x20>;
-- 
2.20.1

