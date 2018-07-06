Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98071C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517E124001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xm1jncoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517E124001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933413AbeGFNCa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:02:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33426 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeGFNC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:02:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id k7-v6so4126717wrq.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SuY4oqOr4l1XJc3N4NfyN3WyVnP/hZUVrmexOuLxNfE=;
        b=Xm1jncoTDUofdVpGHFdloNHyHPuxhVV8ufcLcpeRTH3p4ZQ7uwGIyI1HsoF5BzoUQv
         klV7KeLhT0E7/UCuFgVjyqZPVpd2q3xV4L3aIAf6MO3/1Pv5CpDv9UVgBX71XK9MvfGZ
         7ELQoNs+wRo8kkp2ZzrBZicDjkQ4RmHilTp1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SuY4oqOr4l1XJc3N4NfyN3WyVnP/hZUVrmexOuLxNfE=;
        b=gRbHMcTKzxwn03c/1sRs11+lyZ+AWw9BBTEL6ecfvKMjc2h79sC/qMEEhgWw3gsCtc
         KZaLiGCeuF2fozG4zn50bhIg0xa8rXqzx+SuJYTdNYCvopr5VKI4qaTSFU28hVdq1Zml
         cyaXUSr6nUm1kgYr0n/p+hWjSNLHug3ZXSa//FjbUt8lzgNO+GgCZciONsna2cvOuS0X
         fwSYeMlC3rc58CCxNEw3fH+24DQAPGe+eRooSDYWudPILeKxe/TD2svLgOR+bdVtthyp
         In45oTag8nBFLsKq7TYGtUYy1lzPt6N1gAlxWdd6tfdc2bJvIAVqw8Z0OmwxtRTc9hE7
         Fy9g==
X-Gm-Message-State: APt69E0IJCeJalMkZLRCwuyW2CT1oFCqpniygIhaqEt4mj4CvRSg5Cc+
        I+BLMjI7p9cnR4Wpp1qYe0Ke5g==
X-Google-Smtp-Source: AAOMgpcTPEMoa2o5IRk5L5+IKLxgfl9NdNPABdNasMx6i4V52WxPWUpA+bpo7v8xaZb7ul0BRClKeQ==
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr8006515wro.160.1530882147061;
        Fri, 06 Jul 2018 06:02:27 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.214.65.221])
        by smtp.gmail.com with ESMTPSA id b16-v6sm9764123wrm.15.2018.07.06.06.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 06:02:26 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] dma: stm32: replace "%p" with "%pK"
Date:   Fri,  6 Jul 2018 15:02:20 +0200
Message-Id: <20180706130220.21957-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/dma/stm32-dma.c  | 4 ++--
 drivers/dma/stm32-mdma.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 8c5807362a25..379e8d534e61 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -594,7 +594,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 
 	chan->busy = true;
 
-	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
 }
 
 static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
@@ -693,7 +693,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
-		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
+		dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
 		stm32_dma_start_transfer(chan);
 
 	}
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 9dc450b7ace6..06dd1725375e 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1170,7 +1170,7 @@ static void stm32_mdma_start_transfer(struct stm32_mdma_chan *chan)
 
 	chan->busy = true;
 
-	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
 }
 
 static void stm32_mdma_issue_pending(struct dma_chan *c)
@@ -1183,7 +1183,7 @@ static void stm32_mdma_issue_pending(struct dma_chan *c)
 	if (!vchan_issue_pending(&chan->vchan))
 		goto end;
 
-	dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
 
 	if (!chan->desc && !chan->busy)
 		stm32_mdma_start_transfer(chan);
@@ -1203,7 +1203,7 @@ static int stm32_mdma_pause(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
 	if (!ret)
-		dev_dbg(chan2dev(chan), "vchan %p: pause\n", &chan->vchan);
+		dev_dbg(chan2dev(chan), "vchan %pK: pause\n", &chan->vchan);
 
 	return ret;
 }
@@ -1240,7 +1240,7 @@ static int stm32_mdma_resume(struct dma_chan *c)
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
-	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &chan->vchan);
+	dev_dbg(chan2dev(chan), "vchan %pK: resume\n", &chan->vchan);
 
 	return 0;
 }
-- 
2.15.0

