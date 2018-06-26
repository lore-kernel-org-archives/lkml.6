Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601D82679A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H92+HOLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601D82679A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934338AbeFZJY5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:24:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37229 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933675AbeFZJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so467399wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3XESVAEAqtEgd3rg0RnVmvpLTzr/jNXXPw1bbBZVbcw=;
        b=H92+HOLN+NU7S3F+n95KdUL9PPlnDxUh4fxw7RmZ1B7IvIPuMz3NHlsH2NKWbgTIAV
         5MDSFGaAlHUMSFjlDpPUV8/7IhORxMtNHXDQlyJTTohpcffrWwhum6NbmsOuzoFJHJwk
         z74wNNV2NpTmxNCP05u5OkfJh3SgSuoe4RmsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3XESVAEAqtEgd3rg0RnVmvpLTzr/jNXXPw1bbBZVbcw=;
        b=gnjbtCd7zYmZIUcK8cYnZlmBs4T6Gh1JyBDlp27NWUYTeQVv59wSJmhSYgFEddShIm
         /GN6RVm4wpuIG41W3ZBrO0RB+LgUXMY98BN8jmoZB6n7bmraDbTDwGK6Bo3AzrH3UdMM
         Tk0SpkAcDFpTbCletMMcK6sawiw5I3lgf2JGXgHVHGuTT0vy24utq1tLjDk+q+c89G6s
         QPGmEHhoRuULU3bo25gLQDjz2IXYpvjiyZz7cIYo6XM8CQXBsUFVsLSW6miPjcjaHr3H
         yFq5ZUuHLXNBa5P6ttPYSPYuOszMhdAQ+g2mt3GZlOkEEHaVt4qiLWA/4n2WOCHKVJQK
         9i5A==
X-Gm-Message-State: APt69E1aVedn6pZM7W4h6WDFbnFQSsL/GLXKAmEbDQbheXMh15D3jZyK
        j98eHjg+frMJqIHOIPa00xcuog==
X-Google-Smtp-Source: AAOMgpcTYDKwA0kTK+BktMTfJuPSZgZox8/af4rH0YumxUi1rGHn4yzrP8Lc/YXcH0l0yY3Q/vqCZQ==
X-Received: by 2002:a1c:8312:: with SMTP id f18-v6mr956279wmd.127.1530004946324;
        Tue, 26 Jun 2018 02:22:26 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/12] ASoC: q6afe: dt-bindings: add compatible string to dais
Date:   Tue, 26 Jun 2018 10:20:07 +0100
Message-Id: <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
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
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index bdbf87df8c0b..a8179409c194 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -17,6 +17,11 @@ used by all apr services. Must contain the following properties.
 subnode of "dais" representing board specific dai setup.
 "dais" node should have following properties followed by dai children.
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6afe-dais"
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -100,6 +105,7 @@ q6afe@4 {
 	reg = <APR_SVC_AFE>;
 
 	dais {
+		compatible = "qcom,q6afe-dais";
 		#sound-dai-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.16.2

