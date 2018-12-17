Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABB820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TM/9jfDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbeLQQTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:19:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46155 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeLQQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:19:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so12857001wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 08:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OW7nZPG9WmQXS8ssUWs6Y7Cs30A/I6ebVPwcxGJ2eMw=;
        b=TM/9jfDU02aQW+cO/XZdwNTtdA/sumjepG9vGgmYc60SsV9dynFkEZrgdKpo602nRN
         matjxaHhSBPQ14VUo/PjCqL3eeMHbuXOROp5LOnoB2LuS3kOo/hbLdHL4H3BHsPQCvxG
         jCB13RgIEa/LWLc3AZszC4Pvdd4rmhM5WR1CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OW7nZPG9WmQXS8ssUWs6Y7Cs30A/I6ebVPwcxGJ2eMw=;
        b=RNGksYUqk3o4qsKHPCTmuN8LWk+2HQOawuLmnZjAOWhYGDCzOXK78b1hA1nSYBUHUB
         SAz/ruwXT/j+HFBBhl4c+PuLf1d9XfkqQi8W7OMiIc9sezznF6V5sbGZJUBFNZ+TgOG0
         JswbJ0hDdXsCf1A4CHlfo/38S6+DJ2uZTcNa9WSo9n9fH6xkT9cXqb6hUW39UPjVHSpx
         vOE9U6Qv3DfKzz48K1qgaHVDJq8x5v6X8cChvt3NoSQxx7pymCcwM3Gk+RlLXzFn8sTY
         azcf11RGy0WeppGqq+3zdKDlVxrxOFZ8Am3fHeD3KmEKNpWQjzeuQK2vQwO7Vu15yG2d
         tfWg==
X-Gm-Message-State: AA+aEWYlsEIqlxmnIqxtvRUY//RjPpeIiBxSvKUsmvtzCAAc35c3DaYj
        rxHk9huaRxD2BsQ9+s9srsJZTp+VXoc=
X-Google-Smtp-Source: AFSGD/V7qPlGUuNKogjDWGZ0HTR5xeygIHBDEVVeOLQGOsEHEWyGJlTtquRnkIDO/msi+Jxj0/4v2g==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr5746979wro.29.1545063584090;
        Mon, 17 Dec 2018 08:19:44 -0800 (PST)
Received: from localhost ([49.248.171.173])
        by smtp.gmail.com with ESMTPSA id k19sm943937wre.5.2018.12.17.08.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 08:19:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        marc.w.gonzalez@free.fr, bjorn.andersson@linaro.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
Date:   Mon, 17 Dec 2018 21:49:27 +0530
Message-Id: <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1545063166.git.amit.kucheria@linaro.org>
References: <cover.1545063166.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers didn't have a specific maintainer (other than the
subsystem maintainer). Switch to using the 'qcom' and 'msm' regex
patterns to capture all of them and add exceptions to the couple of
drivers that contain 'msm' but are not related to qcom hardware.

Thanks to Marc for the idea to use the N regex.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 MAINTAINERS | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3318f30903b2..c9376030f77a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1929,20 +1929,14 @@ M:	Andy Gross <andy.gross@linaro.org>
 M:	David Brown <david.brown@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/soc/qcom/
-F:	arch/arm/boot/dts/qcom-*.dts
-F:	arch/arm/boot/dts/qcom-*.dtsi
-F:	arch/arm/mach-qcom/
-F:	arch/arm64/boot/dts/qcom/*
+N:	qcom
+N:	msm
+X:	drivers/rtc/rtc-msm6242.c
+X:	drivers/net/wireless/broadcom/brcm80211/brcmsmac/
 F:	drivers/i2c/busses/i2c-qup.c
-F:	drivers/clk/qcom/
-F:	drivers/dma/qcom/
-F:	drivers/soc/qcom/
 F:	drivers/spi/spi-qup.c
-F:	drivers/tty/serial/msm_serial.c
 F:	drivers/*/pm8???-*
 F:	drivers/mfd/ssbi.c
-F:	drivers/firmware/qcom_scm*
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
 
 ARM/RADISYS ENP2611 MACHINE SUPPORT
-- 
2.17.1

