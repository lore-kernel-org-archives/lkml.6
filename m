Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4590AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0328204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhRaqV2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0328204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeIGVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:49:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36672 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIGVtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:49:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so15393537wmj.1;
        Fri, 07 Sep 2018 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4z7lfRkt8clK10PtitRKJeyibyfa9VlNkLbMmorMb+w=;
        b=WhRaqV2B6OnkZ7IYHS99H2UOk/0lH5JGZwHVNeap9k6FgmjTFfAqHhiPz5TwRCOT9/
         IDXAWTuHxchXv0zrZqawzlCtOIsb4RaZPiE6ktCh/WsAwbuRUBAMkZQnKK3bjCEupoUH
         50+ZQ0ggmbrquMk5nxs1a36HiSpYpMqWONn2RhzHkLG3VrWXdI2KgvpPeNynRaECKphc
         JXf39Ktl+deb3ARSDtiSZ4OmYjbh78mTGLJqbAigKUFF4cCg4CFLxpuZ9iZ/sO8HYUOH
         udNJCavOQovKVbb/mA4Zeu+GHyGB7rLT83riKGDlfIF71Xpl9NCmOiTH9rAKe9HKlda0
         Jgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4z7lfRkt8clK10PtitRKJeyibyfa9VlNkLbMmorMb+w=;
        b=AulrcMnd54m50KRJHK3dVWMUuy5/YmLVE9YBKEqoy/ZJ43NVErgAx5Xv8UfkO+e7Id
         gEgrpfvq/2p/zB+pVatTfdg+Y9o4zepfeEf77LxD6GjBaDfxK/xTFwEmc+DaJ4wKATgc
         1U4RSb12FGrbq2J5pkv+702Tg0LFTkwY5fXPlhj3tk6NxCGq5mSA/OUmdEZHlDp1fL3X
         zykYuT4TS5LAyX6kCTFo4+BPo8TTOpsclt6SJFyGE3boXE7Z90hVnZG4Xmq6jC9lb58h
         SXbb8UDVTt3JiF2O2DImRLqe8HnSyJqymdxS+zHQEcScgnmh08CU4yCM++h19meimNDH
         jMLQ==
X-Gm-Message-State: APzg51CZO+dP0007VHN9q7PB/uvvvvs46CTw07UVG43xbarMEcaIFiMm
        MXpVwe9L7U7XEts+ykSc1Eb7DHdH
X-Google-Smtp-Source: ANB0VdZpOQwaPCqVhE0Y3LqiJ8XDw8FiaMU/Co01pZlhvsvSt2kvVUHXBj50UdtPmwB2nkdtXKEyGA==
X-Received: by 2002:a1c:578a:: with SMTP id l132-v6mr5964512wmb.16.1536340063856;
        Fri, 07 Sep 2018 10:07:43 -0700 (PDT)
Received: from orange.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l7-v6sm11003167wrt.67.2018.09.07.10.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:07:43 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 4.19-rc3
Date:   Fri,  7 Sep 2018 19:06:43 +0200
Message-Id: <20180907170643.18214-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.19-rc3

for you to fetch changes up to e92c0eaf754310f9f31e9229a3f7274a67478f82:

  rbd: support cloning across namespaces (2018-09-06 16:18:04 +0200)

----------------------------------------------------------------
Two rbd patches to complete support for images within namespaces that
went into -rc1 and a use-after-free fix.

The rbd changes have been sitting in a branch for quite a while but
couldn't be included into the -rc1 pull request because of a pending
wire protocol backwards compatibility fixup that only got committed
early this week.

Said fixup ended up being really trivial -- just an extra byte added,
so I decided to send these changes for -rc3.  If it's too late in the
cycle for this follow-up to be pulled, let me know and I'll send the
use-after-free fix separately; we will have the necessary stop gaps on
the server side to prevent the current 4.19 code from doing anything
unexpected.

----------------------------------------------------------------
Ilya Dryomov (3):
      ceph: avoid a use-after-free in ceph_destroy_options()
      rbd: factor out get_parent_info()
      rbd: support cloning across namespaces

 drivers/block/rbd.c | 235 +++++++++++++++++++++++++++++++++++++++-------------
 fs/ceph/super.c     |  16 ++--
 2 files changed, 189 insertions(+), 62 deletions(-)
