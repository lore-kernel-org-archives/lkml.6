Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C107214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C107214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeIYUcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:32:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbeIYUcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:32:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B9A3E23;
        Tue, 25 Sep 2018 14:25:00 +0000 (UTC)
Date:   Tue, 25 Sep 2018 16:24:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.19-rc4
Message-ID: <20180925142457.GA27274@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.19-rc6

for you to fetch changes up to 3e3b81965cbfa01fda6d77750feedc3c46fc28d0:

  usb: typec: mux: Take care of driver module reference counting (2018-09-20 13:35:01 +0200)

----------------------------------------------------------------
USB fixes for 4.19-rc6

Here are some small USB core and driver fixes for reported issues for
4.19-rc6.

The most visible is the oops fix for when the USB core is built into the
kernel that is present in 4.18.  Turns out not many people actually do
that so it went unnoticed for a while.  The rest is some tiny typec,
musb, and other core fixes.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (3):
      USB: remove LPM management from usb_driver_claim_interface()
      USB: fix error handling in usb_driver_claim_interface()
      USB: handle NULL config in usb_find_alt_setting()

Bin Liu (1):
      usb: musb: dsps: do not disable CPPI41 irq in driver teardown

Harry Pan (1):
      usb: core: safely deal with the dynamic quirk lists

Heikki Krogerus (2):
      usb: roles: Take care of driver module reference counting
      usb: typec: mux: Take care of driver module reference counting

Oliver Neukum (2):
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

Sebastian Andrzej Siewior (1):
      Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()"

 drivers/usb/class/cdc-wdm.c  |  2 +-
 drivers/usb/common/roles.c   | 15 ++++++++++++---
 drivers/usb/core/devio.c     | 24 +++++++++++++++++++++---
 drivers/usb/core/driver.c    | 28 ++++++++++++++--------------
 drivers/usb/core/quirks.c    |  3 ++-
 drivers/usb/core/usb.c       |  2 ++
 drivers/usb/musb/musb_dsps.c | 12 +-----------
 drivers/usb/typec/mux.c      | 17 +++++++++++++----
 8 files changed, 66 insertions(+), 37 deletions(-)
