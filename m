Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A8EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C99820831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Bb2tezo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393220AbeKVTZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:25:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbeKVTZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:25:34 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7DEC20831;
        Thu, 22 Nov 2018 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542876425;
        bh=UZ0qp2/vjt/pu52gAySsVB7qhnE3R0MtJuA1x1E/5+o=;
        h=Date:From:To:Cc:Subject:From;
        b=0Bb2tezo3LzsjZ5tQusyAMOCVRFComb7/AOq36cO6NYaQq1HmYsB417F2v6BzzkWR
         wBWNiY3LMVMNaytdnbEmE82N0XeSmEBoDKpJuXcWGNZZCrcD5GtSYWMmXUspiACm9l
         IdunkpcfSisNHo83JLHdN7UHg2QtGvwAb9rpImmQ=
Date:   Thu, 22 Nov 2018 09:45:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.20-rc4
Message-ID: <20181122084539.GA22578@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.20-rc4

for you to fetch changes up to 63529eaa6164ef7ab4b907b25ac3648177e5e78f:

  usb: cdc-acm: add entry for Hiro (Conexant) modem (2018-11-20 12:12:06 +0100)

----------------------------------------------------------------
USB fixes for 4.20-rc4

Here are a number of small USB fixes for 4.20-rc4.

There's the usual xhci and dwc2/3 fixes as well as a few minor other
issues resolved for problems that have been reported.  Full details are
in the shortlog.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaron Ma (2):
      usb: xhci: fix uninitialized completion when USB3 port got wrong status
      usb: xhci: fix timeout for transition from RExit to U0

Andy Shevchenko (1):
      usb: dwc3: core: Clean up ULPI device

Cherian, George (1):
      xhci: Add quirk to workaround the errata seen on Cavium Thunder-X2 Soc

Dan Carpenter (1):
      usb: dwc2: pci: Fix an error code in probe

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost

Emmanuel Pescosta (1):
      usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Felipe Balbi (1):
      usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers

Greg Kroah-Hartman (1):
      Merge tag 'fixes-for-v4.20-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus

Kai-Heng Feng (2):
      USB: Wait for extra delay time after USB_PORT_FEAT_RESET for quirky hub
      USB: quirks: Add no-lpm quirk for Raydium touchscreens

Kuppuswamy Sathyanarayanan (1):
      usb: dwc3: Fix NULL pointer exception in dwc3_pci_remove()

Maarten Jacobs (1):
      usb: cdc-acm: add entry for Hiro (Conexant) modem

Mathias Nyman (3):
      xhci: Fix leaking USB3 shared_hcd at xhci removal
      xhci: handle port status events for removed USB3 hcd
      usb: xhci: Prevent bus suspend if a port connect change or polling state is detected

Mattias Jacobsson (1):
      USB: misc: appledisplay: add 20" Apple Cinema Display

Sandeep Singh (1):
      xhci: Add check for invalid byte size error when UAS devices are connected.

Shen Jing (1):
      Revert "usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers"

Thinh Nguyen (1):
      usb: dwc3: gadget: Properly check last unaligned/zero chain TRB

 Documentation/admin-guide/kernel-parameters.txt |  2 +
 drivers/usb/class/cdc-acm.c                     |  3 ++
 drivers/usb/core/hub.c                          | 18 +++++--
 drivers/usb/core/quirks.c                       | 14 ++++++
 drivers/usb/dwc2/pci.c                          |  1 +
 drivers/usb/dwc3/core.c                         |  1 +
 drivers/usb/dwc3/dwc3-pci.c                     |  4 +-
 drivers/usb/dwc3/gadget.c                       |  8 +--
 drivers/usb/gadget/function/f_fs.c              | 26 +++-------
 drivers/usb/host/xhci-histb.c                   |  6 ++-
 drivers/usb/host/xhci-hub.c                     | 66 ++++++++++++++++++-------
 drivers/usb/host/xhci-mtk.c                     |  6 ++-
 drivers/usb/host/xhci-pci.c                     |  6 +++
 drivers/usb/host/xhci-plat.c                    |  6 ++-
 drivers/usb/host/xhci-ring.c                    | 45 ++++++++++++++++-
 drivers/usb/host/xhci-tegra.c                   |  1 +
 drivers/usb/host/xhci.c                         |  2 -
 drivers/usb/host/xhci.h                         |  3 +-
 drivers/usb/misc/appledisplay.c                 |  1 +
 include/linux/usb/quirks.h                      |  3 ++
 20 files changed, 167 insertions(+), 55 deletions(-)
