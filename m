Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48567C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5082083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="bbw4TEI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5082083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeH2QUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:20:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43264 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeH2QUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so3758410edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+sGAOImL3QCM3+6MjmiZhgd31TmETmDPRNhbPBLuJcY=;
        b=bbw4TEI7QWUC/ljRfNwJFWy9YNzUUY+5xQiT5KGa9F7qb75qAsax1131soGGbwQdSt
         ch92ZckPF8zR4GatpvRnNV6nioGCDDeyKSAI0c0wwz7AnSZZviyW0T+2Iiyw60KTy0Ac
         1IFRR8mdM/fYpSQ1Fm/0c/9KAs3nwjztZwyWd4mMFsXBqMh7zYG53Jvi8ItyC3Qd7TCz
         PUgAbSN3IvAyDQ1br0QCPJr1kHlSCcylSBsKvfGY+YJRFJoOC/EmBEfxUBMpZfrXcQ91
         76FtmJCgswXvixOS2WOb1ibJi6hWGp8JJsTY8654KGxuc92szH6yc9mavM0yWWDZk6xB
         OBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+sGAOImL3QCM3+6MjmiZhgd31TmETmDPRNhbPBLuJcY=;
        b=S0pkxwtG2LReMMtpJ3IG7AENk+Wf+znPxzK6G7aj2jdSXUQPt/BTgwRAgmnOHcXgaA
         VH+hwuU6LJwUKlVteQK8kdXu9zNOT5Y1Jv8TfBdFYiA3rjrfR2UCGooGtXo459jmOkNH
         OYpv4Vv12QcVFZ3AfGvxblzB9dhdIIdhrxfrngqbXQQxdCSlxaLOvQdsur+sHfEX2CIN
         q6LG29kWuS2s3mgye+16XTYKOh0BekTVDIJWnkB56gz2Tu3M9RT2+eWSZDun/0TwRNxH
         h5cceGiM5C0VukInBOBkgQdavP5vaQjNN+fnPbN/hioyQnnWL0UzZIYWtuZKhuPUOlzb
         Gk+A==
X-Gm-Message-State: APzg51Ae/pf0ROjoI10vWWYdTtofMQd0wPchiUOBzoWtMrhVgoo5AXNH
        NgmiHvjwBixWVCX7FBoeyNQIsg==
X-Google-Smtp-Source: ANB0VdYAP1pFw5a2qni+vrfTITUC4UtLvOTYeaWejitRBgShA7gOVLFxhX9PARHtd6UKBjKeDBOleg==
X-Received: by 2002:a50:ae83:: with SMTP id e3-v6mr7244511edd.16.1535545432079;
        Wed, 29 Aug 2018 05:23:52 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1752068edb.28.2018.08.29.05.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:23:51 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/7] pblk fixes
Date:   Wed, 29 Aug 2018 14:23:27 +0200
Message-Id: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This patchset contains a bunch of cleanups and bugfixes for 4.20.
The patches depend on some of Javier's for-4.20 patches.

For ordering, see:

Branch: for-4.20/pblk
Remote: ssh://github.com/OpenChannelSSD/linux

Hans Holmberg (7):
  lightnvm: introduce nvm_rq_to_ppa_list
  lightnvm: pblk: fix mapping issue on failed writes
  lightnvm: pblk: allocate line map bitmaps using a mempool
  lightnvm: pblk: move global caches to module init/exit
  lightnvm: pblk: remove unused parameters in pblk_up_rq
  lightnvm: pblk: fix up prints in pblk_read_check_rand
  lightnvm: pblk: fix write amplificiation calculation

 drivers/lightnvm/core.c          | 14 +++------
 drivers/lightnvm/pblk-core.c     | 25 +++++++++------
 drivers/lightnvm/pblk-init.c     | 60 ++++++++++++++++++++++-------------
 drivers/lightnvm/pblk-map.c      | 10 +++---
 drivers/lightnvm/pblk-read.c     | 13 +++-----
 drivers/lightnvm/pblk-recovery.c | 11 ++++---
 drivers/lightnvm/pblk-sysfs.c    |  3 +-
 drivers/lightnvm/pblk-write.c    | 68 +++++++++++++++++++++++++++-------------
 drivers/lightnvm/pblk.h          | 11 ++++---
 include/linux/lightnvm.h         |  5 +++
 10 files changed, 134 insertions(+), 86 deletions(-)

-- 
2.7.4

