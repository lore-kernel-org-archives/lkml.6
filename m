Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B059C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5692224F9A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5692224F9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeGAIkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:40:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeGAIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:40:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2A328BD8;
        Sun,  1 Jul 2018 08:40:16 +0000 (UTC)
Date:   Sun, 1 Jul 2018 10:40:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.18-rc3
Message-ID: <20180701084013.GA11580@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.18-rc3

for you to fetch changes up to 21eff69aaaa0e766ca0ce445b477698dc6a9f55a:

  vt: prevent leaking uninitialized data to userspace via /dev/vcs* (2018-06-28 21:34:39 +0900)

----------------------------------------------------------------
TTY/Serial fixes for 4.18-rc3

Here are 5 fixes for the tty core and some serial drivers.

The tty core one fix some security and other issues reported by the
syzbot that I have taken too long in responding to (sorry Tetsuo!).  The
8350 serial driver fix resolves an issue of devices that used to work
properly stopping working as they shouldn't have been added to a
blacklist.

All of these have been in linux-next for a few days with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Potapenko (1):
      vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Andy Shevchenko (1):
      serial: 8250_pci: Remove stalled entries in blacklist

Johan Hovold (1):
      serdev: fix memleak on module unload

Tetsuo Handa (2):
      n_tty: Fix stall at n_tty_receive_char_special().
      n_tty: Access echo_* variables carefully.

 drivers/tty/n_tty.c                | 55 ++++++++++++++++++++++----------------
 drivers/tty/serdev/core.c          |  1 +
 drivers/tty/serial/8250/8250_pci.c |  2 --
 drivers/tty/vt/vt.c                |  4 +--
 4 files changed, 35 insertions(+), 27 deletions(-)
