Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA22EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8865E20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhmtXhtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbfAQTah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:30:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39252 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfAQTag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:30:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so4870220pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TQXPfCTSKnjwPhTiSWAl3v2d6xAWwhRd6YzBljgCz4w=;
        b=HhmtXhtFVTykWZakQ2lVKGUpfDSjUpUFiYStj44VFTVMkUye+E/nGOmbmSXH92rxwd
         znYaRbQ2l0GjXAwxjQ9Dr2jE8Ddy7pLvMgbYdtHm4GepGErdZXeE3JvLS0OSk1WdaFtF
         wZB4aMIh+4lNExY+SLJ0CkkOLqMCHkgmHkihk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TQXPfCTSKnjwPhTiSWAl3v2d6xAWwhRd6YzBljgCz4w=;
        b=O2TVC2EsxwdzcOQWQNPj+PoPuAd1BFBpLAhtG5LUS0PtXzdbCdYOeTF1JIDv9rvb1x
         S41xi3fT/QDi+f7ISHMRYnm8L5Cj+iLeWClGoaTU03fgdJYCZ48KZ9LKeGQkDPlFMGuy
         iMS78ZFcwdYnDOFe78+g45LDnC5OuET8hQNGyr5mzeYLZhvs5iK9Xo+Vbv9i/YjbfTaJ
         9QmkNRA/PvUQKskAm/Iqrik5LofJLgxHthYek2sq3qks1t2QvlJ5kzHzWKWzReP6Jshr
         DdIIY2zvRYsfNstEMzC998FzPtL7uAQLBu6MVMs6DMyEA2vsXoIvLM566lcuCpqDnr1T
         G8rA==
X-Gm-Message-State: AJcUukeS9MXmxc9rburZ/piStDkdg4jwjjmqZ2QU5h/XwiSmSl/uxXhs
        HzFMDIl/jAoEUgTSEGZQhEQ9i/ZAwOM=
X-Google-Smtp-Source: ALg8bN75cb6gF1eXOtQeb/UIK6lh7tE6tgJiAA2cVKRPT/Dbd3knq9drjlPtCF4DBDJUPPp7cnlLbw==
X-Received: by 2002:a63:eb0e:: with SMTP id t14mr14804146pgh.445.1547753435331;
        Thu, 17 Jan 2019 11:30:35 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x3sm3935192pgt.45.2019.01.17.11.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 11:30:34 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Fix lpasscc reg
Date:   Thu, 17 Jan 2019 11:29:55 -0800
Message-Id: <20190117192955.16515-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the lpasscc address and size, missed during the conversion to
address- and size-cells of 2.

Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This goes ontop of my pull request to Andy available until it's picked up at:
https://github.com/andersson/kernel/commits/for-andy/arm64-for-5.1

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e4156ea320aa..920bdb03a9db 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2031,7 +2031,7 @@
 
 		lpasscc: clock-controller@17014000 {
 			compatible = "qcom,sdm845-lpasscc";
-			reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
+			reg = <0 0x17014000 0 0x1f004>, <0 0x17300000 0 0x200>;
 			reg-names = "cc", "qdsp6ss";
 			#clock-cells = <1>;
 			status = "disabled";
-- 
2.18.0

