Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29104C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54532089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Lj6IzaRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54532089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJPKup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:50:45 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:45971 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeJPKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:50:45 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w9G31q7D017707;
        Tue, 16 Oct 2018 12:01:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w9G31q7D017707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539658912;
        bh=3+DBLGjXkF5C+3nNMUWftHyifNeqRg+ws54R/o/LmFI=;
        h=From:To:Cc:Subject:Date:From;
        b=Lj6IzaRS5k0pgs+K6UN86QcA/6xfOfBfsdMM6hl5Hjh0K3ySgLHSF0fGSG5IAfcjC
         zLvpaDGrgZ2+FW0cRoGkcZns2APbGa6LEtZo5g+zV3Jn4J5rwQU+jxzK2vcZJ9i8DT
         P+rY13oHjtf1u6xdUgjK8SwsRYGJXOCJCQ+Hyvd4ABvJJJuWhmuUBQg7EWhu8tE7+W
         72Mqy4FN2QdmmBIbnHCj7FF7TzrPTUWgoB5+aNyILNiU2pTVh1fxpESip+UGKHXpsv
         ZNLFlg4KedvJ4HIVkAq/41J/ul/RA+oD24bbnvpaaTuqBqayeqvFonlL8gs7DoR6jE
         kOZxi8Ar0K/0Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] i2c: uniphier-f: fix concurrency issues and race conditions
Date:   Tue, 16 Oct 2018 12:01:46 +0900
Message-Id: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, this driver has issues that rarely happen.

With this patch series, long-run tests passed.



Masahiro Yamada (3):
  i2c: uniphier-f: make driver robust against concurrency
  i2c: uniphier-f: fix occasional timeout error
  i2c: uniphier-f: fix race condition when IRQ is cleared

 drivers/i2c/busses/i2c-uniphier-f.c | 59 +++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

-- 
2.7.4

