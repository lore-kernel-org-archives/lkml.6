Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF4EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E596020866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKQNKE5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbfAOTOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:14:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34460 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbfAOTN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:13:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so1649166pga.1;
        Tue, 15 Jan 2019 11:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fCc5KaqTgZgfy4MB65aXpKGGmlxeuIhNipMfxjQqJdM=;
        b=VKQNKE5LGOOcdzObjQ6eXgUzuXo6ZpcUt7Ktoe7hRQN3GIiKfMpZOGvgIQBQAHdGOG
         oF2Z5XrjC/007Z1KKL51hvrpF+brnDhTKvqQ5p72vzDQUy71yUa3/LYiaGhlsKWICixG
         UOU5qyriAs7mHWy6MfDx/88IYwnhKYmrZSktKXTY6KgmBAy5akp/924o9SrgDi79YTmy
         psha0CWI2z5lGVUp8cUk7aU1K2lNjFqk/Xq3e8JxHktSLhikCiE48fXUkq1daCPwbpQD
         o1BKMEbsijIEScmCKacTeYQKPbruLkBcUr1wNEeCvxc+85wDIxhH6PLt1X+BWbn+t9PJ
         djVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fCc5KaqTgZgfy4MB65aXpKGGmlxeuIhNipMfxjQqJdM=;
        b=fgOcnczP0IHBXA31VFBpY8BELhRJrhr+zzi95Nch8Ycw6yRm3eetTzKF7GxFiw7ddj
         9RIEX1DSq+PfVemjbarq8H76yDS6ElhiztetY+ao/Ko4WNHyPx39AUOcIchB1LywnlPx
         vLJHxqaEQPTw758G+6WhjqmtwHo4u+YNNvQjTx4D98hM8PFiNvq93vu6NFPi0JXngILA
         pflEYdJHg4ElSiSTJMqNloKLfqyIBI4ZEBk7kDicq5MwHI4JTGDKNemwmsLxG0KRCgfe
         TZ8IGW6MvfULrtv9DhsTgGWo9k7GM2I4MKTq5SnUd/0NizJPxMQgcLS1Lpli0ImlQcCt
         D9AA==
X-Gm-Message-State: AJcUukcU0KYK+0t85MpFiEULdBPJSU7840jxhsszFyxxK4dDDKOtANc1
        /MJdJuhnJIV3jrOSYsJLFS8pHOp8yGQ=
X-Google-Smtp-Source: ALg8bN45eROKfbIYf8Y+kmouylQHHe0/YXWZ7dLIDs0Y1nENr/Air4OKrj49AkXM/giTY7JM7CH9wQ==
X-Received: by 2002:a63:d747:: with SMTP id w7mr5030732pgi.360.1547579638462;
        Tue, 15 Jan 2019 11:13:58 -0800 (PST)
Received: from localhost.localdomain ([216.13.234.27])
        by smtp.gmail.com with ESMTPSA id h64sm6130162pfc.142.2019.01.15.11.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 11:13:57 -0800 (PST)
From:   Alamy Liu <alamy.liu@gmail.com>
To:     Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: cqhci: data size depending on queue depth
Date:   Tue, 15 Jan 2019 11:13:50 -0800
Message-Id: <20190115191356.32714-1-alamy.liu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CQE_DCMD is not necessary to be enabled when CQE is enabled.
(Software could halt CQE to send command, or via DCMD)

In the case that CQE_DCMD is not enabled, it still needs to allocate
space for data transfer. For instance:
  CQE_DCMD is enabled:  32 slots space
  CQE_DCMD is disabled: 31 slots space (is good enough)

Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 4cc7863c13..974997b6cb 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -202,7 +202,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 	cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
 
 	cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
-		(cq_host->num_slots - 1);
+		cq_host->mmc->cqe_qdepth;
 
 	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
-- 
2.17.1

