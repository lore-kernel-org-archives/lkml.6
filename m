Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F05313F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3EE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHcDPxi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3EE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeG3Pe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:34:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46574 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeG3Pe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:34:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so7303668pgv.13;
        Mon, 30 Jul 2018 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dBiCWXblctIr3vvyM+Skj+Lv6yBR00qTBG4Bud6S7Bk=;
        b=YHcDPxi7ZzvCeoYbhbi0xhpKITv3aQhStS2eDLRRm8HWaAFjZxSO6seqXgOxf7K+dS
         Mh2T2J0Qwo2RL6XON5uQccpV1eUb7vXGMOMp+ttBCPQ+k2poPEItaJ2U7doDRYGtw7te
         1CRIoQnE61G0hIDb40jvMoVw/5jpxpeAG4lnyzu3pbzGoswM3rlrJOFCyRkwHjnY+PTx
         0WbHpxcj4gt/rA0CHDmXn07/rijL3aWLs67Mr8xyo//6FcUDk2Qb4XGJauzMACCxF2tb
         k5P6GP70dkNiJ3durrP65YnWgcCEeIdkU+i4EqQ9uW9HSUs5MyMn5j7UqdaujREZ/xcK
         Ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dBiCWXblctIr3vvyM+Skj+Lv6yBR00qTBG4Bud6S7Bk=;
        b=depOdyvk+plEgB3Bq4oobWNzj71LRyN9Q74XqfXHQNvcB/xVH3xUeyNDvUGkOCm+Wv
         fatNMESvOGMQx7aGcnXlcj2mdieDhKvvsCFaJMH4SmZAFH3eam7tsCB05+z2KN5qw9uv
         YeO70OgbSxAy3+CSVC9qH2vuswVBf8fypWHRTkwejXLhadL9mEEfkyq2pGm5y5vfICdI
         lPFh31ELdikOL/zz6Wiw5/Yh9wirQtRM8GKweMVQiL+azXM9YztdXdA5SzLdRyyv2mCP
         RXW1ctAfvuRmbGjNIVxPGSzEsZO3voSl9QVgGVOX1sFGHgFpcMuf2bW5GUt5xTfNmfCM
         Fogw==
X-Gm-Message-State: AOUpUlE5pW3Um4SlUrLDQMrRatUkcICX7/3c+Fh2BPBhB2L7D4YtffXe
        +IcglNqDmfK4B7kkbw9FBO8=
X-Google-Smtp-Source: AAOMgpfjUlP3m9XJeip14eRnK6TLPn1JsDiYPpLpTfUhx/CGe0MK5fwyJiXpX4orN/9aFebLhUSSzw==
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr16280702pgu.96.1532959190454;
        Mon, 30 Jul 2018 06:59:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id n12-v6sm32934094pfh.146.2018.07.30.06.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:59:49 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] rtc: rtc-mrst: Replace mdelay() with msleep() in mrst_read_time()
Date:   Mon, 30 Jul 2018 21:59:03 +0800
Message-Id: <20180730135903.9442-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mrst_read_time() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/rtc/rtc-mrst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index fcb9de5218b2..e4015f70f9fe 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -91,7 +91,7 @@ static int mrst_read_time(struct device *dev, struct rtc_time *time)
 	unsigned long flags;
 
 	if (vrtc_is_updating())
-		mdelay(20);
+		msleep(20);
 
 	spin_lock_irqsave(&rtc_lock, flags);
 	time->tm_sec = vrtc_cmos_read(RTC_SECONDS);
-- 
2.17.0

