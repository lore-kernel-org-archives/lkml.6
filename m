Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83386C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D53124F9A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D53124F9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeGAIkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:40:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeGAIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:40:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C41DBD8;
        Sun,  1 Jul 2018 08:40:37 +0000 (UTC)
Date:   Sun, 1 Jul 2018 10:40:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging/IIO driver fixes for 4.18-rc3
Message-ID: <20180701084035.GA11654@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/staging-4.18-rc3

for you to fetch changes up to ebc2dc5f9b231c1b64047c6717cd464104f086f4:

  Merge tag 'iio-fixes-4.18a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2018-06-26 07:45:52 +0800)

----------------------------------------------------------------
Staging/IIO fixes for 4.18-rc3

Here are a few small staging and IIO driver fixes for 4.18-rc3.

Nothing major or big, all just fixes for reported problems since
4.18-rc1.  All of these have been in linux-next this week with no
reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      iio: tsl2x7x/tsl2772: avoid potential division by zero

Dan Carpenter (1):
      staging: comedi: quatech_daqp_cs: fix no-op loop daqp_ao_insn_write()

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-4.18a' of git://git.kernel.org/.../jic23/iio into staging-linus

Hans de Goede (1):
      iio: imu: inv_mpu6050: Fix probe() failure on older ACPI based machines

Laura Abbott (1):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel

Leonard Crestez (1):
      iio: mma8452: Fix ignoring MMA8452_INT_DRDY

Phil Reid (1):
      iio: buffer: fix the function signature to match implementation

Tomasz Duszynski (1):
      iio: pressure: bmp280: fix relative humidity unit

 drivers/iio/accel/mma8452.c                      | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       | 2 ++
 drivers/iio/light/tsl2772.c                      | 2 ++
 drivers/iio/pressure/bmp280-core.c               | 5 ++---
 drivers/staging/android/ion/ion_heap.c           | 2 +-
 drivers/staging/comedi/drivers/quatech_daqp_cs.c | 2 +-
 include/linux/iio/buffer-dma.h                   | 2 +-
 7 files changed, 10 insertions(+), 7 deletions(-)
