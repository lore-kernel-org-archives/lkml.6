Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0954D2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QikUcd0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0954D2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeJATJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:09:29 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:19132 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeJATJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:09:28 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w91CVGk8019301;
        Mon, 1 Oct 2018 21:31:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w91CVGk8019301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538397077;
        bh=UgXXvHnEK93D777EKBxhZls2GBHz6E2ziQ5mZjwQ9EQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QikUcd0MqCvxFJLBKAfmC4YtSCcimD6zOiE9cEycweDDVOxDUbJxHJ3ZN7L6jxHuR
         L8bwsL3P6PPozPaNwjw/TjvbqYGUFH3uI1xFukGLmvbFvq46fcUbXSA+HNlv27HRjn
         H/7tYVrWXAZimSMzXrUBAQFv6sdA3UGXdSDIOLd0Xa2WSu4k3pydBnLxQ+ueqzbOil
         a9731bEwKgzWeUzTqhjOCdVsHCAK+587/pPUWYhwdd0Oz+hrjFHxudSFd3CqNRjXs1
         /kwvjG3PQCaNzy57nu5/jTTRGmr2lMqI9U5/5OMdTZbYJ4tB6NkzU4KLaBFHdDBTO5
         /vBVINnhVMefw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mmc: tmio: remove confusing TMIO_MMC_HAVE_HIGH_REG flag
Date:   Mon,  1 Oct 2018 21:31:00 +0900
Message-Id: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTL_SDIO_REGS is a register specific to tmio_mmc.c

Currently, we handle it in tmio_mmc_core.c, hence need
TMIO_MMC_HAVE_HIGH_REG flag to prevent the other platforms
from accessing to it.

We can just move CTL_SDIO_REGS to tmio_mmc.c
and delete the confusing TMIO_MMC_HAVE_HIGH_REG flag.



Masahiro Yamada (2):
  mmc: tmio: move MFD variant reset to a platform hook
  mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag

 drivers/mmc/host/tmio_mmc.c      | 16 ++++++++++++++--
 drivers/mmc/host/tmio_mmc.h      |  4 +---
 drivers/mmc/host/tmio_mmc_core.c |  7 +++----
 include/linux/mfd/tmio.h         |  7 -------
 4 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.7.4

