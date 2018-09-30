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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DFDC64EB2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BFC20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsb/209y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BFC20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeI3Usw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:48:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32870 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeI3Ust (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:48:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so721720wmd.0;
        Sun, 30 Sep 2018 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=Dsb/209yFJkMl8ZV5UZSq9ybQeVs91BiJx8Vi3h6NTnKWiN+nb9OMLk5YcB+XElPuy
         Lh+q9vryyAhLbCx4qqdvTYv23H4jqhCaSGeKPe7/OSmpagkCZSqMNZ55OM+nyzWXo7r9
         Lgsch/OuS9dDOB09v/R2RIzzcW5JwBj8ig3vcWy2qEzpy4hEyUI4gWwqrqXDonKmhuHS
         yJXiYka2UYhLqFraRx4HwMLjKOaDojf4oseXjRzZPg9j05veSB9HYfPCZiQm9F84QMW2
         cTUHpqJze7YcCFacVlZCTGXXvJJNME2StPiQ4omfq/zjRpESLbNdQqTOrjrDiU6s9Vi4
         ahYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=Bvy4U/i1dRG/jX8ub49lc0m22Mr6Om3oukPoisGdJmK4YN/Pv34c9W8A/If8Mzqcm7
         VgBV1Xee73vMovrcNKbAG5wusZHMzE4uYC7QfkhIHmIUBkYaTxBdR0LiqLc4/GGbSaNn
         O0P5UNSZrOzuFn6vNu0jPeWf4GSIdVRlhvfFCERJ3OTxKcHsSJUihHV7Pllx43dqlsQF
         s22HJypNHqBl1NpbxQwmOH+GNSMDI5U/pjvz1ZIQodcODhy/xnyjXS9maEvI6ZTSZ8ee
         1T1dbywoz4zSlXe91uyxvLGr1W7qqI1KrAbqpIh9rYM16yZjZoQjLZlhMELdeL8ROydf
         BhBA==
X-Gm-Message-State: ABuFfojkPUKJYKocAJ1uchIWFDjqYoPwLmI0A+dOg2GfPQCLALuf4Hiv
        kQxzqjWHV0YVcffQ8kuLba0=
X-Google-Smtp-Source: ACcGV62N6K0XMIPKLVAVpfE0r+VkRZLP3ypLiMVB7nLQQfraMrAEq1uZV1+kzLczmz5JCmsJ1idHCQ==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206-v6mr6276008wmg.93.1538316935860;
        Sun, 30 Sep 2018 07:15:35 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:35 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/5] dt-binding: interrupt-controller: Document RTL8186 SoC DT bindings
Date:   Sun, 30 Sep 2018 17:15:08 +0300
Message-Id: <20180930141510.2690-4-yasha.che3@gmail.com>
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
Realtek RTL8186 SoC interrupt controller.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 .../interrupt-controller/realtek,rtl8186-intc  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc
new file mode 100644
index 000000000000..21956d210021
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc
@@ -0,0 +1,18 @@
+Realtek RTL8186 SoC interrupt controller
+
+Required properties:
+
+- compatible : should be "realtek,rtl8186-intc"
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+intc: interrupt-controller@1d010000 {
+	compatible = "realtek,rtl8186-intc";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+	reg = <0x1d010000 0x8>;
+};
-- 
2.19.0

