Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D066C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B772064C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547374977;
	bh=ZYGz/9hlWDwI2hhAJAAmuXKD6dDi1qQqUw791qESIl8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=A6cxqPcX95IPpy1u51C6Ja18YcHAQUKBtKpoKehYCFMQr+lf6ekSWPbZx30dRRsl5
	 ++hLi9nkCFxKj4yGvYRiCv8ySMeAw7OSMLrU7QEpYSEWpbzknm6e3QuiwdLidFabcY
	 I+F9+dbtIcmo/dE8KIuHY1KhnY0TbsNg766sZ740=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfAMKW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 05:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAMKWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 05:22:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08662064C;
        Sun, 13 Jan 2019 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547374975;
        bh=ZYGz/9hlWDwI2hhAJAAmuXKD6dDi1qQqUw791qESIl8=;
        h=Date:From:To:Cc:Subject:From;
        b=PqXmOJHn4qw3SQf+cQrbOQjerCKPqdIpBGKU1fVY1xtLi1TJgkCG+eQ1L0o1J8d3Q
         TEygZ7eHDyd9LMmf2WGYA65jcXoHTP7h7ez8dC3rp0upVXpfzSYqZOFSYu4ZBRZdQF
         aARO/vnVVztvInv5mL3H/ZPnqL3CJzEq4u+Sgsew=
Date:   Sun, 13 Jan 2019 11:22:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.0-rc2
Message-ID: <20190113102252.GA12640@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.0-rc2

for you to fetch changes up to b9fcb0e6b7052b7e2d18fed1d673f8247060c32c:

  usb: storage: Remove outdated URL from MAINTAINERS (2019-01-08 16:49:23 +0100)

----------------------------------------------------------------
USB fixes for 5.0-rc2

Here are some small USB driver fixes and quirk updates for 5.0-rc2.

The majority here are some quirks for some storage devices to get them
to work properly.  There's also a fix here to resolve the reported
issues with some audio devices that say they are UAC3 compliant, but
really are not.

And a fix up for the MAINTAINERS file to remove a dead url.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems

David Brown (1):
      usb: storage: Remove outdated URL from MAINTAINERS

Icenowy Zheng (2):
      USB: storage: don't insert sane sense for SPC3+ when bad sense specified
      USB: storage: add quirk for SMI SM3350

Jack Stocker (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Saranya Gopal (1):
      usbcore: Select only first configuration for non-UAC3 compliant devices

 MAINTAINERS                        |  1 -
 drivers/usb/class/cdc-acm.c        |  7 +++++++
 drivers/usb/core/generic.c         |  9 ++++++---
 drivers/usb/core/quirks.c          |  3 ++-
 drivers/usb/storage/scsiglue.c     |  8 ++++++--
 drivers/usb/storage/unusual_devs.h | 12 ++++++++++++
 6 files changed, 33 insertions(+), 7 deletions(-)
