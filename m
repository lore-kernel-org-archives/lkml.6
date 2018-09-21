Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD5021522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD5021522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbeIUPVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:21:17 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50750 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbeIUPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:21:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 47DDB603B54F;
        Fri, 21 Sep 2018 11:33:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ck54uniolox2; Fri, 21 Sep 2018 11:33:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E90E16088983;
        Fri, 21 Sep 2018 11:33:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v5SDQBfx7NF9; Fri, 21 Sep 2018 11:33:15 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id AFB13603B54F;
        Fri, 21 Sep 2018 11:33:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     gregkh@linuxfoundation.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBIFS fixes for 4.19-rc4
Date:   Fri, 21 Sep 2018 11:33:15 +0200
Message-ID: <3383200.5o9oegka29@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

The following changes since commit ae596de1a0c8c2c924dc99d23c026259372ab234:

  Compiler Attributes: naked can be shared (2018-09-20 15:23:58 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-ubifs.git tags/upstream-4.19-rc4

for you to fetch changes up to f061c1cc404a618858a77aea233fde0aeaad2f2d:

  Revert "ubifs: xattr: Don't operate on deleted inodes" (2018-09-20 21:37:41 +0200)

----------------------------------------------------------------
This pull request contains fixes for UBIFS:

- A wrong UBIFS assertion in mount code
- Fix for a NULL pointer deref in mount code
- Revert of a bad fix for xattrs

----------------------------------------------------------------
Richard Weinberger (2):
      ubifs: Check for name being NULL while mounting
      Revert "ubifs: xattr: Don't operate on deleted inodes"

Sascha Hauer (1):
      ubifs: drop false positive assertion

 fs/ubifs/super.c |  7 ++++++-
 fs/ubifs/xattr.c | 24 ------------------------
 2 files changed, 6 insertions(+), 25 deletions(-)



