Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B20C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD429208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD429208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH1FmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:12 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39515 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1FmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:11 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so8127oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j5U9NCBMxz5jtw/VckjbH+ZqPHcG46+RkeD5Dihckzc=;
        b=a4lglA1AmdNNgNmKAaQtPS3MvKBffRAq8v8j3lF280QW3tlDEU+mVzq8Thl8Ag/0DC
         7/VZz+7VWUEiX4A65mLbXh4WYksHyYtqcE3QmptsWPEesAXJeJ9OSAxJhQwOgfD7LGxq
         I7s19XvAq2APUe+A9q7RIyFA2BPPCfZN+zDaB4e/jVRd5t4RRRZIyFxQ5tVlxkr6XV+5
         r4cLY0y/CFkdeTgqmOdjrJpGH4rTZscIdkn6uFloxIaA48AYjZcQ3rQOg4XVSXgHQKjA
         KJVeXFJpey3SPmtzfXLe5rXVnCUhFtoB8H0z3nQlDGSzo7idGtjdVwbQy2rWPJwbEDzE
         uQlA==
X-Gm-Message-State: APzg51Ddb3zXAo5ttg9uKfUIZByYhxwUudOfqdK83aUVpiIZYvyWMWvd
        6H63A5N2u0NNvowqTJKgf+IIML4=
X-Google-Smtp-Source: ANB0VdYoBTr9CaBjJamuc16MN4J6Obp0iSpGm9vFExKXiBGNZJQdvi1Jf38WaZHYdEYDdTLmbFGg/w==
X-Received: by 2002:aca:da56:: with SMTP id r83-v6mr1107038oig.265.1535421176375;
        Mon, 27 Aug 2018 18:52:56 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:52:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: zynq: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:04 -0500
Message-Id: <20180828015252.28511-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-zynq/slcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index f0292a30e6f6..10ef99ce1d90 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -233,7 +233,7 @@ int __init zynq_early_slcr_init(void)
 
 	register_restart_handler(&zynq_slcr_restart_nb);
 
-	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);
+	pr_info("%pOFn mapped to %p\n", np, zynq_slcr_base);
 
 	of_node_put(np);
 
-- 
2.17.1

