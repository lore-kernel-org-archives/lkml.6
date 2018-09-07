Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2359C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2992075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vhDprscr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2992075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIGXTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeIGXTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:19:05 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06FF2075E;
        Fri,  7 Sep 2018 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536345413;
        bh=aM5Z9PSvY4GEwmu5wxr6mIPcmh76zx/GMHFWwhaGlnE=;
        h=Date:From:To:Cc:Subject:From;
        b=vhDprscr+icXJhTw/C1Y2ifYKevVmZsmUU959RHgZYDbqMJuXtbsleEYjHxZV9dYU
         rwnixTSiOAU7SPelu2GtBGTZwnvcpyV6lfEmS+Kr4DBe6s9hlxZaExzn+1bCa0jpWf
         W48K88vw2y9rlSJLJGD4bT7te9aYq1g8JHT4ozDo=
Date:   Fri, 7 Sep 2018 11:36:50 -0700
From:   Shaohua Li <shli@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [GIT PULL] MD update for 4.19-rc2
Message-ID: <20180907183650.GA54020@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please pull MD fixes for 4.19-rc2:
- Fix a locking issue for md-cluster from Guoqing
- Fix a sync crash for raid10 from Ni
- Fix a reshape bug with raid5 cache enabled from Me

Thanks,
Shaohua

The following changes since commit 420f51f4ab6bce6e580390729fadb89c31123636:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2018-08-31 09:20:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shli/md.git tags/md/4.19-rc2

for you to fetch changes up to 41a95041126522a921fb73df22cbdd520dfdebad:

  md-cluster: release RESYNC lock after the last resync message (2018-08-31 17:38:10 -0700)

----------------------------------------------------------------
Guoqing Jiang (1):
      md-cluster: release RESYNC lock after the last resync message

Shaohua Li (1):
      md/raid5-cache: disable reshape completely

Xiao Ni (1):
      RAID10 BUG_ON in raise_barrier when force is true and conf->barrier is 0

 drivers/md/md-cluster.c | 10 +++++-----
 drivers/md/raid10.c     |  5 ++++-
 drivers/md/raid5-log.h  |  5 +++++
 drivers/md/raid5.c      |  6 +++---
 4 files changed, 17 insertions(+), 9 deletions(-)
