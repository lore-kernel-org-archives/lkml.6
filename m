Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69791C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112422087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNcKsALB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112422087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeI3EOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:14:17 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43467 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeI3EOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:14:17 -0400
Received: by mail-pg1-f170.google.com with SMTP id q19-v6so6839144pgn.10;
        Sat, 29 Sep 2018 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wpdLpvSnoV0Xpf/xkkyor+XRM8b4TVTsRWjsZxJaw/4=;
        b=RNcKsALBOJVZQ99LHXPBrIFsLU3gY4D98ijZnnzrfbGCCiFQW/w67TTwA5WERjXIxp
         24I7Ij7CzdiTZLr0z4NCCjJ94R6IMOHe0evEEHqe6bgp6mYqhagNOhZNtVlrrUFc0Ptp
         OLa69e5k6jDKeJky0A0GTGsJDJ2/AGQOtucPilRDmNvWNjCoMUAJ2b47v6rAbytvNHtC
         hVx2i9ECll9WnVupUf6LdOnA3vfzWfSZirqCqiMIfrjk2O/M8O1uTTM3i0BFktHiB2X0
         v0LbioQaK3nF9gGXvZvakSwXcf5pd6RDNrLctZS8Wv7kbKwta2BHVyJozMqqcPo4GrHa
         RW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wpdLpvSnoV0Xpf/xkkyor+XRM8b4TVTsRWjsZxJaw/4=;
        b=UTazixLuDf/1VhBz5dXgpVCdFnAXmo7WoAui8iAxZag6+V8hGzxoMh+eJSvQ2MZDRu
         L5DLorRQx5KBw4TyL/E4kDfKG2aLmc90KczpQ5C5Og3fjzE4M3X3JuRRXPI/OuqGqw25
         opAPQwjzmTKID2U5ECqfJbbD8AFD10NNTVKaOHtdAh+Q0Todu95E4Y2rm8LMnjYJOFoX
         VGJ19gHwQcSGuowCgEjBUmsj056F5xkjFelwyoX6+nBXSHvDErTQxTxQpV7mhuI/GfSt
         pbQgu3PjRa9J8H6p5aEQQf3Etdu79M1+rkIkD+2gF6+gVwdbQBNy+IjFwPxjUEeghuPc
         AkkA==
X-Gm-Message-State: ABuFfogrVP15jYXlIiC/8/jvmYaoueDRX3Lh040yinO2o9fPDpcbqNQT
        l9nVckQlGCTTkR6gX5u2kwY=
X-Google-Smtp-Source: ACcGV62CgTeGxLW1tc07N5zoTiUpsJCHIurjMvuzb5wFWOgw49M2L473RxVLk8GBSKqndiDYO5GfDA==
X-Received: by 2002:a17:902:b182:: with SMTP id s2-v6mr4795763plr.84.1538257454376;
        Sat, 29 Sep 2018 14:44:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o20-v6sm17780313pfj.35.2018.09.29.14.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 14:44:13 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add suspend and resume functions
Date:   Sat, 29 Sep 2018 14:44:04 -0700
Message-Id: <20180929214407.27208-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add system suspend and resume functiosn for
ina3221 hwmon driver. To do so, it also needs two small fixes.

Changelog
v1->v2:
 * Added PATCH-2 to fix macros
 * Added power-down setting during suspend in PATCH-3

Nicolin Chen (3):
  hwmon: ina3221: Add INA3221_CONFIG to volatile_table
  hwmon: ina3221: Fix INA3221_CONFIG_MODE macros
  hwmon: ina3221: Add suspend and resume functions

 drivers/hwmon/ina3221.c | 71 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

-- 
2.17.1

