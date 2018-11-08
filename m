Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0265C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A71B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Ip1QaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A71B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeKJIUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:20:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41896 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeKJIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:20:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so4481364qkj.8;
        Fri, 09 Nov 2018 14:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=92sy1wvUEweAUZ24jWNT8JbVsCOE3J1N5JC6rdWHrOw=;
        b=M2Ip1QaJ3L23uj84d6bI51oekLehZ7XEoO6KJQxhtTe0/Fm2Em/6xRWuWz3s0863j5
         UpMdNK3m+igTyx5TOqmF7J7IGjT2y/C6vvIU7QlmmsqxpSnc2+P2s5ptsOOnnXQ49l8s
         etNXsSrJ0dgK9roD4pau9FYFK9YVcU3F1nkfe1/4DTZczVvnLEGZdNTPBkNlL2wopiFg
         zn4IxV9VhdszTG9JhIT3AAcgcA3qDQ/lI3dW4M3bXVJ3dZx5XDOoMuBHABCPU+NB76YL
         QkhlcdXMP3DHkcOTE8XfzlXxfEOX/QqanuiruzzF8BaMDDBylvUZYGO74vEA2mKYHkkk
         plJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=92sy1wvUEweAUZ24jWNT8JbVsCOE3J1N5JC6rdWHrOw=;
        b=DQ2fUcCy57mVuW5fReWXXbRXajCqlw1bG8v5WToyGCKojR9G2xpHIyiTeAIrccBc2V
         0pFYQHSS9guPJeuX8iesiUxaYv9+L6gzG7sSfutL7tog5fc8t8zNDRv8jRgjtUB2qqAA
         zaCoTz7xDq643ksQMpoVwO9SPKAykmtfL/wFHyZMVPgsoRM8fJGOTGKq3iiTQKREXSlI
         LgvAyaVtkVwcNrUF3yuo5nQfmNfZCzwY/y/C9TAD4Xh1AFEAAsJURE3ZTAN23oTKuK+v
         Oyw+yHG19pBGaL3Uff5QcS+7U9UxIxaICrWtmcXG7C8lTQrjtCekav9scIeFjnclZj1X
         nCwg==
X-Gm-Message-State: AGRZ1gJ2K6V2iinyQsvwjnv5Yb26RdXFKq7WPimhFOon1Kh0WXO1S9IP
        /8s+h5MHI01sVZ4kRZsbXok=
X-Google-Smtp-Source: AJdET5e8THwiUv168JuKbVT0qgv2qul82qjQS7+A5euDPfs+ldsKuQdm15JwZbBUcOX2bIwE4xScLw==
X-Received: by 2002:ac8:32b2:: with SMTP id z47mr10345460qta.209.1541803092617;
        Fri, 09 Nov 2018 14:38:12 -0800 (PST)
Received: from ubuntu.localdomain ([177.194.48.25])
        by smtp.gmail.com with ESMTPSA id b8sm6065968qka.79.2018.11.09.14.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:38:12 -0800 (PST)
From:   capetry.dev@gmail.com
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fpga: altera-cvp: Insert SPDX-License-Identifier
Date:   Wed,  7 Nov 2018 23:13:11 -0200
Message-Id: <20181108011312.29587-2-capetry.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181108011312.29587-1-capetry.dev@gmail.com>
References: <20181108011312.29587-1-capetry.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos A Petry <capetry.dev@gmail.com>

Fix the following checkpatch warning:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Signed-off-by: Carlos A Petry <capetry.dev@gmail.com>

---
 drivers/fpga/altera-cvp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 610a1558e..45b7c8c0b 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FPGA Manager Driver for Altera Arria/Cyclone/Stratix CvP
  *
-- 
2.17.1

