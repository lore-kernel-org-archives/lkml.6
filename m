Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D45CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EA120850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="XbH5Tj2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EA120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeH2Q2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:28:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46432 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeH2Q2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so3767760edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=44g6Zy1wNBnya2mMeli7v/3kqfSkk2oTAcHk9GhhS1I=;
        b=XbH5Tj2OU3ScxKPnFVXaMihib/bypEiDqhA9vUYdlqB+XNT9Y6aRcNWv8ayYJf+Nk0
         9pUZZfa3Vz3rNs5DiMHflfKRNztljh6y4CmN5aSfgfQKvAh40aHQOvaa1hIrVjkhVpJj
         ZZVErLNcMCIOUVt/1csMGiNg/vAXnKiv8sisR4qF7tH0ZRdM7n0xLsXwf7QAGZ2b8Ahk
         JRAHQty8llFp6z9fydROBiAopxAwCQx+0jDzhpWpdXI0W2gIZVfVl8FXWA72I4QyhlNW
         BeHllhsX1Qb3oJGq5VuJl26ru0FtOCgbGY6Oc2THrtMMFjNvG8SETIDVTXAttN3mglB0
         5mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=44g6Zy1wNBnya2mMeli7v/3kqfSkk2oTAcHk9GhhS1I=;
        b=nVQGV8mo8rgdeh17DA9a/HL9+xmLBDP8kUZa2ZbplBEgrohvNTYWnUeUeARNy5LdlV
         3Z6cahRQ2cwN4rVZoRHhZUdq2uAuYwQGokW5f4xikIZYx3vGsV/mC1MCACxkbJeqyg3E
         RPLexWqqH3JwV7vKdOoVVsWCJ2wDaAC9DMUguC9ZWviDrH64caV6MMh0SEEfNG7ntWPA
         fzEv5x8PJuQ1NXJl0oIinWpm08zw0W1Wb2iIeL1+ADQdbgFM2a2hhtwtg/a+7ymfrycB
         ZM/UqbDZzJswwFHjbRARq89GIL1+gtHvy1Uy9BC/Ikg/XeZyzxS1KkLC5vIgCkjJvjl4
         Lv7g==
X-Gm-Message-State: APzg51BuEIXGoIArLBRp9g2GJkweeg1JLAOnV6t3ufrSLSS94QE8Oste
        cfFPwhBe7/QlBb1kNEpsTwGglA==
X-Google-Smtp-Source: ANB0VdbBPcv1H6zflmoYsKQtMdwaep6ihDu+fnCpCIceg5EfQRGlozQEzxq/wZ0WeT4ZaH6vcwaLNA==
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr7523173ede.121.1535545890199;
        Wed, 29 Aug 2018 05:31:30 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id r44-v6sm2765454edd.87.2018.08.29.05.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:31:29 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/4] Introduce trace events for pblk
Date:   Wed, 29 Aug 2018 14:31:13 +0200
Message-Id: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This patchset adds trace events for tracking the internal state of
pblk. I've used the events extensively the last few months, and
they have proven very useful.

The patches depend on some of Javier's for-4.20 patches.
For ordering, see:

Branch: for-4.20/pblk
Remote: ssh://github.com/OpenChannelSSD/linux

Hans Holmberg (4):
  lightnvm: pblk: add trace events for chunk states
  lightnvm: pblk: add trace events for line state changes
  lightnvm: pblk: add trace events for pblk state changes
  lightnvm: pblk: add tracing for chunk resets

 drivers/lightnvm/pblk-core.c     |  69 ++++++++++++++++++-
 drivers/lightnvm/pblk-gc.c       |   8 +++
 drivers/lightnvm/pblk-init.c     |   8 +++
 drivers/lightnvm/pblk-recovery.c |   6 ++
 drivers/lightnvm/pblk-trace.h    | 145 +++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-write.c    |  10 ++-
 drivers/lightnvm/pblk.h          |  14 ++++
 7 files changed, 256 insertions(+), 4 deletions(-)
 create mode 100644 drivers/lightnvm/pblk-trace.h

-- 
2.7.4

