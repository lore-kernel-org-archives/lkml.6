Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E55C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A13E2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="lgRahNFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A13E2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbeKFW7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:59:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37523 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388419AbeKFW7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:59:06 -0500
Received: by mail-it1-f193.google.com with SMTP id j79-v6so5640421itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gL8Qq0VcYDDfyeqaS1taQ6NLTbooICca+pVmxUz1Mwk=;
        b=lgRahNFTqvHcWN3GqBAzJEm3bTa9ZHnOoY+UG+kPmA2Hs5tTh4BMGGmM8i0kEjUgIO
         Hlr7Cs0ayZQ4S5K5MMB7mXHbjXHxU/31WTJmd4nrgRCWXC+1MG5PG5MCh5xBO2zroyXD
         N4TvHuH3Q5irbZefgTJN/vG9+5Y8OzTfn1GWjLXA4FP50a2l3TFzJQEKtE+rQHEgS9/I
         ZFOo/AfDmbr9Wq1D0JPc558rnE+oyNuGtLLdwwfF7Ca9VK5+A4OJjSeTqxRVlm2Y2gDh
         PUwIK/DT5vbRsHs2Y80QfN0l8JU2Nf3hvyz8phw5GAU+eJXhql7TJGb4rzzSP1OLQRyF
         IEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gL8Qq0VcYDDfyeqaS1taQ6NLTbooICca+pVmxUz1Mwk=;
        b=Xw5T9dXiYrhfRGs1MgFxBumcNzcGU0uJU835MdhZzMUVPRotVMNXbtOCkxLdfzrC1v
         foOnnJpRnTSYzQpyapKX+c1O/dH7t4rWWeiY0yxQzM5cW8CqoOWm0/m/ABbwHh7Czlx2
         Qu6r7QLa23YvOFOXuu6sXiw87ePqyQuo6pe6C2F3b2rnzHutPoW8mExNZTJenq0ZwPMS
         XOUrH8M3HTbClcMtzhD0KJGvh3kUNP0oJKH/KtBseeuDQw0dA+BL76gspFHICIRRgD64
         GbBzGW35H/Kt5Rxz+dpMXO6jxGOGCtO8PLPlOcCoPAdBIPfXtxlCh+BgvcdPpjczOmlE
         hJRQ==
X-Gm-Message-State: AGRZ1gJjrqSSMKBiDB/eCG40kGtLuFvCawIX1IT+BZ+orJ8euTORLX/O
        Qg25YDTVCCFJZ8RjZYCGXZE4hQ==
X-Google-Smtp-Source: AJdET5d/TunfhIrWQ+iW3biEouvoczOl1RfiAnxRayvAZwihEy5GOYyP/ipB+qTOAop6iyuUJP7RQA==
X-Received: by 2002:a02:8a74:: with SMTP id e49-v6mr24954950jal.81.1541511229274;
        Tue, 06 Nov 2018 05:33:49 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u132-v6sm897282itb.21.2018.11.06.05.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:33:48 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 6/7] lightnvm: pblk: fix pblk_lines_init error handling path
Date:   Tue,  6 Nov 2018 14:33:29 +0100
Message-Id: <20181106133330.26570-7-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The chunk metadata is allocated with vmalloc, so we need to use
vfree to free it.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3219f335fce9..0e37104de596 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1060,7 +1060,7 @@ static int pblk_lines_init(struct pblk *pblk)
 		pblk_line_meta_free(l_mg, &pblk->lines[i]);
 	kfree(pblk->lines);
 fail_free_chunk_meta:
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 fail_free_luns:
 	kfree(pblk->luns);
 fail_free_meta:
-- 
2.17.1

