Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeBTPPj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:15:39 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:56369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeBTPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:15:37 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: hisilicon: mark wdt_mux_p[] as const
Date: Tue, 20 Feb 2018 16:15:21 +0100
Message-Id: <20180220151531.3379003-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:0OKz5pr4AZuFohW481tTI8rpzjJGNWFVLYz6MhDGdbIwQlgiRSo
 ClBSdwj87qjrbj5COChIaerFhyqzYKbX+cQFGOPkrJyWyoSAXpPQJQsjm6/DgJsvLFx2bsV
 hc6Djc6NVrc2agXcywmaEJSzTc7Je391qS5+ju2P3jJ6Rcay49U3jmZT3M9q9BgqdfArCkl
 BZzOeG1xKc8qwCCYv9Mhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x6o5CmB0KmI=:oc9KxIKfYmKyRbGuRWxSUa
 UgQBWOx4rHqwH7LZ5AnVZhFtp+6jeNn/NJmBrhHoV1QFef/uPFwwyxB/mcncb5oVZtus7YqkX
 Pkzd891Gv2bKKDTy3Ch2Mj7eFwZ0uxHRTa9LRBc3CkSKCrOSrShKjDDXySNFz5cNy0pPCUa27
 RYAFekhij66Yd1Mrlp6CzJfQIJmiGx0V8aXNKSWA1UQZ/+dDC9STbbfs3ugtO1nTBBBzTY2pD
 kFBlfKjmzNvJYKhr9QQOqXjpr/2ZEcylbXydtv/HJ72V1VSPH4Cw2x14el2NkmjGY5ablgOqB
 FNcCAbSoDKS585PneYcOGs1dzfmlLb9xT121G1joe7FEFupzbVBU++G+ZnUutuATTsXGEh4/r
 VoPw1eXocPLp1xr6yMVcTYyJxSEEpLa+xaqZY+TEot+ZTRpTaZ7S4yrCoUEO9jmI6o5yWsuuS
 K68Cj3F0drR2ZJ8RSiQmf7gPa+plqA9afPrDkzWnkZHQFtpIvqFnJREipBeMqzQLvq8LGFsdz
 vDMggVDfCXhjaQT55WGMEXVYi7rnmxvz/zSJX9fbNBzjLbRkG0NsThXDKgT83pc3VaIfCXQQf
 /uRKWeBVw6pATlZRgQWc6b6fyFxLkBktJJgjS2dzCNy8E00sMalPBj/PbzLeUADNhTB7AbSWt
 GYsu9lEOYT5pnhcjThPfR9LEWwDM+VVNnKW1OD50uA7ObKa2eBfNB71bxc5HrTf0P2oPHca4H
 TY8YjDZhGMUsM2qBtDNBfr+M75+3PRE+Yol/EQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol is in the __initconst section but not marked init, which
caused a warning when building with LTO.

This makes it 'const' as was obviously intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/hisilicon/crg-hi3516cv300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 2007123832bb..53450b651e4c 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -204,7 +204,7 @@ static const struct hisi_crg_funcs hi3516cv300_crg_funcs = {
 /* hi3516CV300 sysctrl CRG */
 #define HI3516CV300_SYSCTRL_NR_CLKS 16
 
-static const char *wdt_mux_p[] __initconst = { "3m", "apb" };
+static const char *const wdt_mux_p[] __initconst = { "3m", "apb" };
 static u32 wdt_mux_table[] = {0, 1};
 
 static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
-- 
2.9.0
