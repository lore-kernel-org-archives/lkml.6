Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BC1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C5820856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wy2sTZRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfA2Lnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38606 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfA2Lno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so9536379pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7V3NEnt0RHAHgpKuQI6RBLlHxLKpOJpI6SzIqXmgoE=;
        b=Wy2sTZRVZCOrrhdnMBpeBh+ZkXMChwx3ZTSkwwSmjzAIhnToasM9qU9/eVcOgW4Bah
         KZIUXl5QCNEQZ26QsFf6r1km8mgNdwJ0T4Z5xggnJjbrWt/6CM7j9moN6sr2sb/5YXLf
         l2BbIt8iL5UmNJuVgtLs4kKy316Ott/akzKcTgSH0Whtt7hcmdyvTzhQckrsyL7FnTO6
         eO1m2PQzF1fsaVUI/BzVe8UaJhrRjNwHM7IGOEljVLCBfI+LCAfvkFKn8rTUlXagx3M8
         6+DHqXd15f7YsPBzJ5lV4Y0uRF/Lpt2vCblv07a5c3VOpPIz2gCx++LQtc7woByllYEE
         oV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G7V3NEnt0RHAHgpKuQI6RBLlHxLKpOJpI6SzIqXmgoE=;
        b=O0zDA1iY/x2ZwWMRSpwokGJj84CThhW54DtNPATKpwRCHlq9hqg1thPr7/ufKGNCAD
         SFGIWWsQryUVOM7XcvZ21ZIZKMLIJU/klCPSe0FzbUToDzcxdXE/UGwJyWygfcKw59La
         5c9VbZJ7zwYTzxoqH7uw/jj86L/oBcTAkshoLl4PWu7fucRoxy2IKhC0RA6NaJfvgUyc
         I0KaAm5Fub+ZdLW2C2i3UcA2GedaFaI9kSL+Nuiuokvx47gmM3jN4SYk4xQv5+jPodgt
         TBMKNVKuDOCyNblIUXyFV+QN4abqVSQe56H1qu91xp4nTLYsQpNMmtB1UbWamtJpTJJU
         fZGg==
X-Gm-Message-State: AJcUukfGVvXu/wR+S5HrPYIIKStdJLgeAI55GD8lQtRHV4nPRLVTHnAZ
        cCY0Q8RzHcFYCi6B1VoOo7z1TA==
X-Google-Smtp-Source: ALg8bN5UHWdDrQGuqQnVwIC6QqMaf6nFVvX9H79FBnBHAO8SOkmLwGLxSkuiHRPFCYWE6EX4e9JIoA==
X-Received: by 2002:a62:8a51:: with SMTP id y78mr25573066pfd.35.1548762223414;
        Tue, 29 Jan 2019 03:43:43 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p2sm48755717pfp.125.2019.01.29.03.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 03:43:42 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v5 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Tue, 29 Jan 2019 17:13:18 +0530
Message-Id: <1548762199-7065-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for PWM controller added.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..8dcb40d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,33 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. This is set globally in DTS.
+The period also has significant restrictions on the values it can achieve,
+which the driver rounds to the nearest achievable frequency.
+PWM RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+Required properties:
+- compatible: Should be "sifive,$socname-pwm" and "sifive,pwmX".
+  Please refer to sifive-blocks-ip-versioning.txt for details.
+- reg: physical base address and length of the controller's registers
+- clocks: Should contain a clock identifier for the PWM's parent clock.
+- #pwm-cells: Should be 2.
+  The first cell is the PWM channel number
+  The second cell is the PWM polarity
+- sifive,period-ns: the driver will get as close to this period as it can
+- interrupts: one interrupt per PWM channel
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <2>;
+	sifive,period-ns = <1000000>;
+};
-- 
1.9.1

