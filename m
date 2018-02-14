Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032376AbeBNQRu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:17:50 -0500
Received: from mout.web.de ([212.227.15.14]:38781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032153AbeBNQRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:17:46 -0500
To: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Dan Streetman <ddstreet@ieee.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] crypto: nx-842: Delete an error message for a failed memory
 allocation in nx842_pseries_init()
Message-ID: <8261d041-ccd9-c0f8-4530-a4afb43ee7ab@users.sourceforge.net>
Date: Wed, 14 Feb 2018 17:17:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8Bvk4874i74Vk48Yl2qNJlTmngwsa8qGcevg2nGjvaElkU7Hoyw
 ii2ABystiEFy+gR7w7xy4bJzxKGxvGwe6Mao2lWipQuoHo0i3DIWGm8R4UEC7+RhaSIJTT9
 goaFnT+SPYjoXfzMygfp8x/4BsN+iJI3o57HRdV4u/sNAO6Ep9j4TXFlXw9AGFf89ahG18v
 zC4mh1aBvnO5kEZGh54sQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6+K2jp6U03s=:WytGq4pe4pQsjEeTKxDCNF
 aww9LC0qPosL9wlgldLW3MEKe6nCdup8p8qjfiuyEk5uyPNFtL2+dGSYN9cqjDcBk8LcpVrHX
 VTHEFuso9ctw8QtgDF03eQYqyGnpkRdN1nmSzA+yRi3wys9Sc5EyilgnaR5DHma/slQ0qxJJR
 JlWgEzrV2ggpGZVVdzxwuizBPBelWVJVnTr07jbAy+BcFORxrz7r7MVbjAf2V0C6PcCG0II93
 KWOCiDtjj7Ffn7oG08IFEpekzZ+Mvt9iTUbr/093gZ1JhxPnQ0lZOMygpk2FxmwesRl/zqMTt
 2+Tw/xkpa8TZCHB1FNW0uVoyzqOc4Ac2mlUSfbsKXQ2oschAflIxLraUmxgBR3c0AuHUJ7Yo/
 mWr+y0H1+h0yi5mgu5PdZNSZaErHGemSPc/8iIshKtQKpuYWkEhp0YNksKfMtEEuTq9fBWfwe
 ToJlAyU8MssUVB2RCg8EO8Ph0gvd9wmnoMUGSEd+KOKhxkXyH9IGhJmLaLKYVqFRoqh7/hn4K
 fziFp/sWk2MmqTg3OAs+Hj9q865zrVs8NWpWt2xX89MAPeJdz0HXrYZcT3rkpNOsWr9u2cRN9
 bk6I0oq9HgT75YVXGEcEXHbGshxDGGWI3/z8Lmz8oBg7X4FCSTfDAKnEPzKShw6rmXLPRM8Jq
 zyu0eVDoTaK38Uy8GgnywBZNQmKVCm6WFH91u8b/7OLjE64pbfkemRsmYhqQI4Sir6P8E3BjU
 e49RmAmOOO5+jr9AEmFq2daXwBA9OtBi50/gKEtkoA4R86HlE+R+Plpc8EpZ29laEY3uIh4bo
 qzLrIk0Gr7BTxSYbnCpuUSwpR38NA2vLS6l4a88cxzSEQkwLak=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 17:05:13 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/nx/nx-842-pseries.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index bf52cd1d7fca..66869976cfa2 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -1105,10 +1105,9 @@ static int __init nx842_pseries_init(void)
 
 	RCU_INIT_POINTER(devdata, NULL);
 	new_devdata = kzalloc(sizeof(*new_devdata), GFP_KERNEL);
-	if (!new_devdata) {
-		pr_err("Could not allocate memory for device data\n");
+	if (!new_devdata)
 		return -ENOMEM;
-	}
+
 	RCU_INIT_POINTER(devdata, new_devdata);
 
 	ret = vio_register_driver(&nx842_vio_driver);
-- 
2.16.1
