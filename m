Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF8C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C8420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Ov3ADJYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C8420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeKEVqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:46:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46238 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbeKEVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:46:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8-v6so7263690edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4oWqVd7aJitPmc1BR7PgpfQzZ7u//yDgTqBlN/OETIM=;
        b=Ov3ADJYk/K77dlLlmkaOga/TyP8Dx7N08HmrLgyi5/zkGKygLKzGOtCqYkRSPLXOxm
         riIOaPElXowhkQ5qVJUznqDP8XdTpH0t2jhLH4a+96xAOyJlbZp+ZzdUKGZvFxkMOhoW
         eomR58KFiZ902YooStvPJxXScT7AVgu8ObAZb19T6F5NWb2aTN03GolvrmN0U6qW4RLH
         +hLab6z8or0WChuG7ua3ocUy7BdU2gbySncJM2vTLVDbGo6Mu0Ad0fDcrShxS0zdOunp
         5a3ftbnO/YH+EgsZBrZQ6jld7ZvthuCmAGxAjoZQa4c0ClZ7Wpwvofp3on1D4Hr8akod
         0nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4oWqVd7aJitPmc1BR7PgpfQzZ7u//yDgTqBlN/OETIM=;
        b=miXzuxpzzoWE6kg0wogaT3k4BFwbbQo9ed1pQ2VbxGAqZDQh5kfxoycj7392z4Z78Y
         Ew8Usqnmu+S589+O0rkLkXfI3m4yj/S9K054uF8nXX3pqb1hRUj2de28mrpWqW5SYONR
         PMr8VW95elUl6sW+Guks+/TGy0ObiAVeAy+QzaJgtpVOu8Nn6U2Gt5CVJ9JOE+/Pqd1a
         vbGuPuuczT6KQPfa5b44kMyLRYEeGHawL8bHauzr6qiOnZziY1eabI0lXX6dMnMGSHDv
         jREE9jHDrmKWXEzjsWenuOJn1DI5SRbAAvbM2xv698WQFAtvYUAdWSXggAveMDfpYE2Q
         zetg==
X-Gm-Message-State: AGRZ1gKEJLKGUfiDi/gLaW5wdIKIz5qzraQ1dfNf23dmnDznuoOd15Wa
        ujBjpIvmiXOb4BiSJay8ktzz2A==
X-Google-Smtp-Source: AJdET5fLYMd/dhPTVnhFru6OoLGWdwmSEVpRaYK+HuLKW28+xduDtwOnjCqrtAROK6zOCJcGKyspqA==
X-Received: by 2002:a50:f396:: with SMTP id g22-v6mr18012230edm.110.1541420802956;
        Mon, 05 Nov 2018 04:26:42 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 9-v6sm7046056ejw.46.2018.11.05.04.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:26:42 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 0/7] PBLK Bugfixes and cleanups
Date:   Mon,  5 Nov 2018 13:26:03 +0100
Message-Id: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This series is a slew of bugfixes and cleanups for PBLK, mostly
fixing issues found during corner-case testing in QEMU.

Changes since v1:
	Messed up from:, now the patches apply with the correct author
	Pardon the mess.

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

