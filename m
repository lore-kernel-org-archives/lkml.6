Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899CAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289822157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fcKZ0p5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289822157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeHXOuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:50:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43548 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbeHXOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:50:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so4399473pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CjVz756Wq9WH7Mu19uTgoqMyNvMugQhQ6XTIdPI8oU8=;
        b=fcKZ0p5mH+NZltm4Pmg1CJzWBjepNYk+gGYLF9jC5/as7m+7OpNa9hCBLxSJzKPRYq
         4xngvifnaKVAqA82T14FSNQLyCBbRtWI/gTabcM4edUZLrrl1Ri+4VrZo9ssOlkHRb41
         aANOXHSEKOwNTAmoJ/dZGu01eqeCYqgtOA8vzpSvDTJomad70rLBrmXP0f+ezNZdIokx
         h+jKIqSqFPCyhwg2redSOv8wDUVPOPbpAScN2twwmzOe0CRYNIocVxLuMUaQ/K2Cvnav
         RSityPU0cKZb5RVa1oNHLVShiccircJR7S0SUrB0IDGxGZatgvd6w2GVcLS5an0IFpgE
         DaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CjVz756Wq9WH7Mu19uTgoqMyNvMugQhQ6XTIdPI8oU8=;
        b=gPY9Jw8HPFBBkBJuIgnxZhh9M2v+6XUwaBwTXneg91f7jE9yVScFdFJ+1d0+pWy8Ok
         QTvWsYcwNoOHgXwlfXQLH07P36K0Ba9tWPEeGCDKEqLYG6xZyvA/WEdlVNGVLwoSLBrs
         zK4n8L05vO0lrI3P1PRikXyXlTVGg0gl4MZVWs37K4iR97LCfFvTeNnJ1AZ7mWr9UEOH
         A1VJACXPjfQ51rH8d/UdIMx7sHZ3hZKs88bWPf4hYyHMLCn2wZMqYpTdGzX7VeU8BV3g
         ugd0+ZEP/cyE8kYb25tH6vx9J0c0RpU8kJuYvb7UtSq+hWcU8Bf3H9LU1fm290clH82l
         zTFw==
X-Gm-Message-State: APzg51CdeQYMLbCL4nVa4aKGhk1xQFApg4A71tvpO/zfMdkt6SdbkLra
        jkacdgxGoISv8C9Ixq4Qd8YJoQ==
X-Google-Smtp-Source: ANB0VdZrD1kF+2qCHz71duBK81cp/gPZ3cEUOlqlGYowIolkiam40ck6VwnOI+YgfbN2lBpt47aYdA==
X-Received: by 2002:a65:60cf:: with SMTP id r15-v6mr1289077pgv.41.1535109384341;
        Fri, 24 Aug 2018 04:16:24 -0700 (PDT)
Received: from localhost.localdomain (36-239-254-33.dynamic-ip.hinet.net. [36.239.254.33])
        by smtp.gmail.com with ESMTPSA id o20-v6sm10402284pfj.35.2018.08.24.04.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 04:16:23 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd71837: Remove duplicate assignment for n_voltages of LDO2
Date:   Fri, 24 Aug 2018 19:16:12 +0800
Message-Id: <20180824111612.24622-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set it once is enough.
Also move n_voltages close to volt_table for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd71837-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 0f8ac8dec3e1..9b5e1297902f 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -388,10 +388,9 @@ static const struct regulator_desc bd71837_regulators[] = {
 		.ops = &bd71837_ldo_regulator_nolinear_ops,
 		.type = REGULATOR_VOLTAGE,
 		.volt_table = &ldo_2_volts[0],
+		.n_voltages = ARRAY_SIZE(ldo_2_volts),
 		.vsel_reg = BD71837_REG_LDO2_VOLT,
 		.vsel_mask = LDO2_MASK,
-		.n_voltages = ARRAY_SIZE(ldo_2_volts),
-		.n_voltages = BD71837_LDO2_VOLTAGE_NUM,
 		.enable_reg = BD71837_REG_LDO2_VOLT,
 		.enable_mask = BD71837_LDO_EN,
 		.owner = THIS_MODULE,
-- 
2.17.1

