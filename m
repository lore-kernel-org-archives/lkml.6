Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A229EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AFC217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEmRxEvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfAYLav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:30:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:30:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so9939725wrb.2;
        Fri, 25 Jan 2019 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5120sPOIxDNmEkIykLskl4iafqLfg4EFVtsDXjo7AE=;
        b=CEmRxEvyZZIu+7sUbcoBWMrzfKvT2c7B3C9sMjGCzmRdE8gAiBvORmigtwkQHLo6Wd
         BvXhFL1mm59jvN5uVC6nT6zYtu+u6wwgrBxF2OCIGoXJ/WDZOfaUEp8O9ZYltNyFYd+F
         Q3D/7yYYt29xscgKUG6p1IHpuXNwOoID7QGtx2hKc1Q1RlfvYpF8hSSZBBAtYXagc9C8
         NNzlQHMIm1w9FKMFHaM+SWGZRFZHNdndd3XZXLi/kdfaN9Oh5aN1KlT3zSz7/AZ2QTFo
         SVH41Tkr9I2cl8cFV5i92OoIhhHbbrjUEE86J9AN/CSsdNNDTPMXd1VcQI31fsHDLPYa
         qjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5120sPOIxDNmEkIykLskl4iafqLfg4EFVtsDXjo7AE=;
        b=KA33/R1UjBxqjIRuaBW8rMMV6BsA8RqkkLMeiA8EdctKrsIWQF2qY1mKQGwfTQWHJq
         ssSZtwtoOwTb6vDQseIMujtXmgjry+YM3ca/j2+64OgdV5J94bOB9vXa8qWfj149lHJF
         jWzCVB5gJ4EZHMz5/zqhJZ5OcvBm+KkJvmN4bez0W0F7hBRwKlk0eIgtsziT5U2kklIC
         Bsoruh2UIadBKAB7NB6J+9OM4tMzWPp56gozQzUDpz0s0ylysXhFJt+L1cExQox7XD6k
         CRMPfYjsReyJn2jeIVQbvgi7Y3MXdKrESI3hA9zdvYewe7Yj4my99dKJAQAo6ekf6Cio
         Z5+A==
X-Gm-Message-State: AJcUukfML6w/VUJsxU2isd0y5ufsFyEmQ6mBuSyz6wR3JF14q3gyeHlj
        dU9sivk1PQIjGCSvMWC5ZLU=
X-Google-Smtp-Source: ALg8bN4fWo87NEVjOFspwG6CUNXUZRByAryDppCJkzOpwx2ldrVRFM9QbB8VZJOE1uzASA3GsarvoA==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr9873708wra.100.1548415818810;
        Fri, 25 Jan 2019 03:30:18 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id z12sm81960648wrh.35.2019.01.25.03.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:30:18 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] usb: host: xhci-tegra: Add Tegra186 XUSB support
Date:   Fri, 25 Jan 2019 12:30:10 +0100
Message-Id: <20190125113013.11447-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125113013.11447-1-thierry.reding@gmail.com>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JC Kuo <jckuo@nvidia.com>

This commit adds Tegra186 XUSB host mode controller support. This is
very similar to the existing support for Tegra124 and Tegra210, except
that the number of ports and PHYs differs and the IPFS wrapper being
gone.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 49e033f953a2..9a07ea0f9c97 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1423,9 +1423,34 @@ static const struct tegra_xusb_soc tegra210_soc = {
 };
 MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
 
+static const char * const tegra186_supply_names[] = {
+};
+
+static const struct tegra_xusb_phy_type tegra186_phy_types[] = {
+	{ .name = "usb3", .num = 3, },
+	{ .name = "usb2", .num = 3, },
+	{ .name = "hsic", .num = 1, },
+};
+
+static const struct tegra_xusb_soc tegra186_soc = {
+	.firmware = "nvidia/tegra186/xusb.bin",
+	.supply_names = tegra186_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra186_supply_names),
+	.phy_types = tegra186_phy_types,
+	.num_types = ARRAY_SIZE(tegra186_phy_types),
+	.ports = {
+		.usb3 = { .offset = 0, .count = 3, },
+		.usb2 = { .offset = 3, .count = 3, },
+		.hsic = { .offset = 6, .count = 1, },
+	},
+	.scale_ss_clock = false,
+	.has_ipfs = false,
+};
+
 static const struct of_device_id tegra_xusb_of_match[] = {
 	{ .compatible = "nvidia,tegra124-xusb", .data = &tegra124_soc },
 	{ .compatible = "nvidia,tegra210-xusb", .data = &tegra210_soc },
+	{ .compatible = "nvidia,tegra186-xusb", .data = &tegra186_soc },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_xusb_of_match);
-- 
2.19.1

