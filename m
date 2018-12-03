Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D5CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632A820834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632A820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbeLCFdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:33:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeLCFdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:33:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B27C14F2E6A9;
        Sun,  2 Dec 2018 21:33:14 -0800 (PST)
Date:   Sun, 02 Dec 2018 21:33:11 -0800 (PST)
Message-Id: <20181202.213311.1579839820291849515.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Dec 2018 21:33:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Some implicit switch fallthrough fixes from Stephen Rothwell.

2) Missing of_node_put() in various sparc drivers from
   Yangtao Li.

Please pull, thanks!

The following changes since commit 25e19c1fe421280a47f37c3571aa379e6e67966c:

  Merge tag 'libnvdimm-fixes-4.20-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm (2018-11-18 12:21:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to dac097c4546e4c5b16dd303a1e97c1d319c8ab3e:

  drivers/tty: add missing of_node_put() (2018-12-02 20:55:23 -0800)

----------------------------------------------------------------
Sabyasachi Gupta (1):
      arch/sparc: Use kzalloc_node

Stephen Rothwell (3):
      sparc: suppress the implicit-fallthrough warning
      sparc32: suppress an implicit-fallthrough warning
      sparc32: supress another implicit-fallthrough warning

Yangtao Li (3):
      sbus: char: add of_node_put()
      drivers/sbus/char: add of_node_put()
      drivers/tty: add missing of_node_put()

 arch/sparc/kernel/iommu.c       | 3 +--
 arch/sparc/kernel/signal32.c    | 1 +
 arch/sparc/kernel/signal_32.c   | 1 +
 arch/sparc/kernel/signal_64.c   | 1 +
 drivers/sbus/char/display7seg.c | 1 +
 drivers/sbus/char/envctrl.c     | 2 ++
 drivers/tty/serial/suncore.c    | 1 +
 7 files changed, 8 insertions(+), 2 deletions(-)
