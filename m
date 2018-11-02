Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E03EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703E820833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGdtU/gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703E820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeKCERg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:17:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33710 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCERf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:17:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id f19-v6so1837283wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cs/HdsgXrRlb81nkVaefoI3h8zuKKKj/56RKUVVtQxY=;
        b=RGdtU/gDTXeH0/chT7ehctiXFFGrPalMWu1QBCdTU0yCFeBGarEi9G6CC3koHGZCdb
         lDZwpPgYmXvoWeAi0PzVtjMlxmEFQRCEtBUrTmMDXXor0gUqWMFV8aL2qVP1XvEn9P9N
         EG/ocwbCPVNQVyrXftndTAesZZkK/Hr9amPyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cs/HdsgXrRlb81nkVaefoI3h8zuKKKj/56RKUVVtQxY=;
        b=Dirij63xR1hAkbBZ5MQG4y+uw9qts9HcdDPWNtb8DJUp73asYsOObwV/ZI+9mwMphu
         O7p6Kh5+Xf2NISy7I63RLqTQS7yNMRWwYoRtHIg6gkoyuKGQTYyCeTs1T4YAj3PyrnZe
         lU14gzvHBIHzFwnMn3PyMAtgYw2mFnQXWy/ErK3S7XGV4r+SVM2RT7geqj/m3gLC4kL4
         4KoG51uSzI0v+Yyxo5dqD5CHw6hi30EZIHGu9pOYw4W+Ddvs4CmLMitD5ykJaVwm+4tu
         K6Al+/KPzEQxOiAe48/f1k5tUMzGteTL9B7NDj+o9Cgg1jXcpRnAHTstdco7ZI+Il/QI
         A26Q==
X-Gm-Message-State: AGRZ1gKE39dkEgUwoSeuBipB1gQqCkEJ00j2mpfReiJkBvXrbByEy3gL
        DIUJTYHeIVcBBoY7U10lLgii3q5ok6o=
X-Google-Smtp-Source: AJdET5eNf8QcYrTayLAECMhJ58gzrsgkIw471k7k3vfRk1nt5pdm6T9WXkj14KYO2jw9dAPccHFvwA==
X-Received: by 2002:a1c:f60f:: with SMTP id w15-v6mr162627wmc.101.1541185752982;
        Fri, 02 Nov 2018 12:09:12 -0700 (PDT)
Received: from localhost.localdomain ([80.125.186.228])
        by smtp.gmail.com with ESMTPSA id s195-v6sm3899337wmd.39.2018.11.02.12.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 12:09:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ren_guo@c-sky.com
Subject: [PATCH 4/4] dt-bindings: timer: gx6605s SOC timer
Date:   Fri,  2 Nov 2018 20:08:58 +0100
Message-Id: <1541185738-8208-4-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541185738-8208-1-git-send-email-daniel.lezcano@linaro.org>
References: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
 <1541185738-8208-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Dt-bindings doc for gx6605s SOC's system timer.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 0000000..6b04344
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
@@ -0,0 +1,42 @@
+=================
+gx6605s SOC Timer
+=================
+
+The timer is used in gx6605s soc as system timer and the driver
+contain clk event and clk source.
+
+==============================
+timer node bindings definition
+==============================
+
+	Description: Describes gx6605s SOC timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,gx6605s-timer"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: phandle + clock specifier cells
+		Definition: must be input clk node
+	- interrupt
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer0: timer@20a000 {
+		compatible = "csky,gx6605s-timer";
+		reg = <0x0020a000 0x400>;
+		clocks = <&dummy_apb_clk>;
+		interrupts = <10>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

