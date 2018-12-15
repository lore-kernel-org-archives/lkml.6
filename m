Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCF1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD0420645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5girEMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeLODCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:02:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45174 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbeLODCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:02:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so3677308pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 19:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IA4f8trOcC05mppHip2IfoM8w5YdU8xupgECA60alGo=;
        b=N5girEMfNekJHYTVKfmiRezC2W4eSPNeKQlw00k7eI97yCnAcMD49sZTFDWfg3NRD6
         0BRcUD59sRfQGsixEFRnLNzYJpKBN+21eTcsk/EMHY2wRxlvW1Zcl6E2UXFAIl7uvdEr
         DNxWIQUORP815yIKfIm9J6NSw98Rlwhi+2XPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IA4f8trOcC05mppHip2IfoM8w5YdU8xupgECA60alGo=;
        b=MEwhfiH23ju2hwxFXOfK+KDgbjW7UjuSKgNY4Cbf77igB952g8AUpXLKzvQ1Jze6JQ
         p5Y1NUCFDCWDWcUJ7g1xgouqcUiG9SslP85ORCJ8RkgBJTd0Fq7xjGfUdBTexyrhTalX
         LEQC5EiLQCstcqo2MABo/vFLINEDcd2FQtbHMOORGFJ32bYGPSjvJFlrJ0bEbxq2qU8Z
         Y8Rq5rQf77RYpA/KO1LRDtfexR4xnVcXiyv7ltqglBLjkLzNwtVpZhFulw22KbG2aP/x
         6GRhVnDoC+1Mfpj/Lk+vByllNw/Xl3ZXwJlhxrSzbOS8kC5xzhaHfD8HeTMnIOUV/TxP
         FJjw==
X-Gm-Message-State: AA+aEWafros3chqV6hurYF0GATB/Rq0EA7YMfx/3lu/TRD58yjltSn63
        bNZglVcIE3fOgfT42btrMPc/
X-Google-Smtp-Source: AFSGD/UFtsfZW6LjpCWIDfSSRzZt0VO4Qz1tjAEFi1wFtIV0tnGhOk7O0/atqGDgrUKyuoXiWQh8DQ==
X-Received: by 2002:a62:1043:: with SMTP id y64mr5260161pfi.78.1544842942629;
        Fri, 14 Dec 2018 19:02:22 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6301:5419:f1e8:77a0:59f7:2cb5])
        by smtp.gmail.com with ESMTPSA id h15sm7309534pgl.43.2018.12.14.19.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 19:02:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     dinguyen@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, amit.kucheria@linaro.org,
        yossi@novtech.com, nazik@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
Date:   Sat, 15 Dec 2018 08:31:51 +0530
Message-Id: <20181215030152.4386-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
References: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for NovTech, Inc.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..ac182966249c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -270,6 +270,7 @@ nintendo	Nintendo
 nlt	NLT Technologies, Ltd.
 nokia	Nokia
 nordic	Nordic Semiconductor
+novtech NovTech, Inc.
 nutsboard	NutsBoard
 nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
-- 
2.17.1

