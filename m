Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9B21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549615121;
	bh=8E/rO60M8t0gTniu5XrnYumLpfgAPIbjBtx5752AcvU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=00xDaaLaxmp+PrEGAo+0/Nunz7eLv1Rr3dWCekEBYfRtzZm2vLrfNLHMR+cYJ5Nmi
	 zDbOhZM0Drns/qyPna9qFONgwvEIAm1Ha+be3MITYBLyMiAc/KVUcQdiyvg3FeNb/H
	 FGvKGGrmYDLgSLRa+cVH2Jpyu3eFzfmw5Kam8uMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfBHIij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:38:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfBHIii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:38:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C7A21917;
        Fri,  8 Feb 2019 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549615117;
        bh=8E/rO60M8t0gTniu5XrnYumLpfgAPIbjBtx5752AcvU=;
        h=Date:From:To:Cc:Subject:From;
        b=wzg1Y/LTm6+3nAwlLj8rBt+W9p5LwWLVi2CgzGpjM8cAi/boxpW/orDuSJ7CaDikV
         SdISbGFWNYRDP3xOAKywJfLM0s12XoIAAYHtMi9UONBvhKCfEnhSUD99fa5jXGE/5W
         Q5s3IFcnvaiymuV7if7pEqkpcer4CTX4i6KTWRPs=
Date:   Fri, 8 Feb 2019 09:38:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.0-rc6
Message-ID: <20190208083835.GA26921@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.0-rc6

for you to fetch changes up to 6d923f8fe821c0c6b5378635cbcc9da5f5ec520a:

  Merge tag 'iio-fixes-5.0a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2019-02-03 13:10:41 +0100)

----------------------------------------------------------------
Staging/IIO driver fixes for 5.0-rc6

Here are some small iio and staging driver fixes for 5.0-rc6.

Nothing big, just resolve some reported IIO driver issues, and one
staging driver bug.  One staging driver patch was added and then
reverted as well.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaro Koskinen (1):
      staging: octeon: fix broken phylib usage

Dan Murphy (1):
      iio: ti-ads8688: Update buffer allocation for timestamps

Gao Xiang (1):
      staging: erofs: keep corrupted fs from crashing kernel in erofs_namei()

Greg Kroah-Hartman (2):
      Revert "staging: erofs: keep corrupted fs from crashing kernel in erofs_namei()"
      Merge tag 'iio-fixes-5.0a' of git://git.kernel.org/.../jic23/iio into staging-linus

Hans de Goede (1):
      iio: adc: axp288: Fix TS-pin handling

Martin Kelly (1):
      tools: iio: iio_generic_buffer: make num_loops signed

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius

 drivers/iio/adc/axp288_adc.c           | 76 +++++++++++++++++++++++++++-------
 drivers/iio/adc/ti-ads8688.c           |  3 +-
 drivers/iio/chemical/atlas-ph-sensor.c |  7 ++--
 drivers/staging/octeon/ethernet-mdio.c |  2 +-
 tools/iio/iio_generic_buffer.c         |  2 +-
 5 files changed, 67 insertions(+), 23 deletions(-)
