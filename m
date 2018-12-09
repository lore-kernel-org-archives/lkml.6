Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17504C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C452020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544354210;
	bh=IOvJuu2/ACiZq3Hjj5p7VcW7+wyQqnDwJqDjmzPJhW8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wBU4NUA6I0g+J1tlQxkT5aVYcBku/ZNur0A6Zz9NEvaLCIWH2SSbmya48/KsI7wxY
	 hc8n0bF700D77t5Mlywz94gjJVkvYsnUUd5e3+glKbnDZrMgahIYZ6dD+wsSRovogg
	 DBtodx/b5j2a7QlaqNGYXylWciOEMHraaFI9mXvc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C452020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLILQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeLILQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:16:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53ABB20661;
        Sun,  9 Dec 2018 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544354208;
        bh=IOvJuu2/ACiZq3Hjj5p7VcW7+wyQqnDwJqDjmzPJhW8=;
        h=Date:From:To:Cc:Subject:From;
        b=iMngNx2IcktHoeVdPQjTvDwvfPAQ6e/eJ2yuoAn/OQ5wa6rZ/WdGt6GmLxYtPD5wr
         t9umWyIUkvoQw9GISxir1Jyzj4UwNqsUZFwd7Lt7yCmNf90jyqeGeZTrjo1ZV+2/aq
         UHO60ycFDHB9bWYo8zL3gE5DIRrk67G+4jE2lm60=
Date:   Sun, 9 Dec 2018 12:16:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver fixes for 4.20-rc6
Message-ID: <20181209111646.GB9556@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.20-rc6

for you to fetch changes up to 3caad34eab57e622dad48086af7f89c19001664e:

  Merge tag 'usb-serial-4.20-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2018-12-06 18:02:58 +0100)

----------------------------------------------------------------
USB fixes for 4.20-rc6

Here are some small USB fixes for 4.20-rc6

The "largest" here are some xhci fixes for reported issues.  Also here
is a USB core fix, some quirk additions, and a usb-serial fix which
required the export of one of the tty layer's functions to prevent code
duplication.  The tty maintainer agreed with this change.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: Fix invalid-free bug in port_over_current_notify()

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-4.20-rc6' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Johan Hovold (1):
      USB: serial: console: fix reported terminal settings

Mathias Nyman (1):
      xhci: Prevent U1/U2 link pm states if exit latency is too long

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

Sandeep Singh (1):
      xhci: workaround CSS timeout on AMD SNPS 3.0 xHC

 drivers/tty/tty_io.c            | 11 +++++++++--
 drivers/usb/core/hub.c          |  5 +++--
 drivers/usb/core/quirks.c       |  4 ++++
 drivers/usb/core/usb.c          |  6 +++---
 drivers/usb/host/hwa-hc.c       |  2 +-
 drivers/usb/host/xhci-pci.c     |  4 ++++
 drivers/usb/host/xhci.c         | 42 +++++++++++++++++++++++++++++++++++++----
 drivers/usb/host/xhci.h         |  3 +++
 drivers/usb/misc/appledisplay.c |  1 +
 drivers/usb/serial/console.c    |  2 +-
 include/linux/tty.h             |  1 +
 include/linux/usb.h             |  4 ++--
 12 files changed, 70 insertions(+), 15 deletions(-)
