Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC309208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+fI4iFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC309208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbeFTIjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:39:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35034 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbeFTIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so5274800wme.0;
        Wed, 20 Jun 2018 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=neKcrpd5xoAsfDlVepoHgAs/9Huktyiu6Hy4eoW+7nE=;
        b=c+fI4iFYvJJiwKymhBO4ewn0cjLIcRzzXGDCJ4dcZlT4Vcq2w7vv2pEHndYjYziyRd
         fKCdVAy3hLGTGaY5S0Yqqtsw5y0QuaxjAFW41tlslflEnoqF6LvMXpSmvIbJks39/6Fp
         tQ/B81aFHJRwyho8fT3h374IK/JAQ4G3Ub4nIIOB6eP2QNzMeQ/QfOoy311tJUpi6aKW
         xikiIMpXDzs193aIgTDo4cf1LslwXrtRTi8/c+5bQgLU9K83qFgBg4uBx965pS1L4mEE
         jV9BVSem1YkGfOmhmbfbXthnzKtxTDfb7WtZbZ3pjC9QMLfXxvTjXDeWAHfj1CMhYK3R
         rgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=neKcrpd5xoAsfDlVepoHgAs/9Huktyiu6Hy4eoW+7nE=;
        b=KFXOIeZNFjb05EKwNWe5IA7THRt1p7wJ2nv3tKwvoTpAPFYtcBIauTLLq0/Gb9HgtH
         lZrea+PgtbZ69nBvngQg5HoUtpq57y4OVGOP3vUoUalBaB9/p0FhnR6f31TQL8JFiYcQ
         996xqzEl93XzE1DoiNZyYjkzLvSkCc3zq1p/0bs5fAtYZkiwhdr4PM1WWWWUgUdVeK5D
         0DoJbHHsgYoeOWnM7HZ7zKxE/pxn8DTcALqUqZR+hjyDUc324LtgYD1pIInU1WExGjqp
         mxAzsXyLM+XdarGJHDTzrSN/ZyoQf7etxw99EF1zh5s/Bkd59dAytSi4t+tcww/o3HAv
         hnDA==
X-Gm-Message-State: APt69E0tai5kof+KWOTzz3Sh5XPgNsIbB18IqU+otjKBoLm7C1neRVpF
        kGPQJfyDmEWuvG9882wiYcM=
X-Google-Smtp-Source: ADUXVKKp/6ZYXMWAjZp3C+ig3WtoHuPB7K59YagPUTk/6rl3EBBMNR5JLyhKOfG1HcQtBWB8CTMDow==
X-Received: by 2002:a1c:4203:: with SMTP id p3-v6mr994679wma.111.1529483835820;
        Wed, 20 Jun 2018 01:37:15 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id f24-v6sm1615933wmc.0.2018.06.20.01.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:37:15 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 6/6] dt-bindings: xilinx_dma: drop has-sg property
Date:   Wed, 20 Jun 2018 10:36:53 +0200
Message-Id: <20180620083653.17010-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is not needed anymore, because the driver now autodetects it.
Delete references in documentation.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index acecdc5d8d47..53341314eeb8 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -39,9 +39,6 @@ Required properties for VDMA:
 Required properties for AXI DMA:
 - xlnx,lengthregwidth: Should be the width of the length register as configured in h/w.
 
-Optional properties:
-- xlnx,include-sg: Tells configured for Scatter-mode in
-	the hardware.
 Optional properties for AXI DMA:
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
 Optional properties for VDMA:
-- 
2.17.1

