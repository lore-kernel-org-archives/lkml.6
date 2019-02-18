Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED7FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2E421903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="IsB2vKUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbfBROZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:25:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36181 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389149AbfBRODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id g9so3393970eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=C7LfhrPnx4nAAVgxwo9NlyGkJiC6uZjQ0aP5k7jZulQ=;
        b=IsB2vKUQ0fFFZ3Si03pp+C3YnEwIGfiap8SKOQSLsqp4xuu3XfOVwg7fS4wRCKDkQE
         OLbC93ZPgfinbdENjBY13fGRfsVOXYmWZMIvCSNjAjwJ/sXxaUa5ojgt9KK1UuKQYO8h
         J79qQcugI6ovrMgtNAZEgOiapw8Y/bCxMzOhI3luA6lQt1ihP1n13m1SxJ1g3sNASLa8
         nsBt5b9wjpatlE8nuWNvOSCk+Yk6MQptaJ6/19HWYHgNZOYJDLjOAzmo2BDsVnCRx2nR
         y0XD07OFkIXEAJU15ujUJyhmbdp7FEDw9YapXo1H/XWzsEPNetMGdGgJmzijzH0lqEKK
         igpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C7LfhrPnx4nAAVgxwo9NlyGkJiC6uZjQ0aP5k7jZulQ=;
        b=KZZ0d+9hcytEoR1ON51726SkmNls3bqkiWdVtchjiCClVnwaY4+8eyjLtFLvgpvchb
         Q3XBVHSrLrJuPPDQdTKyvtRT6e4fv4wqxH32ng5RSh0hKSKyhEVNhufvryvqYti2T1BL
         RyQsvKiiX4azcYlTk/o+qgUac9owfebds4U6lHi/LSHF5uHHBXhtKoHdsG+1ljTKgTTa
         1LgCQAboWN0i+lFctqIQfFCyMWo/nR8GGXDNlqLanT1kzc2wfQQunIXeQuEpQ8lhPIe3
         Vl7qVAY1Iqfq27w9vZHuIcL7LlGYF9MUzeZk0GAufkaTOmX/nFL1rmBOfldd/emB7k9I
         AmrQ==
X-Gm-Message-State: AHQUAuZJv9fzbC478NIKTeMqF+jdvDR9uV8UD6l8r+nxFyxiDsL1/qnt
        pv5LxvOoqJHg8R3nPFxIkobOWQ==
X-Google-Smtp-Source: AHgI3Ia0x1ktlXNUOXQ9qmej4UWt8bjITH2AKcym466NvP3q2IEYPeYewvhp2d01vHGZ6OHrFmkucQ==
X-Received: by 2002:a17:906:381:: with SMTP id b1mr16659937eja.67.1550498627933;
        Mon, 18 Feb 2019 06:03:47 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:47 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/8] include/fsl: add common FlexTimer #defines in a separate header.
Date:   Mon, 18 Feb 2019 15:03:14 +0100
Message-Id: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 include/linux/fsl/ftm.h | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/linux/fsl/ftm.h

