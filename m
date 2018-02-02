Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeBBOWb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:22:31 -0500
Received: from mout.web.de ([212.227.15.4]:54640 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeBBOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:22:24 -0500
Subject: [PATCH 2/2] i2c-sh7760: Improve a size determination in
 sh7760_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Message-ID: <51f963df-4ad0-22a9-5d27-67facfac7a27@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3f4a9053-5518-61ab-2cdf-e400f6b35ce3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kcDwTQnplwXRSwYbjjyNgYb687Tea6AXpSIgUAsNG9OEA2FIplr
 fjqaGh4x+9MIj/Ul4ij6Co2yJBgQnYw7+BKXozQSTtlAS2hvcr+MaCbdcQ11QCyS8LAc/yn
 DSiHpvCC65untEJacteunDR7tZ1821XzovJtaPiWYaeioYMkurAYL5N1CIN7FlTG7/0F2no
 vgD5Ru94HP257SuncXVmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i2Cj4pgUHqg=:Euxlk7N6xmF/KgIsL2kRCd
 MEkbGHOHTF4aJ7qHlxHxO6/NdPQD4r5mrCOZjNMTVDaJeMfQVa84Bk67sWvU471s1N6H7167f
 T4ST4SVw8QqFe3ILcjythUlFGZOuYmGLYuSonvHBSMzXKdKyuBvlI5Q8tF4Yre1pdHtVf4Cfs
 CSGz5tyUrf2/0aH6vfXF1BLoi3G0FOXEXEWmz5C0cCUseaFcn03ZnXhkbX8wOFpu0wCB9SsaF
 Gm4kcEAhxsB5ztLy47KXp8DLqmK3Fyh7AmRIiLxEW5VvIBqCuVNbTm7JsUhH7+BJBDjNPmy8b
 2KI0P8LOVWvpCenbzw385Pbdl9XF/JanV9rpe/sZdXFIn9MH2/G79+VF++SX+tnBrr6mPAekf
 drE5O+/B8GtThgDK1reQXm12FbzmsCAGPUS7t+5mXJZ3+A7lhCE9IjSziYT8eYPoKLSy/0/pR
 /geDoWwjjtWojBEd0bIxBOZCv31kXapSvtHyrdu9BTaNcQZhy3oML+24o93k5T8wJezQGV77q
 Ov1W0R1tL6/vvr6E8nHP8rtLMnZhGcxvPGDrY+6j5Uce/rvxmuGthAne5Ya1uwto9Enz7xStE
 tk8qK7YTuwqvrmmVxgYlofOCEeip16VboMMOJ0BcMj7KBX5zxkySgBfZ+4I7ogO5rshfHx/Kq
 PxH+KR/iCMgc/lt/2Ey980tmx2K+GUuGAZqKSQKnyD+gqriUVUCPFZFBYY22YpajHdHdJAs4E
 sb6zdjs6PFPlOTKIqEZHUC8ZITXFge26nEuF20274GVpB1F4iZYp6aI9Q1pJtEbCVnHn9acpz
 Gx59ay3Jylk9//L/1EuPP2D5LiKKIEdmIL+sV2Cb37IFr56ks4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 14:50:09 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-sh7760.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 4d2e4d10600b..62bc23b9acbb 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -443,7 +443,7 @@ static int sh7760_i2c_probe(struct platform_device *pdev)
 		goto out0;
 	}
 
-	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		ret = -ENOMEM;
 		goto out0;
-- 
2.16.1
