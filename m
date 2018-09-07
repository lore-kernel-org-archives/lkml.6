Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD02075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TSfYknbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBD02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeIGMJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:09:55 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:51330 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeIGMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:09:55 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w877Sg3w001106;
        Fri, 7 Sep 2018 16:28:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w877Sg3w001106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536305322;
        bh=w2891XBKV6Ssrq9nY3OI6Rt3LrHzKS8vYx4VJKEsWKI=;
        h=From:To:Cc:Subject:Date:From;
        b=TSfYknbSovNizDAGTUL68rJA5+NNL9xHNMDUDdjbR2tjIVDBCeCTM2hhOgL9CmdnH
         qRts+1mGkGwiphvkH9eRwcq2+khgkqBdbpxi7EOFM82Q8ySjBZ/v9KJyQjMkdQLBOa
         KrnDJM5WZqLPoHeyB4MbjsoX4zRe3yg6aGcSE6KoG4GQuaJR76eekkVkai9xYrZC6K
         l1WhlSVEMFd9VtKXpI8DUmWJ5961k6fjwIV48KxSzhrk2vww5PNHToK57LQqCgU4TX
         DnoG4iJh952+jpN4+GpLddl5VxIY3nBbuNTMTMhwhakARc4M8EQIxXpGGry0s4i++v
         NeKPkdjnUNMog==
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
Subject: [PATCH 0/2] mtd: rawnand: denali: clean-up unnecessary hook and device reset
Date:   Fri,  7 Sep 2018 16:28:27 +0900
Message-Id: <1536305309-28026-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As I replied to Boris [1],
I took a closer look for further cleanups.
I test this series on my board.

Remove mis-implemented ->dev_ready hook.
Remove unnecessary device resetting because
nand_scan_ident() reset devices anyway.

[1] http://patchwork.ozlabs.org/patch/960160/



Masahiro Yamada (2):
  mtd: rawnand: denali: remove ->dev_ready() hook
  mtd: rawnand: denali: remove denali_reset_banks()

 drivers/mtd/nand/raw/denali.c | 51 +------------------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

-- 
2.7.4

