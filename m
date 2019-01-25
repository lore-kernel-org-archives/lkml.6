Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C31218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548418969;
	bh=XP5k4jhSVLoPdGoC02GSYhF035CT97+lUS9C4UQvM98=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UOCvmRKQNVNXx6y+vGlrRT46pVd2tqn4iHXSIzSSPzZWRtYFfnvI/g0QpuJ+mPxf4
	 diJH/8wJgaw8L1j9xJzGdZ4FXwjSICiT2AoyEXGuD979DrhYu1ZkS1BFGjTzKpN/nT
	 TA4RXRqiJKw5jO2wHD7LUGAixLo7JbeEVs9JGYpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfAYMWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAYMWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:22:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF6A218D9;
        Fri, 25 Jan 2019 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548418966;
        bh=XP5k4jhSVLoPdGoC02GSYhF035CT97+lUS9C4UQvM98=;
        h=Date:From:To:Cc:Subject:From;
        b=XeaQgD6uHnhFXYxsF19uW6Dof9FWHUUFD8YkbRqmStqZsvMZ5pmx0C6yloGYW9LGG
         32WdOY2X2R4pOceGF3Rtweba1NRatGryXvgfvKM/NOWafEdvYicflC6YnSpQZcGBf7
         sdGM74zlen8ZYPytfjN934Ool4+wj6FOW3UxLvlc=
Date:   Fri, 25 Jan 2019 13:22:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.0-rc4
Message-ID: <20190125122244.GA7566@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.0-rc4

for you to fetch changes up to 815d835b7ba46685c316b000013367dacb2b461b:

  serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling (2019-01-22 09:32:08 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 5.0-rc4

Here are a number of small tty core and serial driver fixes for 5.0-rc4
to resolve some reported issues.

Nothing major, the small serial driver fixes, a tty core fixup for a
crash that was reported, and some good vt fixes from Nicolas Pitre as he
seems to be auditing that chunk of code a lot lately.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      tty: Handle problem if line discipline does not have receive_buf

He Zhe (1):
      serial: 8250: Fix serial8250 initialization crash

Matthias Kaehlcke (1):
      tty: serial: qcom_geni_serial: Allow mctrl when flow control is disabled

Nicolas Pitre (4):
      vt: make vt_console_print() compatible with the unicode screen buffer
      vt: always call notifier with the console lock held
      vt: invoke notifier on screen size change
      vgacon: unconfuse vc_origin when using soft scrollback

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning

Samir Virmani (1):
      uart: Fix crash in uart_write and uart_put_char

Tomonori Sakita (1):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling

 drivers/tty/n_hdlc.c                  |  1 +
 drivers/tty/serial/8250/8250_core.c   | 17 ++++++------
 drivers/tty/serial/fsl_lpuart.c       |  2 +-
 drivers/tty/serial/qcom_geni_serial.c |  4 +--
 drivers/tty/serial/serial_core.c      | 12 ++++++---
 drivers/tty/tty_io.c                  |  3 ++-
 drivers/tty/vt/vt.c                   | 50 ++++++++++++-----------------------
 drivers/video/console/vgacon.c        |  7 ++---
 8 files changed, 44 insertions(+), 52 deletions(-)
