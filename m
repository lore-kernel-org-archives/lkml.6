Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161820AbeBOVW1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:22:27 -0500
Received: from mout.web.de ([212.227.17.11]:49075 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161516AbeBOVWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:22:25 -0500
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] sata_dwc_460ex: Delete an error message for a failed memory
 allocation in sata_dwc_port_start()
Message-ID: <3ba388af-286a-df63-e78f-c82c1d084439@users.sourceforge.net>
Date: Thu, 15 Feb 2018 22:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ByR1GXMSDTeyn8vRLjkLgt7nAR6RlwW80afXCbylBNHWAfDQzJn
 FcnTSyV4jPzf+WyKdBQEBYX/yG3X5Jp5zosLS3XhIT9Q01YnU7uK7nU0rCeKmCaWMOotUd8
 pfNkv2JHTjK2uaPJ0Jc0Vrzy+0Uo5AfQtc6YICLzDfJmh1UynHq87zpHAgvCurQfhFPV4vA
 euDEvEeT5JCjBjocKGUfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ZpI4bAnRHM=:/pyyRIM2RevoYgKGmCbn+H
 8gNMprjhfGS9Atz2xULlWOss61bZzAczS1YQL5/AupxWg2sVnXs2RR903KIOs4HkngV0HNN+u
 AaSqtRvlySPgqXn5EIZuK+GKPR2N028floCpUMasphyCsN0wCcBVi7IlZPw6Gf7/zn0Rna+O8
 PGgaXZrW+m8viqbVDvz947Lu8YGNFlgHA0S2j3/V5kOcAxBcxQVo63ImZiPDdUZgAVnZHW2+5
 j8M8LVRqOlnn5rylQqX1ZVyfhcQJa4LstHbDQrDH3cZ+eqaNKjSQw054nlzWasO3mu/AxRIQ3
 AIPQVEqRCn09LMrRZNtqJoBnRi7jMPjtBmekGgU8v/mH0t/7Ua31o+G8Wh+1OIGhE09LIqbKx
 SSuL+rZpFh+tpWuMUcK2oKLQ1xVpVapidHBzTXYnWet9WsGun/4ALMVpFUWIauGmuTigjjv2M
 +6H4jlNwY7SGna3FA2spqdJ2xfHYwIfFUN61BuGTCC3LJx6NlVga/7f9GXMkA9zxDr6oh2rxN
 rAg2l6b90XDcD3shlc+QW4uU0guIMDzdbYEVRAHg2Ueg4v3mZh6oMcpyVOdNcfJzJus8GqvTP
 LKcWWFyXyKS1bjCb6gFSrLX2TS6KYT/RmX+lWtFhJSWYrklnhCdDem52r1zeYSTdCDmkRt8Y2
 pc7DmTjqzbe/nAjs1Eds7FKqamianm0hw0Y9rXS2e4gxIMNSFnUG+WeKMCxcg6MgdsGhWUaCs
 av6SZQxHlY+0ghHHNwGixeCl1UYnjV+prQ1+HZ2VgV8P91hJ8E+xbTAQ6JheoAjY3v3u4bwSp
 IePX/M5dYbJt7x7WpSbPF81hmXPKjUxT77zBrfehXYnt861dAw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 22:15:25 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/sata_dwc_460ex.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6af4ec3c88c3..ce3d6674ef80 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -901,7 +901,6 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	/* Allocate Port Struct */
 	hsdevp = kzalloc(sizeof(*hsdevp), GFP_KERNEL);
 	if (!hsdevp) {
-		dev_err(ap->dev, "%s: kmalloc failed for hsdevp\n", __func__);
 		err = -ENOMEM;
 		goto CLEANUP;
 	}
-- 
2.16.1
