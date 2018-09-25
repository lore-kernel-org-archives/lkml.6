Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D517C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C22208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C22208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeIYUcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:32:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbeIYUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:32:24 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BD52E23;
        Tue, 25 Sep 2018 14:24:38 +0000 (UTC)
Date:   Tue, 25 Sep 2018 16:24:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.19-rc6
Message-ID: <20180925142435.GA27225@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.19-rc6

for you to fetch changes up to 7e620984b62532783912312e334f3c48cdacbd5d:

  serial: imx: restore handshaking irq for imx1 (2018-09-20 14:51:31 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.19-rc6

Here are a number of small tty and serial driver fixes for reported
issues for 4.19-rc6.

One should hopefully resolve a much-reported issue that syzbot has found
in the tty layer.  Although there are still more issues there, getting
this fixed is nice to see finally happen.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll

Dmitry Safonov (1):
      tty: Drop tty->count on tty_reopen() failure

Gustavo A. R. Silva (1):
      tty: vt_ioctl: fix potential Spectre v1

Jan Kiszka (1):
      serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Stefan Agner (1):
      tty: serial: lpuart: avoid leaking struct tty_struct

Uwe Kleine-König (1):
      serial: imx: restore handshaking irq for imx1

 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 10 +++++++---
 drivers/tty/serial/fsl_lpuart.c             |  3 ++-
 drivers/tty/serial/imx.c                    |  8 ++++++++
 drivers/tty/serial/mvebu-uart.c             |  1 +
 drivers/tty/tty_io.c                        | 11 ++++++++---
 drivers/tty/vt/vt_ioctl.c                   |  4 ++++
 6 files changed, 30 insertions(+), 7 deletions(-)
