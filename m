Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A965ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1086120779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKMlPkvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1086120779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbeGWRAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:00:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38377 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbeGWRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:00:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so1727215wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PuBAy/+QqrCI6FlnCJX4HOLVTirOiWLuNBsfvVcjRB0=;
        b=dKMlPkvbOJYv+A5nYLv+IO62ZVyHDbfAB/DBMyYRaTFbeXFYzA0aWP8CjvpKT8K+PB
         pe/UHvo6In/wbUuFBa68IpUS3yD7PsCijKbHh3gXPvaRlLf227k11QnoCW1mSINYQI0t
         A5iRHoCMWgFGSQG8fvui+jESIA4mglHwNjHiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PuBAy/+QqrCI6FlnCJX4HOLVTirOiWLuNBsfvVcjRB0=;
        b=MoyiGvkU+PEho38yXO9hm2UOhz7j5WmEU4ADKtjBD9gx0xL2jeZ8H7SsM4gyFUw3si
         iCy1SJqbe9k3TtGgdL4hYdGqcDfl+2D7HbIWlcaQLoB53xy6ZNCmDLhvMdan3/7XNm8r
         alrbQPc4t+f2toOCESgRmpB0n3LxkwkBo2cOt+bHG3PqXlEPYTCMptqUz2g/fPEPUzHo
         qLjkYSl+WET25GwPQxcj/9UZabrpI3+nVbfwON3YngI3EKLGANNX3dNPfaJqoML1aQC2
         RlTwUymDcbC91f42SkPeEmY2bO38IhgvghWKh5bpJewIzu93lDUQHtebS8zZry869Trw
         51cA==
X-Gm-Message-State: AOUpUlFOrXhgB3+HazizfVxuPLJBz8EJyl4BpPvtXsQ11//Vr2S5Lcyc
        4ql7vg5rb4fuckfvbrVBzk2DSw==
X-Google-Smtp-Source: AAOMgpe/yhsYs2V1Zy0jAGNbUtf2iwF2I4pgtLhRjuXtbeD9jJC0kOd3He5/E6tg53Gd5ut7vftGKg==
X-Received: by 2002:a1c:c3c4:: with SMTP id t187-v6mr8344054wmf.123.1532361500407;
        Mon, 23 Jul 2018 08:58:20 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 14-v6sm206385wmt.1.2018.07.23.08.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 08:58:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/12] ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
Date:   Mon, 23 Jul 2018 16:54:02 +0100
Message-Id: <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
and I2S/I2C interface.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
new file mode 100644
index 000000000000..55fcf7504fe1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -0,0 +1,21 @@
+QCOM WCD9335 Audio Codec
+
+Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
+It supports both I2S/I2C and SLIMbus audio interfaces.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: "qcom,wcd9335-codec"
+
+- #sound-dai-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Must be 1
+
+= EXAMPLE
+
+codec {
+	compatible = "qcom,wcd9335-codec";
+	#sound-dai-cells = <1>;
+};
-- 
2.16.2

