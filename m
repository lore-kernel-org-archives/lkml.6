Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C358AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2A1204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxri8meb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2A1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeIGLEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:04:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54205 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeIGLEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:04:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id b19-v6so13540791wme.3;
        Thu, 06 Sep 2018 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=442uHEx2h0SkzNwr/c2bDFSZt2b3nXe/wow3C9PRspg=;
        b=qxri8mebiJCUIVqU6eQvVNBD+QtXILHFnszfQ737XEQV3SXUPUkE7dHZJ3oppVK4FX
         gaSb1fSGEH3Qp6lVhz+a6HTyKx8k7iUNsq6h0mGm4Mz9ZO4d/5JrykBc+0YxSKSQHIAv
         TJuz8dhWZQkJ7FC3dPnzvcjZPJxNeS+V3GTSMh/aWtHlS41fd9jgmF+z1e2k6JdpE5rv
         XoPeNk7W8ejqaxk9AzddQu+44DVF4dGeaJ7DkTn0O7k/5ginSjmJYz+0waHMprA/VLM7
         6ennR05bokRlnHb3YiU6uf9UWgjQswenGP0Ja65t6TgmWfmkAUziZiVd8PjfwlVgUl59
         OtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=442uHEx2h0SkzNwr/c2bDFSZt2b3nXe/wow3C9PRspg=;
        b=aiMapeeTHjSr8Lc5sL3yBwywN3cwofme9EDcDeXf6cKefbHGgJ38Hw1PIAwfDRQFOP
         yxcqOb7poKzz6aScs6bSz9gq9b/DccJKO1+JgzVAgolIJJViZajKCLy3JtTjyVQh5RAd
         yfJ4VLuPfD0HxFT052MuoWzQqISewe+raFxBUHrWY2LoER2k5ihEXvnCbmO34YggapwD
         dADsOCuzwvZn/z57Smdx8km0P1nkdVCk7GzgV8yNdxDNBRCVEVLzqweA1kTm6MBEYM2D
         e2x9TUA+Eyxi8y1r9HGByNWF1oxdfO5bZ8wxdJ/pvIFOsBE7jcB7K9ILTI1X5Yc8HdQM
         yDaA==
X-Gm-Message-State: APzg51BfUEuHO/4SP51kQLLC3USaB0xt+oK+ck1d3n8QDGWDyOlgryVq
        YC5I7PjpnUSyoOjtv9RUtrs=
X-Google-Smtp-Source: ANB0VdbejVTlKHykLHLRKRDbhBGCwq2R0bQSVdymfm9yAIY19MaHRCjB2G3XkriRgKv/mMR3OwATcA==
X-Received: by 2002:a1c:dc1:: with SMTP id 184-v6mr3910796wmn.145.1536301521586;
        Thu, 06 Sep 2018 23:25:21 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w10-v6sm8387233wrp.31.2018.09.06.23.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:25:20 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v5 3/7] dt-bindings: dmaengine: xilinx_dma: add optional xlnx,sg-length-width property
Date:   Fri,  7 Sep 2018 08:24:58 +0200
Message-Id: <20180907062502.8241-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907062502.8241-1-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of the "length register" cannot be autodetected, and it is now
specified with a DT property. Add documentation for it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
	- change property name
	- property is now optional
	- cc DT maintainer
Changes in v3:
	- reword
	- cc DT maintainerS and ML
Changes in v4:
	- specify the unit, the valid range and the default value
Changes in v5:
	- commit message trivial fix
	- fix spaces before tab
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfaec43c..5df4eac7300c 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -41,6 +41,10 @@ Optional properties:
 - xlnx,include-sg: Tells configured for Scatter-mode in
 	the hardware.
 Optional properties for AXI DMA:
+- xlnx,sg-length-width: Should be set to the width in bits of the length
+	register as configured in h/w. Takes values {8...26}. If the property
+	is missing or invalid then the default value 23 is used. This is the
+	maximum value that is supported by all IP versions.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
-- 
2.17.1

