Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF74C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBEB2477C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgWlBYyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBEB2477C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeGCWSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:18:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45136 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCWSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:18:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id m13-v6so2805739lfb.12;
        Tue, 03 Jul 2018 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxLqNB1YdTc2r3mDCuIA3X1Wf7BQI0n+qf7F0U4V/hA=;
        b=KgWlBYykK4cJ3TaFXbVExFU2aPryn1y9EflVCEG6xQcrYpU37e41GW316zCGQy3lOr
         hzYFRN3MtHEWbjRe6UMLck4/V63JQUVhJ+0UbxqDpNdsZpaaFwzMQmE2aWfjw+Udp9fB
         inO2Ei8smsIeHx/Fq7Qa3ZF4oN6MoPD84Cirsbu9A/E0Hbcw4oVOT3tAldWoyaUwm/HX
         AARjYL9kXKqY2I/1DSg7zN4rrt0daX31Ex7jWnpcEj9Pgl29YKgmGuI8BFOdCMBM+Ymp
         F6ghj16f6SgMSHpPRGS0xMMLe/9VvVKtm7eRBiZfJU7TAQLWLeTaWgqPS0PnzHPHMD1x
         hNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxLqNB1YdTc2r3mDCuIA3X1Wf7BQI0n+qf7F0U4V/hA=;
        b=ClvFQ9J2dgjhN/iqoof1GL9qzCtJJlPvQIEtKzojXN5LIZFKsI3eCAOdfkgY8wVNTv
         t8olSZq87sN/xwXC8L0XVhTvuxXCStAIinnHk4WuBfeMzLa07QOFjOxqIqzaBeX4z82H
         E7M/xMxdMtjtEzfDsQ+nN/jvpsQKXALUOIwkoUHQOLH5xsC0rlIyhW1dhqwiRe694ezX
         0bzbcnHe6+E8y3j9nVavfKKvFkq7dcwsBW5HnPe/m5kifEMmyRKzsxFQl/jYWcia+J8E
         FaanJLztv2hJO35grHVIbKOYm9iK6SiuN6yOjffjQ4djeS2WYTZAmlF2p6EJZjQUMq48
         l+VA==
X-Gm-Message-State: APt69E2dbUlHc1M53qoO1E6ANDeC1nvLHhZGmYycMa3676PqhnrqeVnJ
        5GELuA3dLZNDidZx2Mh4fr4=
X-Google-Smtp-Source: AAOMgpdYqSWolOBLtuaRKdpdrAT1NSS658YlNTClbCA5Aw0VOYDShcMjvRYIG7t9IkQwbozACy8RGQ==
X-Received: by 2002:a19:4344:: with SMTP id m4-v6mr11276008lfj.111.1530656289174;
        Tue, 03 Jul 2018 15:18:09 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id p88-v6sm328253ljp.90.2018.07.03.15.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 15:18:08 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2] gpiolib: Defer on non-DT find_chip_by_name() failure
Date:   Wed,  4 Jul 2018 00:18:19 +0200
Message-Id: <20180703221819.1825-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180703172635.32508-1-jmkrzyszt@gmail.com>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid replication of error code conversion in non-DT GPIO consumers'
code by returning -EPROBE_DEFER from gpiod_find() in case a chip
identified by its label in a registered lookup table is not ready.

See https://lkml.org/lkml/2018/5/30/176 for example case.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changelog
v2: fix typo (latar -> later) - thanks Boris and Andy for catching this

I'm not sure if adding both Suggested-by: and Reviewed-by: heades both
with the same person name is in line with good practices, please remove
one if not.

Thanks,
Janusz

 drivers/gpio/gpiolib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e11a3bb03820..01295c03b315 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 		chip = find_chip_by_name(p->chip_label);
 
 		if (!chip) {
-			dev_err(dev, "cannot find GPIO chip %s\n",
-				p->chip_label);
-			return ERR_PTR(-ENODEV);
+			/*
+			 * As the lookup table indicates a chip with
+			 * p->chip_label should exist, assume it may
+			 * still appear later and let the interested
+			 * consumer be probed again or let the Deferred
+			 * Probe infrastructure handle the error.
+			 */
+			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
+				 p->chip_label);
+			return ERR_PTR(-EPROBE_DEFER);
 		}
 
 		if (chip->ngpio <= p->chip_hwnum) {
-- 
2.16.4

