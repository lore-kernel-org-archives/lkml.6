Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030315AbeBNNe7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:34:59 -0500
Received: from mout.web.de ([212.227.15.14]:41033 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030198AbeBNNe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:34:58 -0500
Subject: [PATCH 2/2] crypto: sahara: Improve a size determination in
 sahara_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <6a487cd1-c05c-3d5d-ec6b-a6a2ae376f05@users.sourceforge.net>
Message-ID: <1ef7c25b-ff37-6a49-b4ac-02a01b0a10dd@users.sourceforge.net>
Date: Wed, 14 Feb 2018 14:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6a487cd1-c05c-3d5d-ec6b-a6a2ae376f05@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:tXEc9886D22VcOreV6POJhndeFyUtm2WHCSyrO51XN0yMWR4V3C
 mwW/9ZcSeZN05JJgQiJpf3SNu2zWpTMr4oua82g2KI7waSqejg+cJ5L1KjjOaS2R2SZQROs
 8uqVBmjjgj2zXpn/qvlbn1GMkP2tTWa8TTqjXlA7vUbfQ4dV070I05F+8UuyzOCxwARjAW9
 NtdiJA07hTlQtRq0e8Nng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JssY2n5Z42Q=:Eu3iSCwH1m0wpI29PSmONQ
 f4PmMoxUzgrg9Bxcd7sJvGd4XXMGKGj7vMh+jB271CiGG1HWSttRtH3m/lhSGpd4Zceuqe2dp
 +WL4XCDGVpEzeGj4U/qSqH3J1f/EGZ8v9LjCy/7Zds/wyyOtvAY7Nxfjszz1NdhCFhiSixjAf
 2V5NEvOTDkmlG8iybM39FvOgJr8s/IlFnoBUlZ4CM0dgGPrlMH6wvwHg8PebZdS2MH1x2DmVT
 dBCVp3FkAbk5Yotyl3AKeHtptlpL1+tz/egVfON3suQ6/yJuEB4bufIbhTrrq+rE+J37e3yuE
 k74/96R9i+1ZvT18vj/wnFkeZwnFA4IDNbzjfiqmZd8KVqvVpYeFAmFmx7l3qgvVgipY+k7IH
 YAnh1BMAZebXbMJK6TB+OIX1MsIZSv1sxK4N5LZdPovq0j9Cd7c4IyGTWDFGmoonmGz3IF8AH
 3IUc4IbOOlkXiehvQ37fKkTmJk1mzmLKgmO+9H1LBLgcaVa0yg1Xp/RNi1hWQVjAMD23xvN4o
 T3hLfOZ87AchIdPEy7FpDfO/FAZ5SVqgW2Dd9Pv2EdaoKw17AY30vdB/dCNVOyvJYb3ma2M8R
 6You5LLJemDRt+thogYzQYfINnETEhT3uzOvKiTiB8bPGtwByUy7R7SrFn+lC4Xy/Z55bgqG0
 M9E6gf2KOyFLcZFyd4xpUDKKcfsQ9jyYVUWg6PhJVpJW9XOjkKFaIeUCyLxnJDYTo7IS/BSGF
 iamAkdEAFEnaulnmY7JrQI9zBZMlmCYyeiNd0FMkFl+cOGZ075FILi/xPuw2MXfrmcpQtmPy0
 aMfIhgxdmuhzz5vbj5MdV2q3uiorvVwNeZ1Y2Ses/SvUVahthI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 14:14:05 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/sahara.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 9f3cdda59139..0f2245e1af2b 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -1397,7 +1397,7 @@ static int sahara_probe(struct platform_device *pdev)
 	int err;
 	int i;
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct sahara_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.16.1
