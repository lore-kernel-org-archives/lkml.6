Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89101C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5566A214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kD97fW8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbeL0Vus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:50:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38586 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbeL0Vur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:50:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so19433115wrw.5;
        Thu, 27 Dec 2018 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vwjI45tfNGokg0tQ5bvI2hO5i8EXM3XX5a012DEAbX0=;
        b=kD97fW8f4BIW1Dp2BscUjoKLy6dxZKcu/RDYP0FusvauFwMXuNiBIjOS4H22WWWm/U
         gUwGq+ox9b2Dxs2kyyNq8vO2/CSEtqKsQanjvDqwSYti+BzQi/EsDS8Xsn7RmS2OO6vW
         kg5Fpht89pPLhjreYktKtcDeuclxUEc2Oax4pTTwEknSwZVderdQrGI5roanjllObz+1
         R9xyJ4UlENObC/qrxlgvgVmwW7O0zEIi3uYWOeRwwmRvLNT0LInKSEbySLn/jfbf0UzP
         4wCjIOHssZ5zWArdqD4f0v7w9EHqYrKPE3dxaDLbjkZ4E9x+Yf0Mot8uxH+9CjNbUEXj
         EIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwjI45tfNGokg0tQ5bvI2hO5i8EXM3XX5a012DEAbX0=;
        b=IO7PVNWszNVVfqW2kmgY7wAr1tF6Nm+ZYrci/o9qU7e8RfVT8Ha9xJCTk2lsYrFk4m
         criXTKwQ1IDGYeagPHSBcEGkwklBE22nbsS9DdZDKSIbPiZ6JGSFbGk+cWdh7Sd1LkC9
         lPD28rQIQCy+shgyxlm4t46N2wY+WAraymPWxBhrP8rwIouMN98k6bMH68Ihny/Z2zIJ
         013M61CHgwJD+0/5aJ/8HkvB40cpmneynVJmbfHRChzmpE6FMlgu74mK1P37Udb5PA4I
         BAysbKksi+xqKjBkwjOw5wO6r42mfV83kVCDUOPferZRkDYkYMheN/d7YpL4FA7MIt6q
         nYaA==
X-Gm-Message-State: AJcUukfq6YxcoYJ/3trUFWG+E1l6k6yxCa8CVLRYG76NNQO0rtKIceza
        EQCg55nPYqlawBhJcmoG2kaNkYgL
X-Google-Smtp-Source: ALg8bN5aFigp/wAZszU57y2/4eApQU0EgVujJSumDoMaGdpnm99RxIlzwQ/C/S5x71cqzLPyFlSECA==
X-Received: by 2002:adf:81b6:: with SMTP id 51mr24928584wra.240.1545947445287;
        Thu, 27 Dec 2018 13:50:45 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD711B00071582302E30AD474.dip0.t-ipconnect.de. [2003:dc:d711:b000:7158:2302:e30a:d474])
        by smtp.googlemail.com with ESMTPSA id m4sm34538164wmi.3.2018.12.27.13.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 13:50:44 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     balbes-150@yandex.ru, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: meson-saradc: update temperature sensor support
Date:   Thu, 27 Dec 2018 22:50:19 +0100
Message-Id: <20181227215020.9803-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
References: <20181227215020.9803-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson8b and Meson8m2 use a 5-bit wide TSC (temperature sensor
coefficient). The SAR ADC registers however can only store (the lower)
4 bits. The fifth (upper-most) bit is stored inside the
MESON_HHI_DPLL_TOP_0[9] register from the HHI register area.
This adds a syscon property to the HHI register area so a driver can
fetch the HHI register map and store the fifth TSC bit in there.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index 325090e43ce6..75c775954102 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -23,6 +23,10 @@ Required properties:
 - #io-channel-cells: must be 1, see ../iio-bindings.txt
 
 Optional properties:
+- amlogic,hhi-sysctrl:	phandle to the syscon which contains the 5th bit
+			of the TSC (temperature sensor coefficient) on
+			Meson8b and Meson8m2 (which used to calibrate the
+			temperature sensor)
 - nvmem-cells:		phandle to the temperature_calib eFuse cells
 - nvmem-cell-names:	if present (to enable the temperature sensor
 			calibration) this must contain "temperature_calib"
-- 
2.20.1

