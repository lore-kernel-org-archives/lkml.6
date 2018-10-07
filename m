Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD2AC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE922088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE922088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJGNMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 09:12:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJGNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 09:12:35 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 520DDD10;
        Sun,  7 Oct 2018 06:06:25 +0000 (UTC)
Date:   Sun, 7 Oct 2018 08:06:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.19-rc7
Message-ID: <20181007060622.GA13764@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.19-rc7

for you to fetch changes up to 555df5820e733cded7eb8d0bf78b2a791be51d75:

  usb: xhci-mtk: resume USB3 roothub first (2018-10-01 17:59:02 -0700)

----------------------------------------------------------------
USB fixes for 4.19-rc7

Here are some small USB fixes for 4.19-rc7

These include:
   - the usual xhci bugfixes for reported issues
   - some new serial driver device ids
   - bugfix for the option serial driver for some devices
   - bugfix for the cdc_acm driver that has been there for a long time.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chunfeng Yun (1):
      usb: xhci-mtk: resume USB3 roothub first

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-4.19-rc7' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Johan Hovold (2):
      USB: serial: option: add two-endpoints device-id flag
      USB: serial: simple: add Motorola Tetra MTP6550 id

Kristian Evensen (1):
      USB: serial: option: improve Quectel EP06 detection

Mathias Nyman (1):
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Romain Izard (1):
      usb: cdc_acm: Do not leak URB buffers

 drivers/usb/class/cdc-acm.c            |  6 ++++++
 drivers/usb/host/xhci-mtk.c            |  4 ++--
 drivers/usb/host/xhci-pci.c            |  2 ++
 drivers/usb/serial/option.c            | 15 +++++++++++++--
 drivers/usb/serial/usb-serial-simple.c |  3 ++-
 5 files changed, 25 insertions(+), 5 deletions(-)
