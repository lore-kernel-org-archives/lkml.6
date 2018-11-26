Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F22C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682F820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MIMZ9VLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682F820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeKZSgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:36:12 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:54437 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:36:12 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAQ7gcw0005312;
        Mon, 26 Nov 2018 16:42:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAQ7gcw0005312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543218158;
        bh=aR8D4zofb093D+UTs7BWm8I2edcoZHsEqFMnjZwO4bw=;
        h=From:To:Cc:Subject:Date:From;
        b=MIMZ9VLKfXp0rrVDYpypgOThN6h0A0pYW1TYQrfDEf25iQGiOh4oX7PYoxOhO9qtF
         EG8YCJhYOYqguzA1xzXCbu/cZVhvmRI/GSXHKoo7D+KLWh3Puc/5dJGYSVhvwy0e0M
         LLxIPt9W2jX65VwNHlStSjCuKypgxgsWypCKuWSxdGFyP3jpZ00am6eginlO7v1em4
         9rLF0SsIoXjSnXqEapJNduxMUn14gs+ApRHhM0R6ppO4HFLYfXB+KAfWDZrJcD2ABz
         RmLB0hgqsSqrTMn9XoPZ/KShTkZC7itMNCSLX1CAz/XvRV/2/JmLdYJT2CLlvzfXxu
         JfCd99+TpzZHg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: remove unneeded HAS_DMA define
Date:   Mon, 26 Nov 2018 16:42:10 +0900
Message-Id: <1543218130-5800-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/dma/Kconfig globally defines HAS_DMA as follows:

  config HAS_DMA
          bool
          depends on !NO_DMA
          default y

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/nios2/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 7e95506..69c4af1 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -37,9 +37,6 @@ config GENERIC_CALIBRATE_DELAY
 config NO_IOPORT_MAP
 	def_bool y
 
-config HAS_DMA
-	def_bool y
-
 config FPU
 	def_bool n
 
-- 
2.7.4

