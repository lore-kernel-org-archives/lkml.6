Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0272C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6122320827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="qqJ5GxO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6122320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeKEVBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:01:21 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:54145 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKEVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:01:21 -0500
Received: by mail-it1-f174.google.com with SMTP id r12-v6so9395927ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=k6QTiGprAgQRCextATqUFgSWVx4ot42LkiK3YA4/zpU=;
        b=qqJ5GxO+o9qlE8zxSO3v18w/UxIMyo/NkXVZL0/gy9csP6HqnDRmg6pVDH9qci6GTI
         EkCw0dsj2DTkNtMJ6brK4OlKGBopCc2a8tsZrRQEmKUyVJZrvvX2mr7RAEjQWvyeftZd
         e9eauclIN0+25W8XT+BpCCcfeZJtOuwIJz/Y6nGBlAsOEP64d2CkpTiNxlS7KbESiv4x
         cbWaFrvHzmUoiqQ+t5ZDQ5PW5SX6Ak4RKBEoiepdeaQ////FYKU7AfpnhzqFj0Jwk9lO
         mk9FGg0IMLmu+CM9wAbATzJDgervedzp9J1NywdBoFSCjZWgM60kS8giVKmXHel5nzVN
         V4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k6QTiGprAgQRCextATqUFgSWVx4ot42LkiK3YA4/zpU=;
        b=aRH1LitOevJ5cwhTI1qShbOX4DNWydfIzNW/ZOXtA9hDanRZT4DrFW6NmrFn7g1jkT
         yrfM1FgeYgkZhHGkHzpsIQLWcDMDHWFXbYA/S1dZ6qWHD1hSnlxLTPsVtm0lC8h016tZ
         xRTnNj8RbPfIungSJfEw2t+7GMem5UbfsQQ+IgzFjLGQltX5uPjoVLSNxrp4Y07ifnAV
         Joe2ux3utmk91ofWMgcGF81gn3YjlvBUl7WvJTreaHT2mygZ15cGLWP3o+9HjbIMR1wc
         DiUW2by/mhe1423Se3ir0vcCoiEu0B0cUi2t+9ZOuT1CNxlqwFAgGGbK6HyFf6WMty6z
         NGqw==
X-Gm-Message-State: AGRZ1gI5FLxNntZTGWVwNobGHWtAOr1ekL+HM8E1uctLs0GDZseucd8r
        mH4yT/SisNPh7DCP4Ycj9t4R0g==
X-Google-Smtp-Source: AJdET5eDhbBRSpsnJylWDQqPV95BZ/EwLK+9FyeKhHSCLs0EmT7JVEIs9aqjQB+0Bct4Jb6Vx8erTg==
X-Received: by 2002:a24:d703:: with SMTP id y3-v6mr6795531itg.154.1541418122185;
        Mon, 05 Nov 2018 03:42:02 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 186-v6sm14880824itf.11.2018.11.05.03.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 03:42:01 -0800 (PST)
From:   Hans Holmberg <hans@owltronix.com>
X-Google-Original-From: Hans Holmberg <hans.ml.holmberg@cnexlabs.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/7] PBLK Bugfixes and cleanups
Date:   Mon,  5 Nov 2018 12:41:06 +0100
Message-Id: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This series is a slew of bugfixes and cleanups for PBLK, mostly
fixing issues found during corner-case testing in QEMU.

Hans Holmberg (7):
  lightnvm: pblk: fix resubmission of overwritten write err lbas
  lightnvm: pblk: account for write error sectors in emeta
  lightnvm: pblk: stop writes gracefully when running out of lines
  lightnvm: pblk: set conservative threshold for user writes
  lightnvm: pblk: remove unused macro
  lightnvm: pblk: fix pblk_lines_init error handling path
  lightnvm: pblk: remove dead code in pblk_recov_l2p

 drivers/lightnvm/pblk-init.c     | 48 +++++++++++++++++-----------
 drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
 drivers/lightnvm/pblk-recovery.c |  1 -
 drivers/lightnvm/pblk-rl.c       |  5 ++-
 drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
 drivers/lightnvm/pblk.h          | 16 ++++++++--
 6 files changed, 114 insertions(+), 58 deletions(-)

-- 
2.17.1

