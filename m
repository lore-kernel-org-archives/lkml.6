Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB5C208A4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="XLEzSZdI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="XLEzSZdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB5C208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeGHLaW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:30:22 -0400
Received: from fallback14.mail.ru ([94.100.179.44]:38632 "EHLO
        fallback14.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932757AbeGHLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-Id:Date:Subject:Cc:To:From; bh=GSPmnTPw5hYvC3T2Vy8DbRciboPObdd2nuq6c1XFBVY=;
        b=XLEzSZdIkTqpcVwCShiERvBFmDjVcfB1V00RU9Afa4Uq+zHPy2UpQLu88fovdo/3Ry+Onq/Q/E2ypKxCJKXHm4vNLZAMrpmQ8ASeZE1OuQBcnWGyHdV2HQt2Inzvb4Crl9HNlxjloGtavkXZQlBq4qG5wkeNQW+yubId8eKQH+I=;
Received: from [10.161.64.55] (port=51982 helo=smtp47.i.mail.ru)
        by fallback14.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1fc7tT-0008K8-PT
        for linux-kernel@vger.kernel.org; Sun, 08 Jul 2018 14:30:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-Id:Date:Subject:Cc:To:From; bh=GSPmnTPw5hYvC3T2Vy8DbRciboPObdd2nuq6c1XFBVY=;
        b=XLEzSZdIkTqpcVwCShiERvBFmDjVcfB1V00RU9Afa4Uq+zHPy2UpQLu88fovdo/3Ry+Onq/Q/E2ypKxCJKXHm4vNLZAMrpmQ8ASeZE1OuQBcnWGyHdV2HQt2Inzvb4Crl9HNlxjloGtavkXZQlBq4qG5wkeNQW+yubId8eKQH+I=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1fc7tC-0006m8-3l; Sun, 08 Jul 2018 14:30:02 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: [PATCH 0/2] fix regressions in DoC G4 driver
Date:   Sun,  8 Jul 2018 14:29:22 +0300
Message-Id: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
X-Mailer: git-send-email 2.18.0
X-7FA49CB5: 0D63561A33F958A5A21251E13F5BBE3F58CA4CFEA04898E7216630AA3538A87D0A6AB1C7CE11FEE36925688D23FC3BD3BA3038C0950A5D36B5C8C57E37DE458B4C7702A67D5C33162DBA43225CD8A89FBFBFE0634520CEB919C299862C0A6BC17445E81AE98559A243847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148F3F936871CC6C13B42623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 77CB7D53813D46933669B4271CC84AE02A6C9228EA2B8BCAB0BC24327414B39DB7CBEF92542CD7C8D694F0A6A4F3F64130860A92898D06F0CCD8808EE49729257A5E07228308AC44B7D4B47F40347D15B4A721A3011E896F
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5FE440C53876E343C25E8DC6633DF630CE8387B7F096E28E7462275124DF8B9C938130EB80001CEACE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005EB82917A46D95276BDFB4F154169514028F2B1CB9EA02D97D38A1BEA64D5C64ACAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

docg4 driver became broken and these patches will make it work again.

Sergey Larin (2):
  mtd: rawnand: docg4: fix NULL deref while probing
  mtd: rawnand: docg4: specify bits_per_cell

 drivers/mtd/nand/raw/docg4.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.18.0

