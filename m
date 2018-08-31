Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B495C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0CB2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DfrQo3FM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0CB2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeHaM6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:58:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39108 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbeHaM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:58:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id o37-v6so10464516wrf.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=72CyoKBzMtubY3mTYHZb8sAe+LMtlh8bUtSwjYnQ2Ys=;
        b=DfrQo3FMAhEoBDjlpANsZf6whkzdio5gg9khpR7cFpCa5D2gsL7u8w7dFb8kbiLvVA
         QIVMYBIC+DSz5WY0goMmzS68mJTkYsd1bidmj0OR+I3i7k2vt96/XE06rhow25XFlGNE
         XRqEeuNDBDyWF3ZHw11GFSwkgRXL0f0SUeps6VWYLhsbet1oI2Fz9Ib1PDc7cshZl5/q
         6ICOLQbkmJGP7W0O+Vy7a5J5rOD2KdJqdWWe+gvbmwRnvGspAa2NfznFW3VQA1/PEMzT
         DZIC/nc9b1b0OClJKHMy1+3KzRowJcQvc11AtgdETNVz0B2mTJYUemqO7QFR+s8CNeVz
         igSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=72CyoKBzMtubY3mTYHZb8sAe+LMtlh8bUtSwjYnQ2Ys=;
        b=TfZyKt/EsIWmxjIzYsRCLGg7UVKY81ilD21u4u6HthTlrZSWI3ClRvw+WsAjzFgpQe
         t9jn0VyTEElIcewaa6uI9MMvRguvkkIY1mCJmZcnjCzGSicyBqxiFFENMV9v5rjkpeEf
         OtnnVntj6Q/oX+B0EjWR4t1lzJdKV2a7dwYwNcJTw6f9G2LUnkcY9A1v8D5f8JM2PWZA
         naQtCjcWjd7q5OSOnaVvcDpMor/pBAqTmB6HR19tJJ86G07t1AjS9GgOqhgeTjURwg9G
         881puiuYe5GCnkpHp6aYeJnP76CxhamUlHA/+7Cp5OrY1ckX8lYHGnFJS8U9GBd6iH3Y
         pcEA==
X-Gm-Message-State: APzg51Bqexe1LnUPOB8L9AvqV3YiNb4uwdYU8mPwFNJPJDKe/m16SDUK
        bEtcviOREPB5lU3NujajhRkoFw==
X-Google-Smtp-Source: ANB0VdY/TImFEXjjO2VF6KgXgh8L14j4adsDobnGapW+NYj/EWnSf/z8LvOYVdqqQzKHEKdsIO53Vw==
X-Received: by 2002:adf:80ea:: with SMTP id 97-v6mr9832567wrl.57.1535705541070;
        Fri, 31 Aug 2018 01:52:21 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id v6-v6sm8920822wro.66.2018.08.31.01.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:52:20 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 3/4] ARM64: dts: meson-gx: add vdec entry
Date:   Fri, 31 Aug 2018 10:52:04 +0200
Message-Id: <20180831085205.14760-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831085205.14760-1-mjourdan@baylibre.com>
References: <20180831085205.14760-1-mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the video decoder dts entry

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 737b741df035..d9e0fea71dbe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -410,6 +410,19 @@
 			};
 		};
 
+		vdec: video-decoder@c8820000 {
+			compatible = "amlogic,gx-vdec";
+			reg = <0x0 0xc8820000 0x0 0x10000>,
+			      <0x0 0xc110a580 0x0 0xe4>;
+			reg-names = "dos", "esparser";
+
+			interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+
+			amlogic,ao-sysctrl = <&sysctrl_AO>;
+			amlogic,canvas = <&canvas>;
+		};
+
 		periphs: periphs@c8834000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xc8834000 0x0 0x2000>;
-- 
2.18.0

