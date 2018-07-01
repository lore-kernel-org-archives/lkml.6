Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F49DC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382224E63
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1382224E63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeGANIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 09:08:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752344AbeGANH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 09:07:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E213AAEB5;
        Sun,  1 Jul 2018 13:07:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9904EDABB2; Sun,  1 Jul 2018 15:07:53 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 4.18-rc2
Date:   Sun,  1 Jul 2018 15:07:45 +0200
Message-Id: <cover.1530449809.git.dsterba@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have a few regression fixes for qgroup rescan status tracking and the
vm_fault_t conversion that mixed up the error values.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit c5b4a50b74018b3677098151ec5f4fce07d5e6a0:

  Btrfs: fix return value on rename exchange failure (2018-06-22 12:59:08 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.18-rc2-tag

for you to fetch changes up to e4e7ede739f7fb468686dfffa2d1e35dca35bacd:

  Btrfs: fix mount failure when qgroup rescan is in progress (2018-06-28 11:30:57 +0200)

----------------------------------------------------------------
Chris Mason (1):
      Btrfs: fix regression in btrfs_page_mkwrite() from vm_fault_t conversion

Filipe Manana (1):
      Btrfs: fix mount failure when qgroup rescan is in progress

Qu Wenruo (1):
      btrfs: quota: Set rescan progress to (u64)-1 if we hit last leaf

 fs/btrfs/inode.c  |  3 ++-
 fs/btrfs/qgroup.c | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)
