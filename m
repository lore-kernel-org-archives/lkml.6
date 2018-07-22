Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB57C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D4F20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mpEhZWfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D4F20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeGVNlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 09:41:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeGVNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 09:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ELegvTLWoD0QcbU598g/Km7TZJvkCC9VTYqBQ3rhuNc=; b=mpEhZWfvWMYoqUVA8cAHNi1gxI
        LkZLxiAGlUWrEgkUiW/xbZWV6YK2uBixeFu19s6Nwl+UpbXU3yNG7AWTikPbKBncvj+m2gS2FiUR8
        DxvuxNDVcpu+ggZnRWfQN/DbCW+L8MQCwsEbOw1R2WaHTegDH89r33laWRrHi2TJxZborcr8U+Vvo
        2UoVaqTd4sVKiloDjLzFHYAavCjOmq3/B3ozk5NweWWj9LFiDHz13SheKucBuO3D6TweaDOgi3Huv
        PwyjTxjw1ki4eX6vAn/iZNPUnqDElfD6bG4FLXTmXa0U2qARwEzoVr5Qseugvvx4v7jzy1Fr6BpCt
        JDp6dGfA==;
Received: from 213-225-2-246.nat.highway.a1.net ([213.225.2.246] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhDik-0005HR-IV; Sun, 22 Jul 2018 12:44:19 +0000
Date:   Sun, 22 Jul 2018 14:44:13 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] NVMe fixes for 4.18-rc6
Message-ID: <20180722124413.GA16254@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these NVMe fixes directly instead of through Jens so that
he can enjoy more of his vacation!

The following changes since commit 70dbcc2254fa2a9add74a122b9dac954c4736e01:

  bsg: fix bogus EINVAL on non-data commands (2018-07-11 08:48:28 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-for-4.18

for you to fetch changes up to 9b382768135ee3ff282f828c906574a8478e036b:

  nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD (2018-07-20 07:43:59 -0700)

----------------------------------------------------------------
NVMe fixes for 4.18-rc6:

 - fix a regression in 4.18 that causes a memory leak on probe failure
   (Keith Bush)
 - fix a deadlock in the passthrough ioctl code (Scott Bauer)
 - don't enable AENs if not supported (Weiping Zhang)
 - fix an old regression in metadata handling in the passthrough ioctl
   code (Roland Dreier)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: fix memory leak on probe failure

Roland Dreier (1):
      nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD

Scott Bauer (1):
      nvme: ensure forward progress during Admin passthru

Weiping Zhang (1):
      nvme: don't enable AEN if not supported

 drivers/nvme/host/core.c | 63 ++++++++++++++++++++++++++----------------------
 drivers/nvme/host/pci.c  | 12 +++++----
 2 files changed, 41 insertions(+), 34 deletions(-)
