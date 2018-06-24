Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A059C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53924F5D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA53924F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeFXPWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:22:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeFXPWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:22:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 76D40AD1F;
        Sun, 24 Jun 2018 15:22:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 505AEDA8D3; Sun, 24 Jun 2018 17:19:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 4.18-rc1
Date:   Sun, 24 Jun 2018 17:19:58 +0200
Message-Id: <cover.1529853141.git.dsterba@suse.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are 2 regression fixes and an incorrect error value propagation
fix from 'rename exchange'. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit ac0b4145d662a3b9e34085dea460fb06ede9b69b:

  btrfs: scrub: Don't use inode pages for device replace (2018-06-11 15:59:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.18-rc1

for you to fetch changes up to c5b4a50b74018b3677098151ec5f4fce07d5e6a0:

  Btrfs: fix return value on rename exchange failure (2018-06-22 12:59:08 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      Btrfs: fix physical offset reported by fiemap for inline extents
      Btrfs: fix return value on rename exchange failure

Lu Fengqi (1):
      btrfs: fix invalid-free in btrfs_extent_same

 fs/btrfs/extent_io.c |  5 ++++-
 fs/btrfs/inode.c     |  4 +++-
 fs/btrfs/ioctl.c     | 10 +++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)
