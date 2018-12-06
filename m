Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07CC2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="psjC0YGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07CC2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeLFD4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:56:45 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:59092 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbeLFD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:56:44 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wB63trS5007398;
        Thu, 6 Dec 2018 12:55:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS5007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544068554;
        bh=lRN46JcDLoD61gkb82CGphFU7C5zJzI8x8Wvhmkj0PE=;
        h=From:To:Cc:Subject:Date:From;
        b=psjC0YGngRd5CeuKbwq8jUOVO0vOC5vvG+mfV/UnsFl+3C+yYINUG38SrZ79DggR6
         kdor+r+CsgOu/kiCaNvoDL6DJLKibEDFcBFiEYJ/ZyC8I8iZJJZiPaqQ7aRD9+n6LT
         1edq/l5PAHCV3qGuAR0J15VQPuAeakrhyM/ppgUREpZUh94HKFKXQZjy/3HPC+AjG0
         WqkuqurfUJ61Eo1vxImciFEyrr2NyHKr2SseTafgxhXMi4nv4KHxQvNOCzuTeIc0hy
         yEYAKjlIhCesBbBCFj8uSp7YF9N9fMCzMCUXDnWOspeZR56XP2wSvgRDj3MWauX9oJ
         Kq2WMEMmT7W5A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] UniPhier I2C fixes
Date:   Thu,  6 Dec 2018 12:55:24 +0900
Message-Id: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masahiro Yamada (4):
  i2c: uniphier-f: fix timeout error after reading 8 bytes
  i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
  i2c: uniphier: fix violation of tLOW requirement for Fast-mode
  i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

 drivers/i2c/busses/i2c-uniphier-f.c | 49 +++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-uniphier.c   |  8 +++++-
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.7.4

