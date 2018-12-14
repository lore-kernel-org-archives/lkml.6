Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C1FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E733F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ylsIdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbeLNRBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:01:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeLNRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:01:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so6114743wra.6;
        Fri, 14 Dec 2018 09:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P7Ww3vpl4jXN22ajj6oEPSWOSuJBg3MjsqFHYg95A2A=;
        b=S5ylsIdwsqHVLxh48q2B63B1mxDTLUB9Y5ZCOb7r1pcznRmV68dA4tLvXyp0IY4zY7
         8MJztSWgJ/lrgHbFzApS6hK3tQB+9UwcMoYtHF2t4eVh78RS03D0CRL+teL9vfyA7wpI
         OSH431TCsrUPcAvGjVdkl60nicq3D8MrpTiykIUYnAjcl1yvUYjhVcHPCXwxDbRfrgF0
         H41oPEl4tsEp5r7+X2m67cPFPTYWbpRzP6oIxlFZTxsiHaimFMmoCsVadVB83/NVH404
         S+IFVEB1tv5xualVAS/PPEl5iWNStpEdYKEKe/JoFfMhjuS/zyfgBNFvmIv/g+614mgA
         /UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P7Ww3vpl4jXN22ajj6oEPSWOSuJBg3MjsqFHYg95A2A=;
        b=WjKTLbUZsng6BhfNE482wIaYzzXybEr6fh7Zvv5+iILNjhx7dV3Td4hOR0wmquIMd7
         1mYfZH01hWfeoXR7UK3c5s/2iGA+ybssugVkkAxTVFsVAoU7O+BC1hCfSMi9ykE79Rjf
         18bLtcrAyh7PaMNY5MYt+4y+IR5Jetyv4IogsL1hc9+nGN5HqyxyM/WDa9EogxprAtGD
         leR2YMEyJikOaZ1EpqMfarA4NHxkTMWC6Hz8qW8gKymy+aDxILb8Q0t1tOXZxnYlsb+L
         0MfNKUfvXCF3e+MMVDbKxR+ihkThS6wJFuTFDDDXX3/bulboGEVMhdIA48+Ar5ub/7hS
         g5gQ==
X-Gm-Message-State: AA+aEWaiCetNT56ac4Rqc/dvdOrfmpaCVtjh2sh2t43RQxgVe2HWnuYr
        4wbt8Xg7NgrpTKpGY+Gnbd0=
X-Google-Smtp-Source: AFSGD/V7UhdKwGOQpRl+55soOgcQnhskPDwr5CdC2+hNi5Yum/fCRc6o/OeEOheOXu+jJ74fBHudnQ==
X-Received: by 2002:a5d:5649:: with SMTP id j9mr3201499wrw.256.1544806909123;
        Fri, 14 Dec 2018 09:01:49 -0800 (PST)
Received: from centos-2gb-nbg1-1.localdomain (static.211.22.203.116.clients.your-server.de. [116.203.22.211])
        by smtp.gmail.com with ESMTPSA id 60sm7687814wrb.81.2018.12.14.09.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:01:48 -0800 (PST)
From:   jakob.wuhrer@gmail.com
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     Jakob Wuhrer <jakobwuhrer@airmail.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: Correct "gpiio" typo in msm8996-pins
Date:   Fri, 14 Dec 2018 18:01:30 +0100
Message-Id: <1544806891-12516-1-git-send-email-jakob.wuhrer@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Wuhrer <jakobwuhrer@airmail.cc>

gpiio5 is missspelt in msm8996-pins.dtsi, fix that.

Signed-off-by: Jakob Wuhrer <jakobwuhrer@airmail.cc>
---
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index c5c42e9..1d1f7f9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -139,7 +139,7 @@
 		};
 
 		pinconf {
-			pins = "gpio4", "gpiio5", "gpio6", "gpio7";
+			pins = "gpio4", "gpio5", "gpio6", "gpio7";
 			drive-strength = <2>;
 			bias-disable;
 		};
-- 
1.8.3.1

