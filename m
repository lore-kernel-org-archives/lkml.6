Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D6CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4B621479
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bub7JWVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4B621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeLADOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeLADOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:14:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E784D2146F;
        Fri, 30 Nov 2018 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543593899;
        bh=EQMqvhBWT0RXGVnrRwx1B5v6xCIFrgbum/RlzPShH/g=;
        h=Date:From:To:Cc:Subject:From;
        b=bub7JWVZxTPcysgjtF3BTaLF2t1Nk7eAvm2OCcUDT3otJg7Hz8IaN9um6CsjkPKfB
         BtZhadKts1VQuTCBrQJc95yQzjjUMAy71TWOgxkXrcnUNeZWrve8gqHdxtCzK8/aWJ
         DcR5S7inJbz1iCENEFfDf/cWEZ7nmoBnZLfg3xnY=
Date:   Fri, 30 Nov 2018 17:04:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver fixes for 4.20-rc5
Message-ID: <20181130160457.GA2944@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-4.20-rc5

for you to fetch changes up to c648284f6c9606f1854816086593eeae5556845a:

  Merge tag 'iio-fixes-for-4.20a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2018-11-22 09:37:36 +0100)

----------------------------------------------------------------
Staging and IIO driver fixes for 4.20-rc5

Here are some small IIO and Staging driver fixes for 4.20-rc5.

Nothing major, the IIO fix ended up touching the HID drivers at the same
time, but the HID maintainer acked it.  The staging fixes are all minor
patches for reported issues and regressions, full details are in the
shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ben Wolsieffer (1):
      staging: vchiq_arm: fix compat VCHIQ_IOC_AWAIT_COMPLETION

Christophe JAILLET (1):
      staging: rtl8723bs: Fix the return value in case of error in 'rtw_wx_read32()'

Colin Ian King (3):
      drivers: staging: cedrus: find ctx before dereferencing it ctx
      staging: most: use format specifier "%s" in snprintf
      staging: mt7621-pinctrl: fix uninitialized variable ngroups

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-4.20a' of git://git.kernel.org/.../jic23/iio into staging-linus

Hans de Goede (1):
      iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for signed numbers

Larry Finger (2):
      staging: rtl8723bs: Fix incorrect sense of ether_addr_equal
      staging: rtl8723bs: Add missing return for cfg80211_rtw_get_station

Martin Kelly (1):
      iio:st_magn: Fix enable device after trigger

Sergio Paracuellos (1):
      staging: mt7621-dma: fix potentially dereferencing uninitialized 'tx_desc'

Spencer E. Olson (2):
      staging: comedi: ni_mio_common: scale ao INSN_CONFIG_GET_CMD_TIMING_CONSTRAINTS
      staging: comedi: clarify/unify macros for NI macro-defined terminals

 drivers/hid/hid-sensor-custom.c                    |  2 +-
 drivers/hid/hid-sensor-hub.c                       | 13 ++++++--
 drivers/iio/accel/hid-sensor-accel-3d.c            |  5 ++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  5 ++-
 drivers/iio/humidity/hid-sensor-humidity.c         |  3 +-
 drivers/iio/light/hid-sensor-als.c                 |  8 +++--
 drivers/iio/light/hid-sensor-prox.c                |  8 +++--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  8 +++--
 drivers/iio/magnetometer/st_magn_buffer.c          | 12 ++-----
 drivers/iio/orientation/hid-sensor-incl-3d.c       |  8 +++--
 drivers/iio/pressure/hid-sensor-press.c            |  8 +++--
 drivers/iio/temperature/hid-sensor-temperature.c   |  3 +-
 drivers/rtc/rtc-hid-sensor-time.c                  |  2 +-
 drivers/staging/comedi/comedi.h                    | 39 ++++++++++++----------
 drivers/staging/comedi/drivers/ni_mio_common.c     |  3 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        | 22 ++++++------
 drivers/staging/most/core.c                        |  2 +-
 drivers/staging/mt7621-dma/mtk-hsdma.c             |  3 +-
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c    |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |  4 +--
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |  2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  7 +++-
 include/linux/hid-sensor-hub.h                     |  4 ++-
 24 files changed, 103 insertions(+), 72 deletions(-)
