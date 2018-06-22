Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D579CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928BF23C88
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg8toVuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928BF23C88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeFVDYk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:24:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33575 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934322AbeFVDYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:24:36 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so2752716plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4r/kp75gRHhgePw3hxi6Cv5BAONK/+C7nyCuBwUB6eM=;
        b=Hg8toVuAgiLhpCj7N5UbfwHLVP1as3HFPNLOEjFfTg7m3+0sYQKa/t1rtsiioIvlR8
         qZjHvjDjvkfKytnXhNTS1snywbeNX9tNPEYZZqUrUIMv5bPnLK7/DpKxJIoYjNt/OePm
         q5t2+wypPZVfU3iM9Iwar1ll0bSrh6dxqdSS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4r/kp75gRHhgePw3hxi6Cv5BAONK/+C7nyCuBwUB6eM=;
        b=SwOOk1BHYnghy9flatzEEpLAQRzzELAVnqsVhOYAoEGOvtqmxV2e0PltINyzpmJfCE
         ilBBNT2q+tNuiiqDjkZpITVk4HWKMaYEv2JeeY9rRj9ORH3DrYZ1x+Bvy2c/C/eJ90CB
         8jGMobs3foOXna3e2qzf86W1lOcmNXw8bGMIg0fwY0znMsbSnB9pYWjWK/2Delo6ZQAN
         r31sjtkFAGZNOYCD+UdX4+vVEsx/C0z0U57XYJ2GhP52qpYLmqb8IBiNGFtJGl3weO7p
         31MLyLu0jErKjgg5ZoKq5yXMJIjJIRBgWtY8zTyPk2dNInMTFa5J6klk+kdb+nGLBSin
         Icjw==
X-Gm-Message-State: APt69E2FNxbtkWd2OgxyEGhhA/byVv6xC9OEzdezL2upF6TdJvVuRzyj
        qPtx/X/jTA3K4lBBdqbKQNl52A==
X-Google-Smtp-Source: ADUXVKKK/4Jo7OBeBvgEGGQr4oPgkZz94InkzyXsYPOjUBJcDfHm3f5fM5J+Z2lOfv68MagSHKmIMQ==
X-Received: by 2002:a17:902:585c:: with SMTP id f28-v6mr31416258plj.206.1529637875741;
        Thu, 21 Jun 2018 20:24:35 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.153])
        by smtp.gmail.com with ESMTPSA id a23-v6sm9286253pfn.113.2018.06.21.20.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 20:24:35 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: k3dma: add optional property dma_min_chan
Date:   Fri, 22 Jun 2018 11:24:14 +0800
Message-Id: <20180622032416.20133-2-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622032416.20133-1-guodong.xu@linaro.org>
References: <20180622032416.20133-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Add optional property dma_min_chan for k3dma.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 4945aeac4dc4..2fa1370c3173 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -12,6 +12,11 @@ Required properties:
 		have specific request line
 - clocks: clock required
 
+Optional properties:
+- dma_min_chan: the minimum number of DMA channel which begin to use
+		the default value is 0, but in some platform is
+		configured 1, like hi3660 platform
+
 Example:
 
 Controller:
@@ -21,6 +26,7 @@ Controller:
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <27>;
+			dma_min_chan = <1>;
 			interrupts = <0 12 4>;
 			clocks = <&pclk>;
 		};
-- 
2.17.1

