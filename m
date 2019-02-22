Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE736206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pY/E/dMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBVTaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:30:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42018 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:30:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so3543725wrg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wXCuxXTsdy/lH5tfvvMzmJanA1yVCB3GttRv+R6Uc1Q=;
        b=pY/E/dMCE3mt1M/LUbpikfg4uhoLH7IrHKlvlCkHRAjm+cNkZpph+tDg0OXSsnjnXA
         oAfgteEMIl4GdbYpylfnGd1zdDsPPzBrUlu7m1KBVZ1TxRzMzetWA+RTEpf5YqOozpmw
         5yG10PwApAkVQMFgDL5sc7pMPX69r5wpEyNTE8aD5+fuNB8nIAdyiD/XiGe5hB88Bb9Z
         d6FIk/hwN5bKGEMwqpce54m51QvKumcG/MrNLScNtjpkqp2wXZlil0yONHJVDGj8pBym
         ma4C76YxvKlFpVe9a2Unxpun2eyBVggVwZGq/g2L1lNJA77JvjELxRk0RNX1LbqAQzq0
         OMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wXCuxXTsdy/lH5tfvvMzmJanA1yVCB3GttRv+R6Uc1Q=;
        b=J8Mkn4J3v+Ib5O9udi33+1vyp2nyoW2c1k5ycaimafIoGG6oXDrgrs5WbVr+S1tRxk
         Pb11nNWsbDvGz9yrpBXlGFYlSIGA2gI299/BRRA07dSXbmxZp21VgyTkMyL4cjlggLiu
         +RzSq4b81XmIMEYL5nzfesF4fhfK70FIJMHFf+1gSuUUcuQT4gk+HfHu454VKKAmjki+
         ONPQO9WELRzeacDIfYlcWf+r4IZ8S6rSUZLrO4dn8gIB+EgjjddBL+MPC/CJDQ55Fb/a
         v5XjW7QsdbHeTVoGErOfTv5VPsXyCjx2PJkCEHUWr46N4HomNEs5FV6xkovyQgSicEmD
         V+rA==
X-Gm-Message-State: AHQUAua5cOQK+auUbtqAFeaCzfvPq5VWTSVuvGQLlBTJD5S7tD1T4NQV
        QJk8vx+5r/a/pkI1QuCjK5U=
X-Google-Smtp-Source: AHgI3IbXOcZQk/XvcAdCbBfie10qw/o563DnRI1yzr+FGOEmad5AuMR/45R1UBhhws42Oor2YkJYwA==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr3931913wrn.157.1550863803694;
        Fri, 22 Feb 2019 11:30:03 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id e6sm2920345wrt.14.2019.02.22.11.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:30:03 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com
Subject: [PATCH 2/2] habanalabs: driver's Kconfig must select DMA_SHARED_BUFFER
Date:   Fri, 22 Feb 2019 21:29:59 +0200
Message-Id: <20190222192959.241499-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190222192959.241499-1-oded.gabbay@gmail.com>
References: <20190222192959.241499-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses the DMA_BUF module which is built only if
DMA_SHARED_BUFFER is selected. DMA_SHARED_BUFFER doesn't have any
dependencies so it is ok to select it (as done by many other components).

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/Kconfig b/drivers/misc/habanalabs/Kconfig
index b7f38a14caf5..80400a035dc1 100644
--- a/drivers/misc/habanalabs/Kconfig
+++ b/drivers/misc/habanalabs/Kconfig
@@ -6,6 +6,7 @@ config HABANA_AI
 	tristate "HabanaAI accelerators (habanalabs)"
 	depends on PCI
 	select FRAME_VECTOR
+	select DMA_SHARED_BUFFER
 	help
 	  Enables PCIe card driver for Habana's AI Processors (AIP) that are
 	  designed to accelerate Deep Learning inference and training workloads.
-- 
2.18.0

