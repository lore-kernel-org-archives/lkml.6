Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967166AbeBNKSc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:18:32 -0500
Received: from mout.web.de ([212.227.17.11]:60789 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966996AbeBNKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:18:30 -0500
Subject: [PATCH 1/4] crypto: ux500: Delete an error message for a failed
 memory allocation in ux500_cryp_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Geliang Tang <geliangtang@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Message-ID: <e099a8a5-e7dd-5170-f46e-83c3609e8137@users.sourceforge.net>
Date: Wed, 14 Feb 2018 11:18:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LDXS1NtnTxY8mnaiLlRglRBchtlo8OsKagRQIe3hBR+lv98707w
 8EUDdTGeYBPsbuVwCnojYElsJNY0fSGa1WR2BsP6eIJoOFwr1WZ/4iW/PTRMtI4zcPD4/jE
 L0pDPdeIns32EFBFFjGeyRAu/sFfdekOs695wNcRaE1CD8mtA6g3chHnzivBg+VI1q8CiIi
 BmvbhD3lamNpwh6sgzcEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FkiKZpn3nYc=:boS+DzKv4fJJ1gPzzttXY1
 SjlS8oxg54xSPbXWpljJP6gvs/MfTLPUBiw7QJw4i3K2X8tpEHyPgwS/eTtj8zliupPWFYKyM
 yAzdTdyMUqa4Zg5aPnT0eo8iDa9Lej1qa0BkAiqdbdgtm8D+BJdrdvtLzOd8cGFk/W8RUFVob
 Am02UBIX/c4mPx8iDtG2JVG+entOgO3EJ8olNy+JjlkmHEYfsyIonCdWGssqauT+k1160joJV
 4j96B/hWVJOP9dUlL0Ty7WfDSggZjsw6IA1x3De+hd+xE/zEOJTtlppNaFvsm/F8+YlsrcebK
 7G6FDJzk5DSK8kJSKEyhSz3xly2cAyOqVVEeOCSlhPkfDaiIZYttE0KJvSb8SVXMaEAzJARJU
 AiZUwUchGmahUpEbjz8t078z9TlRUBm0+cEca0n5Dj/5x1bHUjsWOiY+dSA/52lX9kjhzavql
 cfAS1Zx0SHCkWQX9H8j6dOKWPEPG4+w0H6sypKtTLp4620xCA3zXOEvJqtjvXvmh6aojmu/Ob
 NOj5w2EDRMldNQ/Frg+X8EhOeO2XqQahS3LNE1Gm6Aob5gV/jp/z4yM8HPmi1A6vodydXDV8F
 lIS8MuZLa5OvG4corBffJGlXx5DQ2UgU/f03Nz5DyIi0LQKzOQyECYCgQRoLB6tzGHYtP8Prl
 F5OiST48sSTMJOXoPxy7rhFImmVmHEbZwzIuYhxQ583FC8ABYKEtZohlbvBoPOPK48Qg8wmdA
 osxaEuHurZ5FMjrkxmIT4dlRNAgB6P3Tr0cbtJUR1stuFls3/jkPRcRPZ4Xt2br3tMd0zX+3K
 BY8YAPWCrn5C1qIbTs3SNpJkoR6DKDbep/2skwOGEZT45fICBo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 10:12:38 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 765f53e548ab..50bfc7b4c641 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1416,7 +1416,6 @@ static int ux500_cryp_probe(struct platform_device *pdev)
 	dev_dbg(dev, "[%s]", __func__);
 	device_data = devm_kzalloc(dev, sizeof(*device_data), GFP_ATOMIC);
 	if (!device_data) {
-		dev_err(dev, "[%s]: kzalloc() failed!", __func__);
 		ret = -ENOMEM;
 		goto out;
 	}
-- 
2.16.1
