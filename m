Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030353AbeBNNeE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:34:04 -0500
Received: from mout.web.de ([212.227.15.3]:52435 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030236AbeBNNeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:34:03 -0500
Subject: [PATCH 1/2] crypto: sahara: Delete an error message for a failed
 memory allocation in sahara_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <6a487cd1-c05c-3d5d-ec6b-a6a2ae376f05@users.sourceforge.net>
Message-ID: <0d8aa357-223d-56e2-1cbb-8113290ea1cf@users.sourceforge.net>
Date: Wed, 14 Feb 2018 14:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6a487cd1-c05c-3d5d-ec6b-a6a2ae376f05@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:XZH9LjwsdXQSmVS44hFA5MRUQG0NgqFSpqn188qTOSNv/jW/1rV
 jvqbD2xGohfkKf8scZEd0DQlgRjlK8JHkQLz3fqjkZCEq7NV31cPwWVAva+3O5XbdGumm4w
 ClRQ6iKB8xuYwFUO0KsTta5z/mNQMyzNnY1T99XCCo2idHeX6vWb7klNpBHyn6vxH5wz9uH
 M9BhA12reHPBkP827rPbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rzOYtdebYaA=:Sx6Xn1vtx1/XxxbD3lN90U
 Y0ODFaiwM3DFsAq7Ytk7MMrG2jDf8+kori2825iQ0lyb0jXEJFQemJCNLgq8+hGKOH/LPzHUJ
 tJn3keIrkTEIGpqLswH7ypBn1ksobxreRKkyXW3xuRik5lxXtZ37wtpgLwF7RqmIuS8l5vNdN
 FzIp7svEwVeIe+azLfDOyFtT+4GOJI3lTlMdlIDXehhdFv8xBmpeI96Gk5QzARPtTjYF8vSel
 xMQuXPSdfWq4iwzluCi0UrEuJmMu76Q2zQKZSja/6LmhvTY3rcxlxju63njMftVIhyVfXLg+W
 o0fwxZp0laWVT4MF2tveVP66whbdqYsNNeWF4aYZDUUEgOWbWts1CLTceT3lIKfLxfURBL0Pm
 Mg7N9mtm1XT/6NH2eNXQyIZMJjH9yl6n1r3yfcuv/oYexFYaThl/uVpv3qMcr6zh/N+som74L
 mbx/0mvVZLA7f55YTQPAgN6FwOEg5RFCCA74mJE+m8FjW1LTD5YbfXoa/VP1if5TFPUnZH+gu
 8h9YVV4UxT8zS6P4PCDT9gr1iKGyHXzwKnlVdPzrKlcwdib6A44+WIHByiZIP/J4CtXy3Qc2G
 Btr+donK6XoM6qEiLsW90fW9UK1aaJPkGDA42NS6aiPFy6Ni0SROUM/LgPOyUIld20KHYmChY
 qhEz+OC7In3RtunExT/Nhkvnk6n2z72Zrqx5Vu79eO+m/4yQ+HdOfSP8qbMKxHXGnJ2dFTXq4
 //Iv6Qv4scYR4hflYIVu7WFXp5k9yUd2lCjJCnc/eWQ1JqukseYbIEJI7JRRlTPsXWl5/UWpT
 0f8ef5yTNwuCnLYaAGTEzkxEyZJXNyWFeyDMSKXBcLDayXt6Mw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 14:10:03 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/sahara.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 08e7bdcaa6e3..9f3cdda59139 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -1398,10 +1398,8 @@ static int sahara_probe(struct platform_device *pdev)
 	int i;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct sahara_dev), GFP_KERNEL);
-	if (dev == NULL) {
-		dev_err(&pdev->dev, "unable to alloc data struct.\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	dev->device = &pdev->dev;
 	platform_set_drvdata(pdev, dev);
-- 
2.16.1
