Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A266D20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZN0KDZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeLIUcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43467 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeLIUbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so7762778ljf.10;
        Sun, 09 Dec 2018 12:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5T0VgQndGqhggBHHHuen16xLL3seZN19sOFULo4ZQO8=;
        b=OZN0KDZbZC4I7dhhMemYVqDRKw12o35rBO/zu7O/OofHHGWUXnzSTfrApqi3E7m/dr
         xRTswITKYr5b4zLsurLH+0pkQm9osQJh8Urwix8v0pAwhAOLWApu2sdNP+pt95eVrPDX
         VvlOSLP0Umr3u5PgyvSvY3cjRio2KXXoaBrNDPVuG6GcXmLU7b+Q7sYi2do5M0r1edxj
         AryX7glhVqVJeSBeMfGTIDx8nv2uCfg2PBOFO4k1xmre19PypgOOe8Kw7mJNGiBZjoZY
         3BxQUzUGArqkQ1ebiw50YjrkBEDnUJB1ji8gF5w0ow7NA4vyoeUvWlp7TUTtrEvrkvWm
         9WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5T0VgQndGqhggBHHHuen16xLL3seZN19sOFULo4ZQO8=;
        b=bfW6KZaZ4Ua3Up/aeU3jDLaqy59vyduC8K1VcYws2QyQSug1Lf7f9MT6vhF37qZGzR
         jefPaBUMwz4tZ8oGYQKmLmdeMpG7NsBHah33YZ9C2M7f+sW6qZ9gfmAibikP+FwV3Qvv
         PSFzmXK8LBGLM90EujTkVuXM2UaKJLsmjQ0DdrZ/mG6GadyTZzYa1XlvammeJ/DHDFDN
         PF5yze2YVvUXkS2j8XhhDXAOzC0ZH6JKb73NZPa+ZMRQIW4iEuh0i5uolLz8vBuWIuCr
         C3sKC/HS5jiJEjDxwwtsglrvaXM7yz3gQluuRCiYkBzKj3HtdPxs6CzWU/IWYv3XFDt8
         7q3A==
X-Gm-Message-State: AA+aEWba6YffSKJ+u2xXBC24MiWYcemVR3zmmrWlvn5JKgQeej905LwB
        6K6hZMQ4H3Njjfyqjk8N/KA=
X-Google-Smtp-Source: AFSGD/XwOta9/6Kb8bqdxbfmEiKpwfUQesLNW4YZM2DvhSdrVclE2/bwTyrYjZnFUXPgx1pG8Cnq5w==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr6064467ljb.106.1544387469979;
        Sun, 09 Dec 2018 12:31:09 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/21] memory: tegra: Use of_device_get_match_data()
Date:   Sun,  9 Dec 2018 23:29:40 +0300
Message-Id: <20181209202950.31486-12-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to match device with the DT node since it was already
matched, use of_device_get_match_data() helper to get the match-data.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ce8cf81b55d7..55ecfb2d8cfd 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
@@ -619,23 +620,18 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 
 static int tegra_mc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct resource *res;
 	struct tegra_mc *mc;
 	void *isr;
 	int err;
 
-	match = of_match_node(tegra_mc_of_match, pdev->dev.of_node);
-	if (!match)
-		return -ENODEV;
-
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, mc);
 	spin_lock_init(&mc->lock);
-	mc->soc = match->data;
+	mc->soc = of_device_get_match_data(&pdev->dev);
 	mc->dev = &pdev->dev;
 
 	/* length of MC tick in nanoseconds */
-- 
2.19.1

