Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C547FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6C52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTl16Qyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfBZKDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:03:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45859 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfBZKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so5984841pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dba4vbJzjlO0KTjHJIPVa0of9AUn1k9oSQPs0NyEp6I=;
        b=aTl16Qyqcodn5Kw/YnsCHwsJReNtoquNMDsSUoEiLDKeeD1CLymBeC0rgshpdg2jYi
         SzvexZKmTpzSDtPGsm2NsCp9Apej2szwBJZMQZRvFixKMgUAQPcL+sCST0Es/KS0X6tt
         UTGlPvz1fWLyEG8pfRiBm6Ho6StyzehS3dz1byh3qVUgnfDmwSSDNDGW7akhZ6QxeFOy
         SshKR33A/9RHVcfRYODGKuunuh/zullCcYAtPKMZgMB5QU4kM32cNVTK3Pucw537fdq2
         NuWkEHPy62STO7qfDTF8Yy5r2DUCoS1JuFbApVv+3c8juwREPPnkcsOoD2FK1wnJqRr7
         ebxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dba4vbJzjlO0KTjHJIPVa0of9AUn1k9oSQPs0NyEp6I=;
        b=O7yeUsznHSsrH7WIG5sTv3qTCENCasbJqOvu1T9NiCxuQHOec5+SAuDnEkBeZwyBTb
         1cayz+wTgjsHE7jJxMRbSPjfGLCv/T08m2KemFeMg7Kg5XcCKsNkkACv7yDQSIgVAs/i
         W32WnWnx2VnFxlq+6JXOj8LzMliZth1G9i6Sgf2YAH2sz3yHPjJLZob0IshO0WCsB9pC
         jUNBED7UqahRrOH1iBb519uU0UkTQDBLAIpR0X+qomXeO1gViM5rVWDhkNMFeepPvP38
         ed3ty+8ULfH7VIogDt7athvDjZnDCgmTE6lYHVnHggDyreclHai9lB1bbWXynPqjxkt0
         LZiQ==
X-Gm-Message-State: AHQUAuZ4hfcwcxb/1Ux6tW8f14MW5bufOOgfFEyjsjJzExMPApm9pbpH
        77xhZnrE87CcAV6gnAoxVZM=
X-Google-Smtp-Source: AHgI3IaLu6e1xkM8WD54ZN+on1zYWqebgF5dA83zUntTudw3m9YKx2sAUuvVdbLVBtdyvQDJeNwHIQ==
X-Received: by 2002:a63:1241:: with SMTP id 1mr23508241pgs.211.1551175417146;
        Tue, 26 Feb 2019 02:03:37 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:36 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 0/8] locking/lockdep: Add comments and make some code adjustments
Date:   Tue, 26 Feb 2019 18:03:19 +0800
Message-Id: <20190226100327.19340-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I recently tried to look at some system hang issues. While at it, I
attempted to use and understand lockdep. These patches are made as a result.
I believe they should have helped me, so hopefully they do for others as
well.

Thanks,
Yuyang

--

Yuyang Du (8):
  locking/lockdep: Change all print_*() return type to void
  locking/lockdep: Add description and explanation in lockdep design doc
  locking/lockdep: Adjust lock usage bit character checks
  locking/lockdep: Remove useless conditional macro
  locking/lockdep: Adjust indents for some lines
  locking/lockdep: Print right depth for chain key colission
  locking/lockdep: Update obsolete struct field description
  locking/lockdep: Consider zapped locks when printing lock chains in
    /proc

 Documentation/locking/lockdep-design.txt |  89 ++++++---
 include/linux/lockdep.h                  |   6 +-
 kernel/locking/lockdep.c                 | 315 ++++++++++++++++---------------
 kernel/locking/lockdep_internals.h       |   1 +
 kernel/locking/lockdep_proc.c            |  18 +-
 5 files changed, 247 insertions(+), 182 deletions(-)

-- 
1.8.3.1

