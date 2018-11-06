Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DDEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9432083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLTJjwlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9432083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeKFOZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35712 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbeKFOZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so3223578pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ESGwK71J9MVIx0LSTHlmPcydTEacdFoGT0gjQtbEMzs=;
        b=dLTJjwlOqus4VJ2X2QZZEpyQjNlSulx0Gim1Vh811QxB/LzDqpG0UGiybmROP/KVdw
         8X1yq/fkyF0Z53QDOdJH29pW3/vgj2YiBaUzHQEAWX9/puxZIYliQk5AdnsdHYZ1ITfM
         3vDygDEQvRkyzkYmHAtH8Jw7mL70zqXv6oXRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ESGwK71J9MVIx0LSTHlmPcydTEacdFoGT0gjQtbEMzs=;
        b=HwIPow29WS+6UbU/ZpwkHz9a8g1PHAnrZI1dcTUzSmM7oGtFpI4GJp3F+odffOUSXk
         qLgNZt1lfe5uecVOLpVqVhW7u/D0NkYc3J68RDxdfLJxVe/cskKgVuZgGozckP7eAmEZ
         DXK7YLwMLjedA3vTjbhXcq2WLkxIOQ8neiAISYZJFplYCHCLt61Ezxo2ZBfONNHnMtEW
         jM/ztr7hy6XczhrdEWJZA3NrTOgvMvx0WvcSDSTa+q29HoJQxzdwLQmIefrmAHlgVRSr
         L2J2DvBMVd4DGVxxb567151nQ1QQYYgR0twOEIAkY61Yy4SsKGssHhFZHT7hkKGvh/Ar
         4/9w==
X-Gm-Message-State: AGRZ1gJOBAHAjhXE/jgMDFBTEOLW7GmkqviHliTC/WL6/YPE4St/6P9B
        7T5GX+VK+W1giqR5dDFjpmEvIQ==
X-Google-Smtp-Source: AJdET5eAfeXAc/DKkmUEwjEG2anuujwBBE03az/EulmT6pJnGWTbLeGY/PoVzcRlDXPFCl/mqp5o8Q==
X-Received: by 2002:a62:302:: with SMTP id 2-v6mr9584532pfd.135.1541480523186;
        Mon, 05 Nov 2018 21:02:03 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.01.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:02:02 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/7] dmaengine: sprd: Remove direction usage from struct dma_slave_config
Date:   Tue,  6 Nov 2018 13:01:31 +0800
Message-Id: <0eb7556e7d0a29c7d88e8b67b6228d1ffb332ea9.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The direction field of struct dma_slave_config was marked deprecated,
thus remove the usage.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 38d4e4f..c226dc93 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -847,9 +847,6 @@ static int sprd_dma_slave_config(struct dma_chan *chan,
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct dma_slave_config *slave_cfg = &schan->slave_cfg;
 
-	if (!is_slave_direction(config->direction))
-		return -EINVAL;
-
 	memcpy(slave_cfg, config, sizeof(*config));
 	return 0;
 }
-- 
1.7.9.5

