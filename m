Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE18A218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548418947;
	bh=2pi3rOZ9+pUimDrXOz6Bu369DZf3iP9QN/q6XHIcU0E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VuoESvNO+t1vIJ3VgwMVGuvN2AABJb7tkj8TzSc0IEMHlVABB/M+Dfg98UuTCRPld
	 +mI10Ir6BfHCFUTgF8bD65ss/4OxGXupvfpAIOqst1QTVRF4jPqhvBANiPOzOEBsw9
	 RBC+l0TNyGJfo7UvZHz6DVOvazGwgB+FpqPz+iRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfAYMW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAYMWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:22:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29DD218D9;
        Fri, 25 Jan 2019 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548418944;
        bh=2pi3rOZ9+pUimDrXOz6Bu369DZf3iP9QN/q6XHIcU0E=;
        h=Date:From:To:Cc:Subject:From;
        b=aBzV6BgGEyDmvHiRLzV6y6/Ky49Pm2mbbl7X2inLHVNlfW8VsnQtOnqiKhv7q1Xgp
         HtPCN1dweBqTIge/k46yHs9Dawt949F0PbIqCSJeDPryzHbYruLljbyETWoxO51SmN
         V+YsAb57o17cWvq5BgGFkgQG5n7i4kdpctt51lt8=
Date:   Fri, 25 Jan 2019 13:22:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.0-rc4
Message-ID: <20190125122221.GA7517@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc4

for you to fetch changes up to 4f9b838927812b5949a9899f14e0c9ef7f02b0c8:

  Merge tag 'usb-serial-5.0-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2019-01-18 12:58:20 +0100)

----------------------------------------------------------------
USB/PHY fixes for 5.0-rc4

Here are a number of small USB and PHY driver fixes for 5.0-rc4.

Nothing major at all, just the usual selection of USB gadget bugfixes,
some new USB serial driver ids, some SPDX fixes, and some PHY driver
fixes for reported issues.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alban Bedel (2):
      phy: ath79-usb: Fix the power on error path
      phy: ath79-usb: Fix the main reset name to match the DT binding

Bo He (1):
      usb: dwc3: gadget: synchronize_irq dwc irq in suspend

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB

Christian Lamparter (1):
      USB: leds: fix regression in usbport led trigger

Colin Ian King (1):
      phy: ti: ensure priv is not null before dereferencing it

Dan Carpenter (1):
      usb: gadget: Potential NULL dereference on allocation error

Greg Kroah-Hartman (5):
      Merge tag 'fixes-for-v5.0-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus
      USB: usbip: delete README file
      USB: serial: keyspan_usa: add proper SPDX lines for .h files
      Merge tag 'phy-for-5.0-rc' of git://git.kernel.org/.../kishon/linux-phy into usb-linus
      Merge tag 'usb-serial-5.0-rc3' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Jack Pham (1):
      usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup

John Hubbard (1):
      phy: fix build breakage: add PHY_MODE_SATA

Karoly Pados (1):
      USB: serial: ftdi_sio: fix GPIO not working in autosuspend

Lubomir Rintel (1):
      USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE

Max Schulze (1):
      USB: serial: simple: add Motorola Tetra TPG2200 device id

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix Remote Wakeup interrupt bit clearing

Peter Chen (1):
      usb: chipidea: fix static checker warning for NULL pointer

Shuah Khan (1):
      MAINTAINERS: email address update in MAINTAINERS entries

Zeng Tao (1):
      usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

 MAINTAINERS                                |  3 +++
 drivers/phy/qualcomm/phy-ath79-usb.c       |  4 ++--
 drivers/phy/ti/phy-gmii-sel.c              |  4 ++--
 drivers/usb/chipidea/ci_hdrc_imx.c         |  3 ++-
 drivers/usb/core/ledtrig-usbport.c         | 17 ++++++++++-------
 drivers/usb/dwc2/gadget.c                  |  2 +-
 drivers/usb/dwc3/gadget.c                  |  4 ++++
 drivers/usb/gadget/function/f_sourcesink.c |  2 +-
 drivers/usb/host/ehci-mv.c                 |  1 +
 drivers/usb/serial/ftdi_sio.c              | 15 ++++++++++++++-
 drivers/usb/serial/keyspan_usa26msg.h      |  1 +
 drivers/usb/serial/keyspan_usa28msg.h      |  1 +
 drivers/usb/serial/keyspan_usa49msg.h      |  1 +
 drivers/usb/serial/keyspan_usa67msg.h      |  1 +
 drivers/usb/serial/keyspan_usa90msg.h      |  1 +
 drivers/usb/serial/pl2303.c                |  1 +
 drivers/usb/serial/pl2303.h                |  2 ++
 drivers/usb/serial/usb-serial-simple.c     |  3 ++-
 drivers/usb/usbip/README                   |  7 -------
 19 files changed, 50 insertions(+), 23 deletions(-)
 delete mode 100644 drivers/usb/usbip/README
