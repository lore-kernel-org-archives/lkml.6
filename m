Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AEFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C50520989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz9sDAHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C50520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeK3EJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:09:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35362 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeK3EJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:09:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so2525886edx.2;
        Thu, 29 Nov 2018 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0g6VD4yO1x565KzJ27vSUM/PrFvOCXEHCPaF4GvQwM=;
        b=pz9sDAHQZgVtxNsLX9Deulj2lljyJihIfXDhW0SJ30GzQcD9nBYC/7gZfJZQBIhZyJ
         1TeazH/lbvnN2Xh96T4OoFc8tHmd4laiimZlmcCIy7bkm8gtAeUrK1oPelA7F2Ga579z
         KQwykRbrw2rv5y6D8L1Tr7g3R5jOMu4EQdWkvip7A8CBpmR9QbwdSeAXXjKJUhrg6Zcd
         2W7txzx3EpLwKJzpF8P7Le4eCiXnRId7Xg7hjZpLOxkIrjf97x8uIopQDOOogQEucyCW
         EVEV8j37WsNPSGdt8gmPVhRMqmdOCRrSeSZ+Jm6Z5dfyaoqjETGwcnTBEa7V9Zeccppc
         Y+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0g6VD4yO1x565KzJ27vSUM/PrFvOCXEHCPaF4GvQwM=;
        b=o/TT4XwNfHYcrR8eJ0ZZxl3nnuzPdLF0OPcyNqjQEunDq3Ofou+KiyGbkusdJue2yH
         NhV3BVcV0d96nfzp+QIA1u/avwzYrgqALVP8Kom9W8J9ZckExJ9YcJ/w48LpAqR7ff8X
         ZNlCFeVflNi1wIfMh6J0L0qIAxSMZL7hLOzcBLp2W/re17tpGvuWUbvWkUCucam1pQEN
         fLa/VG0VAb60QGUyOHnr78YPxSZKiJOsRn8eV8SxbHy5veBB0lNeMAv0hEXBX5eEq6CQ
         z8VKKSJgvyIfUJwme1iDwNmqrcYKlCouBdBlsWNCi7fMJtED0NuZc873R14tuMgNuqOJ
         32/g==
X-Gm-Message-State: AA+aEWaoyprS1FQ9Cqub5cYZpoA8p57DfFp4Jjlwfz57Xi4e+yUEkaOK
        VWQaHO4Rs+cERnn208lwsOc=
X-Google-Smtp-Source: AFSGD/WejkvgbpDceDm5DGW3n8pU1pmvO0OHZNGjMGifegK07q2THS8Jrk1JGdRb4VVF6EZgsSFVcw==
X-Received: by 2002:a17:906:258f:: with SMTP id m15-v6mr2178688ejb.191.1543510997706;
        Thu, 29 Nov 2018 09:03:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c11-v6sm413985ejz.70.2018.11.29.09.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:03:17 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] genirq: Export irq_chip_set_wake_parent()
Date:   Thu, 29 Nov 2018 18:03:09 +0100
Message-Id: <20181129170312.23625-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129170312.23625-1-thierry.reding@gmail.com>
References: <20181129170312.23625-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Interrupt controllers in a hierarchy want to use this function to
propogate ->irq_set_wake() operations to their parent domains.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a2b3d9de999c..b3aea5282243 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1381,6 +1381,7 @@ int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 
 	return -ENOSYS;
 }
+EXPORT_SYMBOL_GPL(irq_chip_set_wake_parent);
 #endif
 
 /**
-- 
2.19.1

