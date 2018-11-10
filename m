Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E94214F1
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjGzziUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E94214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeKKEnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeKKEnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:43:08 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D6C2081C;
        Sat, 10 Nov 2018 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541876229;
        bh=BtviU7n97dgl7FvrzQeLz7zMXdDKRmwP1817RbxRtiM=;
        h=Date:From:To:Cc:Subject:From;
        b=fjGzziULOpHu+2Zio86OEQUZOPzP6ByZ8hm179LJU4omQkzC7e9knLaJNNQAac2Vd
         9AIpNTNU6Fzm/1+pb6Bxz5EjeCOrhH8C5aR2FaKsq86M54FLpcrZGXi59fxs0ERSPH
         ZHJukxIQbpTbgyyFMHLnD3JUO9kB9vpCKR4dI0KU=
Date:   Sat, 10 Nov 2018 10:57:08 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.20-rc2
Message-ID: <20181110185708.GA13637@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc2

for you to fetch changes up to 641a41dbba217ee5bd26abe6be77f8cead9cd00e:

  serial: sh-sci: Fix could not remove dev_attr_rx_fifo_timeout (2018-11-09 09:34:50 -0800)

----------------------------------------------------------------
TTY/Serial fixes for 4.20-rc2

Here are some small tty fixes for 4.20-rc2

One of these missed the original 4.19-final release, I missed that I
hadn't done a pull request for it as it was in linux-next and my branch
for a long time, that's my fault.

The others are small, fixing some reported issues and finally fixing the
termios mess for alpha so that glibc has a chance to implement some
missing functionality that has been pending for many years now.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      serial: sh-sci: Fix receive on SCIFA/SCIFB variants with DMA

H. Peter Anvin (1):
      termios, tty/tty_baudrate.c: fix buffer overrun

H. Peter Anvin (Intel) (1):
      arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

Mikulas Patocka (1):
      vt: fix broken display when running aptitude

Yoshihiro Shimoda (1):
      serial: sh-sci: Fix could not remove dev_attr_rx_fifo_timeout

 arch/alpha/include/asm/termios.h       |  8 +++++++-
 arch/alpha/include/uapi/asm/ioctls.h   |  5 +++++
 arch/alpha/include/uapi/asm/termbits.h | 17 +++++++++++++++++
 drivers/tty/serial/sh-sci.c            |  8 ++++----
 drivers/tty/tty_baudrate.c             |  4 ++--
 drivers/tty/vt/vt.c                    |  2 +-
 6 files changed, 36 insertions(+), 8 deletions(-)
