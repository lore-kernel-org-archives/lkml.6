Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6562B21B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eqshanoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405756AbfBOKkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:40:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43657 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405686AbfBOKks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:40:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so9771385wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0yitGNScO3IMqqGpNFQGrqpaVO41izEagUP+rK/RW0=;
        b=EqshanojYFFhuFNfGt/bKnBYOSX0wxmtWHR7LzmBDusYiy5PxKR06tjoZwQiqiBcgS
         6/08mcP1PeD0G+Enem4/2+db3IbSkr3qhhUI6tFXFr0f2VmgIm85iy/lPuR9nTnMc4gm
         SWT72HgFf13ckiQzDsoUt19ePaAxmZhfm2DqQQUR32HvLp3KKncFZ1Z50fLuTtgOMpXv
         q2fvtDyXzjU/P5v2Wz7D7FtzRDG9ojs39knu2H8fCKRm3oqxB5/PG1txdoZVKr6QenWT
         GP8fGBSa+sa/JFHbXqUjRapNk3IQzm5XRXSAQBOgekojnX2omyOcBI+n5SlXEp6D2KKK
         Rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0yitGNScO3IMqqGpNFQGrqpaVO41izEagUP+rK/RW0=;
        b=rov3scas0cvy5GXZj0du4vNVK3qqw7KhB26GydfyC+P9L2h4+atANWjkKndWH50eAv
         UeAKYbp6Cy5p5FkmHavn2hie3VLRCJ5Vx8rTzh4Dg7oVRCO+H0xUkUvdnYRFWS8RvIqS
         B+fC6lgR++W8XNPYtbzLXcKuxdEqrUj/fMxhJiaLKxPt8wvD3pfTZS83QI8zWVQ/3OGu
         3ViTZsR4J+OlQSq/gp9RVaNqF17cRmIkPPIcLaxELiZe4sq8tKt3kE3NAC5vwZirskQ1
         LWT1awMTYrPzEF0lfkKDxTO+KzxXZoAvAMrnHg7AKRDpCuHpAypoKX1DmxY4zmt6pe4Q
         tHHw==
X-Gm-Message-State: AHQUAubJjqS+K2b1GVNdqAJLaqvFnoNJnzk63AfE3/I+Bs13ELVE6Fdw
        ca4oqonTX7DhEJR3ePDDtmyr1IhfJYg=
X-Google-Smtp-Source: AHgI3Ibg9/FzQ/Be2pKnyKJM6ECX2+c7L7HFt+Xl3wRhFfMcCX7/1ntPQJ7gj/qLZj3ydouQnbJpSw==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr6318933wrs.3.1550227246976;
        Fri, 15 Feb 2019 02:40:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v4sm6525577wme.6.2019.02.15.02.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 02:40:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] misc: fastrpc: select CONFIG_DMA_SHARED_BUFFER
Date:   Fri, 15 Feb 2019 10:40:06 +0000
Message-Id: <20190215104007.27103-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215104007.27103-1-srinivas.kandagatla@linaro.org>
References: <20190215104007.27103-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fastrpc is a dma buf exporter as well, so select the corresponding
DMA_SHARED_BUFFER config to fix below compilation errors on platforms
without this config.

ld: drivers/misc/fastrpc.o: in function 'fastrpc_free_map':
fastrpc.c:(.text+0xbe): undefined reference to 'dma_buf_unmap_attachment'
ld: fastrpc.c:(.text+0xcb): undefined reference to 'dma_buf_detach'
ld: fastrpc.c:(.text+0xd4): undefined reference to 'dma_buf_put'
ld: drivers/misc/fastrpc.o: in function 'fastrpc_map_create':
fastrpc.c:(.text+0xb2b): undefined reference to 'dma_buf_get'
ld: fastrpc.c:(.text+0xb47): undefined reference to 'dma_buf_attach'
ld: fastrpc.c:(.text+0xb61): undefined reference to 'dma_buf_map_attachment'
ld: fastrpc.c:(.text+0xc36): undefined reference to 'dma_buf_put'
ld: fastrpc.c:(.text+0xc48): undefined reference to 'dma_buf_detach'
ld: drivers/misc/fastrpc.o: in function 'fastrpc_device_ioctl':
fastrpc.c:(.text+0x1756): undefined reference to 'dma_buf_get'
ld: fastrpc.c:(.text+0x1776): undefined reference to 'dma_buf_put'
ld: fastrpc.c:(.text+0x1780): undefined reference to 'dma_buf_put'
ld: fastrpc.c:(.text+0x1abf): undefined reference to 'dma_buf_export'
ld: fastrpc.c:(.text+0x1ae7): undefined reference to 'dma_buf_fd'
ld: fastrpc.c:(.text+0x1cb5): undefined reference to 'dma_buf_put'
ld: fastrpc.c:(.text+0x1cca): undefined reference to 'dma_buf_put'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7e0726253755..53cd16f795d6 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -299,6 +299,7 @@ config QCOM_FASTRPC
 	tristate "Qualcomm FastRPC"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
+	select DMA_SHARED_BUFFER
 	help
 	  Provides a communication mechanism that allows for clients to
 	  make remote method invocations across processor boundary to
-- 
2.20.1

