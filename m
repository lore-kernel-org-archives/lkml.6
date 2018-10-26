Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A6ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163C207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pASvG5zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6163C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJZTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42941 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJZTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so929446wru.9;
        Fri, 26 Oct 2018 04:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sZwP3mlc7VxxXlW13/auVGX7x7GQ4BVbqowzB5gMCg=;
        b=pASvG5zWUBOpsGY2JT9/6cknbvnC7WYynrEcIvv/AfzfW1m+vZhzTfHFXIvAgCCwav
         ylmvlSrGc42yZ47+pb092xmPd4aREgPAQo0QG+4QpkBt0HPjvrg0rxlBD75c12htHPU9
         rGAqiaEcOfGY1xTFqx3rMv06Tx5jkLdiP+2pqRuB2rAh+GCY+Ltw5uv8ykZodzgigO9W
         Xxb6CD7bFU4TbiOWvsq3/xI+hdYELe4HRPXlJRJcZjU2K0YGOA2YeIWb213yz0sAZsVs
         ORtQWekQ/yCaZGDY3dKf79fBe/e5AyZHvpo8M3hn14kpNGicFfmbVhYM8HmThTntLUaa
         bO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sZwP3mlc7VxxXlW13/auVGX7x7GQ4BVbqowzB5gMCg=;
        b=EAGOgL2McqFU8nM/iK2Xa216v4u2jMH3qr9ugZD/1QY9ijMk37ompG5Ul0nAcevD0B
         JkdNY16h7xgYiPZiNljXOrfPqWGi0Z8hckZn4BQF8LVdNiCnTI5yqqbM1QBVqDvXG3FP
         aGUdxsd9N4mcQ00yZSwzzRr8CJ1PmGAXZlREGdoH5+XIG9Ur4UH5uw6Lvv81P8xtZLOI
         /tSmoweyc4Z1AmH4FyVbIgMdMSEIrUxNo886Lpvtz1GWjpt/ukDw9KzotvC5Oj0qL8sZ
         4GE7EVCDGdlUGrjhsKt4Lz/DXSW4X0VV/RcPdX0GLoe0zT/nyhHK7T7xg0S8f+q3FMYB
         wgWg==
X-Gm-Message-State: AGRZ1gLRuWSxs9mN3DbtZwe4xX2gRJd2K8XeRuA7PIfDLj4Lu2A6XCq2
        JRHi+AlM0MtyNR865m3seSo=
X-Google-Smtp-Source: AJdET5cUmTiwi5a/EEOSbpLZjBgpKvmVAZd7+401Zl3v8ZujdGTBUrIWf/uWZ/J1UQhmhRB/PAh2EQ==
X-Received: by 2002:adf:cd0c:: with SMTP id w12-v6mr5496264wrm.67.1540552610102;
        Fri, 26 Oct 2018 04:16:50 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1743870wmf.12.2018.10.26.04.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] mailbox: tegra-hsp: Add suspend/resume support
Date:   Fri, 26 Oct 2018 13:16:34 +0200
Message-Id: <20181026111638.10759-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Upon resuming from a system sleep state, the interrupts for all active
shared mailboxes need to be reenabled, otherwise they will not work.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index d070c8e38375..043f7173af8f 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/mailbox/tegra186-hsp.h>
@@ -802,6 +803,23 @@ static int tegra_hsp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int tegra_hsp_resume(struct device *dev)
+{
+	struct tegra_hsp *hsp = dev_get_drvdata(dev);
+	unsigned int i;
+
+	for (i = 0; i < hsp->num_sm; i++) {
+		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
+
+		if (mb->channel.chan->cl)
+			tegra_hsp_mailbox_startup(mb->channel.chan);
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);
+
 static const struct tegra_hsp_db_map tegra186_hsp_db_map[] = {
 	{ "ccplex", TEGRA_HSP_DB_MASTER_CCPLEX, HSP_DB_CCPLEX, },
 	{ "bpmp",   TEGRA_HSP_DB_MASTER_BPMP,   HSP_DB_BPMP,   },
@@ -821,6 +839,7 @@ static struct platform_driver tegra_hsp_driver = {
 	.driver = {
 		.name = "tegra-hsp",
 		.of_match_table = tegra_hsp_match,
+		.pm = &tegra_hsp_pm_ops,
 	},
 	.probe = tegra_hsp_probe,
 	.remove = tegra_hsp_remove,
-- 
2.19.1

