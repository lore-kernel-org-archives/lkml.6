Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeCIQtL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:49:11 -0500
Received: from mout.web.de ([217.72.192.78]:53883 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeCIQtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:49:09 -0500
Subject: [PATCH v2 16/17] mfd: twl6030-irq: Delete an error message for a
 failed memory allocation in twl6030_init_irq()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <575d5e65-381d-c12c-8d75-eadae7a92566@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:49:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:jcvPPrgh8aSLHS54hnIo1doU7FWD90xfJhpFOcd+quQ7exYoMZO
 N1VjKPz/TPBX30r8RVG4L+eXV5GSBvOhC4oFtOXDPP91mNc7TLDqa+xD7V9TNrxi+pGpRm7
 iEi5yO5Q8JENvnRgWDk5ahkE7+O8A6Ti2aBxiWJo33TMAH9S6SiRgPgYV5VwCmtiTMWTpQL
 hD6GPOG5Ztld5UlIgbmZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sccQOTD9O9A=:W0Tgx3pR/i3IsdIx1CWjzX
 zLHN0Sx3P09nCAKTbNQ6QbsPPMG0H8rJUo9Kj9c5DxK2A/EqyZ+vMjXmEM5veFl/1vZk39Sll
 q6QTROiSn2f8n0fD1zBRZ6v28Y4hmR82czL68oMqFkQKiVuYUzs6ozzck+zbFuXjkHgKkiTYW
 TB3Tj9BAJ3pgOpeKFPHf2s2JZG8qRGs6bkbk/C29lWhuvui3m7DwgM42dWa4ruoeOPoxZkrT6
 cnN+6G+YoqDYXbEcuAcHXNMS8mJRzG2Tjy89/T8BebCWFK3Idm+vqnVqQhUWFveOV7bKISLRL
 8GtKhSD9aU/nNA0KaZT6eKXKRzleNMJlc/gsu8TqQxd8uje4SdnuOG7j0uKmi9Gpa0TAtLAf2
 wsaTmTwBU2nQkHpIe6aT5ksz1oq9TtOvZzoAfkWTChQm++MTIO68oeehIC/d5I99L8w2DhlqW
 UrzEcIMZ3atzHIDscS4TB2lXn6FXiR7KPT479DBw9mdkCQVWoEHSccj415Zk4wKgAJO1z5ig8
 8bGGrAuZ3utn2u6KGhS+xdS9/Xh2uymyVeN6wD9W7Qs3ZCgDaC+W2K7l8fQsrsXfU0xfYBgaw
 IU/W0MgzG4aCQnlYbB8N4NsWiMOp0IIVRg5paDr9bSXBRc+34xR972AbjYsXy6g/YJEWVlQJa
 3VdWNMrMEUCx1B9EN3JpRCf855usc/u/1UAYSceXAzAzM+DyimmSfozziLdbS27Nrh1sUM5mJ
 fOawbpRgk9NB/5524dre76ORna1BR75C0aODM98jYEkiXR53myWcQXCg/rl1CCx3Z6CWsLSjZ
 Vwi4RVFZk/ZAPCn/lAgWWHdJGTVOM+fRMHDa4oHZhlvCUhfJ3c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:49:32 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/twl6030-irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index e3ec8dfa9f1e..e939431ed10c 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -392,10 +392,8 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	nr_irqs = TWL6030_NR_IRQS;
 
 	twl6030_irq = devm_kzalloc(dev, sizeof(*twl6030_irq), GFP_KERNEL);
-	if (!twl6030_irq) {
-		dev_err(dev, "twl6030_irq: Memory allocation failed\n");
+	if (!twl6030_irq)
 		return -ENOMEM;
-	}
 
 	mask[0] = 0xFF;
 	mask[1] = 0xFF;
-- 
2.16.2
