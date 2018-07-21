Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F69ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6BD20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6BD20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbeGUGYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 02:24:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727480AbeGUGYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 02:24:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48F55AE60;
        Sat, 21 Jul 2018 05:32:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89333DADD8; Sat, 21 Jul 2018 07:32:50 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 4.18-rc5
Date:   Sat, 21 Jul 2018 07:32:44 +0200
Message-Id: <cover.1532150370.git.dsterba@suse.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please pull the following update to btrfs. It's a fix of a corruption
regarding fsync and clone, under some very specific conditions explained
in the patch. The fix is marked for stable 3.16+ so I'd like to get it
merged now given the impact. Thanks.

----------------------------------------------------------------
The following changes since commit 665d4953cde6d9e75c62a07ec8f4f8fd7d396ade:

  btrfs: scrub: Don't use inode page cache in scrub_handle_errored_block() (2018-07-17 13:56:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-4.18-rc5-tag

for you to fetch changes up to bd3599a0e142cd73edd3b6801068ac3f48ac771a:

  Btrfs: fix file data corruption after cloning a range and fsync (2018-07-19 15:36:31 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      Btrfs: fix file data corruption after cloning a range and fsync

 fs/btrfs/extent_io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
