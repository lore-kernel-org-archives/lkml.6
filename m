Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F0BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747D520857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnr/Mehj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747D520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeG0E60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:58:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeG0E60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:58:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so2395293pgv.3;
        Thu, 26 Jul 2018 20:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DHAPU5UIhScx9JZon8uYOagBreRNQYhap7VuA//AZ3w=;
        b=Hnr/MehjghF5S1oQ9OnvZBMzVlBsqJmgEdw+MewcnVFVyi5UTtsZ6RLE4SFJ4vwbfT
         2jx1iR9P3fjaY839F4k4x8aeu9WJLRd1EcAlHWaQL/NLWwuV1sWsVbQGBeT003Thn8ay
         8Fci2bweL0TBJW854YWibG4rjmrjEfgkc0ZvHfszyeh2eb4ZZFXhmGlASBViVSEcals5
         KSsNMbCNgC5OrvZPwiPGz99Cd0AjCwaHrnnWuCYcsUn3Ax3ggA0UHJBsx1LVaM0Q3lkN
         nSWglILxDE2B7fywIVbB8TZUurm68aCTb96Ey5dkvQNX+XE0Lfp/7WYBw/JfM4H9B8Um
         KkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DHAPU5UIhScx9JZon8uYOagBreRNQYhap7VuA//AZ3w=;
        b=a/6jA1Sot6DjV9OIZtGbvZFjoTeTlSPltSXYmQPd52IWz+jz6fe0YBxPXKGAHHho6e
         dAAUJTKleB9MtiWsn2vT5TH06WdwGP7WrD64NYSx0U6bGVCsjFP5hhpd5ab+kEhRjRhd
         HIduLlC1iWeDbUOQs4Lg5E4I3yVUzafn83g6oKtcqWiWaVre7o9Xd+dl9Ppu69OOFrPe
         IkXuY7ztSgUajHRRZKk2jYDhXkwgoe8Hr0LSeJRlQdhA+MBnElQw+gozDW2TDRI1R4cq
         GZw8C6x3ml++JD2Db8mhGrLLgebrG/BKiQOdFT8SF4QQjsdhw790tCwJB5a8twtpygPd
         +1mQ==
X-Gm-Message-State: AOUpUlGeSM5Q5Lif76yWZj1/vB1W/TtFWi1yINTIFTt76oxG3Z9BwNGC
        BbufHPEj3TWQsKpRbN/S+fw87l4H
X-Google-Smtp-Source: AAOMgpdFRvm5fxwfRcLIfzNE9OqyDVGmtmafTKC9duywOG5iel4VKLne3wFBhtiqqfFgDd036usI+g==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr4309697pgp.200.1532662717591;
        Thu, 26 Jul 2018 20:38:37 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id l185-v6sm3949429pga.65.2018.07.26.20.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:38:37 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] media: pci: cx88: Replace mdelay() with msleep() in cx88_card_setup_pre_i2c()
Date:   Fri, 27 Jul 2018 11:38:23 +0800
Message-Id: <20180727033823.4148-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cx88_card_setup_pre_i2c() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cx88/cx88-cards.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-cards.c b/drivers/media/pci/cx88/cx88-cards.c
index 4c92d2388c26..07e1483e987d 100644
--- a/drivers/media/pci/cx88/cx88-cards.c
+++ b/drivers/media/pci/cx88/cx88-cards.c
@@ -3307,9 +3307,9 @@ static void cx88_card_setup_pre_i2c(struct cx88_core *core)
 	case CX88_BOARD_PROLINK_PV_GLOBAL_XTREME:
 	case CX88_BOARD_PROLINK_PV_8000GT:
 		cx_write(MO_GP2_IO, 0xcf7);
-		mdelay(50);
+		msleep(50);
 		cx_write(MO_GP2_IO, 0xef5);
-		mdelay(50);
+		msleep(50);
 		cx_write(MO_GP2_IO, 0xcf7);
 		usleep_range(10000, 20000);
 		break;
-- 
2.17.0

