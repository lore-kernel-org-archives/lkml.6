Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C8BC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903420684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fi/eYR8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7903420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJBP0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:26:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeJBP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:26:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so1351984wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PKzH8oYKZ82Z9TWd7i02OlmOTFAJUgwk8t5GyaIR3Bc=;
        b=Fi/eYR8pwykHWHOKpYSmKoc+0Wmlao7S1/rdIXXxB/GD9s7jVvZJ/5YovtSwd6Susj
         6qPpJLPAat6p/M925sKVHsJ7RlM1rEdqOsIcEReJoHeXe8ee+vWhFA9ufBhrGzD12hgz
         FNWa4ZQjWu9hoIaYqSJDrYcCbFD4pqTa6hkkSCqxys29pNh0wuJ7tnuSvaFA8X/CfL6K
         mj+pyzR8NmAKsWveqZamci3eG932H1eUYbOu2f+QQYlYrYrU0ueUYphxwwS9r1/ds0nU
         1V1zWZT3IPOf0jFgiSW0o3KxaWOq5E/MxzsRmAMqSjM8W6Fv7cXpzF9ThNqKOIJ9PYkV
         +EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PKzH8oYKZ82Z9TWd7i02OlmOTFAJUgwk8t5GyaIR3Bc=;
        b=E4EzdSn+uRCXtlwzYRrI60wo0VvGbo2Z+3/b/dCRESlEJ05c1OfQ0sLT3scFhz3BJk
         sCASZKB3Lpl8FCryP3/L746zUo9gdvdiAG22MvBmVziFaD/Q+ybElH4XIA7pgepf2FdQ
         JIwg+99ce2VlOHiKqL1nvb5Pg22km9ILttIMwRnFM24MVmDG8NEqKgkxknLmy52I7m9D
         fhv0F6VdMX6ZwOeN9jc/nVTQz+dyKktCXmASi7LjiWIswgaUSBgEX8yjWPDkR5FTyflr
         o7UZ06JrrToI503p8JCjdENxVnro1um5Vu+PIn6kUe6l9yG4bpmbFmIoyQnJms/Es9dD
         3GIA==
X-Gm-Message-State: ABuFfogk6LHbq96qMmUvRbRgVh2oTfhapYd9hgEe6vvFzRWBrC+M4Dql
        w8K1mGDXSO4sdJ3kBbpXI9b4wg==
X-Google-Smtp-Source: ACcGV623DtWlOgdp/InigkmS4w1yiXL61w0NCjABKQqR/Iw2XTwnXTqxSHuU7fvpyC8nKrNCv8wWPg==
X-Received: by 2002:a1c:ee0c:: with SMTP id m12-v6mr1209010wmh.112.1538469831403;
        Tue, 02 Oct 2018 01:43:51 -0700 (PDT)
Received: from boomer.baylibre.local ([2a01:e34:eeb6:4690:3146:aafc:91d9:4b96])
        by smtp.googlemail.com with ESMTPSA id 198-v6sm16162298wmm.0.2018.10.02.01.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:43:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: meson-axg: s400: disable emmc
Date:   Tue,  2 Oct 2018 10:43:41 +0200
Message-Id: <20181002084341.5487-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002084341.5487-1-jbrunet@baylibre.com>
References: <20181002084341.5487-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it is possible to rework the s400 board to solder an eMMC on it,
it is not the default option and most boards are fitted with a NAND
instead.

Let's disable the emmc device by default to reflect this. The board
equipped with an eMMC will just have to alter the DT in the
bootloader, like we do for the reserved memory regions.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 166ab598395e..c74ff1efebb8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -479,7 +479,7 @@
 
 /* emmc storage */
 &sd_emmc_c {
-	status = "okay";
+	status = "disabled";
 	pinctrl-0 = <&emmc_pins>;
 	pinctrl-1 = <&emmc_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
-- 
2.17.1

