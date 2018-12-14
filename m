Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20904C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA05B20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X8t8L5Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA05B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeLNGVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:21:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38170 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLNGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:21:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2325459pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 22:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y2uFCXiJuXowKbjYO6BVNjHU6wQk1zGPwNY0PMaxB4A=;
        b=X8t8L5Lrcf998Ry9QkXcSsKXXfFvEcQOFPFvGwzZDNgzkrIqTm0c2/FAw6oLntUu8V
         HFX/Wm7lBcAHONkBQ7Ph5YpFxaQt8TbHa/g8ua5shT8ij4yvqmZuAAnwH78DaIeQ/GbX
         7QZ8usiAxLusob+tkP4d8GQM5tvEOlg+Bxs1MsS93IzKzhWmnOXu0wEthqULHK7W/nfG
         vdNAChftTblNo0hRsa0x95hTxYoaXmrjNoQMO/Dbj5yZrPvnbqkhwcAaM7gzufjnn41N
         BaCI74p8ySBF66WrCW8fiOLJtsfdk5BnepjMRsJR8nf/DGyNfpD8iI3HGNJJm1VoIwMJ
         R64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y2uFCXiJuXowKbjYO6BVNjHU6wQk1zGPwNY0PMaxB4A=;
        b=NVTQnVAP9GJnvi1S3y6VsIHBJ1hul5B/jjiJo/ock33IQjZywEDhpeiuhvymQXZ7jV
         SAtzrBhOQDvpdbqKUY/PWH+X0HNob7ydnxNIjgzo18V17I01XQqWGT4fZJWQII1zV8cx
         2ZmucreDkozOPVjvZ4P6v80PTOSWv8h10bwH0uEVaKIbfEWaAJiBFdYwuURWB009pJB1
         fpf6JVvM5HhcWu5O4mhAltE+m9DIaaCb59hgdXEzAPir6j7SUKvFa68dswHam1u8riFd
         /x+xkSw2e+QWutXYhgod3U3fgDYsUBUoW40jijiBhKgJdq0LWQoQgx5GGrM4wyj/t/PF
         MdDA==
X-Gm-Message-State: AA+aEWb+4JnsaHdhcMT43TDwxnJm8SwBuTpXMrBTset7XwLvyCbdzrph
        0UCE0Qq5sDzE+vMt9iadFftmag==
X-Google-Smtp-Source: AFSGD/VEStnIFYNojR+jlGrPT+98KR2dnXiG+KSAOGn8gu0KsUA+RHRAZrEFQr6S7RO5wyTqB/RP4w==
X-Received: by 2002:a62:69c4:: with SMTP id e187mr1740518pfc.50.1544768494383;
        Thu, 13 Dec 2018 22:21:34 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id i1sm4841703pgb.46.2018.12.13.22.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 22:21:33 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [RFC v2 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Fri, 14 Dec 2018 11:50:41 +0530
Message-Id: <1544768442-12530-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
References: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for PWM controller added with updated compatible
string.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..250d8ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,44 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. This is set globally in DTS.
+The period also has significant restrictions on the values it can achieve,
+which the driver rounds to the nearest achievable frequency.
+
+Required properties:
+- compatible: should be something similar to "sifive,<chip>-pwm" for
+	      the PWM as integrated on a particular chip, and
+	      "sifive,pwm<version>" for the general PWM IP block
+	      programming model. Supported compatible strings are:
+	      "sifive,fu540-c000-pwm" for the SiFive PWM v0 as
+	      integrated onto the SiFive FU540 chip, and "sifive,pwm0"
+	      for the SiFive PWM v0 IP block with no chip integration
+	      tweaks.
+- reg: physical base address and length of the controller's registers
+- clocks: The frequency the controller runs at
+- #pwm-cells: Should be 2.
+  The first cell is the PWM channel number
+  The second cell is the PWM polarity
+- sifive,approx-period: the driver will get as close to this period as it can
+- interrupts: one interrupt per PWM channel
+
+PWM RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+Further information on the format of the IP
+block-specific version numbers can be found in
+Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <2>;
+	sifive,approx-period = <1000000>;
+};
-- 
1.9.1

