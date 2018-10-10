Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A950BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560C92075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ek6gn8dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560C92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJJLMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:12:34 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:61081 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJLMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:12:34 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w9A3pfet028281;
        Wed, 10 Oct 2018 12:51:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w9A3pfet028281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539143502;
        bh=72rXcG8j13CA0TXB2J2jd+mk6dhbo3w1oruCUDkEMug=;
        h=From:To:Cc:Subject:Date:From;
        b=Ek6gn8dJjSpjzRkdykdPtjerJENR9c1GjVmuxWxjgw+OcxyHhK8qHAvWgiVzqB+Za
         in5shSOCaMuTIJwyQOF6oVzVIifODdPazgcZ1AAigtM01fA9D8jFqBUxj0T3fg4B5P
         upi6jEbCVlQRxG78DvjJUYEfIH44oOg5yA25jtVEvGuuaEs7XqRIvqRyxBXtsdlc9p
         meGREXVG/2hBxd6ZCCY3EBIam6N0ThbsNjfCZpOV6zqZ9Zexhfta6Drwy9jb7nNPrv
         jycODePzIm3na5JKJv2Mxzhs536fDWwZbMzOOmMMlrrDizZW9v932eN5NL0ymoBzH/
         v3IZq4FwcREfA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mmc: tmio: remove confusing TMIO_MMC_HAVE_HIGH_REG flag
Date:   Wed, 10 Oct 2018 12:51:30 +0900
Message-Id: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
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
 drivers/mmc/host/tmio_mmc_core.c | 14 ++++++--------
 include/linux/mfd/tmio.h         |  7 -------
 4 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.7.4

