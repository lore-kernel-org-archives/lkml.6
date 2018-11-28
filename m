Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC5FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3392081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="C7y+TCRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3392081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeK1Q3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:29:55 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:19161 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeK1Q3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:29:54 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAS5RnF3025853;
        Wed, 28 Nov 2018 14:27:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAS5RnF3025853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543382870;
        bh=XYuzJ05SyslHyFg+pYKyQixXVxk2/B8n7c/ByI091wI=;
        h=From:To:Cc:Subject:Date:From;
        b=C7y+TCRbNbKb1L8fJ+VN/mDxmTbbM/HKIhAPfZIrRCFSikAkdiMLQlTzBoi0nmJVk
         m1afUcWhPIPAYx41opDwIQ2vq4ZmwDk7L+ozl3KFiwG1zwv2B/ehXcZALQcwpoKnau
         MSOoxffR8erTTfb90IKvZKWa8k992cd/8ZkSqTT/u41R9XistrjvXzzlR+BIWp6vfq
         PS6E/ADTSjdZpoEBPmfI5x1j3nVqhysxwqh4sYFy/9mx1g2G7qbiaz8ikFnn7/SSaj
         q5iWUiR+HktQB3my5XRiPp9C23mwcL0xHh0wC9X94keJ2i1N8guH3l3VOg3D0T289Q
         jvorvIFufaO5w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 0/2] mtd: rawnand: denali: clean-up unnecessary hook and device reset
Date:   Wed, 28 Nov 2018 14:27:35 +0900
Message-Id: <1543382857-30827-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this series on September,
and Miquel replied this series was applied:
http://patchwork.ozlabs.org/patch/967242/

But, It turned out not applied.

I rebased it and resending now.


Masahiro Yamada (2):
  mtd: rawnand: denali: remove ->dev_ready() hook
  mtd: rawnand: denali: remove denali_reset_banks()

 drivers/mtd/nand/raw/denali.c | 52 +------------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

-- 
2.7.4

