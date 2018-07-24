Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CBCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82B120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QH88hvMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82B120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeGXN7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40483 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388441AbeGXN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so4022991wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2gm9y/N9OWSpJqr6m3qsCkKZCUpLkEz5tg6SxUSEII=;
        b=QH88hvMKJcmYPGKBDwslYEWOXIxenau4uQBys8aALwLp+/Hq/+3SXQNEptn4YjglLE
         ZiqlnhrVp+AsPo4Xv1bGrH+yIzDE9fmLFT5KR6KUzKYmCamjOLBZarmE48KWJ4iHYKms
         SW/GcW1jsnvhwn1045ywJcqlhdRqtmEyl4Y81OY28CWdrt4VXFBhTpIKl0B8zsUrCk9Y
         JTAST7W0Lf6OqC18es3vgpz1uuX5PjWyuXuD0j/vjkowXlZ7mH7pFcNQP9Bgrfrw3ObZ
         ON2igwcaMcBaqBMXcBWJpyby+ugBJ0bCHIL+RldnC07reM+adijN/f2ax49jaxKXZI31
         JrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2gm9y/N9OWSpJqr6m3qsCkKZCUpLkEz5tg6SxUSEII=;
        b=FTBb3DETofS2yYzzkhTmrENZsvTgFx6V23J06r6tvLFs0hMIgqWfQNJCHvfWokVLwQ
         9Mp2+HI8CHhOIGszVgf5Lx49R7vOn88h6iRi5kriaqVUnCahoErpeAlL+CmG6Yo2cXnC
         slI4q6P2K1hmhQkCE7ETmdVvrmU51MpSNoi8rZLDFpBiWqF36VQhV4q9sdvqrRPpuiYY
         Kkf5NJD49/SkM7EkElJL9QIQy0nYHb+1HYG5MSQBkIma5alJZ/DZhpiXgdnYyGsVPZIx
         tzSB6BOdr1B1dYxrrYrFEM60piiP+5tjb3I+6dxeuPe/wjF8Y98a2+nTog0mW+syoaii
         vq/g==
X-Gm-Message-State: AOUpUlE2w+vRN3wSbgqj6dljbMPy6lHxVPY9djoEnQszZBDUELDChgPh
        NfE2+BGV6q4G+xtZy2cvzIU0bg==
X-Google-Smtp-Source: AAOMgpf61jzUtpNO4Huckla0RIF+4k2vkAEAhGf9YZkXXJeuHTTHukdGq3jQa9zUbo1eB4FNNWWvhg==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr12311263wro.195.1532436774990;
        Tue, 24 Jul 2018 05:52:54 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] arm64: dts: meson-axg: add audio arb reset controller
Date:   Tue, 24 Jul 2018 14:52:28 +0200
Message-Id: <20180724125238.14567-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audio memory arbiter which control the access of the audio
fifos to the DDR.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6adc8d3dbf0a..3893c630d969 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -189,6 +189,13 @@
 
 				resets = <&reset RESET_AUDIO>;
 			};
+
+			arb: reset-controller@280 {
+				compatible = "amlogic,meson-axg-audio-arb";
+				reg = <0x0 0x280 0x0 0x4>;
+				#reset-cells = <1>;
+				clocks = <&clkc_audio AUD_CLKID_DDR_ARB>;
+			};
 		};
 
 		cbus: bus@ffd00000 {
-- 
2.17.1

