Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D736C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0507920835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Px4pPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0507920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeIBRsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:48:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38638 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeIBRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:48:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so13390857ljc.5;
        Sun, 02 Sep 2018 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8tSy38qranaWqjwVNQ8q7Dd26GwbxqPMGy9qiXDSk4s=;
        b=D6Px4pPFZw7qnhG18/Ys4JOGIRni7T1PoSPfLq1+cAhbfV6QkKaZCFrEI+mz4nszWp
         l5FeQdT9dyjCyg2Sh5r27/MrCZZQTXYqygeUn6gFRcPfJ3RIrqG1siPQOnM6AO9J4RVg
         jrt6DvyxVO1aICAy+A1jE5igV0TKSrr5whTyRm/8XdlqSgmiZBy5pWvkfB3/182ebwj1
         17zXW/QQcDinpW7PvJzH3mD6wtW+td8yO+nmpiu+GodDQopp6sAsxAnTZoIB8IesvIa8
         gNQ2Vg1Y+IToc4jz8dgzGZWliR4nnGrKVQU0iEeXevMLYY7Hn34zHKl6YeeN4kBv9nKR
         bTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8tSy38qranaWqjwVNQ8q7Dd26GwbxqPMGy9qiXDSk4s=;
        b=bmndDIW19v3ZO/mvVzGaj/k4ZDma3CH5C+X1siBs6Mp3gnhk6LzYm9F3W+MKPii+gC
         MmkwxrZzpmLejW5fibgqwiBj+mRPiJ/7TpH0YvDF6NT88PuPHO+WWTrXw2swDRaC1Cf5
         ipkctWOsABu/sU5zgCVHoAilAmc7ZVRhNW1lVgMkovmVMjP5M6JQA73HcxNAMS1F1s1L
         9szTxZIyob2QaTKC3VDFoRvZq933RnqD7EVm/Sn0zgBsikkeFfM6xH8MpMmndB4tb1k5
         H2EVl981/UIv4UNYTy3gSYmmuoFGijBz6vjLDyKHoy51nSSZ6DwCfqzHsBf/q5ZkreAb
         TD/Q==
X-Gm-Message-State: APzg51Dn5eXCPPsXMMWN44OSkzO1mFnVBXBDieGUCnT1BkMMziWOkSps
        6NeXlYEaT+pGoViISpZbsNvz6ifI
X-Google-Smtp-Source: ANB0VdYeC9Pl6rrEOuUtUhccxvUbXftJj8XmCZFuyBvR8p6g3uXUfDoQBjpJepkiabaqV2C9nv81QA==
X-Received: by 2002:a2e:84c6:: with SMTP id q6-v6mr5972869ljh.65.1535895126497;
        Sun, 02 Sep 2018 06:32:06 -0700 (PDT)
Received: from localhost (89-70-31-6.dynamic.chello.pl. [89.70.31.6])
        by smtp.gmail.com with ESMTPSA id m31-v6sm2988233lfi.17.2018.09.02.06.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Sep 2018 06:32:06 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: bh1750: simplify setting PM ops
Date:   Sun,  2 Sep 2018 15:29:23 +0200
Message-Id: <20180902132923.13513-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relying on CONFIG_PM_SLEEP to set PM ops is not necessary
since core will handle everything internally. One have to only make sure
that functions that can go unused are marked with __maybe_unused.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/light/bh1750.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 493ca7420602..c3a481452b67 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -278,8 +278,7 @@ static int bh1750_remove(struct i2c_client *client)
 	return 0;
 }

-#ifdef CONFIG_PM_SLEEP
-static int bh1750_suspend(struct device *dev)
+static int __maybe_unused bh1750_suspend(struct device *dev)
 {
 	int ret;
 	struct bh1750_data *data =
@@ -297,10 +296,6 @@ static int bh1750_suspend(struct device *dev)
 }

 static SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
-#define BH1750_PM_OPS (&bh1750_pm_ops)
-#else
-#define BH1750_PM_OPS NULL
-#endif

 static const struct i2c_device_id bh1750_id[] = {
 	{ "bh1710", BH1710 },
@@ -315,7 +310,7 @@ MODULE_DEVICE_TABLE(i2c, bh1750_id);
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
-		.pm = BH1750_PM_OPS,
+		.pm = &bh1750_pm_ops,
 	},
 	.probe = bh1750_probe,
 	.remove = bh1750_remove,
--
2.18.0

