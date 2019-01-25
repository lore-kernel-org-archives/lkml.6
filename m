Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B0FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9744A218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReOvbQCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfAYLZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:25:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36677 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfAYLZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:25:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so6282924wmc.1;
        Fri, 25 Jan 2019 03:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Z8HJRf7jFWL8ndlHDECsk1rDr2pU3ULSQ2VkFakbVM=;
        b=ReOvbQCoTIwL8WRPo12puX+FLVBg9muumJqmo4+OeXl0dFx9DKt/KoLL6v+zIBXfYo
         6Ix8ZPu6YwZYBx4gmQZ2Qk2MymHfjuh/IBl6gV2zDG9aofAV0AZqKLt4rxTrVetzodmt
         1xlSs5mvRtCjlz4Hoo5CFpwvdi+bpiiUXkXLg3bWtSG8z3zG+gIylRGguK65Y3tje1Uz
         BwHoD54qhM0wb5GPElmUf/uSSOvCZyp7bZirDxw8pTJlARCbjPW5NZiMZlomkhj3cOkE
         lSYyLO08slesdxcYuqFJRyKv1ILMMgnR3WYbHeHzbAA1VY+57xt8HcF1K7GcV5w/1n0f
         A3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Z8HJRf7jFWL8ndlHDECsk1rDr2pU3ULSQ2VkFakbVM=;
        b=mgqB3prKLx5/K3hboySQ314H26epxBOvN9XJ8j6+GwMIEAtsNzpfnhkHZzoDTRqBfO
         +hFmixPBxgKE1cN0sYPjN5BOuKERCOcwMzPeNZsQz+WF4Q2lKMsyo/N5NCA03jObOjd7
         TFABF6wAqaUkMOXmTgzulLStnCmc1qIQmqMsBiYug8DdcRbXRpzXRm2gwiVaetYullSA
         8ODDIn1x4H001o7x7q805Y8J2xQNNCmlZypLE8W7cFJEr2oKvj2IECI8RnwmR+tZ4SDk
         DwWlqyVUsk1iRPbhCZcCSsqwhiCwsh2rPTMyg8aTJv8YiLmyYKoTrt4OI944xIHnlBWj
         mn4g==
X-Gm-Message-State: AJcUukck0hLUDs4WV91Lov0dydd7j6uolOHQS+ETecX4ZGJtzd59jL/w
        Z2qV8a8mkRQlVT5JZRe1iMQ=
X-Google-Smtp-Source: ALg8bN4bYifcjefhPEJ33UuhPbDKkSL8TRnkCqJK/Hp10GVaNvIzzHYvK/iDXqw6jhU8XNRCwROvuw==
X-Received: by 2002:a1c:1688:: with SMTP id 130mr6261924wmw.86.1548415529596;
        Fri, 25 Jan 2019 03:25:29 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a187sm57523034wmf.33.2019.01.25.03.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:25:28 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] phy: tegra: xusb: Skip single function lane programming
Date:   Fri, 25 Jan 2019 12:25:22 +0100
Message-Id: <20190125112525.10697-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125112525.10697-1-thierry.reding@gmail.com>
References: <20190125112525.10697-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JC Kuo <jckuo@nvidia.com>

Tegra186 USB2 pads and USB3 pads do not have hardware mux for changing
the pad function. For such "lanes", we can skip the lane mux register
programming.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 5b3b8863363e..e3bc60cfe6a1 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014-2015, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -313,6 +313,10 @@ static void tegra_xusb_lane_program(struct tegra_xusb_lane *lane)
 	const struct tegra_xusb_lane_soc *soc = lane->soc;
 	u32 value;
 
+	/* skip single function lanes */
+	if (soc->num_funcs < 2)
+		return;
+
 	/* choose function */
 	value = padctl_readl(padctl, soc->offset);
 	value &= ~(soc->mask << soc->shift);
-- 
2.19.1

