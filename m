Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CB1C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE4F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="iOk4yw4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE4F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeLKTS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:18:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37748 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeLKTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so14039051lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHnAI6INNpfEyeoVrs4hGgZP5NaC4/R4lNfx3MHbEtg=;
        b=iOk4yw4GWJBIdDmIg6btixhc/royuqRtuMz1DggZ82XcXGZV+Xj+oWkCnURBzyKqOO
         tjTRNdNWF8THoDdALsqaEEfkU/fhv0xVpUT6XUvOzAqhVJkTl4u5f45iaN/ZNcMSvL7l
         vLpZ89PwNpzE9KAiNJtUNCLMV/xGyv8r0XkqnWxxEYL7nXf5GMWzmnoYcY2U9HbcsUb+
         F3vmxLcYr37ddYtmGzuk42pc9CZP/o4rEg9wFpi4QiabKe525dbfBUfwrNxbtI1KwYnB
         v0ZO/PHuuIuCI/0qQscuEnzLwUveCOXa7OPzgJl3cPo+3nxsy9zGCUD/sSaj4uAfUFNC
         txKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHnAI6INNpfEyeoVrs4hGgZP5NaC4/R4lNfx3MHbEtg=;
        b=rHAtWc8q3IterQEsa1hUzVv24t7VyL5Sj03zev89blec6HNWu8RJmRAMyV3eVUixbU
         vNpl8DP3f9eDEMSIZFG5Ir3p+75H6nak1t+sFuSOKgSyzu0x8sntDgFUTUtmUY9p9cLl
         NPzFnnT3KnSAoW42aiYC7jZODatye6fD+cZvRLqo6Pz0uP2FdKoFPxn38BCYHgrPayNn
         XoZe9cWtmqUGoBdReNCBJGGBoSTPpM69QSDM27Dq5bih9MLzyogdBXeYwsE2N+6lvmwA
         q6AW/ViJTebHvnPj9te9/+biIfYajGiGmfLkTcLniNjIhrCStKFrzVCLpKUzgMezQP/G
         N98w==
X-Gm-Message-State: AA+aEWZgnnS7iZqz1qjaJlBWetXdsOHs9sf0cWmh27ivdluA2NMrpho8
        96sMPk1ZmFAw+KznjLNH2Ue0VA==
X-Google-Smtp-Source: AFSGD/UQ1PMhMoNRwjuZb8wv1xRZROqMX6+ALeQZ928+6fgXZVxIIQqjwjqmnngPlI/m2PNFaj9OFg==
X-Received: by 2002:a2e:82d7:: with SMTP id n23-v6mr9194727ljh.143.1544555821617;
        Tue, 11 Dec 2018 11:17:01 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:00 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 02/21] lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()
Date:   Tue, 11 Dec 2018 20:16:08 +0100
Message-Id: <20181211191627.15542-3-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

With gcc 4.1:

    drivers/lightnvm/core.c: In function ‘nvm_get_bb_meta’:
    drivers/lightnvm/core.c:977: warning: ‘ret’ may be used uninitialized in this function

and

    drivers/nvme/host/lightnvm.c: In function ‘nvme_nvm_get_chk_meta’:
    drivers/nvme/host/lightnvm.c:580: warning: ‘ret’ may be used uninitialized in this function

Indeed, if (for the former) the number of channels or LUNs is zero, or
(for both) the passed number of chunks is zero, ret will be returned
uninitialized.

Fix this by preinitializing ret to zero.

Fixes: aff3fb18f957de93 ("lightnvm: move bad block and chunk state logic to core")
Fixes: a294c199455187d1 ("lightnvm: implement get log report chunk helpers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 2 +-
 drivers/nvme/host/lightnvm.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 60ab11fcc81c..10e541cb8dc3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -974,7 +974,7 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
 	struct ppa_addr ppa;
 	u8 *blks;
 	int ch, lun, nr_blks;
-	int ret;
+	int ret = 0;
 
 	ppa.ppa = slba;
 	ppa = dev_to_generic_addr(dev, ppa);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index a4f3b263cd6c..d64805dc8efb 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -577,7 +577,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
-	int ret, i, max_len;
+	int i, max_len;
+	int ret = 0;
 
 	/*
 	 * limit requests to maximum 256K to avoid issuing arbitrary large
-- 
2.17.1

