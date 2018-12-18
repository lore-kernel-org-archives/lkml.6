Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD46C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E2821852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vr0ulnX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeLRPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:04:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40697 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeLRPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:04:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so7935001pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZyE2u/x6knKCVFcTEeQSNyr8fOyOJ4nkYkMjo3bMh2M=;
        b=Vr0ulnX35CEGh2MCG+DB8I5x2nAWwFenlVCA4OL7ruMkJP+7SNlJ6N1qvYHMRwNQrf
         cgpYWp7aPElCv4rkpvtcTQovERPPk9i3gOWXOB0jX9pK9hmEwljrVP+IF/XExrxK9e4P
         l3C2icU6all4dweckFJVtVo7hXrQFwLcIzlj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyE2u/x6knKCVFcTEeQSNyr8fOyOJ4nkYkMjo3bMh2M=;
        b=QL8bKF1C40Gz8/5rw5XH87gE1RPyTrYORB0Lo75f+DiahLQtJzykjBjSasdLAx0PJc
         2iDtR8vtw+X9fos4Hbs7h0Wn7nAjsuzjcQhjIYK8tVdSU1Drl4G/8iMNMMDnsvt2gI4p
         p14T7l6A9gQVoIEH40M1TuYoQLzewfsHJVPi1Oy5xGKeG9r3EY1OlCgpqhhz84D8UfKv
         FKAHqGoRNvpePkUyfDd7AnSpAgMgbfmzdKFSJTawRdG7EUkJpVLPTK3K8n6CNSpq3/D6
         gUVtPVGYZkILtSUXIiGbVzC/HdldXT4440YZ889GI0/T+ykP3og6hzMced/7JOGW9FfM
         +l+w==
X-Gm-Message-State: AA+aEWbJ5IalDnBNKd4GVs91x0uRKAf7BAvTy/LykZ8QhURpxBe+42YN
        UwkchReBkSyyI047Pz2x9kCKN/Qs/Q==
X-Google-Smtp-Source: AFSGD/Xk6jxsVPBjTImvDMuUNVfX9dobCUceaV1lugNfBzC4qh4ZQNOfLOE0hOFgmO5S+rc5dUYqnA==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr17393861pfa.229.1545145441586;
        Tue, 18 Dec 2018 07:04:01 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:04:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 08/11] dt-bindings: serial: Document RDA Micro UART
Date:   Tue, 18 Dec 2018 20:32:35 +0530
Message-Id: <20181218150238.23010-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add an initial binding for the UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
new file mode 100644
index 000000000000..a08df97a69e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
@@ -0,0 +1,17 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+- clocks     :  Phandle to the input clock.
+
+
+Example:
+
+		uart2: serial@20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+		};
-- 
2.17.1

