Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD2B218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TuXn+0hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfAYOWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:22:55 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:54463 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYOWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:53 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0PEMZ7j003778;
        Fri, 25 Jan 2019 23:22:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0PEMZ7j003778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548426156;
        bh=kk7W5XRHLO5xeY3yHPaXwCXSqbmGUzArqbuHLfDAhVg=;
        h=From:To:Cc:Subject:Date:From;
        b=TuXn+0hbMuHx4I0HboJw8sSJGOi2U8mBPwgBYSyGVe2VVNJ2WnJThsLZoPL30pgnX
         dp7OvD7E5zjyCRc0HGFs1GihB30gOWo0HSUHK7kmJV6hZw8oGHoDYh9m/egj3qfuDu
         p09/QPg7yK6fKUo3V6MnX1368Iap0mF27M2IA1d3XL3wZh/5l6SeKuEjAgDt2YLEjc
         18MwnPFXtCgEvtwdnVdhJ//uR9FhPIkxLWRXjcvPimr/xq/Uk+9P+6ARuDrc3WxURg
         erw/X4CDiuNuSmUifdUzZHpayDfZn26I+bdOkCrU5oRg+seuZ25vwKYTqDD//Fhngb
         4xC4K9MuyWPjw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: lmc: remove -I. header search path
Date:   Fri, 25 Jan 2019 23:22:29 +0900
Message-Id: <1548426149-7961-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header search path -I. in kernel Makefiles is very suspicious;
it allows the compiler to search for headers in the top of $(srctree),
where obviously no header file exists.

I was able to build without this header search path.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/net/wan/lmc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/lmc/Makefile b/drivers/net/wan/lmc/Makefile
index 609710d..247f60c 100644
--- a/drivers/net/wan/lmc/Makefile
+++ b/drivers/net/wan/lmc/Makefile
@@ -14,4 +14,4 @@ lmc-objs := lmc_debug.o lmc_media.o lmc_main.o lmc_proto.o
 # -DDEBUG \
 # -DLMC_PACKET_LOG
 
-ccflags-y := -I. $(DBGDEF)
+ccflags-y := $(DBGDEF)
-- 
2.7.4

