Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEEAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE78B213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfb7DIgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE78B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeHQQEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:04:22 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40117 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeHQQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:04:22 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so3703762plp.7;
        Fri, 17 Aug 2018 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VNCkgJ9itB8TQC6SbBaxgHvFVYuf+um7lOzVMExziKM=;
        b=Lfb7DIgR3E1Lp1wolMAQZAJBlX2dO3ciWUEnl1yt6yenZPnlu9MWpXXBRD02+jqhja
         s/1unrumVzSo1qTAOKQDlv33ncRyNvNKPwtIX6fgmlREvE6JM5ZALv3i4pRFlTg7bGbj
         6Wtql/Ad/Sm04p9eWQItTkGxgQwmlNuBq32Qd7cA1f7e30x2Xiv91Bn2AeY2578UPzkE
         qaCUAa2/34w2ZiuX6wl//ozOTsZaVXFmS6/9lb6WIKZRmqqscIu/3Mb3fQbgbk8cC2yi
         KCnPCR/4U1ErEcR+aA8jYPjpEJX6lMTF8+d753brZlpY71xSQL9XPIeV/5rlQdHlKijH
         e7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VNCkgJ9itB8TQC6SbBaxgHvFVYuf+um7lOzVMExziKM=;
        b=nIJ7djiIHlA133aYyzGgPuU/iM2i9GZa+dWTab8fEW1wSM5pki1GCT5R4jMyHIH85q
         q6ajhGhZMfS6TPc2PNNrNHajtadO0+G/baGmlvIsRWcVi8j3DvhqG+5qM6qzXKpVEhQ0
         Kq5IJ7aTtgcFPVzNxG6MF5mGZEPNTiOi5vy7Cf+BX3lOaZXmuq9Rf2w9N9uUDIUC1r4m
         s65zi3N1JOGUoMLVfb075gbEbWYuR9GOpdt52Lg7M6VVMuX0/alY3IiwFPErkWPRczrh
         VDkqK+xIMbf2hXOcg+ZFNwjk2aDIjrTK5PGJSMdlPu77gaxALjewW6txQhnXwMrxx6eM
         QQBg==
X-Gm-Message-State: AOUpUlHL3XhMjKgHtvgH10kucKqBwckrgHWbf7a+7BxX8iaE+ya0ybTP
        7Ev8CFE8/jlkpm1LevFzjWI=
X-Google-Smtp-Source: AA+uWPyBcjybpU3eEeKhLvTV77TWiUiEfWAltWVMhp8BXtz/Rdc+k89+hZT1/h+6RwdcOULgRR5LZQ==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33-v6mr33487121pld.134.1534510862087;
        Fri, 17 Aug 2018 06:01:02 -0700 (PDT)
Received: from localhost.localdomain ([47.88.150.209])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2398301pfh.63.2018.08.17.06.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 06:01:00 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     leoyang.li@nxp.com, zw@zh-kernel.org, dan.j.williams@intel.com,
        vkoul@kernel.org, linuxppc-dev@lists.ozlabs.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/3] dmaengine: fsldma: move spin_lock_bh to spin_lock in tasklet
Date:   Fri, 17 Aug 2018 06:00:26 -0700
Message-Id: <1534510826-7603-1-git-send-email-21cnbao@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/dma/fsldma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1117b51..9d360a3 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -987,7 +987,7 @@ static void dma_do_tasklet(unsigned long data)
 
 	chan_dbg(chan, "tasklet entry\n");
 
-	spin_lock_bh(&chan->desc_lock);
+	spin_lock(&chan->desc_lock);
 
 	/* the hardware is now idle and ready for more */
 	chan->idle = true;
@@ -995,7 +995,7 @@ static void dma_do_tasklet(unsigned long data)
 	/* Run all cleanup for descriptors which have been completed */
 	fsldma_cleanup_descriptors(chan);
 
-	spin_unlock_bh(&chan->desc_lock);
+	spin_unlock(&chan->desc_lock);
 
 	chan_dbg(chan, "tasklet exit\n");
 }
-- 
2.7.4

