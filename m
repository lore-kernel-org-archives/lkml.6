Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F12267C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YM9FBofU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F12267C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeFZJ36 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:29:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33923 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933592AbeFZJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so14706197wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdGmQxzOghqMV5ZHv5yZbGKuLLYWfjUuKjjUkB5IiUQ=;
        b=YM9FBofUX5rpYJvEkVMD2VOBUk8fqWT3gB+NMDgbY+CN4fDnpXKALos/Dv3wQVL7aj
         UmJOXaSuoajMiCKyZy3KkdZ26npgJ3HpLfeovzXBiW3e92ai2RAAYQnhi4hURmLGq8Ps
         jlc5hbQH+cvibVHTGWHlPFTIRp3xdCF7uKv2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UdGmQxzOghqMV5ZHv5yZbGKuLLYWfjUuKjjUkB5IiUQ=;
        b=oQ5zQzXYuUKjyuAuWHrT43E64ZJxyTH8xoqDn/XVuHx/lcSzYQODsmgwhl1f4vte5A
         gYH7F0qSp9f3nict9IkpwjPIpQP/BBO1O/sM7B0shrMgUtVdEvSg9iz58wx8qDhn5QG4
         HkJzy8JAeIRjvt/SO8HTiR2z1+F+fxOkV22fQnSZsCK9i/x1sIe/yvO7oS9M4sWzj9IR
         uJb4N+esAtpM2tCqhJLt+j3ZaC46Shcvv+4USODuwWO6baiJVwop1P+j73+yWG418yUk
         cUKI9xD8/aHYvqQiPTTIORU+k8F125zOtV4J7Y0s2aayzlPkXnITMp1j0iBf6VCAHg/W
         yHyA==
X-Gm-Message-State: APt69E2GGcI+PcpK7MHudkNPdACl6iPmNB8/aM6RlOXRgGaEVicz6oxZ
        RBBal9s5xQpr/zKRTaR5MhKVpg==
X-Google-Smtp-Source: AAOMgpeuM1zAkvs8LIoT/2+0z7ArBQ1H+FfcJ0h52UefdfsT7WnUfIGQt2fxjtjdgA6WD+j2QN3Hhg==
X-Received: by 2002:a1c:5451:: with SMTP id p17-v6mr938209wmi.69.1530004945182;
        Tue, 26 Jun 2018 02:22:25 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 02/12] ASoC: q6asm: dt-bindings: add compatible string to dais
Date:   Tue, 26 Jun 2018 10:20:06 +0100
Message-Id: <20180626092016.9296-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string to dais so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6asm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
index 2178eb91146f..f9c7bd8c1bc0 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -17,6 +17,11 @@ used by the apr service device.
 = ASM DAIs (Digial Audio Interface)
 "dais" subnode of the ASM node represents dai specific configuration
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6asm-dais".
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -28,6 +33,7 @@ q6asm@7 {
 	compatible = "qcom,q6asm";
 	reg = <APR_SVC_ASM>;
 	q6asmdai: dais {
+		compatible = "qcom,q6asm-dais";
 		#sound-dai-cells = <1>;
 	};
 };
-- 
2.16.2

