Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708AFC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E2127237
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qx3snv8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E2127237
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeF1KnL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:43:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45700 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933048AbeF1KnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:43:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so4991093wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=S53wbi4mGoQLB+yRCebSoL1n+CCuc7cEeP7FibSh9rE=;
        b=qx3snv8+AxhBL3R84Z5M8Jey7cEWXuESEeYC59Eo+SNECYSHUVNHOUTXObVsSxx3Zt
         GWGC6PajqpORaoFS2PwWR2IGQ3Tx9X1G4VRzozmyquPHpTDyt+Y3uUACXVDADCUgPNOf
         HthvH5tQlkv7FIV9Y15AiNxivsosV1cjSFcmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S53wbi4mGoQLB+yRCebSoL1n+CCuc7cEeP7FibSh9rE=;
        b=Z0a1f3eejxkppGZYjkSjqGqJPK9216MAxjK/HoEr7Y9ScS+WRsRt3GzyMbLcaWaOJE
         hM7DGWpwN9kxgjd+rOwM1XjirCs1nrG2CPCLpByOq+2E5PNA5r1BjV7U/6bN9JJEU2iw
         Jr8J14Po7NkBpsF4CrQpUxwzgcQz+DN4bhcEMUl3e6/Rwd2MDq/k4xDcks0v2XScCDAc
         9y894f8JefNefEODM8CgdObkk/mXSVs8NPx8pFdX3Bxziu0JmPyvwpAUwOfjV7/fJq82
         2ZqQ7qqhrhVSIE9hcKWa2JcUQ9IMtfuqumYlHLqac8i/ngDzpv3FZ4GGFDp4JlQGgq2v
         sM4w==
X-Gm-Message-State: APt69E08nLZlaMr1VGC51ncmP3/0sSstYuJWGi+YHRbDs1FW2B1DcwPw
        LliB+Bv6QqU0bVtGEutK9wuNmbfT
X-Google-Smtp-Source: AAOMgpeQEvym5pp2CgUKHnRfTGBKTTY50tRykoyjaMkcvWOCJix3PEXjpTgF/RP1DdqFliay5gh8mA==
X-Received: by 2002:adf:99ea:: with SMTP id y97-v6mr8105898wrb.215.1530182587452;
        Thu, 28 Jun 2018 03:43:07 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id 14-v6sm9257298wmh.8.2018.06.28.03.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 03:43:06 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 0/3] sched/locking/doc: Miscellaneous fixes
Date:   Thu, 28 Jun 2018 12:41:17 +0200
Message-Id: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a follow-up on the discussion started in [1].

Applies on -rcu/dev.

Cheers,
  Andrea

[1] http://lkml.kernel.org/r/1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com

Andrea Parri (3):
  sched: Use smp_mb() in wake_woken_function()
  locking: Clarify requirements for smp_mb__after_spinlock()
  doc: Update wake_up() & co. memory-barrier guarantees

 Documentation/memory-barriers.txt | 43 ++++++++++++++++++------------
 include/linux/sched.h             |  4 +--
 include/linux/spinlock.h          | 25 ++----------------
 kernel/sched/completion.c         |  8 +++---
 kernel/sched/core.c               | 30 +++++++++------------
 kernel/sched/wait.c               | 55 ++++++++++++++++++---------------------
 6 files changed, 72 insertions(+), 93 deletions(-)

-- 
2.7.4

