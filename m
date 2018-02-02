Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeBBSNO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:13:14 -0500
Received: from mout.web.de ([212.227.15.14]:61681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753213AbeBBSMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:12:30 -0500
Subject: [PATCH 1/2] i2c-bfin-twi: Delete an error message for a failed memory
 allocation in i2c_bfin_twi_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <740e31b4-79dd-a4bf-a2f5-001c44864b79@users.sourceforge.net>
Message-ID: <cfd1ee7e-6f4d-7d05-b857-a509887a6bc4@users.sourceforge.net>
Date: Fri, 2 Feb 2018 19:12:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <740e31b4-79dd-a4bf-a2f5-001c44864b79@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:HdPZNF5tNswzvng+X3ZyQJxozf00pvy3X2doHzmQaFgX36A0bbx
 Pn0swNv5stoVIQYSwLjJrOUEwpazxuzKHwznzrhVDn5fatq7aUHVFchTG4tA7r1LpcRZi9y
 hcTuJhSbDuVRXmfMJnZ/EZgTW3zTm0pkATiFtyXPlHwB8WqeHstgye4pJUoBWN2c2jUEO2O
 GlpvS+XjGUsX0W6fpp5CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fQ21erJM1qs=:IHnUZ7JMsOC8+FXvUL8ram
 Gbb9PaU3b9zLaieqtThIL1qJ9dLXY9dJFNO6GseerbNlOE3+IJ3fbkyI+SzoIyUQh5HCqUuCp
 qNB+1C2BFwyK0JUGigBxPiV3SjDupkpKXVUVl0n9tGZyyCR9yDL8BW3S15wh4C3Z5sxShkTUb
 XvldKarlqtdt34EmPx2y0ca3ciE98G0aTZ8XviRExgHbX8zWh14bdhptPGW+5mQNcObTTiT6s
 6yn0wzRvCFVr4x/kd9m2tptWGfrHJu41MJLzwCuKwigwzCZmyIgfhI1nqtqb2xuRM0mFUHkip
 ybm/T2WyMbL4Z+5+ji9Ia0RTGVl9Z5av05EiHzhAGGHA8YD+tuNTyMSLomMdqiWCBAtjdUmVT
 TywULios/HHAj1bO2L+PRHhMvH3p0SUeyctEmVSGrSHuw2vGEurqROi841kYkhfNq0Qkf396m
 p+E1DFSz9QfYWpRw2lmGVofgSKouhCKwfUp+xqNfSqdLtLP0B86kpwe5YYkPOZIc6Flw3g6DC
 5nKbP0wxuksb3qhg9vMIfpvJxN26HMOOXK4UOokTyUuF/lIvlqMTkB24zR8Gxvl2hlg8NI1vX
 3J/RRhcxfq6rYfuJuoDssXyyZpuJXO3zBozcka+LfxSMsxifW5TkNZBx+KqmYIwkVcksXoASN
 Sdk4SQ2JOxVO+cJy0on+BDvQx5zf5ZNc7dHwtcBOcKlMo63pKTan886cOae49BAzul8KV/l6w
 H6Ke39nmJshn1+1Ck7e13NvwVHt/hbTCe59e7C9F8rR+g/RcVoYKg0B148l24PM/s1RUjz/eI
 UoQX8F9hbyS5vHtTYIOuMJB26itsmod0arW6a2QzNuut0tVN1s=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:55:04 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-bfin-twi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index ff3343186a82..ed596fd56b8b 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -621,10 +621,8 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 
 	iface = devm_kzalloc(&pdev->dev, sizeof(struct bfin_twi_iface),
 			GFP_KERNEL);
-	if (!iface) {
-		dev_err(&pdev->dev, "Cannot allocate memory\n");
+	if (!iface)
 		return -ENOMEM;
-	}
 
 	spin_lock_init(&(iface->lock));
 
-- 
2.16.1
