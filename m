Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CACC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD19B2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibtnOHLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD19B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeKFOZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38807 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so5528838pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5xZvV9ure0B+Th/au/ie3rB7XqPr/svxvChRm0xoFwg=;
        b=ibtnOHLLblZ1SlAZodKPh/TX2KVmtl3uaPRMacZpaeeiBkQzgOVYxdiVAeIS0Jdo0N
         06W3hhRNRbHpipyhfbCJZjeWTT1SydCN+HskekJc5bEosR19R2B62RJhxrjPpXL/4qb+
         ek/r7SvL5Yf/z9G8D/OGTEz68nGZ9lS7trkZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5xZvV9ure0B+Th/au/ie3rB7XqPr/svxvChRm0xoFwg=;
        b=c9VGTvwtonj47Gad0v8aZc9toRHml0ln2cZ0RqyZ7qz+Re1e18YRK2VZT+RD676pQa
         k2itICWRwhEHrYtkhPjQuURVrERZzNlkv/w4lFZPc+RhGFLWilo72q5MTqr7ZGByqy9f
         liGnNLSgcHqj2yP1ORa7HgaA7qnoaDEx6kvMfztxWPLeClz08IPHt0kl98QdQZV8mXL0
         xcUcPPY/iuSK4uwcyFS4Loik1e7G6oOccQbtlKEEL/UPgaKYIHx8DhBFSE5/DoeZ98Ei
         ak3E/sH6Yv6H1CkFo6mfHNvf3gQ4xKQxxPMy5WjD+L7LFjogRLLCRiZ/hY3jk6RSoODy
         dljw==
X-Gm-Message-State: AGRZ1gKHfFWJWRqvFNVbKbUb/2nLh8eD+qIY/jEri1UgK3JKHjujvNms
        ieQuw1f6M6uqRgJxvXs8oTcFSw==
X-Google-Smtp-Source: AJdET5cb1ZR1pZrZ/P3tJEKI0XGk+MTt2eLNCjgjUXltOimntoWmqjGxmQvobcnNNPWbbzs7SyiZtg==
X-Received: by 2002:a63:4c4e:: with SMTP id m14-v6mr22781968pgl.173.1541480540758;
        Mon, 05 Nov 2018 21:02:20 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.02.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:02:20 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 7/7] dmaengine: sprd: Add me as one of the module authors
Date:   Tue,  6 Nov 2018 13:01:37 +0800
Message-Id: <fe0dfc3e809bd6c3ff896a9a930b720a85dcbedd.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

Add me as one of the module authors.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 50d6569..e2f0167 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1226,4 +1226,5 @@ static int __maybe_unused sprd_dma_runtime_resume(struct device *dev)
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DMA driver for Spreadtrum");
 MODULE_AUTHOR("Baolin Wang <baolin.wang@spreadtrum.com>");
+MODULE_AUTHOR("Eric Long <eric.long@spreadtrum.com>");
 MODULE_ALIAS("platform:sprd-dma");
-- 
1.7.9.5

