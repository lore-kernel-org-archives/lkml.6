Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeBBOVl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:21:41 -0500
Received: from mout.web.de ([212.227.15.4]:50051 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeBBOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:21:35 -0500
Subject: [PATCH 1/2] i2c-sh7760: Delete an error message for a failed memory
 allocation in sh7760_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Message-ID: <737fe7c8-9ae3-7e19-100a-f2f3d9f2b83a@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:21:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:68yC4l39mQkeA2y6/6WsFbkh8AIJiQvI6PXgx2Xzawn1d0JZpID
 n91t1i8sUfC37orngnOc8xIv6rzOKVDXx5HuKKw7/K1rHZNFqZhLkBZPIjniZsHs84STdxX
 QXUcPoH0d41P2CzgFFN7OSgFtD2DKowLfgLfuIqIDGlZ8jTrk5/7po8hp1YRUNYpPWRXYqU
 s8jqhwq2RBMZeGyZQNZiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rjdhrFLoA9I=:cMlJGV0j540GRk8VEWjNyU
 vnTs35hgC/reEgXAoPv6H8cWVLB4+TMeVwH4Tn04JVtYyQPp1PcXq3rDG7mjk/bjh7nCM16ba
 2fjhyN+D/xyYgeFdUimcODXrU25Lf2g6Xuqub7NYbci88ePFE+5jPzrkTqGGH6SX+WmKrGOwW
 /pjuPtvC+mnK2ad9RYQ0+q7b80pW2HKOBTXNgO0cMOpd5gavOHCera0R3NOcWhSNFuc4TEslV
 GOjeFrVbJ69xdBU3UCy1kV2+vfEMwX48sXbtMPD4Yo0Eez/IQeIIo6arYYgYRYECfCEcpX02H
 Mw1TLOxAJXysjD7g2gqGwSAfCrYsiR/8qNdwWmG0y9pFVj054yNWROCes8F0j5ZMuiKLf4Y9X
 bfHQPsl28eZHGMrobZNNA1mlz5dZEGjG6QTxQOfn2V3Ub5slRhBtfkriTWo8YRcn/XrQArdpa
 Kxx/XiHQUbxWKfwoF1ZeW7HRPjSei7Gc+fe9bhpGjTHcpmUXASf3YFT0l5mWbvLRyGlustiSA
 s9shW1Gq6A+InFuDMQLH5icCypcwqsh2/MaXB/4UMI+pWEBHcizxrwSflVgBINrVQ9wZ6VskZ
 a9WRLF2gPyYr3BdGX8NfdBHDj4PiUHY8g/21WeaJZUYt/4DW0389sqtrUseYC0hvwQfP7qbiO
 QMn4eDoudTfAznvpqRQY8wnRziA24boE6RFBx7bnC1ubrZIe7awtwzVGs7nk5RFe9/5RR7CcV
 uvIrBV5vYkz6rjOtzo4fcWbxMl/hdXv+NVxHdW5zYTvb8OIVpIhojZGbCHFpYZzqCD4esxUZn
 96hRSRMsr118ueCmVuAl7sIcZF4weJaSs54yJ8Y4IbPnccefko=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 11:46:02 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-sh7760.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index c2005c789d2b..4d2e4d10600b 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -445,7 +445,6 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 
 	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
 	if (!id) {
-		dev_err(&pdev->dev, "no mem for private data\n");
 		ret = -ENOMEM;
 		goto out0;
 	}
-- 
2.16.1
