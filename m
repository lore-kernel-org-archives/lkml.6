Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45017ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B002098A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z90Hgvv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B002098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbeIUQBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:01:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42684 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:01:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so12275650wrr.9;
        Fri, 21 Sep 2018 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glZV49Ep2s2aL5s4iHVlVkhgYEOAi/oWCd5CUZz2C4w=;
        b=Z90Hgvv9nZF3Y5tpt8dc10Q2p7xLvLqHfzxe5wsi0JPShcGHP0MeUH2uc/WrD6JnDs
         +Ukttp+CUZN2bnOVIhUiCV/1sK8xcIW7iVlkjaXclQT1uRdHEZMeyemmqbh6H38p7L0p
         0tKBbwTuhWtJipqp4czvHeJrxTbWceMUqMLmo58GfG0IV5//fgFXQG4bQPz2K1x9mA9G
         vGLO6mqyp+bquJImJFtbhDPy1Lv6p8UpEOJyI4/pauixxmdVIq+1y088TnjI1tglYWql
         FnSU50qU4jqyy3QDaoEnXC6IEYTjMOockbkbGiCsWfYmYDEDmz9R0u1VZfVIg5G7OYPs
         PYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glZV49Ep2s2aL5s4iHVlVkhgYEOAi/oWCd5CUZz2C4w=;
        b=RODekaZrS6iow76ZJvE53x+MtwXA9TUMN5SeQDVB7gMHBvi6Tu+fFGz2+bEWBtmgOI
         ES6pHlz/DymZs8OrlOQ7xJntKGEstT/odbobsduJZ/nWiGpu3Ztwd4G5xbaIbyrL3Tx/
         2jK9W5cvnCwRsffpKgn/HLR2q40YtlU9q3qJgalLMBGRoXu+eec0mQ4YDl3AWVUkYQa7
         Uzkpo1seGOrWN60kSkL7HUeN445pUd7KsSV5jNEZYxfdhmscF+/HfuYD5xY64EscTSf7
         jB309+lDN4PxQsjdGLvpJlIh7t3oQ1nXj1LZ893Y4brWM0dA6peG2O/8PawyFzYEnZZE
         kbbQ==
X-Gm-Message-State: ABuFfogtpTOxXu8hU46trnhGhZFfwJawg7ktk8EHiNnQ+IdoCDNWXn80
        bEEFQ/j1sDxDmFx9HWCNc6M+C3+v
X-Google-Smtp-Source: ACcGV616P4uJIIQOS4Sm8Ox5SKRI9e8E1NEGevX1eXRYDKxvlKgvSpttoclsGm7yt3mUPa6mOZoiuA==
X-Received: by 2002:adf:d084:: with SMTP id y4-v6mr946204wrh.152.1537524788491;
        Fri, 21 Sep 2018 03:13:08 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id h10-v6sm5783793wmf.44.2018.09.21.03.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:13:08 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: tegra: Remove gratuituous blank line
Date:   Fri, 21 Sep 2018 12:13:07 +0200
Message-Id: <20180921101307.12089-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

It's common to follow a device tree ID table by the MODULE_DEVICE_TABLE
immediately, without an extra blank line between.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index f8ebbece57b7..48c4595a0ffc 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -300,7 +300,6 @@ static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
 
 static const struct dev_pm_ops tegra_pwm_pm_ops = {
-- 
2.19.0

