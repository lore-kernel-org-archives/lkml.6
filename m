Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBFBC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EAC21840
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SG3GyBZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EAC21840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeHUUiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:38:16 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:33106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeHUUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:15 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 15/24] pwm: jz4740: Remove unused devicetree compatible strings
Date:   Tue, 21 Aug 2018 19:16:26 +0200
Message-Id: <20180821171635.22740-16-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871834; bh=5Qi3CDFsvJoYRmKgcyWNjWFvL4eKwfcw1U/GwZYuE9A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SG3GyBZcmutwaKIUU/oiqTG6rD4bbZWqE0i22ul4/1kGfrvUvApGT3LKwc64GZXMKLzsHBndELUEzMQtMR+9WSXaTULsidQ+xoiAepuZJd6DLYOFKRdqDzUaLsb3Ce0oe/T+FlUSNAHZCoVYBJfC6WMWwBVthNkErg5Nfq8r/6c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now none of the Ingenic-based boards probe this driver from
devicetree. This driver defined three compatible strings for the exact
same behaviour. Before these strings are used, we can remove two of
them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: No change
    
     v7: No change

 drivers/pwm/pwm-jz4740.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index d08274ec007f..5814825d9bed 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -235,8 +235,6 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{ .compatible = "ingenic,jz4740-pwm", },
-	{ .compatible = "ingenic,jz4770-pwm", },
-	{ .compatible = "ingenic,jz4780-pwm", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-- 
2.11.0

