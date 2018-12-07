Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F89BC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D6620892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2lrxFN3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D6620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeLGLe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:34:28 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:45644 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:34:27 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB7BY6rb020070;
        Fri, 7 Dec 2018 20:34:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB7BY6rb020070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544182447;
        bh=pVOdlkegaATJUbvG4nVvv+Bvm+t5/NrD38fGJh/akiw=;
        h=From:To:Cc:Subject:Date:From;
        b=2lrxFN3iRATlb3b7t9xhGfK+Skbpdie8vAAS2TdxLJTdwxIV9at+ESGhCfeVdUgCE
         yCkz0/xS2gMnoJOItrPe8c6kirhZNix8Ty2RH8Zmt/1+s3CFzRM99eFyscBk/qSKat
         CuN4ujrkIGwB1HQvPQ72d4qEd/0aGBRl6qJ5w/+Y4Da6MopgyoPjPSnPc97Z6MQNg9
         RliJtY4GcvKAGXwEDQrl1AoIAg6xuW7lth4eurdKkBgbZh9tKaL7eHfDJJgTBW2zMD
         70b7d2wIz/65dlg/apYcBlHb5YMQiA5oR89IEJfEP/LCQ2eL5sLsKNFuDHtxiGuExu
         oD5OoGvFkikuw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/6] microblaze: fix various problems in building boot images
Date:   Fri,  7 Dec 2018 20:33:51 +0900
Message-Id: <1544182437-26660-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes various issues in microblaze Makefiles.

V2 reflected Michal's comments, and cleaned up a little more.

I did not add Michals' Acked-by.
If this patch set goes to the MicroBlaze tree, he will add
Signed-off-by anyway.

This patch set is independent of Kbuild tree,
so it should apply to MicroBlaze tree.

Resolved the conflict with:

commit 1e17ab5320a654eaf1e4ce121c61e7aa9732805a
Author: Firoz Khan <firoz.khan@linaro.org>
Date:   Tue Nov 13 11:34:34 2018 +0530

    microblaze: generate uapi header and system call table files




Masahiro Yamada (6):
  microblaze: adjust the help to the real behavior
  microblaze: move "... is ready" messages to arch/microblaze/Makefile
  microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
  microblaze: add linux.bin* and simpleImage.* to PHONY
  microblaze: fix race condition in building boot images
  microblaze: remove the explicit removal of system.dtb

 arch/microblaze/Makefile          | 22 ++++++++++++++--------
 arch/microblaze/boot/Makefile     | 23 +++++++++--------------
 arch/microblaze/boot/dts/Makefile |  5 +----
 3 files changed, 24 insertions(+), 26 deletions(-)

-- 
2.7.4

