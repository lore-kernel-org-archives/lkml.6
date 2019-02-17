Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE52BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E91218AD
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0rC7sn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfBQQX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:23:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37640 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBQQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:23:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so7296948pfh.4;
        Sun, 17 Feb 2019 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=044zzjCw4ZN/dcuprZ5Plp3/agK0+JZyI0LI9BwuQXc=;
        b=c0rC7sn55G5pkWZWJ90fEg7dGJpW0wMX52kjSbOWwzWh2o3d6B9iGQWAiif26GAUjL
         h+/RiEzCtGAoI3dw24BNm9I+2ZeCu8lJcdyK3rAlJin3OQpQK4AqBXw31moHEJO+M53U
         R8QBdI93DxMusxpw1a5V8+4FZmrxRIEMq/0rqtibN4JLVtiuxFJ6/C6BcOj/D8mvlzmU
         waVGTbHLZTbsYtfYG33m+gHiCLDnUbWEL3sgni0wVOBY6bQSjPwk3L6rfOnE19LwBboH
         6/CR1CZ7KMkdTSWTkrasG6ELT/Pjv/uQlINfuTUJt4AiH/Q877SbB0Km23s8PQ1A2nLx
         2+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=044zzjCw4ZN/dcuprZ5Plp3/agK0+JZyI0LI9BwuQXc=;
        b=lD3iP/r0nIPTfvkiTWRHbQA7tTLL/uwGxmhs/S3RxFKwI217eQntH4P22CRVdlyFpD
         lCiCH0zVo5AnlmwqDr0SaBW+cSh0wsAgHIibGRkGL+gDeZ3Iii38wc0AjMf2Rm1OZoHw
         WmWzwsONHgmBjnxXAzntgg+CmMfOvlACJJL9pd1L4wii9FHGZdfOPLgAblOkV+ui6ztn
         4fn964AzDmlPK5v09K528gTMZyh5p8/ms/q91xZNTh+ylRuvCfZU1hg5KIFQPGJoWkHN
         RBKusZn9pjMx3GVN7VfNueLyMsypYeWHYHi5i0fe3qKS/FGNUEqeOsz2IbUNxjZ/xA3J
         /Ydg==
X-Gm-Message-State: AHQUAuafQUlQdkZ1WG5nhiYkpOD8YfYfuku/xepL1hFQaPnsobWnsOgh
        x10UD8urEi54syvKVsrmo9U=
X-Google-Smtp-Source: AHgI3IYpoKb5kNwFZmr6W1HZ9CAPqVLaEiXfiSaBYzmfRJGqRx5Vaj5qdGUvnsET1Ijk/3DQjlwJGg==
X-Received: by 2002:a63:2141:: with SMTP id s1mr14431685pgm.363.1550420604516;
        Sun, 17 Feb 2019 08:23:24 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a24sm1624043pfn.85.2019.02.17.08.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 08:23:23 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/5] nvmem: sunxi-sid: add SID controller support for H5 and H6
Date:   Sun, 17 Feb 2019 11:23:11 -0500
Message-Id: <20190217162316.14111-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SID controller support for H5 and H6, and do some
cleanup without functional changes.

Yangtao Li (5):
  nvmem: sunxi-sid: fix wrong description in kernel doc
  nvmem: sunxi-sid: add support for H5's SID controller
  nvmem: sunxi-sid: add binding for H6's SID controller
  nvmem: sunxi-sid: add support for H6's SID controller
  nvmem: sunxi-sid: convert to SPDX license tags

 .../bindings/nvmem/allwinner,sunxi-sid.txt    |  3 ++-
 drivers/nvmem/sunxi_sid.c                     | 23 +++++++++++--------
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.17.0

