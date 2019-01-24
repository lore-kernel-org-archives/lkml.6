Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585DF218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqdvP77Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfAXPuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:50:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38841 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAXPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:50:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so7001292wrw.5;
        Thu, 24 Jan 2019 07:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4X40eqBy8zRByT/AnMwBLP8L5L8LaP3v1vVVNpWhtQU=;
        b=gqdvP77QsenVirYhf3WMNRImTAIt/fWTPa4MnUHWzm6nmNXbw76G36Any92rNYhd6g
         mPcI26WsHfHVLTFIcj2MxjANxVfKIW2OZMVGFcUHdkypyMWQ0ud2DHHZdfISZ31kWU4t
         rTzlsYxSE7frrXcW92hksReoHpN2yYnzETAzrFgVRTASGAOXWEGp07bYtk3KgkogsmDL
         X1FomYoPOkkveEsFFT02/7+B6CdT+3/XLndelGGXhpQLyUsh1MEQT4+s8STHDCHnK/4K
         xelVVVGBNt/UZjc11IU/UQ29oSTN0VUxvRNdlvyoKJ3+YC6BBp/5x7Y8Qp3XYywt3GLv
         ESYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4X40eqBy8zRByT/AnMwBLP8L5L8LaP3v1vVVNpWhtQU=;
        b=iCfMr5k3MckWxI6j6hfROckEim9kJc5pKWAfqzfXvgNT/Y2zhESxnFmIIPbJgkx+zs
         QeVOR6hoE7IthaiYfhUCZj4R62ykbvS2v0qVFHeLyFaSQAdrC49pMQOcpWSkc9tiXrkp
         Zln8qfPUSXI8jBLV3H5umxcTX9YN07nwFxQM5mz12ciWnKSmdw9nf8+1svs3n6Zoy/TG
         u5TGtWPPGpjWBqqRhLyP+SBRGm8MCK2kd17dsoJZFs4pRNrY7oI9IY4MG6besEfD3q5B
         uj+/0sY1cQnIPSXh8HHzi6CYlbBh9/k6pUmtT3GOPJn0s0HuyDZCqDLCXOqydHfuOead
         aM+A==
X-Gm-Message-State: AJcUukeF6pHfC1C2o0w2VSWdwxby+VvVRhMm+4HlVxyU9AMonJIJ7Qbm
        r7OSEpgdPk2mMomMTZv6ChQ=
X-Google-Smtp-Source: AHgI3IaYpG2qCgYU2S4kuO7xXEyxptWcFXleGZnRzNoNmb85C3fVN6SfFPHAx242Dz0/Z70+Wut5kQ==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr3526321wrp.111.1548345009384;
        Thu, 24 Jan 2019 07:50:09 -0800 (PST)
Received: from orange.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f15sm94701721wrt.10.2019.01.24.07.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 07:50:08 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.0-rc4
Date:   Thu, 24 Jan 2019 16:49:58 +0100
Message-Id: <20190124154958.8067-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc4

for you to fetch changes up to 74827ee29565f86e2a64495a5e3e58d3371d74ee:

  ceph: quota: cleanup license mess (2019-01-21 14:53:23 +0100)

----------------------------------------------------------------
A fix for a potential use-after-free, a patch to close a (mostly benign)
race in the messenger and a licence clarification for quota.c.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Thomas Gleixner (1):
      ceph: quota: cleanup license mess

Yan, Zheng (1):
      ceph: clear inode pointer when snap realm gets dropped by its inode

 fs/ceph/caps.c       |  2 ++
 fs/ceph/quota.c      | 13 -------------
 net/ceph/messenger.c |  5 +++--
 3 files changed, 5 insertions(+), 15 deletions(-)
