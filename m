Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08058C64EB1
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2D4208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo20lw9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2D4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeI3Uss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:48:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeI3Uss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:48:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so10957578wrr.13;
        Sun, 30 Sep 2018 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=Qo20lw9M3JkN07IZ94G0L4Z8aC8BsDlLJ1Lei5zF7k97rqEbjoE+kkFsiWTa+TLp/C
         Tz6WqfxK0vxgfG22+TVaLDeLYHvLk9ZoZRMY0ZyzrH+HURcVA/u7tAO5Eee6rD4gZ62Z
         uS3BRX49Oh2bMMCKgv0V1R0fLR9X5BvHCdPpcmWFH7B/ZgZ1ftfxNM2YSRG+0p8SBdHW
         6rae7v7ThK10uN4lvpODBZFXYZ6y0kRqanoAd3hqZgfxNtK5LuyZ8iItPpjuxcYF8xI0
         2CTN3+OI3SpnpHMOoZRx50kKpguYiNlkLlbkmviOZmzbbm2uMZLjEDF9QHBq/Nn2X5qa
         zVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=axZ0RD4RwibpMs4YVi50mIvoAvn+rAMulwvywXzTB2DEBkIzEsB46xi3nsDFbVPChN
         AjbUUo5czMfRLwohoQEQAIjkTV5fmHJXo3UKCSxN6V7PZOsRFUfYeb3BmR4MenmKW6CW
         eN1eUIJtfkpkuA6WW/occ8qM2HvxEetWVL4G7gMysikfsHxs+c3DGs7wtrNdOTPfsdf5
         shnC2sf57L0TGH9FFhEVXHKZ2j7+mDe9i6KxEKNK2BL2TzfrCgwyC7Z9xgvhbJi3uOzW
         dRSpayvcfVo2/Lzi6+ydBnIW5FTVDNZ6feLv9QqGGR3R4BviCXSDBr75SfbBL6RmH43A
         ws4g==
X-Gm-Message-State: ABuFfoi++6I8FekroUktjcPb8HBLOfHx/e+kBA8n77El4WijH/C+ja1T
        LK3rsF6oFukNivTE+ToJxp4=
X-Google-Smtp-Source: ACcGV62CvjUD5JGQCjpLZhkMmwTzce069M0NylEBZwyOKREW+3dzcLSn/Ig8FUZS4zs0zVukwkgDLg==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr4252596wrq.225.1538316933722;
        Sun, 30 Sep 2018 07:15:33 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:33 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/5] dt-binding: timer: Document RTL8186 SoC DT bindings
Date:   Sun, 30 Sep 2018 17:15:07 +0300
Message-Id: <20180930141510.2690-3-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930141510.2690-1-yasha.che3@gmail.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree binding doc for the
Realtek RTL8186 SoC timer controller.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 .../bindings/timer/realtek,rtl8186-timer.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
new file mode 100644
index 000000000000..eaa6292c16e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
@@ -0,0 +1,17 @@
+Realtek RTL8186 SoC timer
+
+Required properties:
+
+- compatible : Should be "realtek,rtl8186-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt number of the timer.
+- clocks: phandle to the source clock (usually a 22 MHz fixed clock)
+
+Example:
+
+timer {
+	compatible = "realtek,rtl8186-timer";
+	reg = <0x1d010050 0x30>;
+	interrupts = <0>;
+	clocks = <&sysclk>;
+};
-- 
2.19.0

