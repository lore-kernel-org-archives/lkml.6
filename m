Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798D5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EF72145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFdLHFbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EF72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeK3Sob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:44:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35409 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeK3Sob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:44:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so2379387pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 23:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xsbNaAib3hG2Q6HbDpz0Hq3OyJts+KC2ZFvdivQ13DU=;
        b=BFdLHFbzhU+37VXzDIkZNfO+l/KunmVoTqfXqNOuRBkOpBzfh23brj6wXI+PdyQaSg
         058rI6u1tw/i460qA1gJL0e4W/pu/BpQcRIaIWiSZ018XHyuBZnd/i8QwhjDoJG87Xvp
         ED7Ew/18XQmVe1AtNwt3tCh5b7+lWtxWzsQS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xsbNaAib3hG2Q6HbDpz0Hq3OyJts+KC2ZFvdivQ13DU=;
        b=t0RoHDm3LClZS1Q2QEX0mU1u5+Cv8lxTHRQiyhxw7agj/C+gLBQImgeg0MfRDxAhih
         ownv+mkqvKLMnDSE07Jxp/7hS5WUmGezr8YXa82Hca7KYfYo6Hcg54HN73ruGE59NRQO
         Yw6UuwN5PKO3k+WRsV0/yy7i35qIsVw4B6x+qg5Qkqcn4WO7folhQSznHjSzGa2b5OB0
         2hZDur39AKhl36sLrXHpez/j7CPmV8GDlPkS75HADqig7JvBEP5IwNP83/sC614N1J1t
         WFJ97xMJ1IhbIy/hrwoXMMOCAlZmKsksXCfZ56640i/ldwa2znxLcX43wwpktFyMuHK2
         NQeA==
X-Gm-Message-State: AA+aEWY8bFuQjeT9Q1CE1PSGXluHvoKXC0OPJp4m6Q7L/4Mtd8NlfSeg
        51tdQtpMbCaZB0VQfbDtQCScBA==
X-Google-Smtp-Source: AFSGD/WQ/xZrmlXqc5a0lcUIdZn7/Nq67iBMZNOmHPuPnuIrVU8TvSi7aICa+snmZ8TUdB2PbGCe/g==
X-Received: by 2002:a62:32c4:: with SMTP id y187mr4742571pfy.195.1543563367984;
        Thu, 29 Nov 2018 23:36:07 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m76sm218139pfi.102.2018.11.29.23.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 23:36:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404: Add pshold node
Date:   Thu, 29 Nov 2018 23:34:00 -0800
Message-Id: <20181130073400.28100-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pshold block is used to drive pshold towards the PMIC, which is used
to trigger a configurable event, such as reboot or poweroff of the
QCS404 platform. Add the necessary node to enable this functionality.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c16562bbe..ce00fe678e5b 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -260,6 +260,11 @@
 			clock-names = "core";
 		};
 
+		pshold@4ab000 {
+			compatible = "qcom,pshold";
+			reg = <0x004ab000 0x1000>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,qcs404-pinctrl";
 			reg = <0x01000000 0x200000>,
-- 
2.18.0

