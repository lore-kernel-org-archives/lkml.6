Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08D4C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DED2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DED2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeGZPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:37:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbeGZPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:37:13 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5361BAC;
        Thu, 26 Jul 2018 14:20:01 +0000 (UTC)
Date:   Thu, 26 Jul 2018 16:19:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.18-rc7
Message-ID: <20180726141937.GA14111@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.18-rc7

for you to fetch changes up to 249a32b7eeb3edb6897dd38f89651a62163ac4ed:

  usb: core: handle hub C_PORT_OVER_CURRENT condition (2018-07-21 08:38:29 +0200)

----------------------------------------------------------------
USB fixes for 4.18-rc7

Here are a number of USB fixes and new device ids for 4.18-rc7.

The largest number are a bunch of gadget driver fixes that got delayed
in being submitted earlier due to vacation schedules, but nothing really
huge is present in them.  There are some new device ids and some PHY
driver fixes that were connected to some USB ones.  Full details are in
the shortlog.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Thomson (1):
      usb: typec: tcpm: Fix sink PDO starting index for PPS APDO selection

Antti Seppälä (2):
      usb: dwc2: Fix DMA alignment to start at allocated boundary
      usb: dwc2: Fix inefficient copy of unaligned buffers

Benjamin Herrenschmidt (3):
      usb: gadget: aspeed-vhub: Fix SETUP packets with OUT data phase
      usb: gadget: Fix OS descriptors support
      usb: gadget: aspeed: Workaround memory ordering issue

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition

Colin Ian King (1):
      usb: dwc3: gadget: remove redundant variable maxpacket

Dmitry Torokhov (1):
      usb: dwc2: host: do not delay retries for CONTROL IN transfers

Enric Balletbo i Serra (1):
      usb: dwc3: rockchip: Fix PHY documentation links.

Eugeniu Rosca (3):
      usb: gadget: f_uac2: fix error handling in afunc_bind (again)
      usb: gadget: u_audio: fix pcm/card naming in g_audio_setup()
      usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'

Fabio Estevam (1):
      usb: chipidea: Always build ULPI code

Greg Kroah-Hartman (3):
      Merge tag 'usb-ci-v4.18-rc4' of git://git.kernel.org/.../peter.chen/usb into usb-linus
      Merge tag 'phy-for-4.18-rc' of git://git.kernel.org/.../kishon/linux-phy into usb-linus
      Merge tag 'fixes-for-v4.18-rc5' of git://git.kernel.org/.../balbi/usb into usb-linus

Jaedon Shin (1):
      phy: phy-brcm-usb-init: Fix power down USB 3.0 PHY when XHCI reenabled

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Jia-Ju Bai (2):
      usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
      usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in r8a66597_queue()

John Keeping (1):
      usb: dwc2: avoid NULL dereferences

Joshua Frkuska (1):
      usb: gadget: u_audio: update hw_ptr in iso_complete after data copied

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000

Peter Senna Tschudin (1):
      tools: usb: ffs-test: Fix build on big endian systems

Randy Dunlap (1):
      usb/phy: fix PPC64 build errors in phy-fsl-usb.c

Tony Lindgren (1):
      phy: mapphone-mdm6600: Fix wrong enum used for status lines

Vladimir Zapolskiy (3):
      usb: gadget: u_audio: remove caching of stream buffer parameters
      usb: gadget: u_audio: remove cached period bytes value
      usb: gadget: u_audio: protect stream runtime fields with stream spinlock

Zheng Xiaowei (1):
      usb: xhci: Fix memory leak in xhci_endpoint_reset()

 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  3 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c           |  4 +
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |  4 +-
 drivers/usb/chipidea/Kconfig                       |  9 +--
 drivers/usb/chipidea/Makefile                      |  3 +-
 drivers/usb/chipidea/ci.h                          |  8 --
 drivers/usb/chipidea/ulpi.c                        |  3 +
 drivers/usb/class/cdc-acm.c                        |  3 +
 drivers/usb/core/hub.c                             |  8 +-
 drivers/usb/dwc2/gadget.c                          |  6 +-
 drivers/usb/dwc2/hcd.c                             | 54 +++++++------
 drivers/usb/dwc2/hcd_intr.c                        |  9 ++-
 drivers/usb/dwc3/ep0.c                             |  3 -
 drivers/usb/gadget/composite.c                     |  1 -
 drivers/usb/gadget/function/f_fs.c                 |  2 +-
 drivers/usb/gadget/function/f_uac2.c               | 24 +++---
 drivers/usb/gadget/function/u_audio.c              | 88 ++++++++--------------
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c           | 11 ++-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           | 14 +++-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          | 33 ++++++++
 drivers/usb/gadget/udc/r8a66597-udc.c              |  6 +-
 drivers/usb/host/xhci.c                            |  1 +
 drivers/usb/phy/phy-fsl-usb.c                      |  4 +-
 drivers/usb/typec/tcpm.c                           |  2 +-
 tools/usb/ffs-test.c                               | 19 ++++-
 25 files changed, 187 insertions(+), 135 deletions(-)
