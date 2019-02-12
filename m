Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB1AC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A961217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pjfB0ZL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfBLPO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:14:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36725 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfBLPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so3096773wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QStPts8zTq0nzdsNrA3kpwyRiZHYfDnQ/8rWa0NJD4=;
        b=pjfB0ZL0FUP0iHeBg/u+HrbsQ6TfmFauXbBxkBZOa6U5YhCQBMph42ZfzIzpmHuKjG
         Rbaxj7VSXxcUw+tEFuujSgW1rTQ0YDgd61MuuTozwaJKY6gicB+Ikr3w5HiEYDxyyHDF
         INvHpu/bSQX/GkzIXxahDZVn1Q/gNcGZDTPstVaArBl9qHrLgO7tidGYkz5KVs95lXni
         ju6I/6Q0ZxfqdXxiYKeTjR45iKBTjvMEHTqg0NgY+kCqs88yfD1GKBWnwN2wzJu6rmah
         HD50V0FkDlxKks1kfjyFshCWV4ht//NRorDuhyXG368HfswcGux59mlkv8vNrC7AMnUQ
         8V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QStPts8zTq0nzdsNrA3kpwyRiZHYfDnQ/8rWa0NJD4=;
        b=TPskRVjrvlLaRa0UI0PXmpucVnIDuhEvEDw7n+g2uqoXCd7EFX7E1Eempx28lHNFOL
         RMao+Rx96202+WjG9ubEsSPS/kMbXyqQujOeerMXYS13oEOGWC/YGUK+bzFWZM5Laz4r
         6AM/BFi1m/psetcGVGLykq+VGOy/rvm39VWDBt8XlZjXXIFwpWYuJGVSNpNrWEXusQPi
         vQdo4aB2AMmW06ZoxPd6k+BF0m5lZl1mGEMc8TxKk5WKgQqFyqc1B0YvMXVl6/3ItYYO
         YiZtJWzAnnkFLmUCdCO7PzRowokKgppPl+6WJgToxKjJaox1MrkqcAZp+NsVeQeSiAmd
         6HAw==
X-Gm-Message-State: AHQUAuaBqNNX+jXy8bpHCyyYrSONxxVpEdCnOnEkFM+vYUHBCqrOiou2
        A37u2ynZSegl4YJu09d3erJMdA==
X-Google-Smtp-Source: AHgI3Ibzp9VQ+vzLCVRjVo2VWXd4YQZLSkYFrF3xMPOtB4w1Xde6Mq6DfFzcqJV9FwT1oJgH7Pfbqw==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr3101375wrn.157.1549984462294;
        Tue, 12 Feb 2019 07:14:22 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 07:14:21 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
Date:   Tue, 12 Feb 2019 16:14:08 +0100
Message-Id: <20190212151413.24632-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the specific compatible string for the DWC2 IP found in the
Amlogic G12A SoC Family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 6dc3c4a34483..e150b7b227c9 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -14,6 +14,7 @@ Required properties:
   - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
   - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
   - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
+  - "amlogic,meson-g12a-usb": The DWC2 USB controller instance in Amlogic G12A SoCs;
   - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
   - snps,dwc2: A generic DWC2 USB controller with default parameters.
   - "st,stm32f4x9-fsotg": The DWC2 USB FS/HS controller instance in STM32F4x9 SoCs
-- 
2.20.1

