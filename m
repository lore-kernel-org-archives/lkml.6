Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF7FECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74562087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYyUa/Rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74562087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbeGLVl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:41:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44186 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeGLVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:41:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so23091503wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w8B3GajgXdJld37+2bzGlYrW3yzpF7LkrvByTGWqmYA=;
        b=pYyUa/RxlxJhEp1XV9zLMz0GpeEAUa4R4JEPd5eLFERvBPxfSodY1YiMmNeWPwVTJh
         ywvroueDYApXUNbZG1OH/E/qctnFT8MQsbh4BaMOAFUI3GaK5INTftGK2/quxLp5P2u9
         MLDXBwmxOxOmh/b9jdwfFszSzaeeC3jw//WynexqCVLekJmMNCjzi8tRSuYV1EvTtWUe
         m8PTGxkTr64+L1kS9kcHmd1uARYPoEJuYZXFDZfPQByma20UWVNLuAHtqo9dlWdvBkrb
         bfA6kdrGca6kHlpcm8i8hCNJtvcSnKX0X1iJnhSDHoH9un1d9IT52retuV8g9fPg5r0a
         d+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w8B3GajgXdJld37+2bzGlYrW3yzpF7LkrvByTGWqmYA=;
        b=TNViuPCz/1qhesMfKYsQGQ4y/fn2bLcp4twWrxXZXI7jMcBcbhROepWZbVyetnO0O1
         BKa2yQh7R9GlIsBvdb1BkTN9Q2bPRygHvhy8Uv84ghM8S83BB6MRpDnCajHDv2FlDDVH
         XRRVAqqGE+2jBAGVnpSm7uNxk43JfNr/xQnA0DZD8FzrdvHRLVPeaphGWNo6RfVO/k+8
         gtKQS2RnszdE+tihsFkfjfJG8lYUweodblvEHva9dDoW/Ue7JjQhreiINMhp/UbiduoS
         u/YAD0244VuxguM78cSKSX1Kll2KmzvXzWzHgZ5zb0lpCVpga7M+eQMrc0vQtxYoxLQp
         DMJw==
X-Gm-Message-State: AOUpUlEroMa4EK7a0KNHeXoxhFx6F+zZq5C6O5tUgYeyN+UhhvwS4eOq
        Zt8u2UD+XUqay5GkAq0Yvqw=
X-Google-Smtp-Source: AAOMgpeQHtDjsSJaO9oOP2c+8+q6rAIB9J8iHnbUjmcjYvJIPMKCqqxLCSuu5OEUPktxOtVZ75rF8w==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr3092930wrq.61.1531431001017;
        Thu, 12 Jul 2018 14:30:01 -0700 (PDT)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id f190-v6sm10789365wmd.0.2018.07.12.14.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 14:30:00 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/2] parport: sunbpp: fix error return code
Date:   Thu, 12 Jul 2018 22:29:55 +0100
Message-Id: <20180712212956.16661-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Return an error code on failure.  Change leading spaces to tab on the
first if.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_sunbpp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 01cf1c1a841a..8de329546b82 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -286,12 +286,16 @@ static int bpp_probe(struct platform_device *op)
 
 	ops = kmemdup(&parport_sunbpp_ops, sizeof(struct parport_operations),
 		      GFP_KERNEL);
-        if (!ops)
+	if (!ops) {
+		err = -ENOMEM;
 		goto out_unmap;
+	}
 
 	dprintk(("register_port\n"));
-	if (!(p = parport_register_port((unsigned long)base, irq, dma, ops)))
+	if (!(p = parport_register_port((unsigned long)base, irq, dma, ops))) {
+		err = -ENOMEM;
 		goto out_free_ops;
+	}
 
 	p->size = size;
 	p->dev = &op->dev;
-- 
2.11.0

