Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00099ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02322146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ldJEx3ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02322146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbeISHAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:00:03 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47112 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeISHAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:00:03 -0400
Received: from localhost.localdomain (unknown [209.82.80.116])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 67B9C5C1528;
        Wed, 19 Sep 2018 03:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537320283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=nUAoOry0XsMkfMQshaNFrVRTBFfxd4k729C6nk0ZM/w=;
        b=ldJEx3ZDB9M0v9UIseJh8Uz7NU3wf53oV7IMAhDRUhDgsTXO+VbwHLldyCAagRDNxw9zcC
        nkKuqkTHU2tieG5nWqstagwSDW1VSHpk7R54yP+4UGAOFcVKTBa1A+ac6w40cx9l9RZfBk
        s736XtTzQ2bU6gKptALYHl+nb8RU358=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] pinctrl: tegra: do not export tegra_pinctrl_probe
Date:   Tue, 18 Sep 2018 18:24:26 -0700
Message-Id: <20180919012427.12439-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No user of tegra_pinctrl_probe can be built as a module, hence
exporting the symbol is not necessary. Drop EXPORT_SYMBOL_GPL.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 1aba75897d147..a5008c066bac2 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -737,4 +737,3 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tegra_pinctrl_probe);
-- 
2.19.0

