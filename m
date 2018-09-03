Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD34C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DD820856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkY7GaVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DD820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeICOVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50566 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeICOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so564080wmc.0;
        Mon, 03 Sep 2018 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfuzh9T+CpyAPnemdnqeg4728XIZ30noV5zNc4YBbSs=;
        b=dkY7GaVzP2wLdFWCwyAMlswzjqggspJYq8VFG7wQe9/IZAXX6xJqJKxB783tYp23mG
         hhrySEyAMj/TN6r9QQGrQY2JhGI1vt/BEKEl3tLe/UQjfuzy9GhfLlZCMmDvURdr9zY5
         yTDgyt/3Gov6fU4iL/zfEE6ntECK1PkvNmryp5djRcGbGcxOXxYVyoFD4J4hNk+a+ODb
         RdNHA6zniX6ngL7ElgrsP9Qb7xNWzoSXu+Zbzb08lESQ7ptWki58I/YZiG2jeH2S80G5
         HJKyNyJd9F3fUXAkyR7w/snERMA1yAZShXQi0E2JyNilVXqEWYNmzaEdufWSlVSivwSZ
         8C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfuzh9T+CpyAPnemdnqeg4728XIZ30noV5zNc4YBbSs=;
        b=OQSz/IBfOqs1HnU01j6vezhFQp3H7YW4Ptl2ppkFSIDklJ92QgqzU+uxijGcI/PPNJ
         btzzIiaBrGqpWyntIp9o6FecRnueGouq84XR99acyTi4dCtRpEqH/Nb5YZEoZ+TkAfcj
         faOWynZtuGLoRcFSBVn2U2yfr8g1jxVT2Jcc82dtlL6INnwaJ431UWS5RZzBS9VdQTsh
         smqAj05HF0vdjKg+0y5F9+8k9F+pU8HPdfd2eJnmgx3HRto5TYrarv69wVoLL0gne0ik
         DoDlhlDfpzOPT6adN/kD9+UmQ240rn5VnrjzeoN6sfkl20rxi4AdJ90yqA575aQ3upPB
         Qu0Q==
X-Gm-Message-State: APzg51DOHfVlhdkeN5DJ8rR4O25c4wrnbYrwVt4HEvpueBOPIPQw/Bnf
        Qz+9JdGBkrfhGVMi+YYd83Y=
X-Google-Smtp-Source: ANB0VdZpQGuSBITo3ceVBcWUmYxP6UpkNxPjKYVo2cynUaeXk/8PYnZXGOxJoI86W7paaHTYauwDxA==
X-Received: by 2002:a1c:b441:: with SMTP id d62-v6mr4695405wmf.17.1535968934457;
        Mon, 03 Sep 2018 03:02:14 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:13 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 6/9] ata: ahci_sunxi: add support for r40
Date:   Mon,  3 Sep 2018 12:01:58 +0200
Message-Id: <20180903100201.23131-7-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the r40 compatible to the ahci_sunxi's supported list of
compatible.

Since R40 need ahci_platform to handle the reset controller, we also add
the new AHCI_PLATFORM_GET_RESETS flag for ahci_platform_get_resources().
This has no consequence for older platform (a10, a20) since the reset is
optional.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci_sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 631610b72aa5..911710643305 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -181,7 +181,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
+	hpriv = ahci_platform_get_resources(pdev, AHCI_PLATFORM_GET_RESETS);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
@@ -250,6 +250,7 @@ static SIMPLE_DEV_PM_OPS(ahci_sunxi_pm_ops, ahci_platform_suspend,
 
 static const struct of_device_id ahci_sunxi_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-ahci", },
+	{ .compatible = "allwinner,sun8i-r40-ahci", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_sunxi_of_match);
-- 
2.16.4

