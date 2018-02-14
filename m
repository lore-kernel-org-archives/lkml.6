Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967187AbeBNKWm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:22:42 -0500
Received: from mout.web.de ([212.227.17.12]:33111 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966996AbeBNKWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:22:40 -0500
Subject: [PATCH 4/4] crypto: ux500: Delete two unnecessary variable
 initialisations in ux500_cryp_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Geliang Tang <geliangtang@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Message-ID: <b8fb9abe-2ac4-d720-b676-79083fc7e5e6@users.sourceforge.net>
Date: Wed, 14 Feb 2018 11:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:I3dD7zDFNpbf2dUuifjIgP9nbJwfo6LkRD0qZgTbMLy6JQ60wz5
 akZUsd8DxNH0kpU6SQuzTUTRaijsW11q3Jm3X6L+Kfrbx/VoJbm3ZQB6nHHM8pkDJINxnxD
 p/DvPjmPNCEquefL/qmJJoa06Cu/UjffBjIl2oKqsJYXAPsHjb1GQFZGKZVkXzCMDpTk5MH
 h1oEsk+5eBpIZRQcFgTrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nvrNXJIE0Wg=:9pIBBK48zZcjW4KWx5aJXj
 wLAr/43u/Vf1PEYP7MptuCLkM1DxEz2I9ZcBf36U7cFR2Cqxnj2G+BhFV6WeWJSn5OfctLCMn
 2+Q2ea9mViGe8UuglAyufWh5H3cTZlvLzQSGnvVcIdxWPykZylJTcmr2u5stW4cfzINKU4r+P
 DXd2J5UCOnhVBrNL6S0Kh9Npmq+X1/fPzcUnlsa3iukoOlGHWBKoHu/vVmJEvWQRAFHofj8RP
 nu3Fmq+7P8+5cfDMZGunr5UsC4S4HW9upOlSoGYiMS1+35Ag5D26aCpG+RNfJ4F7ogNZPTGpm
 wGMhtuKYmIMiVvrhBBXtjq/9bsRbYUGYVd7l+9uVwwy684L1apMLlSbfJFIG2Sq28GhjkayVm
 S0Ge1gWnAV42xeefJvnEFm/LuPagsg6t4JJ3PXd6ruCsc09YraiSXKB+XwN3aimkgaM4hUX36
 7CBCKeYbo1Vx9Y/0owUWjKoa9D1D72t8CrXfb4zLZHJb7tQ2uMC3Y6d9GXBWat5ISWqHjt9H4
 AVKLH3l2LzaDLVYOOttXr+cQV1ffRJ8MwrBjvX/00a+2CsLgdW11qyZ5IOrWl5k0Lx7svpwhj
 On3gHgsXRbPHt86CcR7bEdZ8fUGXXNewbWpZMua5GuuYdqU6qxd8d+leJl9haschvd9iEH4jU
 uQG30hWA6JAi8vZK7nloH4gQqkLPXz9jSjBD/vM9+ukT8r/ZCYkIKNS2yGQ2VCRZ3Jv63VaYJ
 LRWRP4DlnwschnA7IjGYUU94RpEVTYGKpG2dXY1hCi5n2Fyel/wee72UE+GkJvnmJG1YUVkyR
 ZFcjHAwQd9qEuYL8bfl0fpRq3EA8BcJCaJsrlfK9Pd5sQ6tD7s=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 10:56:38 +0100

Two local variables will eventually be set to appropriate pointers
a bit later. Thus omit their explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 7c811d7eb274..cb31b59c9d53 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1404,8 +1404,8 @@ static void cryp_algs_unregister_all(void)
 static int ux500_cryp_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct resource *res = NULL;
-	struct resource *res_irq = NULL;
+	struct resource *res;
+	struct resource *res_irq;
 	struct cryp_device_data *device_data;
 	struct cryp_protection_config prot = {
 		.privilege_access = CRYP_STATE_ENABLE
-- 
2.16.1
