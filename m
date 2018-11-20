Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6695A208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNfhIH+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6695A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeKTLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:47:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45725 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTLrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:47:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so141845lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 17:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN9VS2wIP8DJV3oeVtTodbAD4F5Sm+dglwNI3bYTmRw=;
        b=NNfhIH+EAZ2t3oTTI3oe9B5KjuTK18DiX/yCskGOICYT2lc/XGxUR+rblDFlBPFYx4
         uDGYjNHSKd42a++9Nx0S2yossEZbBamLsQABeuNznZEmpAIVkYwM/q0AkRapCup0ZOew
         DNIfSGfRXI6Wbj2IIBsCcWdH39JlOrgIv6Aw0XHCYBXijIykOP1XP6wu49GxNvZ1RKgU
         EXyXhM05I+LNak6TxHO99iQ38B1tkm9GdNn9t3M2Re+TZTw/MN+ml0rlRDs6ZPY3HZn7
         nr0vZ7HyBXFRQxEKvfpj3NaoO/89Y0Q8CLZjgJOBmu9VWPTxoBdxUdAiY6apfappjkJe
         p4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xN9VS2wIP8DJV3oeVtTodbAD4F5Sm+dglwNI3bYTmRw=;
        b=pf3ZP8IGWNM9wVERJ+Oy1KlExpPdTvwZp8qqU3iVZ2CNZnS00Yk2fje3bb+iKaWH4w
         FRhp2Ah8UwkG54Kl3/PmjdCyBKF5UzRcBC6ylzESK0X9hGx1FOy5Wt7fyiN//aleesqJ
         9rrWWL/TNEzba1jdyJ+0uq/zV0rjpyCIG/3iGXo8jjlDmR82UcWbDWxGR46NrdXvlOaA
         nLvfU0RjsnvoYfH8goDTdBMIxOa7IrEV1icUPHOtilnpLFA/9Wbo2l+RjNbW6EUvme9M
         UNVuwTvtt06iVRrIod7PGIO28yKIqhXPwjiEGh+TR6p7oJK5SIeC4WvoStpRlpBhwTP6
         Tqug==
X-Gm-Message-State: AGRZ1gK8OOGsk1sEBFVn+7lnBLhO7Mj07G0vs1xf1Yr6iYnFYoH0LJcy
        MzPPmSasWdu7Z/7I7ZNkWCY=
X-Google-Smtp-Source: AJdET5cNjFzysZG0gAZIUS5eZE/4CysWPq43BYHzlUJjqpEF+treCxZWx5l3FNFTKWyWx5X3zhU3Ew==
X-Received: by 2002:a19:d912:: with SMTP id q18mr19686lfg.24.1542676874944;
        Mon, 19 Nov 2018 17:21:14 -0800 (PST)
Received: from localhost.localdomain (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.gmail.com with ESMTPSA id t144sm5625568lff.53.2018.11.19.17.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 17:21:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] regulator: core: Export regulator_lock and regulator_unlock
Date:   Tue, 20 Nov 2018 04:20:19 +0300
Message-Id: <20181120012019.23112-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes compiling regulator drivers that use these function when
these drivers are built as kernel modules.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7bb5bc16babf..00d2af032509 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -211,6 +211,7 @@ void regulator_lock(struct regulator_dev *rdev)
 {
 	regulator_lock_nested(rdev, NULL);
 }
+EXPORT_SYMBOL_GPL(regulator_lock);
 
 /**
  * regulator_unlock - unlock a single regulator
@@ -232,6 +233,7 @@ void regulator_unlock(struct regulator_dev *rdev)
 
 	mutex_unlock(&regulator_nesting_mutex);
 }
+EXPORT_SYMBOL_GPL(regulator_unlock);
 
 static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 {
-- 
2.19.1

