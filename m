Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4068FC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10282146E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10282146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeHSQHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 12:07:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeHSQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 12:07:31 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5E56CBE;
        Sun, 19 Aug 2018 12:56:06 +0000 (UTC)
Date:   Sun, 19 Aug 2018 14:56:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 4.19-rc1
Message-ID: <20180819125604.GA24731@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.19-rc1

for you to fetch changes up to 3d27c4de8d4fb2d4099ff324671792aa2578c6f9:

  Revert "uio: use request_threaded_irq instead" (2018-08-12 17:30:58 +0200)

----------------------------------------------------------------
Char/Misc fix for 4.19-rc1

Here is a single UIO fix that I forgot to send before 4.18-final came
out.  It reverts a UIO patch that went in the 4.18 development window
that was causing problems.

This patch has been in linux-next for a while with no problems, I just
forgot to send it earlier, or as part of the larger char/misc patch
series from yesterday, my fault.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Xiubo Li (1):
      Revert "uio: use request_threaded_irq instead"

 drivers/uio/uio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
