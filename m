Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58755C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BB2217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBsidocu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfAJPGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:06:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50586 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfAJPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:06:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so11605321wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWFlqbGAFzvrAoHmmyqgPgLoONPfHVsxP0tJdBCnNvc=;
        b=WBsidocuTERlLUsDnAuqCDJt1NAX57/m/MRIiZnsmLNoV3g85JFY4ebc8g57yefVNP
         GkS2hSSFolB6hSSux9KwbNHzhyaS+pmUMEzpMlCQzHkMgy7l8qriXabZVh287Wh6Jb9z
         uAmXiWqrLcaP3i7E4w4dxkd2idT9R1qjZgYYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWFlqbGAFzvrAoHmmyqgPgLoONPfHVsxP0tJdBCnNvc=;
        b=ts0W4bBDkPqERsfc91SsIkCQNJWKD92Dr12dNTVzK/wqL+mLPqu7V8YsVmZTq+hC4S
         ix5c47KUw4bXgVxgvvLXXpPOHDBSAnEr2jM+J2SMRox0Oylqs3/mY3BJkKqleksD75JL
         onYNNrQKfaAFibBGo0/D73gDjTQKkUw9SPKNtIiowLae+leYkDpVxrJt8vOJYpGwKIA3
         xFvQSsoCVFZ4bLEBiFYR8NztbnlSTM4mMlWXQH+8rcXWFdS87a7xRv93eIMDUqh2w+Ia
         eO7WIIusmZ9UQ0gUvBCpHOT2n3kf6Nn1qTsBRjNuvEc7A8MuCHmmMyua00O1qNsYXuoU
         2RbQ==
X-Gm-Message-State: AJcUukcA8RJQOb5Opx0vruloL1RS0kmZ3MWdvkt89c9endYamkln9nQ7
        DrAXA1ApCc09ZeJRPxiulyRC3A==
X-Google-Smtp-Source: ALg8bN7zValIsnnrxc0nEwa/cB3P+G2KWwqrcBKiTyL8Xnk0ixwFf/9xMV7jBlp94fKTnPaNBPPJVw==
X-Received: by 2002:a1c:cbcb:: with SMTP id b194mr9469694wmg.64.1547132785285;
        Thu, 10 Jan 2019 07:06:25 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b12sm51063754wrt.17.2019.01.10.07.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 07:06:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/8] ASoC: dt-bindings: update wcd9335 bindings.
Date:   Thu, 10 Jan 2019 15:06:09 +0000
Message-Id: <20190110150616.2332-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates wcd9335 bindings with recommended properties.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 1d8d49e30af7..5d6ea66a863f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -34,12 +34,12 @@ Required properties with SLIMbus Interface:
 	Definition: Interrupt names of WCD INTR1 and INTR2
 	Should be: "intr1", "intr2"
 
-- reset-gpio:
+- reset-gpios:
 	Usage: required
 	Value type: <String Array>
 	Definition: Reset gpio line
 
-- qcom,ifd:
+- slim-ifc-dev:
 	Usage: required
 	Value type: <phandle>
 	Definition: SLIM interface device
@@ -104,13 +104,13 @@ Required properties with SLIMbus Interface:
 	Value type: <u32>
 	Definition: Must be 1
 
-codec@1{
+audio-codec@1{
 	compatible = "slim217,1a0";
 	reg  = <1 0>;
 	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-names = "intr2"
-	reset-gpio = <&msmgpio 64 0>;
-	qcom,ifd  = <&wc9335_ifd>;
+	reset-gpios = <&msmgpio 64 0>;
+	slim-ifc-dev  = <&wc9335_ifd>;
 	clock-names = "mclk", "native";
 	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
 		 <&rpmcc RPM_SMD_BB_CLK1>;
-- 
2.20.1

