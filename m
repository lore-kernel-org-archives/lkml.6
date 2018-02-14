Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935427AbeBNUmj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:42:39 -0500
Received: from mout.web.de ([212.227.15.14]:33135 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932096AbeBNUmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:42:37 -0500
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] crypto: bfin_crc: Delete an error message for a failed memory
 allocation in bfin_crypto_crc_probe()
Message-ID: <1601995f-79fd-8365-5dd3-4438a3515c28@users.sourceforge.net>
Date: Wed, 14 Feb 2018 21:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JGbZ+Uw0/DP+vg7B39YPuPEEqCIHddZX8yAPjyJxFzF6by15Y2P
 xwzoUGvpWOKVU34PrScSTc6u7eVG4aG+w3Lhz1jSr0lOPROWJAqExi6aHdNwMqNIm+yBLub
 pnaKmQW6ixXrrPMWRWQeml9LCklCX+OP6JUUS6jaVPYEXg7B3luAIeW27+a8q+05eiMpMIp
 doFlZ1JseASNE3mCjN9gQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eYFTa0TV+e0=:0as+uoTIpc0NUJULbJIjbT
 C1iGKbZV1iz17oDJfPAABDUNhf5MRZ08xojHyYyqptLbPu9eHnK6gXm5vzx3kGCTkEg7yFokw
 /AAcpul+RC2PSmutRpQkk+K0dTWDH6i+mjZqSj98t77tnMbW/m1Is3M55YaYDryRz6sAShkEm
 GTnX8U8gAlkdwtDQrwK7Rx4wnAZnJYJD6Bjg0FMPZjyBA+T+6TabUtP9p7CYdqKEMCC5WLTVk
 5fRCk2yF8dCNNkpNDPvDgJVcdUy79sTyoxjhLXrOn8xh8G5EF2NeN55vxVUEQTIN/VQpjz/K5
 jbjZ8xUk2gXPJdgXADrAFtA24d79WmaPnPQdJvMOP+8uO7unAuq7IEdaIWatiqjmARCwHWyzS
 DZIZpdCOCHaLG16EqSLy9on3qeqGfTUIkvLAKuNtiUG3X5V+zPGUCq6/bQyRdwAoyQ/fG7VMv
 JqgYzAqQWRMfXAHnOhiX+jZoc0GgmI7ji9tjEXJi8LiSHEjieTWHbicbnQraxEi7UPqFSJ/bE
 FSv6HdKeZNSa6lBE4A11z3f8rs7OoVFniBjIR1IrdPzAL/WvkEXIXgoe0h2NnPs3bO1WlHMWr
 DX6zddluGAscIK7rCrg5XvEcBusKcuurvqIoq+YWzdwB3ANnPSSm0zxIzL935tuaLPCTlFsev
 +idBVL+vTgXFSxORPupNCOK/rtt/g55hUHyp5D0K9Ol0uyxzj9t0OF/aEhRK0TCbpl0GurzPF
 Su9CtUqWaFW+LgdHLTpzBDxRAg1cuzZV866DiCGsouujTDJk8TlWkJFVoS21b5liHK/kbINFu
 ftdH50hjsztn/pQg9+5zwrmRAG8Pa3Yyrzfq7rSWWhn3T24oE4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 21:34:54 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/bfin_crc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/bfin_crc.c b/drivers/crypto/bfin_crc.c
index a118b9bed669..7a1d6ed6d0b7 100644
--- a/drivers/crypto/bfin_crc.c
+++ b/drivers/crypto/bfin_crc.c
@@ -575,10 +575,8 @@ static int bfin_crypto_crc_probe(struct platform_device *pdev)
 	int ret;
 
 	crc = devm_kzalloc(dev, sizeof(*crc), GFP_KERNEL);
-	if (!crc) {
-		dev_err(&pdev->dev, "fail to malloc bfin_crypto_crc\n");
+	if (!crc)
 		return -ENOMEM;
-	}
 
 	crc->dev = dev;
 
-- 
2.16.1
