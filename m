Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeEWGZJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:25:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36033 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbeEWGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:25:05 -0400
X-Google-Smtp-Source: AB8JxZpWfHyypu2dfG67NKNTc7BJWQhIqNTqUCl6lih+R0TlTJBIEycFu3BDR9cWNPyTxxQliZxi5w==
Date: Wed, 23 May 2018 07:25:02 +0100
From: Lee Jones <lee.jones@linaro.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v4.17
Message-ID: <20180523062502.GS5130@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This fix seemingly builds fine for me locally:

 [for-mfd-fixes]$ ls -l build-x86/drivers/mfd/cros_ec_spi.o 
  -rw-rw-r-- 1 lee lee 39880 May 23 06:59 build-x86/drivers/mfd/cros_ec_spi.o
 [for-mfd-fixes]$ ls -l build-multi-v7/drivers/mfd/cros_ec_spi.o 
  -rw-rw-r-- 1 lee lee 10032 May 23 06:59 build-multi-v7/drivers/mfd/cros_ec_spi.o

... but hasn't been soak tested in -next for any length of time.

The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-4.17

for you to fetch changes up to 11799564fc7eedff50801950090773928f867996:

  mfd: cros_ec: Retry commands when EC is known to be busy (2018-05-23 06:59:00 +0100)

----------------------------------------------------------------
Single fix correcting the handling for long-running commands; cros_ec_spi

----------------------------------------------------------------
Brian Norris (1):
      mfd: cros_ec: Retry commands when EC is known to be busy

 drivers/mfd/cros_ec_spi.c               | 24 ++++++++++++++++++++----
 drivers/platform/chrome/cros_ec_proto.c |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)
 
--
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
