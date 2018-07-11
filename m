Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F45C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A23F2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A23F2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGKLAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:00:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGKLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:00:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CEEAFD48;
        Wed, 11 Jul 2018 10:56:44 +0000 (UTC)
Date:   Wed, 11 Jul 2018 12:56:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.18-rc5
Message-ID: <20180711105642.GA18037@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.18-rc5

for you to fetch changes up to f1e255d60ae66a9f672ff9a207ee6cd8e33d2679:

  USB: yurex: fix out-of-bounds uaccess in read handler (2018-07-06 17:21:34 +0200)

----------------------------------------------------------------
USB fixes for 4.18-rc5

Here are a number of small USB fixes for 4.18-rc5.

Nothing major here, just the normal set of new device ids, xhci fixes,
and some typec fixes.  The typec fix required some tiny changes in an
i2c driver, which that maintainer acked to come through my tree.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency

Dan Carpenter (2):
      USB: serial: ch341: fix type promotion bug in ch341_control_in()
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-4.18-rc4' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Hans de Goede (2):
      typec: tcpm: Correctly report power_supply current and voltage for non pd supply
      i2c-cht-wc: Fix bq24190 supplier

Jann Horn (1):
      USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold (2):
      USB: serial: keyspan_pda: fix modem-status error handling
      USB: serial: mos7840: fix status-register error handling

Kai-Heng Feng (1):
      usb: xhci: dbc: Don't decrement runtime PM counter if DBC is not started

Laurentiu Tudor (1):
      docs: kernel-parameters.txt: document xhci-hcd.quirks parameter

Nico Sneck (1):
      usb: quirks: add delay quirks for Corsair Strafe

Olli Salonen (1):
      USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/i2c/busses/i2c-cht-wc.c                 |  3 ++-
 drivers/usb/core/quirks.c                       |  4 ++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig      |  1 +
 drivers/usb/host/xhci-dbgcap.c                  | 12 ++++++++----
 drivers/usb/host/xhci-mem.c                     |  2 +-
 drivers/usb/misc/yurex.c                        | 23 ++++++-----------------
 drivers/usb/serial/ch341.c                      |  2 +-
 drivers/usb/serial/cp210x.c                     |  1 +
 drivers/usb/serial/keyspan_pda.c                |  4 +++-
 drivers/usb/serial/mos7840.c                    |  3 +++
 drivers/usb/typec/tcpm.c                        |  5 +++--
 12 files changed, 38 insertions(+), 27 deletions(-)
