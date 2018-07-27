Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B34FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA45920891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZWEZ+Ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA45920891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbeG0KLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:11:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeG0KLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:11:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so1517645pfo.4;
        Fri, 27 Jul 2018 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6GIpNh2bgdb/KYxb9tHqH2uePhDL83X9iGZ1KtSBckI=;
        b=eZWEZ+FfMtmkmsTaQrrFL03RnKWneXAatS+rLfPxgE2Pmt+NiYXpLR5Myho3HLCbiA
         ExPeUEd0kZs4ecKir086FGgZqqEOOxq3VkHLhXzaM6b5y1ox298u9LZffK/DtBNrKda1
         u2Bc73qgcr1ABoOKxnuKRFo1UxtFeSwE+HOegGgm0dkm39xbkChXbTclrsTWFNNQcp/W
         FAA1It9feqxrsgMAG+nMpmqkw9vz4pfR7roZPRB3O9ZTwJTiOzsSXQ/odV5SPMAp/wKJ
         qf8trtxKmUvI95Iz/XczMEl3SIqbZw/oTodpufsjuB0y96M4OcoRpvVlI5gDVNf7NWvc
         J1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6GIpNh2bgdb/KYxb9tHqH2uePhDL83X9iGZ1KtSBckI=;
        b=uKxrMOHIRc0XnfObwHw0pkyRzZ9vv7VIvuaj+pp6TbdfzBWg54g8WiuB0t0IpagxwO
         NPB/vOXrBsbKDTwJGp1d+QClK9fHOxu6pgMEpGhc6yL9ezF6SKH8AVpIkakLaS81/sKZ
         fyDxcqvNaZz+y61umHvD6WpNAS2XacxWJAm8WKSGuH2X5VxSHmjS5TlaHXVJignLBq1l
         TqMTpxjeRbXJr/57f9znIazrD4nT4+3+Pn4zRKS0GMM5uB/puRgU2yjEZj/+tHfS2dgV
         uJLdOHJ6tN6CoMZLBGE9dOgDPb6Hoa4DgMzgEib3cu6/959L1V6jbEWeaCk1gj6A8Kjs
         UgBQ==
X-Gm-Message-State: AOUpUlGFtI27gNElB7SXtXTxt7BKFx4CTXdaylj6nJ5E9yTutrr45Ll/
        uCWG6cKRCD9nAyKCT/DP9tE=
X-Google-Smtp-Source: AAOMgpdDisc8qNjl8baKF0ZSEV5ffoZycssS/5rmAVOxen5+EmYhmeKc3KWLIlZjywh/ucSQf1OVVA==
X-Received: by 2002:a63:f449:: with SMTP id p9-v6mr5327193pgk.213.1532681451424;
        Fri, 27 Jul 2018 01:50:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id c88-v6sm6041924pfe.132.2018.07.27.01.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:50:50 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: wireless: realtek: rtl8225se: Replace mdelay() with msleep() in rtl8225se_rf_init
Date:   Fri, 27 Jul 2018 16:50:45 +0800
Message-Id: <20180727085045.3949-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl8225se_rf_init() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().
This patch only replaces the mdelay() that has >20ms time to wait.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225se.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225se.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225se.c
index fde89866fa8d..51e32df6120b 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225se.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8225se.c
@@ -363,7 +363,7 @@ void rtl8225se_rf_init(struct ieee80211_hw *dev)
 	rtl8187se_rf_writereg(dev, 0x00, 0x0037); mdelay(11);
 	rtl8187se_rf_writereg(dev, 0x04, 0x0160); mdelay(11);
 	rtl8187se_rf_writereg(dev, 0x07, 0x0080); mdelay(11);
-	rtl8187se_rf_writereg(dev, 0x02, 0x088D); mdelay(221);
+	rtl8187se_rf_writereg(dev, 0x02, 0x088D); msleep(221);
 	rtl8187se_rf_writereg(dev, 0x00, 0x0137); mdelay(11);
 	rtl8187se_rf_writereg(dev, 0x07, 0x0000); mdelay(1);
 	rtl8187se_rf_writereg(dev, 0x07, 0x0180); mdelay(1);
@@ -386,7 +386,7 @@ void rtl8225se_rf_init(struct ieee80211_hw *dev)
 	rtl8187se_rf_writereg(dev, 0x00, 0x00BF); mdelay(1);
 	rtl8187se_rf_writereg(dev, 0x0D, 0x08DF); mdelay(1);
 	rtl8187se_rf_writereg(dev, 0x02, 0x004D); mdelay(1);
-	rtl8187se_rf_writereg(dev, 0x04, 0x0975); mdelay(31);
+	rtl8187se_rf_writereg(dev, 0x04, 0x0975); msleep(31);
 	rtl8187se_rf_writereg(dev, 0x00, 0x0197); mdelay(1);
 	rtl8187se_rf_writereg(dev, 0x05, 0x05AB); mdelay(1);
 
-- 
2.17.0

