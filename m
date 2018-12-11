Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420F4C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0915E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="nJAhIR2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0915E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeLKTTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:19:01 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:35177 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeLKTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:04 -0500
Received: by mail-lf1-f52.google.com with SMTP id e26so11632484lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmJnvhRDq+XrZ6hTWK6vWKJ3pmK1jX6DMSH7DISlQQQ=;
        b=nJAhIR2ekuo/pDaTHJnKPQ41v1LVN+1Fcipk9yKag7i2HBjDKqwsneXLBAMZ3HNMPc
         0Wkq9/9bEkmEC+p1pzJuJGlcYyYwF84qISAXEeWII4dWm5n1OJez4pAdATmBop3tWXVJ
         6GZaX+6ttrlW4BHCCA2YB0uX2M8Q6h3hf0nf39JhRND46Ch6FNNpdWVvZ9K+fbpfhKoF
         fqqV0xtsuqM6e4x8YqmtzFmClyuMGuAI8Th1oa9zJjVbjn4Jyjsqwt04Co2O/8vNztyO
         LYSxoLhIiMo5gu42luuOjA6qQPcUc9CyjLgUbPDcMusOIVo58gDkBz5FsXliRdivX/rt
         gydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmJnvhRDq+XrZ6hTWK6vWKJ3pmK1jX6DMSH7DISlQQQ=;
        b=CFcAWwqItJDbrv6cnsWBdIUCq6pE8CSHNFWxhiSQ0emygT3ZTb2jsQxazQPjp5+FTn
         xv0X1ojiWdOXT6pRag2w+d/eiILsoQN0lv2s5YaXIgEEKJkkeoxP3haHtBNFumtb6TsJ
         dXJGdphUfpGxAzljvavr92rhDhLORtPacNcMYXjVh4w1QSoQRELxrCkE0rV5pLmn6xFq
         FDRwlMQ+m9UvppYC+YL9sdDytdsXeN0xR1tsa239a8T8g1AbXuk0DKXWucwdOtYKc0m6
         HcUKzGQkfeWcGy/ZLODNMjgUx9coiuziG1Z0D3mj3xqTZAuWYIk5upZjYdLeBuyysyzO
         +HOw==
X-Gm-Message-State: AA+aEWYYRp89ifkBTtZBRXUEpZOXSLaDOy2Xz8ONDPnOgz5mc+TOQWLq
        XKdGn/05fPCG8VQ8sSbMn9DyKw==
X-Google-Smtp-Source: AFSGD/V4z7A7w5bxMIBz3HhhLRXWA1lKxef+gsGt7P3OX7m9jF39S9EttCvgJw316YCkghb51g3WOA==
X-Received: by 2002:a19:a149:: with SMTP id k70mr10051471lfe.5.1544555822844;
        Tue, 11 Dec 2018 11:17:02 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:01 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 03/21] lightnvm: pblk: fix chunk close trace event check
Date:   Tue, 11 Dec 2018 20:16:09 +0100
Message-Id: <20181211191627.15542-4-mb@lightnvm.io>
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

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The check for chunk closes suffers from an off-by-one issue, leading
to chunk close events not being traced.

Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..6581c35f51ee 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
 		if (caddr == 0)
 			trace_pblk_chunk_state(pblk_disk_name(pblk),
 							ppa, NVM_CHK_ST_OPEN);
-		else if (caddr == chunk->cnlb)
+		else if (caddr == (chunk->cnlb - 1))
 			trace_pblk_chunk_state(pblk_disk_name(pblk),
 							ppa, NVM_CHK_ST_CLOSED);
 	}
-- 
2.17.1

