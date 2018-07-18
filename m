Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A8CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE0E206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE0E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeGRNI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:08:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbeGRNI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:08:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0C0DADF2;
        Wed, 18 Jul 2018 12:30:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A438DAC97; Wed, 18 Jul 2018 14:30:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 4.18-rc5
Date:   Wed, 18 Jul 2018 14:30:35 +0200
Message-Id: <cover.1531916500.git.dsterba@suse.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please pull the following branch with 3 regression fixes. They're
few-liners and fixing some corner cases missed in the origial patches.
Thanks.

----------------------------------------------------------------
The following changes since commit e4e7ede739f7fb468686dfffa2d1e35dca35bacd:

  Btrfs: fix mount failure when qgroup rescan is in progress (2018-06-28 11:30:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.18-rc5-tag

for you to fetch changes up to 665d4953cde6d9e75c62a07ec8f4f8fd7d396ade:

  btrfs: scrub: Don't use inode page cache in scrub_handle_errored_block() (2018-07-17 13:56:30 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: restore uuid_mutex in btrfs_open_devices

Naohiro Aota (1):
      btrfs: fix use-after-free of cmp workspace pages

Qu Wenruo (1):
      btrfs: scrub: Don't use inode page cache in scrub_handle_errored_block()

 fs/btrfs/ioctl.c   |  2 ++
 fs/btrfs/scrub.c   | 17 +++++++++--------
 fs/btrfs/volumes.c |  2 ++
 3 files changed, 13 insertions(+), 8 deletions(-)
