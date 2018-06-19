Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAFE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="lfGy6vKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAFE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756672AbeFSJHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:07:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39832 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756608AbeFSJHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:07:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so20541627wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=eSzDELogY49TVYILZ3s9BjeiVGknbjjA5dmkQ4yjYpg=;
        b=lfGy6vKSJwNdi+2zpVZ1Afv68yF3xIK+PRjf3ZS5ggv4Xg0I7am3QfDY5CDkgEtAvw
         eszDY6EBQOtosli6cUeN5koRIhNNIE0ZaSJFVLFSLKGQOpKym04ESHP09w9XZ36Fu5KW
         Y90KXoNM+ZkbgJKGN6TQ0OvjuRyQd7y2zsVkQNwpwJukh69/wSwBOQeYWqn5c673dkwd
         52egkOlvosEZQRB69CAwB8g7q7O+n3CG3m07iHamKQts+/M9GDdsEChoJ8I9lhBvT/Ef
         T1RUjd/QngGyNjPPogq/UiyRbXThLyrzMRPvrp+KirKyEf+PQwYhjDJ5/hLIM/xVZX8c
         q6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eSzDELogY49TVYILZ3s9BjeiVGknbjjA5dmkQ4yjYpg=;
        b=aWBGesh7xIpjP9qGEoy7b4XoU4Jg2vrQJcbbm2EImFJS3E8UEScuk0wM98siWTnJMP
         n1lT4veOFni7h8NoC3W/IxaV12fsSBOAZnHQZeTGYizWZ5zszULeaQpIpTU12Y7lRWIx
         CBdjPwrSpHXtpmr6wtlIWV8wHe2MHanR/6Bia4d+d5efLDdbdVb4RFWRuWMRgNpVUWqy
         ywKblCAoj/fg+2AL0vQVy4KeU7fDE/5XdA3Mz7mjHR9gbI35NVjg9LjE+PZl5xaEhgIC
         kOLmqTT3NRaVM2hPWCOFvUx+RU89S4MoXXsx1U6o+A2RIn/Tn/S7mLbCJ1LXyQFHUdfe
         LB8g==
X-Gm-Message-State: APt69E1N5eAvDtMnm+Hei4NILuGZtvH5qRZVa7BWnCt88HNd3WU8NYQU
        XfFImrKrjrEzjfYbwMLBZ+mgqw==
X-Google-Smtp-Source: ADUXVKIoWWpsGNKCQQ5GWzDOVWx0ayccMzI4w3lq/Ra+9+UYLQ25VTvNh2IG23Sv2QMmgS6qZXnUbQ==
X-Received: by 2002:a50:abe5:: with SMTP id u92-v6mr14208861edc.43.1529399257622;
        Tue, 19 Jun 2018 02:07:37 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f25-v6sm7902102edd.87.2018.06.19.02.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 02:07:37 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2 devices
Date:   Tue, 19 Jun 2018 11:06:29 +0200
Message-Id: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

We can't know if a block is closed or not on 1.2 devices, so assume
closed state to make sure that blocks are erased before writing.

Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

This patch applies on:
ssh://github.com/OpenChannelSSD/linux branch for-4.19/core

 drivers/lightnvm/pblk-init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index aa24264..3b8aa4a 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
 
 		/*
 		 * In 1.2 spec. chunk state is not persisted by the device. Thus
-		 * some of the values are reset each time pblk is instantiated.
+		 * some of the values are reset each time pblk is instantiated,
+		 * so we have to assume that the block is closed.
 		 */
 		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
-			chunk->state =  NVM_CHK_ST_FREE;
+			chunk->state =  NVM_CHK_ST_CLOSED;
 		else
 			chunk->state = NVM_CHK_ST_OFFLINE;
 
-- 
2.7.4

