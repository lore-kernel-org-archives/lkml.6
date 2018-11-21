Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D35E21707
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIRdqss0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D35E21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeKVACd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:02:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36903 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbeKVACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:02:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so5572134plr.4;
        Wed, 21 Nov 2018 05:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BRdmM2L6RB/NlssXoHUqZz6iwXtJJa89Etjnd9PmtoE=;
        b=bIRdqss0hQ5lNCeSDpIqr7olhGquFO/0CeuVBsXo+4fAgObbw4cCIMj0AvtFlPmyqF
         OMfHOSMkJWOkfxjaps/hE0U+gqNFY6CUU/4cuca1CuO3CvN+md/dQZYcfN7axY4ppQ7g
         /BEgSrup9INmN+AI2CpbZ7ZHnG9eFITdeOCyplLifUFpgcsNKXLq5BXQBSbi7BTzMkXo
         QEG1v0KFhom5HPmTf/Yosa6xRExKczUPXBV7LpqoVScDZD944LnbK6Kvu5LirE8Tx83n
         z1vdpM9bscIBklpSicHbwCjgnq7DyMTRxhFZiehPsglDXb6DUsOha6OuiFukoW1ItVGh
         a8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BRdmM2L6RB/NlssXoHUqZz6iwXtJJa89Etjnd9PmtoE=;
        b=ULgYL2yqZAiRAqun5cHMBA+uG6LxEzWAj+INUv711Ffrje0FxfycPqIgh6yaFQH1nN
         mOWwPJzJpC5aBbCB3HBOFubjee52251TymZk1hMGGL5Zoy7J7BIN+g5BzNQmaQDI0he9
         oJ9d60KfV9su26hESMwVpvI+aLNfInNSiu+QNqjdXRXz61+XfzTEC/wiAwAvWV3VhFif
         BYXWSkYKZbHxFiVzxQVCgFgGKRhrOoF30s/08TvbgwIYgVKGv/SudDDKqiN4DO6tsioC
         DqsnRhutIYWQ95PCdtmB799cdRugrBzcnA6e/Bd70/cbnLcQ1pkoy8EyQxK+hGI1q92O
         npyQ==
X-Gm-Message-State: AA+aEWZM39Gin8E33KOC0YycY1RywHRMe6xbFInILIMHHlhj9aV7veqA
        Q7fCPra61NVgw3Sq60rcNkp4E7wVwUo=
X-Google-Smtp-Source: AFSGD/X5RbwLE/T2ntzN5J0n477AQ2vHzutI/TqD+a6+5jFIxpNt4jMJ/kCO/5YJW3vVglprrSY+fA==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr3582099plg.222.1542806889758;
        Wed, 21 Nov 2018 05:28:09 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a73-v6sm55882401pfj.38.2018.11.21.05.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 05:28:09 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] Input: sparcspkr add of_node_put()
Date:   Wed, 21 Nov 2018 08:28:06 -0500
Message-Id: <20181121132806.22521-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/input/misc/sparcspkr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 4a5afc7fe96e..dc121fbbd3e1 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -205,11 +205,11 @@ static int bbc_beep_probe(struct platform_device *op)
 	info = &state->u.bbc;
 	info->clock_freq = of_getintprop_default(dp, "clock-frequency", 0);
 	if (!info->clock_freq)
-		goto out_free;
+		goto out_put_node;
 
 	info->regs = of_ioremap(&op->resource[0], 0, 6, "bbc beep");
 	if (!info->regs)
-		goto out_free;
+		goto out_put_node;
 
 	platform_set_drvdata(op, state);
 
@@ -217,11 +217,14 @@ static int bbc_beep_probe(struct platform_device *op)
 	if (err)
 		goto out_clear_drvdata;
 
+	of_node_put(dp);
+
 	return 0;
 
 out_clear_drvdata:
 	of_iounmap(&op->resource[0], info->regs, 6);
-
+out_put_node:
+	of_node_put(dp);
 out_free:
 	kfree(state);
 out_err:
-- 
2.17.0

