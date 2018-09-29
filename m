Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68363C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B7B20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qb2H0IiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B7B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeI2MRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36550 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeI2MRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id b7-v6so5679253pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VKu6Lyuuq1HCg2vjK0SKqBKedEZKBAaQkFejaBLFPf0=;
        b=Qb2H0IiXPCuD8odQfq1Yamo/SKGFNg2b7kL6xEAWg3+elPiIo4YbrXHFPwc3cSSSfb
         q5M3wEb87m24TQLVuaaEphVnaC/QLNnL+kolsOklPoVk6MvA7pYqVwOf67gY4YrNAfoy
         rUtJiy++oR54JMpkDsSVi0K12BLUvfCetQB+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VKu6Lyuuq1HCg2vjK0SKqBKedEZKBAaQkFejaBLFPf0=;
        b=ZWW/12uDNaNO6n2fZ14w3n54F3WfNUdegKb0QZdB4Nb1ZTr5VDVoV0Y6mHYyZsICV4
         9vCOfYRWH5OB0HPtvM3HFVRcoU7nx1qtsQqnJc4W3fcCn9qyfsQbjcUlwbwRYWPjE3qu
         xvC8Ir6gsjHV/AFk6zc9HJqXRyVtFTB3cRWOrb88+qz/lI3UiO2Ywp/F04GM8t4kIlmb
         C3ejOiOEmT3KVbUEdFAkbVYct2pesoYuX8/pk0/YyK8SCBurxfDtMBgqPnMXIsq1YFvM
         6YKP+e7O7OAgN08YNGIijdv+oPmITSuoi5/FnjjtOxNtUaS8uRsZly97qWTD6hu+Y+vc
         4QxQ==
X-Gm-Message-State: ABuFfoj6cD5gRZ9NGgJqweSgxfbkxxwQz9dPPYCPQf6fst/RWZ2lE+tc
        eXel2ULePgY9wWzGSc2HreP06w==
X-Google-Smtp-Source: ACcGV62p0TnV0Ef3aU3Sb3L6W68nW4G+RXzxp5MCaDUMdkRK8A6Xn5DbjYLFWZ99MOi5QAf51kfc3Q==
X-Received: by 2002:a62:c42:: with SMTP id u63-v6mr1737797pfi.43.1538200212273;
        Fri, 28 Sep 2018 22:50:12 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.50.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:50:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dmaengine: sprd: Set cur_desc as NULL when free or terminate one dma channel
Date:   Sat, 29 Sep 2018 13:49:02 +0800
Message-Id: <3a42dff7df19aa14d61b95f81ff22a7e16939ecd.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

It will be failed to start one new transfer if the channel started one
none interrupt transfer before, since we will only set the schan->cur_desc
as NULL depending on the transfer interrupt now. Thus we should set
schan->cur_desc as NULL when free or terminate one dma channel to
avoid this issue.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e6a74dc..1b39661 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -439,6 +439,7 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
 	sprd_dma_stop_and_disable(schan);
 	sprd_dma_unset_uid(schan);
 	sprd_dma_clear_int(schan);
+	schan->cur_desc = NULL;
 }
 
 static bool sprd_dma_check_trans_done(struct sprd_dma_desc *sdesc,
-- 
1.7.9.5

