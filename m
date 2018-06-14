Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 516ADC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C01208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2yJCti/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C01208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964783AbeFNLMu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:12:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44052 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeFNLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:12:45 -0400
Received: by mail-lf0-f67.google.com with SMTP id 36-v6so8762083lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=se/RkAuYKxDvATwaOKEGCpzfV6DWJrCjLhv0y8/exhc=;
        b=d2yJCti/BEj7slOqcbupZKVBjqqarGgC4sxWJ46PbBBsZOch/Grx4ot16W0+3MFvOS
         6XoakgHWG8iICLfTqMZ5UQXBog7+qE02gQPWcSUIOZFhikv2upJng+qTVldYkG2zTv15
         eeLQ7P2qCLoxgctx72AfqZ0Mb8u95etUIelGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=se/RkAuYKxDvATwaOKEGCpzfV6DWJrCjLhv0y8/exhc=;
        b=WoQ4UR8HHZmm/C4UUOBfhMpkBQBPON3gNvPonhDuCErLBWveC9Nz/td0IKGtRGTU4I
         0SJ8y7qh0fO5VFhgoMWX4OphfRMRnE4/97FB5L1PUI8viMTPF7ZWM0UGXyPm5W10ShSq
         sGE32UDLc0mn0ulWIC2mk8P2sIlZ1/hNOA/8DA6wS/frJWozL9IgzY3OSMfdlMB9PptF
         flXo72hNreP0qjQnYY2LA+9IJDCQksP6fKOMeG7YqpOCTTn9EsD3DFLlA/dlAjQQPE5a
         MShYzY/6gxBejbX9NJ/yHkLRQfbxhfKHkDayXuZK3YukyhlRB8PAAEg2dx9RD6ti4p6l
         t4Fw==
X-Gm-Message-State: APt69E1B12ex69Vqje8ysRFcrJGZK0E7vpLP43dHs+ccp0BcLk5+HciQ
        tuZMfl5WmjzE1wFACqjdSpU2MsBWujk=
X-Google-Smtp-Source: ADUXVKLuy53pDtHQ8Z7iQjx052q0GYbMNGHVgtXy37hhzeyLB9VNgGKMnkGn91LjGu8Y8XjHlYgaMg==
X-Received: by 2002:a19:274e:: with SMTP id n75-v6mr5545583lfn.14.1528974764180;
        Thu, 14 Jun 2018 04:12:44 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id y13-v6sm1030434lfk.37.2018.06.14.04.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:12:43 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] soc: qcom: smp2p: Add select IRQ_DOMAIN
Date:   Thu, 14 Jun 2018 13:11:34 +0200
Message-Id: <20180614111138.8923-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are using irq_domain_add_linear(), add a select on IRQ_DOMAIN.
This is needed in order to be able to remove the depends on ARCH_QCOM.

drivers/soc/qcom/smp2p.c: In function ‘qcom_smp2p_inbound_entry’:
drivers/soc/qcom/smp2p.c:317:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smp2p_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 9dc02f390ba3..2f59d0a835fd 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -106,6 +106,7 @@ config QCOM_SMP2P
 	depends on MAILBOX
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory Point to Point
 	  protocol.
-- 
2.17.1

