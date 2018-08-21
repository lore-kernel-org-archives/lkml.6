Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0625BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DF7217C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DF7217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeHUSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:23:16 -0400
Received: from sauhun.de ([88.99.104.3]:42412 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbeHUSXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:23:15 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id 0E8D92D8F92;
        Tue, 21 Aug 2018 17:02:43 +0200 (CEST)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] i2c: remove deprecated attach_adapter callback
Date:   Tue, 21 Aug 2018 17:02:38 +0200
Message-Id: <20180821150240.19964-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, I wanted to do this in the next cycle, but Linus seems to want it this
cycle already [1], so here it is:

Remove the attach_adapter callback from the 2.4 times by converting
the last user to a custom probing mechanism based on deferred probing. We used
this already in commit ac397c80de89 ("ALSA: ppc: keywest: drop using attach
adapter") successfully on HW, so we agreed to use it on the windtunnel driver
as well.

With the last user gone, we can then remove the callback \o/ I think this
allows for more cleanup in the core, but let's do this later and focus on the
removal for now.

Tested on a Renesas R-Car Salvator-XS board (M3N) by using and rebinding
various I2C busses. Build bot and checkpatch are happy, too.

I'd like to send a pull request to Linus this merge window, so looking forward
to super fast comments, acks, etc...

Thanks,

   Wolfram

[1] http://patchwork.ozlabs.org/patch/959322/#1976742

Wolfram Sang (2):
  macintosh: therm_windtunnel: drop using attach_adapter
  i2c: remove deprecated attach_adapter callback

 drivers/i2c/i2c-core-base.c          | 11 +----------
 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 include/linux/i2c.h                  |  6 ------
 3 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.11.0

