Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E5C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13A220685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH7Ils5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13A220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeI3JfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:10 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:39852 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeI3JfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:10 -0400
Received: by mail-qt1-f170.google.com with SMTP id c25-v6so10696477qtp.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iuVbUwN5tgca2jN9Sh9mwDBhfTUUx2rPrVIz/oRxHwI=;
        b=CH7Ils5B4wv7PVGwr9MeujWF5tCwJx4eVgTlCFcYbDi7sTW0YOTv+BUxIOcy8N3pny
         44SgB3PmZAFlWsZobOhTluDqydTEWTmDwBjqxVu+2tPWYOUmjdIDgFfmqNZm8dRvCasq
         gxk0aGBCV1tE5sY01oW2YPx4/eJqJgroS1Vosoiw6WEmrzmnQUAFLGYljzJ1NLGkixGu
         HQFwf8f4fsC6jV+3rwq9a70gT8YdNjhVDCSpW/hHrDJ4O0QfM1FLrcFjsw0Ey35R8Raf
         rsqA2HY4fwAv8ogsWH3ujSSgM1xnmPXK03yeVdR0NjZ3dIilehT5ZlthJ++J5y99H/Tz
         EK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iuVbUwN5tgca2jN9Sh9mwDBhfTUUx2rPrVIz/oRxHwI=;
        b=RYuiF02ZkVfd16i4AGZdt8tpxXntIEYjowg0uDz4bgKa4ylZxPzQJG2BkuNqJ7ujEd
         H2rG2ub6Gc21SjOdITy5hbeA+bxvhBP/DLhfbjOghEJswDZn56LHKscC1B0zxXehJPpi
         Jb3+fMEvRYzUeNr7C/sXt9wNd4zC4Oa9v4DTBd2ZyvCWLB+5cWHg7+lrM5EegpRVrNBs
         wxc3jMop00Qz+fa9MnvnPB0MExpB1qP8yvsgO2xJu5Uq1wV+2Lv/5S2Oj5V2NRVktp6P
         be8qxSDreRpAMNJlodOuzkYy8lZnkDjZUiExZxFzcAz68jatuPycqmx+GZqJRJfnSLK+
         5F5w==
X-Gm-Message-State: ABuFfogRU3WxyJhIqO+oBIbv/K3epAw9BI2Q+MZl5dnRV06GAX9xRyEv
        jQX09uurUUqhkzpLU36ltXgqfU/X
X-Google-Smtp-Source: ACcGV63YntKevbG0jpzu/6KQIkDjzeMN2N+poDdsAjZWxbneDokH8Np0W/sYTh3Y8iQxRPhl+iQ9Bg==
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr4206894qtc.50.1538276643165;
        Sat, 29 Sep 2018 20:04:03 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:02 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Add ZxR support + bugfixes
Date:   Sat, 29 Sep 2018 23:03:15 -0400
Message-Id: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Sound Blaster ZxR, as well as a
few bug fixes. This should be the last ca0132 based Creative card that
needed support to be added.

Also, I did check to make sure each patch compiles properly this time,
but you can check yourself just to be sure. :)

Connor McAdams (11):
  ALSA: hda/ca0132 - Fix AE-5 control type
  ALSA: hda/ca0132 - Fix surround sound with output effects
  ALSA: hda/ca0132 - Add ZxR quirks + new quirk check function
  ALSA: hda/ca0132 - Add ZxR pincfg
  ALSA: hda/ca0132 - Add DBpro hda_codec_ops
  ALSA: hda/ca0132 - Add ZxR init commands
  ALSA: hda/ca0132 - Add ZxR DSP post-download commands
  ALSA: hda/ca0132 - Add ZxR input/output select commands
  ALSA: hda/ca0132 - Remove input select enum for ZxR
  ALSA: hda/ca0132 - Add ZxR 600 ohm gain control
  ALSA: hda/ca0132 - Add ZxR exit commands

 sound/pci/hda/patch_ca0132.c | 369 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 345 insertions(+), 24 deletions(-)

-- 
2.7.4

