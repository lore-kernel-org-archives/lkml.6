Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E44ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C423F21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAPPQCdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C423F21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJTBH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeJTBH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:07:57 -0400
Received: from localhost (unknown [178.231.37.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768E421476;
        Fri, 19 Oct 2018 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539968461;
        bh=2oSPe4u8LurHZUNitp43OON1xUWrXifYyw1P0KwT4U0=;
        h=Date:From:To:Cc:Subject:From;
        b=RAPPQCdAlpq6Q3KVQp8gCddrNG1qEim5QfYcIMm00cuYCyI+wv5Dw2JxBEToq8tf/
         MRhsyZa2nXPM9jBUYP0NFZXIcoRkl33lcpb5s/Nc4vpxa5Uqr7rhtPr5c4L7vq85E3
         Rb1XSJClA0/wm8lJlZ5AdM0hvNGf/baA/aqPtk08=
Date:   Fri, 19 Oct 2018 19:00:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.19-final
Message-ID: <20181019170057.GA21010@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.19-final

for you to fetch changes up to 9ae24af3669111d418242caec8dd4ebd9ba26860:

  usb: gadget: storage: Fix Spectre v1 vulnerability (2018-10-17 20:57:55 +0200)

----------------------------------------------------------------
USB fixes for 4.19-final

Here are a small number of last-minute USB driver fixes

Included here are:
  - spectre fix for usb storage gadgets
  - xhci fixes
  - cdc-acm fixes
  - usbip fixes for reported problems

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: fix the usbfs flag sanitization for control transfers

Gustavo A. R. Silva (1):
      usb: gadget: storage: Fix Spectre v1 vulnerability

Heikki Krogerus (1):
      usb: xhci: pci: Enable Intel USB role mux on Apollo Lake platforms

Oliver Neukum (1):
      cdc-acm: fix race between reset and control messaging

Shuah Khan (Samsung OSG) (2):
      selftests: usbip: add wait after attach and before checking port status
      usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()

Tobias Herzog (2):
      cdc-acm: do not reset notification buffer index upon urb unlinking
      cdc-acm: correct counting of UART states in serial state notification

Wan Ahmad Zainie (1):
      usb: roles: intel_xhci: Fix Unbalanced pm_runtime_enable

 drivers/usb/class/cdc-acm.c                        | 16 +++---
 drivers/usb/core/devio.c                           |  4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  3 ++
 drivers/usb/host/xhci-pci.c                        |  6 ++-
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |  2 +
 drivers/usb/usbip/vhci_hcd.c                       | 57 ++++++++++++++++------
 .../selftests/drivers/usb/usbip/usbip_test.sh      |  4 ++
 7 files changed, 65 insertions(+), 27 deletions(-)
