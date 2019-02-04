Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D23C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5FE2177E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRLQBnNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfBDGfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:35:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40669 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfBDGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:35:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so5839924pgp.7;
        Sun, 03 Feb 2019 22:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FNKuMDVHt+ZsQRgJsONLVjRsFg7gykTngh/tL8n8OqM=;
        b=tRLQBnNdchlfF5CKG5GIq8V5qAd6zT5ijhz1+IxDI0xms3UiCY7+EG/fNsfRCNlcRo
         i0K00Q7DpvnxZXiUdYANwHca+OtKrmqvuBcPN3Og4SsNqCCUwUcjx7j3SnwH6pfEYexc
         lK4If6ipPenMixFoXieE0cXzUiCUOGQBlSJr3Va0p5wsyUcfinBW36ilmYvrpDe2RZCC
         WWVAvTbKYZFtrmkOWw7q8Z26Q1sEAzvXAFlKLCSUZi+THIxq+eHPfGw+nIdb8Dbgkuwn
         tYy6wOAJ4oK5s/qoT0D9ZK/bRgLvZY6LYuqg9J01uy2LjOGk5cmYMEkfZ8oboh8pYKnN
         XZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FNKuMDVHt+ZsQRgJsONLVjRsFg7gykTngh/tL8n8OqM=;
        b=B3aF1rGVJHCcN7GsZl/ZoI7PJi0Vjd+3lKY5sgh8UwQcATe5k/V3LUJfWjsJ4Bbz3S
         VmQzd3xgUG5F6GWTTiSFvSIcsuB3GhYjjVysmGrJwkYsQUjt2bBaZajKN+zURUg7VUbf
         jwgo+8vN2lT+rOG3YYOp46wLCvPkkKFCHy/HetOr7LJcV6gIwfBeyTkfSQti6pR0AAGv
         EEPVjhsyXDFOokwYWDteba58SbGDw1S/7KNnsYMhx/QH5Tryzut175AKcGzk8jjVog8V
         SGKF2d1g72USsh0Md6ftKw830kI+BHPmutBf9NdnKCIvaR/i6FeGKu8IC2vcAKRkAJYq
         URNw==
X-Gm-Message-State: AHQUAuZO3k/RgqJGbFbCxTK4tGrNQUW++NnENfn1venml8KkxUJxYAQG
        jojlys0/UJ3VuBoSmiWxoJo=
X-Google-Smtp-Source: AHgI3Ia0/Pas480PeiHjUV+r+t1q7hLj8dfVAPPCjLKCk9HfJKJD0bXwtTBhY8AuxIG0RgUVWdOdvQ==
X-Received: by 2002:a63:2784:: with SMTP id n126mr12052546pgn.48.1549262103525;
        Sun, 03 Feb 2019 22:35:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l82sm16589099pfg.127.2019.02.03.22.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 22:35:02 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: tegra124: add missing of_node_put()
Date:   Mon,  4 Feb 2019 01:35:01 -0500
Message-Id: <20190204063501.1348-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_cpu_device_node_get() will increase the refcount of device_node,
it is necessary to call of_node_put() at the end to release the
refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/tegra124-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 43530254201a..140a9266b64a 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 		goto out_put_pllx_clk;
 	}
 
+	of_node_put(np);
+
 	ret = tegra124_cpu_switch_to_dfll(priv);
 	if (ret)
 		goto out_put_pllp_clk;
-- 
2.17.0

