Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6617F2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd9FH5Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6617F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbeKQAJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:09:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38333 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeKQAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:09:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id f2-v6so21123344wme.3;
        Fri, 16 Nov 2018 05:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8jGYlVSxPueClcYXJTbQ0gvKhk4i7gRBArO/gO+N3lc=;
        b=Yd9FH5GlOIaU37tAKUN9VLAuwMHMLyiIz2XEm0ZnViyXj7Hnd/OHuBB6opNpdASOU7
         6NvBz1DWQebBpGmDPTeJClfejyEhvSs3drkFTouv9UFKUfUN8dMxU18hS+I+FZrt+KiF
         6AdSYfen6yjykcevlgaUhmTbNT1HWiGTP28JloCiiq3wgglUyU+DuEXg/w9UHyvV1WW6
         GJB7LSOzPqCJ+8hqJDdtX5lmnoS9wtnAkJu1VJcUZkAxQIFXxYVYRS3gOojhJFRGzAQR
         qpLASDFu9M53AEz83Af1Xuc4ker5WbVjqhY6H7l6cZr0c9tZXDmvuGU4ErbfSYNHH139
         Ev0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8jGYlVSxPueClcYXJTbQ0gvKhk4i7gRBArO/gO+N3lc=;
        b=QyCN/0SkWPwazjqHYc1x0CMo1zjmBKUp2BLp89UJY0pXePpvfnk3vXAOvCrc1rH8pB
         RoZR62DKbf7z6Y8eAMnHSrRh7xCedmxKek5aig+7YulIdSOIb7sCT8vFhQZtZY0fA1o6
         mO9cmtreEvFvOD8agUhsIWAPLtYLfMG0xVYXmDs5NA1z/nzy4yfV0vN0pKzULP0mHzyY
         9+mk9PsIDLo0dMmECsuCaV6bGvRwCk+8Xe4IvY6WRezXzvTiQYW0RNDk1SLZL0gDiRQm
         +0XdBUPM6dMujaA2aLWzo3Zm6sp3RtQk7qe1PECHWudSgfurot5DQWa/yaoGCyC7yqgv
         JJlA==
X-Gm-Message-State: AGRZ1gKhTqU2LIHfZ6BrlsvAV97fAjE+0povKHafDpSDqhYH/U5q0wXC
        Lle5rKC/JjXRr8u1/5uZnOk=
X-Google-Smtp-Source: AJdET5cIbpJ0vIyWl9KqGJ7WHxruZwdPiuPcSd913nmJIx3GXaJuIpttdfm3tBfqKwqsmpC8hZaKkA==
X-Received: by 2002:a1c:9c4:: with SMTP id 187-v6mr8868564wmj.119.1542376615404;
        Fri, 16 Nov 2018 05:56:55 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id j40-v6sm22673692wre.48.2018.11.16.05.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 05:56:54 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH] dmaengine: fix dmaengine_desc_callback_valid() doesn't check for callback_result
Date:   Fri, 16 Nov 2018 14:56:28 +0100
Message-Id: <20181116135628.19388-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two flavors of DMA completion callbacks: callback() and
callback_result(); the latter takes an additional parameter that carries
result information.

Most dmaengine helper functions that work with callbacks take care of both
flavors i.e. dmaengine_desc_get_callback_invoke() first checks for
callback_result() to be not NULL, and eventually it calls this one;
otherwise it goes on checking for callback().

It seems however that dmaengine_desc_callback_valid() does not care about
callback_result(), and it returns false in case callback() is NULL but
callback_result() is not; unless there is a (hidden to me) reason for doing
so then I'd say this is wrong.

I've hit this by using a DMA controller driver (xilinx_dma) that doesn't
trigger any callback invocation unless dmaengine_desc_callback_valid()
returns true, while I had only callback_result() implemented in my client
driver (which AFAICT is always fine since dmaengine documentation says that
callback() will be deprecated).

This patch fixes this by making dmaengine_desc_callback_valid() to return
true in the said scenario.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 501c0b063f85..0ba2c1f3c55d 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -168,7 +168,7 @@ dmaengine_desc_get_callback_invoke(struct dma_async_tx_descriptor *tx,
 static inline bool
 dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 {
-	return (cb->callback) ? true : false;
+	return (cb->callback || cb->callback_result);
 }
 
 #endif
-- 
2.17.1

