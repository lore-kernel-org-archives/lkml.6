Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068B9C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76502403B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xskr/0ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76502403B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeGEJvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:51:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35428 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbeGEJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:50:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id h40-v6so830875wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAsaDaoM4cmNMyEeeXPJzkq8xplOfG6YKcYNp1p0JlU=;
        b=xskr/0ryaiHxfqWmDrk90wCSwYCLUz3YN7Mf8k54QVjCGKAeOjc6ZhCsZGO5VJiXw0
         Tk49UI4fwYGOT0Y0GpgAEubOt8ogrlCrcWxm4+NkL+UfyM8qTTrImECYC3KvwSXAGwYb
         o0l2/teG5BD4Shoyk29AFL9bCr6XqJAdGH7dZA10cTJ99fBNLgT+BbyhRnezYP2hErLF
         JrRgw++ZXLJr6BELZ9P0BA7dBuV6n440NERxy9sDysvL9dkOs7uuk44f92IZrbEEs94E
         G0XxiQqCF/FJqZQpgtFhvLK0+YVsZVgAEo+I4SpfZr0qWIMF7AZtZGGDxBs4eUtyFNpo
         V1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NAsaDaoM4cmNMyEeeXPJzkq8xplOfG6YKcYNp1p0JlU=;
        b=KINonzpx5CVrpVKp0dVo8h0iciuArvo5nnyKbELBL21qiLyWIXnrnAeaA7kWJt2Ijy
         Ikew1SICqyy8AgSMzOSXhpTDDBpGoNNuVi+r/qdAfUFDciMcIfwlexfJYIBNaQEdaDCv
         UPbIrxYdfj3uk8B5Irr7uNvIBDydg8GOAyXxZB/45cXP9i7QDphrywn3YHIKmccXcnYv
         tFRMiM/msPzqLsDEFO4K5FdJqtpVk4gKtw2agNjA0clzBPKIvlRQQFVnzNfOXn8rwO2h
         AuLfd+M/Vd9YC/FnUrrxFRh8cxVhqNeXOHSZaWHgdRDCLpkPDn+9f/7ZI1pbQiTDfTxX
         PkXg==
X-Gm-Message-State: APt69E3WhvlpTCf4hiabQ0llitlEQLnaKdkxSSpYiitvwW/aFlxDH7MY
        yEG843TDQo4eHceFDbqVS6o9P+FguFw=
X-Google-Smtp-Source: AAOMgpe9pmSTaBzNVrPVNNYlEsGrjJD+dGaoHltjt1ZhEwfvBziB/nrlLRRN01XXUmkiWImxBC0czA==
X-Received: by 2002:adf:984e:: with SMTP id v72-v6mr3876793wrb.180.1530784247717;
        Thu, 05 Jul 2018 02:50:47 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h18-v6sm6967590wrq.36.2018.07.05.02.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 02:50:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH 1/2] dt-bindings: amlogic: Add support for GXL S805X and the P241 board
Date:   Thu,  5 Jul 2018 11:50:42 +0200
Message-Id: <1530784243-20823-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S805X is a variant of the Amlogic Meson GXL SoC family with the
following physical limitations :
- No SDCard interface
- No GPIOCLK pins
- No USB OTG ID pin (but Gadget feature can stil be forced)
- No 5V regulator
- Reduced ADC inputs (only ADC0 and ADC1)
- GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
  GPIOX_15, GPIOH_3 are no more exposed on the package

Amlogic exposes the following SW limitations :
- HDMI max resolution should be 1080p60, VPU clock should be downgraded
- Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
- CPU speed should be limited by SCPI OPP table to 1.2GHz
- DRAM interface is limited to DDR4 16bit up to 1GiB

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 6988056..849834c 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -41,6 +41,10 @@ Boards with the Amlogic Meson GXL S905D SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,s905d", "amlogic,meson-gxl";
 
+Boards with the Amlogic Meson GXL S805X SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,s805x", "amlogic,meson-gxl";
+
 Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,s912", "amlogic,meson-gxm";
@@ -79,6 +83,8 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
 
+  - "amlogic,p241" (Meson gxl s805x)
+
   - "amlogic,q200" (Meson gxm s912)
   - "amlogic,q201" (Meson gxm s912)
   - "khadas,vim2" (Meson gxm s912)
-- 
2.7.4

