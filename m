Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0628C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B18F22565
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwAMzak6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B18F22565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934366AbeGCR0M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:26:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42194 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933637AbeGCR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:26:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id 1-v6so2162079ljv.9;
        Tue, 03 Jul 2018 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yRwPHqdzreWQR0K/JkpBGuCe/bdZMajH7m3tWS4hMiI=;
        b=uwAMzak6xG4mya0n69ucDbjuYmKLCAOMd199scLj8Ul2AbLyilJb8TLNbZFTii1Xul
         aaMVkMoIRVSwLS/bNb5sKqGlWRFWc/40td3I1msKaWi4b+H/ikOwuoQcoAzreOQnKloK
         YttmY30xy7wZUj61ClmRs0gRoKzwpbkc0N0UE85bvs6tFw5zvvAHbJx6KmfuCI2v9g+p
         fMnLwKRPU/kxOO/dzKgBlV8NwwDRvEHU0zD6XAf6Mq6+UkLKAACnrcFCkBPFylLvLRSC
         KuA7etGryn9qDmvbFOthSXsu45YLqO5L6WumpGywo2D9nInzwZyEChbiNsB9luKEYp9/
         I2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yRwPHqdzreWQR0K/JkpBGuCe/bdZMajH7m3tWS4hMiI=;
        b=DIr21zuuNoGMfXVpWFUKFD03/N3IebfzVl2blhfyPn6VbXZdNXMFk5G2Soia40RzPO
         B02ZP64BHQ/z4gOvh3UtMR4FnflpLbpmpZTVwxRjQuBVeQzhfeiouaf9g5aWP3eRHrCv
         pU+xp807rTXNd+4w63Cn2/MI8B0zfIyKt17M7mf9Al7VetSdL5GRz1vShIWcy2O7zvn3
         Mu4UPxEBV14KrzbiMaUZHbS9gygMqeRd+kKHmdnKXPA3aovRS+LYwkvZ8RXSynXkrhgr
         VTqvEvINZdd5lqDB5It0WjsP6RzxGNpLVd7hSJhAbKbPNHodA6fN8QHxacmEIYI/lmp2
         PKCg==
X-Gm-Message-State: APt69E34m8Uit+12TDrK8o2+fgznpqsSxdsJMemAp4uWhZ0fQyWE5VkU
        4ROcAEl5TE6CnzroV7RQA/I=
X-Google-Smtp-Source: AAOMgpc2CeIdNyBHBYF928FbqQ8Ozn3nrNE6H7+oifdOclSu7GerFeU0sR9zB4RPO0saEzrfAYZwdA==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr2258374ljj.53.1530638768999;
        Tue, 03 Jul 2018 10:26:08 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id c83-v6sm344930lfg.18.2018.07.03.10.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 10:26:08 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Date:   Tue,  3 Jul 2018 19:26:35 +0200
Message-Id: <20180703172635.32508-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid replication of error code conversion in non-DT GPIO consumers'
code by returning -EPROBE_DEFER from gpiod_find() in case a chip
identified by its label in a registered lookup table is not ready.

See https://lkml.org/lkml/2018/5/30/176 for example case.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
If accepted, please add
	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
if Boris doesn't mind.

Thanks,
Janusz

 drivers/gpio/gpiolib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e11a3bb03820..15dc77c80328 100644
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
+			 * still appear latar and let the interested
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

