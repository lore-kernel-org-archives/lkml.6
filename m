Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9206FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FDD2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMwW5LBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FDD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeJARIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:08:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41079 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeJARH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so13301430wrt.8;
        Mon, 01 Oct 2018 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=nMwW5LBA8WrGgwePmDgiisPk20YadWq/BoIoR2xiCHcd3dVahu1j7gm3Ptj8UyG2Kk
         aDbVRCXsGw/K14OOcrI9onnJGTXQAoe97X2vusHOz91XlO9HQkWfo1wKWD9QH5b17cUv
         ioiA9JMAndcT3I8yORBY8Maf+3y/sk5lmJV0D/3DX9rS7Q5zS8FAyFUIfvWu7a9lNKex
         hUOMfoBrrKbYu/PWqVs+EUfFLj1+MxaidtMCaifeqZdvM6wWnA41RjTd933NYI9rwVW/
         7Cos9wND2zaFb0D1rDVqYRGq8xgJKk0nlTSXL8RoIeoRTYqhjysxGSpLStgr3DUpCsQi
         OzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=TETszzp2dt93wpkR+Dfi7mk+bb97oWfBS5by5LyvtZkw6HRdBvhBNQSG4Ufom7W8IN
         JxduSbEf1U5HsmHihYkC/S/qrs4uLbWOBlbQdjeNCanoV3Guyu2Iijbue6Hbfdvxq99R
         t8RFIw8+oBrUoDGW3o6hi3y1f7EhzqTeNsrlcpQpmnUz3pWQprQqv9dlTurhVKSSReiJ
         mamVXNOv+X3K6uE7a9iiNnBmomULgt4aVt9xEkD0hpKDCJ7QhR8ZMvLCvIJNrrfFrwEw
         ztCTapmNC+gN8qnnNqUNIMrrEk6KYGZPLDeOmFALCExSEwFRhwFsCOJvWX5AQgNRjQnx
         xgzg==
X-Gm-Message-State: ABuFfogqskpBqAqZZiNVjBGYRbbQVbaSyzlY9eqS3ggqfKp+P8SoNQEQ
        Hd3Pkhssvj/zdAn31cGW5uI=
X-Google-Smtp-Source: ACcGV63/RMHbOik+vGmGQqIGsQNnD0Fe03xJoZK71lbaIqBrkaoXo3pXhiUsog7bMr2UAR3HymSzLQ==
X-Received: by 2002:a5d:5342:: with SMTP id t2-v6mr6469966wrv.257.1538389818383;
        Mon, 01 Oct 2018 03:30:18 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:18 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 2/7] dt-binding: interrupt-controller: Document RTL8186 SoC DT bindings
Date:   Mon,  1 Oct 2018 13:29:47 +0300
Message-Id: <20181001102952.7913-3-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
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

