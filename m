Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34EC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 01:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CC42082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 01:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwzapc/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CC42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKBKfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 06:35:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52360 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKBKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 06:35:15 -0400
Received: by mail-it1-f193.google.com with SMTP id r5-v6so1222406ith.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aO5vHvhTG/aLis6+ZNOaUGchBgAYgFfC4RA9Ck5wplA=;
        b=Zwzapc/pkau8zVNT8LoMhD9+r6YYBJf+IewEygJYj95OHxNDCaAX0V0UJt9biyAq80
         aPqjXW57/+fFTbzRXz3ZJ3xRCg4sBKXvxMlK/Q9sbdX5dX3guvgiEsJ8CXirF6c2tn6a
         33gg0BsTzux6ReJLO5sTO0u/XVT0dWIaufaD2FgeOfBdrOzlK4Sw6K322A0GgmNa6hDw
         rTS0M9IxgRkMp8m+aHC1PQlr1Cj9dhwCXvV/U8qEPcQFHct1AAliuAwbsm573Meh8i4N
         ejwjJBQO9eUXhvQ/4IC7Ph9+rxQibIKR5psdh4DmtPAq3zRIG9PkokUZP7beYfwcf9GU
         O0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aO5vHvhTG/aLis6+ZNOaUGchBgAYgFfC4RA9Ck5wplA=;
        b=aw4pIqAdHp0o4/bxv3+R/hb2YrtmewuBl1SxA4bJgiS0Cyk2yGh5T5PCrgmtq6bfjZ
         PPPaW9lJcPmtRyx8MnZARR+c5wjUN4gyI5q3cRVOjVBjzbJ2EFoIZ9QuvwN24LV/adDO
         Wf3yIPaj2Nzr9CFb/D+tdd9w/18eJFJbwXO+kY1FP1eBZ2Y4vHnzHAridsB//sSsKzk6
         RUxCraWFJ0jZwZsyMUFMLeIOwPhVKW3vlCNSWtSbh/DlieZomkCxMjaTAoN9U/7wa2et
         ckYS5eY9gL5POBCwDnMoCuOY33zIAAzcpmFRV6433TsNkM8fMG4S3Pfxjoq1Sr9QT3De
         tOaQ==
X-Gm-Message-State: AGRZ1gKpHJxOZGp7KQfLcPfAXR9HyHAkMZOyO8mwdz56r+gEP9CUqrUg
        ovUfxQAvY23wMV8qZvS/5l7hdQG4fsJR2e6abw4=
X-Google-Smtp-Source: AJdET5dAp6HrM0J+jVT9OaV5peXGtiXJrQ+PO8DBibIYVZ+DzjAT1zoVSzq0GujGSTVd1BaeUlt81ugJk3oL8OklPHc=
X-Received: by 2002:a24:d086:: with SMTP id m128-v6mr7750740itg.13.1541122195015;
 Thu, 01 Nov 2018 18:29:55 -0700 (PDT)
MIME-Version: 1.0
From:   sh liu <liush.damon@gmail.com>
Date:   Fri, 2 Nov 2018 09:30:06 +0800
Message-ID: <CADnCVLz__D9n+UpFLChVcZkjmFZxKZacCCgufRx8y0_03OGgSg@mail.gmail.com>
Subject: [PATCH] ASoC: wm8996: fix small typo
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From e9b923690675ca8fa883fd25dcead5b457856735 Mon Sep 17 00:00:00 2001
From: liush <liush@allwinnertech.com>
Date: Fri, 2 Nov 2018 08:57:00 +0800
Subject: [PATCH] ASoC: wm8996: fix small typo

atleast -> at least

Change-Id: Icc970b438166daef13518b7d1a62b13eb8752f5f
Signed-off-by: liush <liush@allwinnertech.com>
---
 sound/soc/codecs/wm8996.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8affa49..d039835 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2109,7 +2109,7 @@ static int wm8996_set_fll(struct snd_soc_codec
*codec, int fll_id, int source,
  if (i2c->irq)
  timeout *= 10;
  else
- /* ensure timeout of atleast 1 jiffies */
+ /* ensure timeout of at least 1 jiffies */
  timeout = timeout/2 ? : 1;

  for (retry = 0; retry < 10; retry++) {
-- 
1.9.1
