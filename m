Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeFBMfY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 08:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeFBMfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 08:35:23 -0400
Date: Sat, 2 Jun 2018 14:35:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] IIO driver fixes for 4.17-rc8
Message-ID: <20180602123500.GA15904@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.17-rc8

for you to fetch changes up to 9d569b1cf7a2a385770835df15f77dde587b58a3:

  Merge tag 'iio-fixes-for-4.17a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2018-05-09 17:08:29 +0200)

----------------------------------------------------------------
IIO driver fixes for 4.17-rc8

Here are some old IIO driver fixes that were sitting in my tree for a
few weeks.  Sorry about not getting them to you sooner.  They fix a
number of small IIO driver issues that have been reported.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Eugen Hristev (2):
      iio: adc: at91-sama5d2_adc: fix channel configuration for differential channels
      iio: adc: select buffer for at91-sama5d2_adc

Fabrice Gasnier (2):
      iio: adc: stm32-dfsdm: fix successive oversampling settings
      iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-4.17a' of git://git.kernel.org/.../jic23/iio into staging-linus

Hans de Goede (1):
      iio: hid-sensor-trigger: Fix sometimes not powering up the sensor after resume

Martin Kelly (2):
      iio:buffer: make length types match kfifo types
      iio:kfifo_buf: check for uint overflow

Michael Nosthoff (1):
      iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ

 drivers/iio/adc/Kconfig                            |  1 +
 drivers/iio/adc/ad7793.c                           | 75 +++++++---------------
 drivers/iio/adc/at91-sama5d2_adc.c                 | 41 ++++++++++--
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 17 ++++-
 drivers/iio/buffer/industrialio-buffer-dma.c       |  2 +-
 drivers/iio/buffer/kfifo_buf.c                     | 11 +++-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  8 +--
 include/linux/iio/buffer_impl.h                    |  6 +-
 8 files changed, 93 insertions(+), 68 deletions(-)
