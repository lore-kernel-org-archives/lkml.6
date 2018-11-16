Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB1FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A697422506
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A697422506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbeKPKhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:37:39 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:41417 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeKPKhj (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 05:37:39 -0500
Received: from linux-r8p5.psav.com (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 15 Nov 2018 17:27:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/6] treewide: Remove redundant branch predictions around signal_pending family
Date:   Thu, 15 Nov 2018 16:27:07 -0800
Message-Id: <20181116002713.8474-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series trivially gets rid of users of signal_pending (and family) explicitly
wrapping the call around an unlikely(). It is redundant as internally this is
already done for us via signal_pending() and [__]fatal_signal_pending().

All patches are independent, so I split it up in case folks want to pick up bits
separately.

Compile tested only. Please consider for v4.21.

Thanks!

Davidlohr Bueso (6):
  locking/mutex: Remove caller signal_pending branch predictions
  kernel/sched: Remove caller signal_pending branch predictions
  arch/arc: Remove caller signal_pending_branch predictions
  mm: Remove caller signal_pending branch predictions
  drivers/i2c: Remove caller signal_pending branch predictions
  fs: Remove caller signal_pending branch predictions

 arch/arc/mm/fault.c              | 2 +-
 drivers/i2c/busses/i2c-ibm_iic.c | 2 +-
 fs/afs/fs_probe.c                | 2 +-
 fs/afs/vl_probe.c                | 2 +-
 fs/buffer.c                      | 2 +-
 fs/exec.c                        | 4 ++--
 fs/orangefs/orangefs-bufmap.c    | 2 +-
 kernel/locking/mutex.c           | 2 +-
 kernel/sched/core.c              | 2 +-
 kernel/sched/swait.c             | 2 +-
 kernel/sched/wait.c              | 2 +-
 mm/filemap.c                     | 2 +-
 mm/gup.c                         | 2 +-
 mm/hugetlb.c                     | 2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.16.4

