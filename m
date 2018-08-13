Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47328C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC732175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5y1VwMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC732175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeHMVr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbeHMVr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:47:56 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631912175C;
        Mon, 13 Aug 2018 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534187066;
        bh=lzJuFgJkBAJNafzOFPhTwg/QTmpd3y32uYD1xC6IIcY=;
        h=Date:From:To:Cc:Subject:From;
        b=Q5y1VwMC0GxqjM4wnjVtxk0wf2D6w3hSHVC33aad7eyK5mR83ihEwEw80PUQOs/Pb
         WqD/vt5HBXgguSGt/Io9+0bDL6+xQgV/mpecJinUNthfSiFlkcNS9KSVL9GH8PUZVv
         55uuDDC1ANGKrpUPpQCy4hPYptc/Ekf/VFPPkkL8=
Date:   Mon, 13 Aug 2018 11:45:57 -0700
From:   Shaohua Li <shli@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [GIT PULL] MD update for 4.19-rc1
Message-ID: <20180813184557.GA8056@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A few MD fixes for 4.19-rc1:
- Several md-cluster fixes from Guoqing
- A data corruption fix from BingJing
- Other cleanups
Please pull!

Thanks,
Shaohua

The following changes since commit 06c85639897cf3ea6a11c5cb6929fb0d9d7efea5:

  Merge tag 'acpi-4.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2018-07-05 09:52:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shli/md.git for-next

for you to fetch changes up to d63e2fc804c46e50eee825c5d3a7228e07048b47:

  md/raid5: fix data corruption of replacements after originals dropped (2018-08-02 11:22:06 -0700)

----------------------------------------------------------------
Anna-Maria Gleixner (2):
      drivers/md/raid5: Use irqsave variant of atomic_dec_and_lock()
      drivers/md/raid5: Do not disable irq on release_inactive_stripe_list() call

BingJing Chang (1):
      md/raid5: fix data corruption of replacements after originals dropped

Colin Ian King (1):
      md/r5cache: remove redundant pointer bio

Guoqing Jiang (3):
      md-cluster: clear another node's suspend_area after the copy is finished
      md-cluster: show array's status more accurate
      md-cluster: don't send msg if array is closing

 drivers/md/md-cluster.c  | 47 +++++++++++++++++++++++++++++++++++------------
 drivers/md/md.c          | 17 +++++++++++++++++
 drivers/md/md.h          |  1 +
 drivers/md/raid5-cache.c |  2 --
 drivers/md/raid5.c       | 12 ++++++++----
 5 files changed, 61 insertions(+), 18 deletions(-)
