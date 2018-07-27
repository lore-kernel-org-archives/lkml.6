Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B4C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E502020857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRvtAJ/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E502020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeG0FBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:01:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40905 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeG0FBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:01:46 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so1716169plp.7;
        Thu, 26 Jul 2018 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tpTJPg5QWaipjTJYMVBmNVQXCw0qelx4b/0mN4xIPGo=;
        b=qRvtAJ/uYnWzRSCk6inyX/P8aZWs7w2HryZrG7XlP3Ywddj3sf5WuQICfBV+MUbG8h
         sX6dqKRn5PacfOzCqhWfmAsaAfvnVR29eJLXoEOg5ywJPtbIZi609ym+hm//bYkKrj8s
         aVXILvzsrLKWwMJVkXsvuxDi3yyda8F5zF0v1g+lN++P1Ylu2sTjMpRWRmmZQT0Mt/48
         0msuUMglIzLyyUM6UjAMqnh+Ob8xtHZSbb8QerzXxjh/Hy3GrowyP3AnDpZzZM4Vf7rN
         fat3j0zJkZQSgfmAhj8r/SMqDI81/kjOW7rpBQWJmxRZxJgd6qp3GdlkmBP4TpxAnnzl
         VZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tpTJPg5QWaipjTJYMVBmNVQXCw0qelx4b/0mN4xIPGo=;
        b=EZz61HGBRhp8Hc5MjZ8Zmww8hQ3qhAbFxCDqYfjSSDdLVVMnnEavkdrAuFxf5On/W/
         di1Ixxf7YqoR40LWC8gmm01vaTswcaPG7yX7PbIniV06/zM/Esw09ygOQWANfhA0fgCS
         Z3zrvI+ubyNCDWxuMc7cqB+u4TorM7d5Xxl1GUx5aMrzCtjwK8ZDb/ZE+r27wP4I7ADf
         t3eKI19rBWudBEFX5kM+Fn+M0Bqmwz9vJzBikh5P66bQLyReThYvU1dJ8BgQ7aNcTxui
         I876+DyrbmNvvbT2liGTzOi4lSmyz6pRL87K7NpludE72W4nPij4jqMljNHprwCaE2RR
         Nhrw==
X-Gm-Message-State: AOUpUlHaB9VZKFCUxdf/d6ScZNigt/1XEUydijHb3M98BHaa7UeRKNnQ
        CbR9KcyebZSpULBv/ZbDyKKEgzc9
X-Google-Smtp-Source: AAOMgpcIdaz2ie+6nsbZSWJj73+v+HTLVRNE/855zt8cJZt8hUhhj1C4msdEsVzIP5u4fOaFfYl10A==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7-v6mr4389445plr.215.1532662916484;
        Thu, 26 Jul 2018 20:41:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id d132-v6sm3681147pga.10.2018.07.26.20.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:41:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] media: pci: cx88: Replace mdelay() with msleep() in dvb_register()
Date:   Fri, 27 Jul 2018 11:41:50 +0800
Message-Id: <20180727034150.4259-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dvb_register() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cx88/cx88-dvb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-dvb.c b/drivers/media/pci/cx88/cx88-dvb.c
index 2f886140dd2e..f350adc94cb8 100644
--- a/drivers/media/pci/cx88/cx88-dvb.c
+++ b/drivers/media/pci/cx88/cx88-dvb.c
@@ -1229,9 +1229,9 @@ static int dvb_register(struct cx8802_dev *dev)
 
 		/* Do a hardware reset of chip before using it. */
 		cx_clear(MO_GP0_IO, 1);
-		mdelay(100);
+		msleep(100);
 		cx_set(MO_GP0_IO, 1);
-		mdelay(200);
+		msleep(200);
 
 		/* Select RF connector callback */
 		fusionhdtv_3_gold.pll_rf_set = lgdt330x_pll_rf_set;
@@ -1250,9 +1250,9 @@ static int dvb_register(struct cx8802_dev *dev)
 
 		/* Do a hardware reset of chip before using it. */
 		cx_clear(MO_GP0_IO, 1);
-		mdelay(100);
+		msleep(100);
 		cx_set(MO_GP0_IO, 9);
-		mdelay(200);
+		msleep(200);
 		fe0->dvb.frontend = dvb_attach(lgdt330x_attach,
 					       &fusionhdtv_3_gold,
 					       &core->i2c_adap);
@@ -1268,9 +1268,9 @@ static int dvb_register(struct cx8802_dev *dev)
 
 		/* Do a hardware reset of chip before using it. */
 		cx_clear(MO_GP0_IO, 1);
-		mdelay(100);
+		msleep(100);
 		cx_set(MO_GP0_IO, 1);
-		mdelay(200);
+		msleep(200);
 		fe0->dvb.frontend = dvb_attach(lgdt330x_attach,
 					       &fusionhdtv_5_gold,
 					       &core->i2c_adap);
@@ -1289,9 +1289,9 @@ static int dvb_register(struct cx8802_dev *dev)
 
 		/* Do a hardware reset of chip before using it. */
 		cx_clear(MO_GP0_IO, 1);
-		mdelay(100);
+		msleep(100);
 		cx_set(MO_GP0_IO, 1);
-		mdelay(200);
+		msleep(200);
 		fe0->dvb.frontend = dvb_attach(lgdt330x_attach,
 					       &pchdtv_hd5500,
 					       &core->i2c_adap);
@@ -1582,9 +1582,9 @@ static int dvb_register(struct cx8802_dev *dev)
 		cx_set(MO_GP0_IO, 0x0101);
 
 		cx_clear(MO_GP0_IO, 0x01);
-		mdelay(100);
+		msleep(100);
 		cx_set(MO_GP0_IO, 0x01);
-		mdelay(200);
+		msleep(200);
 
 		fe0->dvb.frontend = dvb_attach(stv0299_attach,
 					       &samsung_stv0299_config,
-- 
2.17.0

