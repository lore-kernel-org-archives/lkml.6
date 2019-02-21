Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA45FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA43E2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhQoTYTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfBUFfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:35:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44621 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:35:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id c4so8534493pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T4yr4bk1rvyrNRXUVeZwF9n7nFBtXZOYoRS0bwjzaMY=;
        b=WhQoTYTo2kw7AXaa0/gWlonxJvoRifCpRYttsri9VopJY/b1WNv/sUaBCghPtgXFV8
         +rv594Zknr3rXbC7zWqUsLztidK4rRGR8s+FP19bBKZOwUrrL9RjIiVy3YqYVVNN+rXx
         S+dj3LAGpbKqUZ9y+XQx6HCLs71DajxlqqmJ4CoTz6yl7DE4Owoqt+LcfKtv9fPKxKTt
         3gYFZydSZKeyG3R1UedXEQWvqnXOf2pLj5z/vXdXgdzozIsbw6S3QEyyrNQz/SQr2Vx0
         LUmvMQKqyNX9roygA+RQUeGiT8JmFCv4o/NLgkwb4cV5N4842tqkXo1RBjHLFCzv5DGr
         ArfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T4yr4bk1rvyrNRXUVeZwF9n7nFBtXZOYoRS0bwjzaMY=;
        b=iYDWVKvZfj/I3kJBk9ugoTi+EXG2WN/UENDWBrQk7jImu70gDK4rlwybEqSjvWxiK/
         wIJE2b7nO20KmnsTDx2ePRKjJdNeZNBfbssHj4GtYvfFGI3Is7Mi8s+k936wxFjtIyXn
         bvzt9HJDKzOkkIra3Hn+7DndhX/1No43BhA2XhDCG+tUuiUfxJw5rFfpHNxVqMj91n0k
         gNHJ/g2dj6XsILnbtsiJZFVqgH0PpiHc/t7F8rPFvfDyjK2mHBDoWYajogWwHdaK+9Rq
         //aF/VUjAqwyYOWR3vy5OCxLGUvruh/IvlZXGRt/PObcgOrOPMx5XHuqJz11Jg9iZYSQ
         XTCQ==
X-Gm-Message-State: AHQUAuZg1rvoDhowiY1KMcL173woBUcuVoRqNvgG0cByeqKjOyMC9lYu
        rgq5tSC53jlqzoJZIdghU/r4Cw==
X-Google-Smtp-Source: AHgI3IbBQFlcuxD5vuIr+qI4QoDjWHaDUlMQHvVrZ+Ydx/YsCDVQztiXzqyXskLK3Hn2fbcfssWHvQ==
X-Received: by 2002:a17:902:b70b:: with SMTP id d11mr23557013pls.178.1550727309029;
        Wed, 20 Feb 2019 21:35:09 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l10sm35001421pfc.90.2019.02.20.21.35.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 21:35:07 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        arnd@arndb.de
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        eric.long@unisoc.com, broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 1/2] dt-bindings: dmaengine: sprd: Change channel id to slave id for DMA cell specifier
Date:   Thu, 21 Feb 2019 13:34:40 +0800
Message-Id: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Spreadtrum DMA engine, all channels are equal, which means slave can
request any channels with setting a unique slave id to trigger this channel.

Thus we can remove the channel id from device tree to assign the channel
dynamically, moreover we should add the slave id in device tree.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Remove channel id from DT.
---
 Documentation/devicetree/bindings/dma/sprd-dma.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
index 7a10fea..adccea994 100644
--- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
@@ -31,7 +31,7 @@ DMA clients connected to the Spreadtrum DMA controller must use the format
 described in the dma.txt file, using a two-cell specifier for each channel.
 The two cells in order are:
 1. A phandle pointing to the DMA controller.
-2. The channel id.
+2. The slave id.
 
 spi0: spi@70a00000{
 	...
-- 
1.7.9.5

