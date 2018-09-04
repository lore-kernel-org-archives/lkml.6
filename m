Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFE8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B892086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYXbuMKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B892086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeIDJXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:23:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41408 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeIDJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:23:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so1028946pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wvwN+izZzaxLdtuHcPmstuWd7RpRw4uoCPxCZfhK2k8=;
        b=VYXbuMKt05aS14KM/l2DfyhTvSZve/JDDC1wuBMdVa69OCHJZNp/I74UHEukINZ8c6
         mhV2yJW24SOAC+G9yuJ5GfxkaaRnHEM6qRAJI/XilXwPs4miDJs9iQvV+4EpuZaOmsA/
         wVzQYEdpUqAz2mAhyQqLpKIJiVv0YzcaG/yIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wvwN+izZzaxLdtuHcPmstuWd7RpRw4uoCPxCZfhK2k8=;
        b=oBTSCFMstYdDQ7THMed1V4k2nTmY7lFQTElpvAOCAR34JYnyfGUpC4o/A5zNOj1l5S
         lWfoFI+v+o/pJfyBacvo3rPLTrHP+XbDOtRBSp5Hw9dDi5V6u/zH7z7xV41EVMyKkeqy
         GGGfuxHdZ1bDKg4zQeVKXBBbwl+o8Q2BZMSAZCkApKIoKXfHkGcWA8noDJnWOt/vq4wf
         TgGhz52SUhwDAEJ2Lh9JEt2gM3R+n1s1ABTwH2fXOXtmdcoi9ral/AOwBwNbLujfkwtI
         hqipNe6Eob+Nki5ZYKcBbh7pLKsJtUujJDI4k8yzXiw86lB0U1jKhwZQa8ML56ZEAD50
         roqQ==
X-Gm-Message-State: APzg51CAEjnLTVnJ/odXw9LX5TuZ5olTUCKNlE9+D/ooblHTugevZEcI
        xo0fcf5ZbtpUetCD584+B5Knaw==
X-Google-Smtp-Source: ANB0VdYXs8zK4Fqrptmho/iUb5UTumwUy/E7m9/BaLW8IVFB6B+CaaqROzXX70DIYxEK+HH+ive+Aw==
X-Received: by 2002:a63:f80a:: with SMTP id n10-v6mr28948999pgh.82.1536037180993;
        Mon, 03 Sep 2018 21:59:40 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72-v6sm41180378pfj.22.2018.09.03.21.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 21:59:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] arm64: dts: qcom: msm8998: Add firmware node
Date:   Mon,  3 Sep 2018 22:01:21 -0700
Message-Id: <20180904050123.26601-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904050123.26601-1-bjorn.andersson@linaro.org>
References: <20180904050123.26601-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the firmware and scm nodes for msm8998

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 335bbc339932..7cf655f04489 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -237,6 +237,12 @@
 		};
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-msm8998";
+		};
+	};
+
 	tcsr_mutex: hwlock {
 		compatible = "qcom,tcsr-mutex";
 		syscon = <&tcsr_mutex_regs 0 0x1000>;
-- 
2.18.0

