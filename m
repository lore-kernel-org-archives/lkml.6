Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F5FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E212184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsmloMLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeLRJ7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:59:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40935 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeLRJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:59:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so15219010wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8OEdTVozQxClVBbIU7NBQsHspAFsTO1ZUR1Kn8Esn1Y=;
        b=UsmloMLq0uifOWJFqCnXwYlGp3Sq1jAASmAWlG8rniDpcO4i02I14v1l/5NWmhYPiR
         4n8fPzsbOzbq9QabeImg9mE5eTdvvMsOP5iZhXHthQ5Occa/S3Cd3PYTXqnLKLDsnhkn
         pkhrTmHP22fWxVvsgBNFB813kmKO2eV4cY11M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8OEdTVozQxClVBbIU7NBQsHspAFsTO1ZUR1Kn8Esn1Y=;
        b=WyzfHX3R2Vgixlfh6uDruSD3PSfHO9lsBt6ye2cJ9vFNVSMw21cLQmdG/mZhYtMnqh
         g+dHWTj8wPMu98zMI8hJAIwtDraXmYSF6MfVN8m8JIRJldSXJg8YOY1zxBk/vzuqq7ol
         cg1iUlUNwqbUezrOGrUARngl6J6kdi/dGgMBS9wxpPAlbiEgjNHOaOW1io2BLusCHNWN
         ADTvTrgxC4I9V9y5yWut5dfM97VsNj0BYgIfOqGIlpn2L2pp8fXgIlCnd0KgNH9ObRg5
         Yjq7+BwbGRRi8jWw/fu1aj6UhWisnjWV7e7M94x/kOrz92npvzdVpZs5AuaOFdfRlQ4+
         N1GQ==
X-Gm-Message-State: AA+aEWbCV1jU+xjwiJB4IXg4Z8M0FWX9lAeKXU9Bg5NUxEi1G8t5ipEG
        1SmsENkC5F0vfI+ygjSwpCX2/WCnZso=
X-Google-Smtp-Source: AFSGD/V2PWZ01fL1x5u/aQPCfuuHkFhDgU5v6+ZtHCS4V8gawkqkZOjbijevnqff2/Z2qw53Ms1p4w==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr14230723wrc.191.1545127166738;
        Tue, 18 Dec 2018 01:59:26 -0800 (PST)
Received: from localhost ([49.248.197.134])
        by smtp.gmail.com with ESMTPSA id l202sm3231311wma.33.2018.12.18.01.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 01:59:26 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        marc.w.gonzalez@free.fr, bjorn.andersson@linaro.org,
        kvalo@adurom.com, joe@perches.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/1] MAINTAINERS: update list of qcom drivers
Date:   Tue, 18 Dec 2018 15:29:09 +0530
Message-Id: <d153a86748f99526e7790bfc4ef8781a2016fd51.1545126964.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1545126964.git.amit.kucheria@linaro.org>
References: <cover.1545126964.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers didn't have a specific maintainer (other than the
subsystem maintainer). Add all drivers referring to qcom or msm to the
list of supported drivers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 MAINTAINERS | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3318f30903b2..8f8dfb6f9675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1929,20 +1929,61 @@ M:	Andy Gross <andy.gross@linaro.org>
 M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	include/dt-bindings/*/qcom*
+F:	include/linux/*/qcom*
 F:	Documentation/devicetree/bindings/soc/qcom/
+F:	Documentation/devicetree/bindings/*/qcom*
 F:	arch/arm/boot/dts/qcom-*.dts
 F:	arch/arm/boot/dts/qcom-*.dtsi
 F:	arch/arm/mach-qcom/
-F:	arch/arm64/boot/dts/qcom/*
-F:	drivers/i2c/busses/i2c-qup.c
+F:	arch/arm64/boot/dts/qcom/
+F:	drivers/bluetooth/btqcomsmd.c
+F:	drivers/bus/qcom*
+F:	drivers/cpufreq/qcom*
 F:	drivers/clk/qcom/
+F:	drivers/clocksource/timer-qcom.c
+F:	drivers/crypto/qcom-*
 F:	drivers/dma/qcom/
+F:	drivers/edac/qcom*
+F:	drivers/extcon/extcon-qcom*
+F:	drivers/firmware/qcom*
+F:	drivers/hwspinlock/qcom_*
+F:	drivers/iio/adc/qcom*
+F:	drivers/iommu/qcom*
+F:	drivers/iommu/msm*
+F:	drivers/i2c/busses/i2c-qup.c
+F:	drivers/i2c/busses/i2c-qcom-geni.c
+F:	drivers/irqchip/qcom*
+F:	drivers/mailbox/qcom-*
+F:	drivers/media/platform/qcom/
+F:	drivers/mfd/qcom*
+F:	drivers/mfd/ssbi.c
+F:	drivers/misc/qcom-*
+F:	drivers/mmc/host/mmci_qcom*
+F:	drivers/mmc/host/sdhci_msm.c
+F:	drivers/mtd/*/qcom*
+F:	drivers/pci/controller/dwc/pcie-qcom.c
+F:	drivers/perf/qcom*
+F:	drivers/pinctrl/qcom/
+F:	drivers/phy/qualcomm/
+F:	drivers/power/*/qcom*
+F:	drivers/power/*/msm*
+F:	drivers/regulator/qcom*
+F:	drivers/reset/reset-qcom-*
+F:	drivers/remoteproc/qcom*
+F:	drivers/rpmsg/qcom*
+F:	drivers/scsi/ufs/ufs-qcom.*
+F:	drivers/slimbus/qcom*
 F:	drivers/soc/qcom/
 F:	drivers/spi/spi-qup.c
+F:	drivers/spi/spi-geni-qcom.c
+F:	drivers/spi/spi-qcom-qspi.c
+F:	drivers/thermal/qcom/
 F:	drivers/tty/serial/msm_serial.c
+F:	drivers/tty/serial/qcom*
+F:	drivers/usb/dwc3/dwc3-qcom.c
+F:	drivers/watchdog/qcom*
 F:	drivers/*/pm8???-*
-F:	drivers/mfd/ssbi.c
-F:	drivers/firmware/qcom_scm*
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
-- 
2.17.1

