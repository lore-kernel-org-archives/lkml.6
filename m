Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FEDC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208F520863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbTYOZJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfBAPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:39:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40459 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbfBAPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:39:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so3382069plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/eDFiU+7KNoLYdpw1NkuAhHQ88OLOmPVAtIDTQWvTdE=;
        b=MbTYOZJvuRP6utRpezSOD/+w9RM8L9RrQYTDP7+H3mZbry+fDTp+hHmpgRqWsH0mRF
         ow0r1MF5zGmTc9TqnuAIc1+KwylQ6aV+8tCiEFl5UkKqOffRCG2Q/nBA3t9PQNh1k0pN
         96/D4U46eE1N8zkqpifQss6UDUtgabGDnpozk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/eDFiU+7KNoLYdpw1NkuAhHQ88OLOmPVAtIDTQWvTdE=;
        b=H38OMCemIJlShXsqeq+OmlcF2d/n7RsLtwFPZAVbNdvTwaDKNEBYnPcGw+GY5dcN6H
         jbFc+Ohzwee8v35MbDZ+KGRfoG+ZqCQx962wK8iNdamtYIIlElI0AJvZt1pAXjnhBN5J
         NW0ZdVjyleHPLfaim8p3WKMUK5o6MzOALikbq/HtBS9WJpbjhd8oGhtEEVNGAqB0eg2r
         gRriqcSNmn10kis1FTDInvl8w1ipQB5MD+hLcnCyyuvQSmIpE7M4VxwLVB9gaPil1B0E
         x3/c91+oi5qDM1e2/gpMVkPRN3hv93k6e3QfxmAjmbViR5Rkn+Ctf4knF8ttpA5N8idS
         1JLw==
X-Gm-Message-State: AJcUukcCm5YgvZhd2zliBNLuf+UCZq6TD8bOHEOkc6WW3MRAkzGwO7RF
        vQpKcq1x7MaZayGO39wPNPGeuYlo2Q==
X-Google-Smtp-Source: ALg8bN50b+qQrPq+/IZNPw8Lb/zo7wXHou8HW8efg6X4yWh/qpN4TgSjhUgYjtHuv3bpXqg9ByZxbA==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr40015197pll.111.1549035542441;
        Fri, 01 Feb 2019 07:39:02 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
        by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:39:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: reset: Add HI3670 reset controller binding
Date:   Fri,  1 Feb 2019 21:08:39 +0530
Message-Id: <20190201153841.21903-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
driver is reused for HI3670 SoC and the binding is documented here.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt     | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
index 2bf3344b2a02..5d60ec541331 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
@@ -5,11 +5,12 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 The reset controller registers are part of the system-ctl block on
-hi3660 SoC.
+hi3660 and hi3670 SoCs.
 
 Required properties:
-- compatible: should be
+- compatible: should be one of the following:
 		 "hisilicon,hi3660-reset"
+		 "hisilicon,hi3670-reset"
 - hisi,rst-syscon: phandle of the reset's syscon.
 - #reset-cells : Specifies the number of cells needed to encode a
   reset source.  The type shall be a <u32> and the value shall be 2.
-- 
2.17.1

