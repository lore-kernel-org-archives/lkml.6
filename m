Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031651AbeBNVjm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:39:42 -0500
Received: from mout.web.de ([212.227.15.4]:40329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031404AbeBNVji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:39:38 -0500
Subject: [PATCH 1/2] crypto: bcm: Delete an error message for a failed memory
 allocation in do_shash()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Rice <rob.rice@broadcom.com>, Steve Lin <steven.lin1@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <68946b12-83d6-ab74-fd54-71b23cf9b7ef@users.sourceforge.net>
Message-ID: <35f107c8-c640-07f9-c10f-83fbe1ce4259@users.sourceforge.net>
Date: Wed, 14 Feb 2018 22:39:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <68946b12-83d6-ab74-fd54-71b23cf9b7ef@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7lc1cEzbb21Yiz7PKdRI5vIMOG3/dHAajEIVLKgF37d/CRqISbi
 N9aeVQNGJ/Hiw+fJan6eZJ/KUIVwl3rfzQvDv+uzfP43R/DAJxak7ALSr926XJObALwTRaX
 IV4Of2ma4X4H+z3v+neszgbv8301SRshRLPk0vwBLqnQmaYED7OT67CimuqhmXGkhx7AKC1
 ToQjpJLSa/sORGRKw6U0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gUZHcFtnFJY=:ZH2O0RZhVrfMl/jWHhs6YF
 OusfP8g5ck+XYME+yDFkC0HbfMF1PC3/SucWfgTb9PdbgPZ/c5B9I2AztQkwaTgRmC5jAy40N
 4zs+VJW3NNVu3QpMA2XJHgEWsmwSWGT8Qo5NTMZQowgMGbTirfAACA9M3C9RwG0XbH3f1kzu8
 auqaqjGnIHJHmOx8qF9mlXIX+8Os8qRX0oZZEMAHQ6olfBNKoHq5dGik/SOtn6nwx2BhXOCtH
 vSkasBcMto2bFgKJ4jRhBP+SXMLnGMSjtvnaAz7cc0xihRcRyL64ulwNRSfoZz+44dRiBVHqB
 UCfNtZ9gLpYwsGJa3Q0qlnXj8Z7ds84fEIYzu+nJwF/zYS3T7KejhCsDastGfdBBBmo8hdNKc
 X0s6gyL1IOF8q5qoH2d94v2Sh1men7eoT2H6i6CCKDFR3EjnMoeal6uQDqxfHc5rJyLYdfEZU
 iJwbjv/xIW0YjsoxlxFRjXjOUgGGL118V9s0bTv3LdCHvej0pz3DXgT28cgrFFlD2TSv1XFhR
 1Z9wzF6oapRMIWxAFq+mIGXFfinUHqByPBnbZWx1SiHG2kBJhsI43pdj6kgGPPGwztQgydSkH
 t5lMTam8RZdvNQ/tegnBVPRqJ7NYFLlu//FW/v4r0kWORTthQ1xX4patB1AttEYNA7pRtSyQO
 O1vtPcJtSaWhPPfIC2BMzHZNIagj9i63UvLwyModJQoqtkswixMBpB6Zj2TiUicHMz5XeYwB9
 AVBfsoO/2Hfp3lG4Wl6iY8L0S2pdFt9LlmwDOJCbVmu9cAu7D/rSmM0P+dckJV7dBQbagGd8I
 4Zpm/E25jpKn59orflR1Aa13tiI/PR4EzK2ubJmNLhuTM2NEyY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 22:05:11 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/bcm/util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/bcm/util.c b/drivers/crypto/bcm/util.c
index d543c010ccd9..a912c6ad3e85 100644
--- a/drivers/crypto/bcm/util.c
+++ b/drivers/crypto/bcm/util.c
@@ -279,7 +279,6 @@ int do_shash(unsigned char *name, unsigned char *result,
 	sdesc = kmalloc(size, GFP_KERNEL);
 	if (!sdesc) {
 		rc = -ENOMEM;
-		pr_err("%s: Memory allocation failure\n", __func__);
 		goto do_shash_err;
 	}
 	sdesc->shash.tfm = hash;
-- 
2.16.1