diff --git a/include/linux/fsl/ftm.h b/include/linux/fsl/ftm.h
new file mode 100644
index 000000000000..d59011acf66c
--- /dev/null
+++ b/include/linux/fsl/ftm.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __FSL_FTM_H__
+#define __FSL_FTM_H__
+
+#define FTM_SC       0x0 /* Status And Control */
+#define FTM_CNT      0x4 /* Counter */
+#define FTM_MOD      0x8 /* Modulo */
+
+#define FTM_CNTIN    0x4C /* Counter Initial Value */
+#define FTM_STATUS   0x50 /* Capture And Compare Status */
+#define FTM_MODE     0x54 /* Features Mode Selection */
+#define FTM_SYNC     0x58 /* Synchronization */
+#define FTM_OUTINIT  0x5C /* Initial State For Channels Output */
+#define FTM_OUTMASK  0x60 /* Output Mask */
+#define FTM_COMBINE  0x64 /* Function For Linked Channels */
+#define FTM_DEADTIME 0x68 /* Deadtime Insertion Control */
+#define FTM_EXTTRIG  0x6C /* FTM External Trigger */
+#define FTM_POL      0x70 /* Channels Polarity */
+#define FTM_FMS      0x74 /* Fault Mode Status */
+#define FTM_FILTER   0x78 /* Input Capture Filter Control */
+#define FTM_FLTCTRL  0x7C /* Fault Control */
+#define FTM_QDCTRL   0x80 /* Quadrature Decoder Control And Status */
+#define FTM_CONF     0x84 /* Configuration */
+#define FTM_FLTPOL   0x88 /* FTM Fault Input Polarity */
+#define FTM_SYNCONF  0x8C /* Synchronization Configuration */
+#define FTM_INVCTRL  0x90 /* FTM Inverting Control */
+#define FTM_SWOCTRL  0x94 /* FTM Software Output Control */
+#define FTM_PWMLOAD  0x98 /* FTM PWM Load */
+
+#define FTM_SC_CLK_MASK_SHIFT	3
+#define FTM_SC_CLK_MASK		(3 << FTM_SC_CLK_MASK_SHIFT)
+#define FTM_SC_TOF		0x80
+#define FTM_SC_TOIE		0x40
+#define FTM_SC_CPWMS		0x20
+#define FTM_SC_CLKS		0x18
+#define FTM_SC_PS_1		0x0
+#define FTM_SC_PS_2		0x1
+#define FTM_SC_PS_4		0x2
+#define FTM_SC_PS_8		0x3
+#define FTM_SC_PS_16		0x4
+#define FTM_SC_PS_32		0x5
+#define FTM_SC_PS_64		0x6
+#define FTM_SC_PS_128		0x7
+#define FTM_SC_PS_MASK		0x7
+
+#define FTM_MODE_FAULTIE	0x80
+#define FTM_MODE_FAULTM		0x60
+#define FTM_MODE_CAPTEST	0x10
+#define FTM_MODE_PWMSYNC	0x8
+#define FTM_MODE_WPDIS		0x4
+#define FTM_MODE_INIT		0x2
+#define FTM_MODE_FTMEN		0x1
+
+/* NXP Errata: The PHAFLTREN and PHBFLTREN bits are tide to zero internally
+ * and these bits cannot be set. Flextimer cannot use Filter in
+ * Quadrature Decoder Mode.
+ * https://community.nxp.com/thread/467648#comment-1010319
+ */
+#define FTM_QDCTRL_PHAFLTREN	0x80
+#define FTM_QDCTRL_PHBFLTREN	0x40
+#define FTM_QDCTRL_PHAPOL	0x20
+#define FTM_QDCTRL_PHBPOL	0x10
+#define FTM_QDCTRL_QUADMODE	0x8
+#define FTM_QDCTRL_QUADDIR	0x4
+#define FTM_QDCTRL_TOFDIR	0x2
+#define FTM_QDCTRL_QUADEN	0x1
+
+#define FTM_FMS_FAULTF		0x80
+#define FTM_FMS_WPEN		0x40
+#define FTM_FMS_FAULTIN		0x10
+#define FTM_FMS_FAULTF3		0x8
+#define FTM_FMS_FAULTF2		0x4
+#define FTM_FMS_FAULTF1		0x2
+#define FTM_FMS_FAULTF0		0x1
+
+#define FTM_CSC_BASE		0xC
+#define FTM_CSC_MSB		0x20
+#define FTM_CSC_MSA		0x10
+#define FTM_CSC_ELSB		0x8
+#define FTM_CSC_ELSA		0x4
+#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
+
+#define FTM_CV_BASE		0x10
+#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
+
+#define FTM_PS_MAX		7
+
+#endif
-- 
2.17.1

