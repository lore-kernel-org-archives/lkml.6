Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F9C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FED52146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbpGqvJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FED52146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeLADOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:14:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeLADOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:14:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F3D2146F;
        Fri, 30 Nov 2018 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543593877;
        bh=+jSzTTwaGdU5gBgbLIxetrrR2KyYzzK0Q9gX1Ft3XjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GbpGqvJsiAxJR5SurQoJ4cYZhTNpJK9OEc37LfDW/6sQcODJgr3czv1q4+F9Kyuz2
         66KsVgpMe8vhz6lTdPrdNgpdPIBw6i6cnxT40PWp1Q7iuHcmbLGE8XW3duMrJDJOnG
         g/kdwsueQTruAaH0rZocrCNWlkCt4CxulutlSTtM=
Date:   Fri, 30 Nov 2018 17:04:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver fixes for 4.20-rc5
Message-ID: <20181130160434.GA2898@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.20-rc5

for you to fetch changes up to 96ae93b46dbb37a4a7a1e807d1b089f6b438840f:

  Merge tag 'fixes-for-v4.20-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus (2018-11-29 11:39:35 +0100)

----------------------------------------------------------------
USB/PHY driver fixes for 4.20-rc5

Here are some small USB and PHY driver fixes for 4.20-rc5

Nothing big at all, just the usual handful of USB fixes for reported
issues, along with some gadget and PHY driver bug fixes.

All of these have been in linux-next with no reported issues.
Note, the USB gadget fixes were in linux-next on its own branch, not in
mine, it just got merged into here yesterday and missed linux-next of
today.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaro Koskinen (5):
      USB: omap_udc: use devm_request_irq()
      USB: omap_udc: fix crashes on probe error and module removal
      USB: omap_udc: fix omap_udc_start() on 15xx machines
      USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
      USB: omap_udc: fix rejection of out transfers when DMA is used

Douglas Anderson (1):
      dt-bindings: phy-qcom-qmp: Fix several mistakes from prior commits

Felipe Balbi (1):
      Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"

Greg Kroah-Hartman (2):
      Merge tag 'phy-for-4.20-rc' of git://git.kernel.org/.../kishon/linux-phy into usb-linus
      Merge tag 'fixes-for-v4.20-rc4' of git://git.kernel.org/.../balbi/usb into usb-linus

Kai-Heng Feng (1):
      USB: usb-storage: Add new IDs to ums-realtek

Kunihiko Hayashi (1):
      phy: uniphier-pcie: Depend on HAS_IOMEM

Manu Gautam (2):
      phy: qcom-qusb2: Use HSTX_TRIM fused value as is
      phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845

Marek Szyprowski (1):
      usb: gadget: u_ether: fix unsafe list iteration

Michael Niewöhner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream series

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 31 ++++++--
 drivers/phy/qualcomm/phy-qcom-qusb2.c              | 20 ++---
 drivers/phy/socionext/Kconfig                      |  3 +-
 drivers/usb/core/quirks.c                          |  3 +
 drivers/usb/dwc3/gadget.c                          |  5 --
 drivers/usb/gadget/function/u_ether.c              | 11 +--
 drivers/usb/gadget/udc/omap_udc.c                  | 88 ++++++++--------------
 drivers/usb/storage/unusual_realtek.h              | 10 +++
 8 files changed, 86 insertions(+), 85 deletions(-)
