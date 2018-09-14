Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61281FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122FA20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122FA20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeINQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:40:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34940 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeINQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:40:02 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A12BC8A;
        Fri, 14 Sep 2018 11:25:58 +0000 (UTC)
Date:   Fri, 14 Sep 2018 13:25:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver fixes for 4.19-rc4
Message-ID: <20180914112556.GA27684@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.19-rc4

for you to fetch changes up to 65aac17423284634169489f298169c3e3f099cc7:

  staging: vboxvideo: Change address of scanout buffer on page-flip (2018-09-11 18:39:54 +0200)

----------------------------------------------------------------
Staging/IIO fixes for 4.19-rc4

Here are a few small staging and iio driver fixes for -rc4.

Nothing major, just a few small bugfixes for some reported issues, and a
MAINTAINERS file update for the fbtft drivers.  We also re-enable the
building of the erofs filesystem as the patcheset that was causing it to
break never got merged in the -rc1 cycle, so there's no reason it can't
be turned back on for now.  The problem that was previously there is now
being handled in that other tree at the moment, so it will not hit us
again in the future.

All of these patches have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmed S. Darwish (1):
      staging: gasket: TODO: re-implement using UIO

Arnd Bergmann (1):
      staging: wilc1000: revert "fix TODO to compile spi and sdio components in single module"

Daniel Vetter (1):
      staging/fbtft: Update TODO and mailing lists

Gao Xiang (2):
      Revert "staging: erofs: disable compiling temporarile"
      staging: erofs: rename superblock flags (MS_xyz -> SB_xyz)

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-4.19a' of git://git.kernel.org/.../jic23/iio into staging-linus

Hans de Goede (2):
      staging: vboxvideo: Fix IRQs no longer working
      staging: vboxvideo: Change address of scanout buffer on page-flip

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: take into account ts samples in wm configuration

Matt Ranostay (1):
      Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"

Todd Poynor (1):
      MAINTAINERS: Switch a maintainer for drivers/staging/gasket

 MAINTAINERS                                    |  4 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 13 ++++++-------
 drivers/iio/temperature/maxim_thermocouple.c   |  1 -
 drivers/staging/erofs/Kconfig                  |  2 +-
 drivers/staging/erofs/super.c                  |  4 ++--
 drivers/staging/fbtft/TODO                     |  4 ++++
 drivers/staging/gasket/TODO                    | 13 +++++++++++++
 drivers/staging/vboxvideo/vbox_drv.c           |  7 +++++++
 drivers/staging/vboxvideo/vbox_mode.c          |  5 +++++
 drivers/staging/wilc1000/Makefile              |  3 +--
 drivers/staging/wilc1000/linux_wlan.c          |  6 ++++--
 drivers/staging/wilc1000/wilc_debugfs.c        |  7 +++++--
 drivers/staging/wilc1000/wilc_wlan.c           |  6 ++++++
 drivers/staging/wilc1000/wilc_wlan_if.h        |  2 --
 14 files changed, 57 insertions(+), 20 deletions(-)
