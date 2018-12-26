Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E8F2190C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLHR69tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeLZQyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:54:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39876 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeLZQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:54:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so8044979pfc.6;
        Wed, 26 Dec 2018 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Yn9bPTbkLifv5D8U//ZYbgNmgR5ZNAfBYCx0gbDmrY=;
        b=bLHR69tUAWUgHb8yYnsHqs7B5kY+NKEYmwgAnE5U8uozwRRGYJ90npIj0fbI1eI4pA
         ynGdhm8j6UFZnMbDKbZ2tM0yfFoEgB4TockPob524nocOE6rvjY2jTVwXQGum4TMSsLG
         gk4e/TMB6UHwmW82Efj2XmdtwtET99aVA3ldbfXy8Whw8XRJJGzIunJ7loromIaD8rqj
         MyEwGfepamgFEsrr2JELnRA459nRfQKOaGa38CUVTXEVF6ZaVx36xX/OvdntdxlGjHMG
         fGQxsCOkPBwoAcUvuU7TEeQMzmLy+hHDCnnYEYuAWYCGNuh4+hRM1lOJ2ET76aLn/g3k
         82ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Yn9bPTbkLifv5D8U//ZYbgNmgR5ZNAfBYCx0gbDmrY=;
        b=cK4/RewJNjtJu2BOPLK9eycw1rODAiYMwt2Xdmc2tEwXkEW7Zw1s91N6657DAh0Vbu
         ctDfKT1ItQlbM1BQdeLePnWNHdJ7JsqOmQ/GSFhhAUmQleCJxJEnl81Do+SjGNCrpLIt
         a8yJdOkDNphmufxFVHxeuGRjkD9tef7QC1Tw3Xh0Iz4LImGIzk2OlApfMBR/58SAzYSW
         4uTcJSgmGHE6XRGww/uvuztPonC2y63tv0kIyjd7Y+C0zxl/G6hFjNcsBgJy7bTosO9s
         MIadNEBQG0VppetrAW9FPV5eKqH6iszpBpS1QSN7pJhvaa1ZsS/kuC3KJ1PEdsZdV/8k
         SdvQ==
X-Gm-Message-State: AJcUukdoSv7eOiCk72kCfeB4NEH1ndZkyqS3yw7kVFBgcrMujlmUrAYX
        zUHvOU6DgtRk74JxZrQGdVA=
X-Google-Smtp-Source: ALg8bN7wHjGwCr/m7szjSktL4QiAoznM6+49LBVF/rc3fla/WLRmVv2urS3V0jvtaYl3xgFnvcAnoQ==
X-Received: by 2002:a63:585c:: with SMTP id i28mr19743118pgm.178.1545843240333;
        Wed, 26 Dec 2018 08:54:00 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id j6sm57897980pfg.126.2018.12.26.08.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 08:53:59 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] power: supply: remove some duplicated includes
Date:   Wed, 26 Dec 2018 11:53:57 -0500
Message-Id: <20181226165357.6426-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We include of.h twice. It's unnecessary,so
just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index e85361878450..529721660e68 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -156,8 +156,6 @@ static void power_supply_deferred_register_work(struct work_struct *work)
 }
 
 #ifdef CONFIG_OF
-#include <linux/of.h>
-
 static int __power_supply_populate_supplied_from(struct device *dev,
 						 void *data)
 {
-- 
2.17.0

