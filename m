Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884BBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4317424064
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKSjxOyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4317424064
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeGFD4H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:56:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46487 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeGFD4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:56:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so7208869pfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t33j/YWl9147C3o56cc/SXhWTJq/mWttqXWsSRue59w=;
        b=FKSjxOyNyLIFqLRBdLbPexUrj0l53lmf2+WYmqJkoaH8FoZ4gOmGG1nPNuloakxI3H
         3KBYdenCi3prowOjbwKen0iX+OG1lMiUg3mRMDqY/I5/Lb7R4z5OQAXK/Kxvw1Gx2A77
         hdM12KOYrciQzRugydXXC4t9CSt0uWHeeV4OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t33j/YWl9147C3o56cc/SXhWTJq/mWttqXWsSRue59w=;
        b=nin+c8+jr343evlU6D83Va0EwxZzCRUoRKDBGTxinOpaNs5xDSZcAsj22VAr4gO3Px
         tyJ/lhczTPLIRFRGdaC/m+maYZ7uuDWRwsSt+8WYeHP4Y/rNN6uCpNNVvKnFXL+O5N8w
         Se9qGi5fjkuwKPIo2kMYNev5mSNjN4dGmzEFN1rPANXml0Em5GoEmNLWWoEMMtS0hpcj
         1wgWbF36/111P4BxwbYtlK/b2Fb1otDs0hmZIilPh9oOGRjCrSpYWdrfSn/yw90dH/n3
         HxQ5vVzmmQBgb+4+8rHNf4BWQJotdxmAAxUbo2f0+jnqFIeG85uQUW1e9HeqR0m1bLkW
         hSzQ==
X-Gm-Message-State: APt69E3MzHAJCyUrHJ7Y1a4OYJtfDxjZVLm3GaAPXjfhG+kLRKeB64/+
        a60rm/S1k4XXXjSBYI9CHTfPiw==
X-Google-Smtp-Source: AAOMgpe3iObA2xiKs0WEVW1U/wIwBUD3G44zZQL7yfgGIi7IoLzhfw5l2uBPcHDP13ktSP+ndntAng==
X-Received: by 2002:a65:5288:: with SMTP id y8-v6mr1176118pgp.284.1530849362942;
        Thu, 05 Jul 2018 20:56:02 -0700 (PDT)
Received: from localhost.localdomain ([64.64.108.33])
        by smtp.gmail.com with ESMTPSA id y14-v6sm12568403pgo.22.2018.07.05.20.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 20:56:02 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: k3dma: add optional property hisilicon,dma-min-chan
Date:   Fri,  6 Jul 2018 11:55:18 +0800
Message-Id: <20180706035521.13736-2-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Add optional property hisilicon,dma-min-chan for k3dma.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 4945aeac4dc4..f34202a80f3c 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -12,6 +12,11 @@ Required properties:
 		have specific request line
 - clocks: clock required
 
+Optional properties:
+- hisilicon,dma-min-chan: the minimum DMA channel number which is usable
+		Default value is 0, but in some platform it is
+		configured 1, like in hi3660 platform
+
 Example:
 
 Controller:
@@ -21,6 +26,7 @@ Controller:
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <27>;
+			hisilicon,dma-min-chan = <1>;
 			interrupts = <0 12 4>;
 			clocks = <&pclk>;
 		};
-- 
2.17.1

