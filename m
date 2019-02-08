Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65069C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2750221920
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549615093;
	bh=7tetpEgvPKUIEq2DlT0o3sei1pmBACm8Us7tRu59qeI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=A13zaLLqJMv9nIjDMxFyJxQj8hECwLRRgaC+H7RYknwop6Fll5v2cY+uDGNg0875w
	 sXmS3QrFhNPg63Ug6WevAXn8cbAZsABEV7Ryfil5cUFJy4fevfqAk0EymoXMj3cMoW
	 QoJi6tSYPV0dC4R/3Bdd4c0VkbkQ2TZQQ0NyeguA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfBHIiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:38:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBHIiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:38:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95CA21917;
        Fri,  8 Feb 2019 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549615090;
        bh=7tetpEgvPKUIEq2DlT0o3sei1pmBACm8Us7tRu59qeI=;
        h=Date:From:To:Cc:Subject:From;
        b=ySmrzBJFnMB89Kj4o8sZqhi0CmqtK/S5bJxBAAHeIpVeBfaiMfYMsHtWvpmdA25po
         rzU6f3JeKxHEzHg3/vastIQfJxi1jI8u91Ngo0E5hdMoOHQngPJfwSXd641M1rwQVx
         F83Trvrze/1nYWkp6lPUwDgOrz1FEsY+mWxFJ2RM=
Date:   Fri, 8 Feb 2019 09:38:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.0-rc6
Message-ID: <20190208083808.GA26882@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc6

for you to fetch changes up to fedb5760648a291e949f2380d383b5b2d2749b5e:

  serial: fix race between flush_to_ldisc and tty_open (2019-01-31 19:43:04 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.0-rc6

Here are some small tty and serial fixes for 5.0-rc6.

Nothing huge, just a few small fixes for reported issues.  The speakup
fix is in here as it is a tty operation issue.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serial: 8250_pci: Make PCI class test non fatal

Chris Brandt (1):
      serial: sh-sci: Do not free irqs that have already been freed

Greg Kroah-Hartman (1):
      serial: fix race between flush_to_ldisc and tty_open

Gustavo A. R. Silva (1):
      tty: serial: 8250_mtk: Fix potential NULL pointer dereference

Johan Hovold (1):
      staging: speakup: fix tty-operation NULL derefs

 drivers/staging/speakup/spk_ttyio.c | 6 ++++--
 drivers/tty/serial/8250/8250_mtk.c  | 3 +++
 drivers/tty/serial/8250/8250_pci.c  | 9 +++++----
 drivers/tty/serial/serial_core.c    | 6 ++++++
 drivers/tty/serial/sh-sci.c         | 9 ++++++++-
 5 files changed, 26 insertions(+), 7 deletions(-)
