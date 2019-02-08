Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BE8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B3F21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549615073;
	bh=T8cHf+eKduPjblabmc4iqCXrdA7LfD+YYKMyrTp0paw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FCtjIm5vTz2lxcxuSSxk9MafgSUU1VqI/iqvyToqWNJd+1qABgoj/hdcQBibnQfLE
	 002bkoED+YPpyk0J8dlkP5QGglGCKn243MyhEW3i6tez2uTnRnLmBX03fZu9QjrCRm
	 46/i0r00PkkjL8aZ037EG/lrKJ+xY/y883xmclp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfBHIhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBHIhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:37:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC10821917;
        Fri,  8 Feb 2019 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549615070;
        bh=T8cHf+eKduPjblabmc4iqCXrdA7LfD+YYKMyrTp0paw=;
        h=Date:From:To:Cc:Subject:From;
        b=IAOGpqMRjbtBOfg2t+oxU37MYUoFKY6Wd01PdmoGhZmtMSq+2SRG0gH99NySCVJzy
         v/gAYAB4Tx/mG8SwIvKX9XPO+KOhqe62Db21dMQ7WXcZjKxdWqjDcH0YllcUM7PjzJ
         xhtOFQlA0+NyghuJuO9dTlgXaIvpTxa9PuTauz34=
Date:   Fri, 8 Feb 2019 09:37:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.0-rc6
Message-ID: <20190208083747.GA26787@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc6

for you to fetch changes up to a07ddce4df807e41a85245e769b6f6f14f0c6db0:

  usb: typec: tcpm: Correct the PPS out_volt calculation (2019-01-31 09:14:00 +0100)

----------------------------------------------------------------
USB fixes for 5.0-rc6

Here are some small USB fixes for 5.0-rc6.

Nothing huge, the normal amount of USB gadget fixes as well as some USB
phy fixes.  There's also a typec fix as well.  Full details are in the
shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Khoroshilov (1):
      usb: dwc3: exynos: Fix error handling of clk_prepare_enable

Anders Roxell (1):
      usb: phy: fix link errors

Bin Liu (1):
      usb: phy: am335x: fix race condition in _probe

Greg Kroah-Hartman (1):
      Merge tag 'fixes-for-v5.0-rc4' of git://git.kernel.org/.../balbi/usb into usb-linus

Gustavo A. R. Silva (1):
      usb: gadget: udc: net2272: Fix bitwise and boolean operations

Kyle Tso (1):
      usb: typec: tcpm: Correct the PPS out_volt calculation

Paul Elder (1):
      usb: gadget: musb: fix short isoc packets with inventra dma

Tejas Joglekar (1):
      usb: dwc3: gadget: Handle 0 xfer length for OUT EP

 drivers/usb/dwc3/dwc3-exynos.c   |  4 ++--
 drivers/usb/dwc3/gadget.c        |  2 +-
 drivers/usb/gadget/udc/net2272.c |  2 +-
 drivers/usb/musb/musb_gadget.c   | 13 +------------
 drivers/usb/musb/musbhsdma.c     | 21 +++++++++++----------
 drivers/usb/phy/Kconfig          |  2 +-
 drivers/usb/phy/phy-am335x.c     |  5 +----
 drivers/usb/typec/tcpm/tcpm.c    |  3 ++-
 8 files changed, 20 insertions(+), 32 deletions(-)
