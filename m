Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeDIKyw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:54:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeDIKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:54:51 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: cs2000: mark resume function as __maybe_unused
Date: Mon,  9 Apr 2018 12:54:34 +0200
Message-Id: <20180409105438.2402477-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:cejmJcCRaIJhA1WrdLbPtMW7ss523NaRqHKvyhbFpH/9W/bYSGj
 wwu78gxe0quYZMzSJ/qoUHE490gqp9oBgwYM9WrCnZ+xHrNsyyyppU/g1XAERMzA29I8JlC
 toHCHqxi4LOJ5iDjqVhvjP3k85Qo6C8CklYGw3ESD37LmW5k10sViE7MTCn8d3uY7iQmQsU
 yx0axCBmRMyI5hKf7LSWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/OeFxE/DA4M=:yAmk4/Ear+pHPAPqu/oYbH
 GoLNvvmsaqSVGjmxtbCK9sn4l3IRnuxlaCcw2VQ7vlprVWhVp20bfC0AxnNHI/0JvMnSDCOQt
 GkYicKiCJXJ2doaZiUCXQn/j2AqXG+HGT2Twlffz8r3vxCBGkgxxvRF0MPTNLXec2G0diIOGh
 IrnKxhy5jCDKH/lCLMMf9J7HTB3OKoGfomMeocb53x4dVy3/JOh8ZH6yfAktidQeLY52tf0E4
 5Y7cp/ANPENdeimLYbIP5sPAsBTs4bII1oOt73a/MCFKhfJDDQFk+/03baMB2kUOoURBjvjn0
 pJ99JgHQrDg4wflQiScbdjZA7elLwC7ZoglV/OAJ+rDYedKi0EZbXyYqSUkgOSBsQ9CmKhJAE
 k/jaZ571YwpuQE18pMDcPvP4NzirhjxssVzh7wAopoYxtBCfc3VeUKv6wBS25nIzFiwwzmiMJ
 0EfQlIYDFjchBBCSw+jEE9jrqK/Qvlb0CZEG1JZsdyp7tNXkK6QBPxy38ZHM8hJqbdR1rXUue
 2kQmaioD6R6reon38MjxiV/m894U66qqBom3mtUK95cTCPyiHiiXjCcPh8ZRpcLcmyyjBsZUt
 +il4aBO9sDQTmjcbGaw+QV6QuUdlVsemSDZowoqohVWIkAonE4Lf9CPqbNUdzaLsveYQ+4xP2
 /zPYESM31RCaWusLr4I821VaAy8sEl2LT8w+wyx25Czsog/5kvYOhZN4EZDJFfSDFNuBU23lS
 emVYXmAljyY+7IInL+jkWewuRDwl5Y1uENqmCA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When power management is disabled, we get a harmless warning:

drivers/clk/clk-cs2000-cp.c:544:12: error: 'cs2000_resume' defined but not used [-Werror=unused-function]

Marking the function as __maybe_unused lets the compiler silently
drop it instead.

Fixes: eade4ccdb087 ("clk: cs2000: set pm_ops in hibernate-compatible way")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/clk-cs2000-cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
index c58019750b7e..a2f8c42e527a 100644
--- a/drivers/clk/clk-cs2000-cp.c
+++ b/drivers/clk/clk-cs2000-cp.c
@@ -541,7 +541,7 @@ static int cs2000_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int cs2000_resume(struct device *dev)
+static int __maybe_unused cs2000_resume(struct device *dev)
 {
 	struct cs2000_priv *priv = dev_get_drvdata(dev);
 
-- 
2.9.0
