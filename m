Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72620C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3423B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3aIkQqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3423B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeK3SHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:07:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45816 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeK3SHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:07:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so2311697pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bDNuh8z2OloRaxk45I5cbmt0YiC2//HWTgg8fYbj7s0=;
        b=Z3aIkQqBq/yzdPoZPbC4a0kKl/SMHSx6MzQv7cDqM/86CS/CDntu9DW2AzLxy93qik
         odBtEHND6GKz2ChIH77cLBhvge42mHCdk83mkEBiC9SzqDlLotM1uqWX+jSP8jIUsKIL
         l55E6/VUxAK73Wrdxh2shc/ah0VsBJX7yeAaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bDNuh8z2OloRaxk45I5cbmt0YiC2//HWTgg8fYbj7s0=;
        b=baUyTS9tF3tLXkpNzrOKBfCyPBkkCGWbhEve97NREp4Zt6YeBv+anWy8ZsLiEPEO15
         KOO0dYqeHUWqzHYzTHWMjehYi/UdNWbVvPufltjg5F3jPoOZodGFKzeR8fYvfEqZfw1d
         BJzLWGwZEZDrHkSYsL/WYMe0Wz34YUR/jmwaXmAY4hoXMexTI4KL0pgoaSOH+kkbcGDL
         KZpFnWsOK7XBV6Vk9dZNPj8gnWYCGOLclwE9zwCrspKzC4Qio0hKY3fGCRhOeZ2Sc5D5
         vde6wDFZj80l3yZCIEDvLYnxCpGCLGGGks0Xfg6i3NRJBUx2sngYCfgRpyR4bk29bGKR
         pNSw==
X-Gm-Message-State: AA+aEWbEhiQURx84JqbA0UDUgjlyPzfmClqZTIUPOLXY3QYjIYmUAteD
        EJ2m7fOigv6lqcyr4KcpPAYY1w==
X-Google-Smtp-Source: AFSGD/XARtZZugigznnlZz7i+aba4nEyWiaCIngVD6/q2Ja+rUbuy2gFZob+R4l5l9pc8mmduKWcZg==
X-Received: by 2002:a63:9f19:: with SMTP id g25mr3839562pge.327.1543561143884;
        Thu, 29 Nov 2018 22:59:03 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z30-v6sm5820963pfg.41.2018.11.29.22.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 22:59:03 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998: Fix compatible of scm node
Date:   Thu, 29 Nov 2018 22:56:55 -0800
Message-Id: <20181130065655.26713-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scm binding and driver was updated to rely on the fallback to the
default qcom,scm for any modern SoC and as such both are required. Add
the default compatible to make the scm instance probe.

Fixes: d850156a226a ("arm64: dts: qcom: msm8998: Add firmware node")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 78227cce16db..a15949d32bad 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -239,7 +239,7 @@
 
 	firmware {
 		scm {
-			compatible = "qcom,scm-msm8998";
+			compatible = "qcom,scm-msm8998", "qcom,scm";
 		};
 	};
 
-- 
2.18.0

