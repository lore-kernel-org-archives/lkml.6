Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B12C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7928F213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PUPNZ7P1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7928F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJCSZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:25:26 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:27478 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJCSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:25:25 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w93BaXuQ004652;
        Wed, 3 Oct 2018 20:36:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w93BaXuQ004652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538566594;
        bh=qUUVbAlgYWUSHXOyHXkrd+n8zWW2YsiDCDxY7k1RW7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=PUPNZ7P1CAfMe31Vgm46jb6DCOj6JrOQMvOsqBH8ov9yqQ52T+dadvdayBDCOeiyJ
         k9Is7pCaFCbuHaJDYsmIeia0a+OfB26yISC13tzQLjiyciYKY4KSsKz/kCC8clYpGY
         ETKVVTJUhf2pFKiSwe36zYjuzI+pLqdIRmj42WUx9UYcOLFXpdfl5nWUZNQNV6rZ7A
         h2meBYCIbOiPHGf0y5B7yMYFKonjBjqx3ewUy5HIk+tfpCLzcxKhvxzrKEMlFFU8RL
         3k6oYHyAX99ldcHopYEK995c13Jw5111cKYu58eVA0iL+QdZRKiSCRZGYmfaGwuSg3
         RIvKLi+vX7Dww==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mmc: tmio: remove confusing TMIO_MMC_HAVE_HIGH_REG flag
Date:   Wed,  3 Oct 2018 20:36:25 +0900
Message-Id: <1538566587-29452-1-git-send-email-yamada.masahiro@socionext.com>
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

 drivers/mmc/host/tmio_mmc.c      | 24 ++++++++++++++++++++++--
 drivers/mmc/host/tmio_mmc.h      |  4 +---
 drivers/mmc/host/tmio_mmc_core.c |  8 +++-----
 include/linux/mfd/tmio.h         |  7 -------
 4 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.7.4

