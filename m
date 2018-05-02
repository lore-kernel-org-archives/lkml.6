Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeEBNQr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:16:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56221 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeEBNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:16:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502131642euoutp02d6ce89a8b3ddef9474ec66e6ab166c05~q1kHu0VnS2750627506euoutp02v
X-AuditID: cbfec7f4-b4fc79c0000043e4-af-5ae9ba393258
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: ti-soc-thermal: fix incorrect entry in
 omap5430_adc_to_temp[]
Date: Wed, 02 May 2018 15:16:39 +0200
Message-id: <4545865.29a7YhQN8j@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7djP87qWu15GGSz5ym0x/8o1VotT25uY
        LC7vmsNmMXtJP4vF594jjBZPHvaxObB57Jx1l91j8Z6XTB7Hb2xn8vi8SS6AJYrLJiU1J7Ms
        tUjfLoEr4/qlu6wFz9gqpl1dzdrA+IG1i5GTQ0LAROL2jBXsILaQwApGiS2z9boYuYDsz4wS
        /evus8AULThwlRkisYxR4vyXPWwQzm9GiYZvN8Gq2ASsJCa2r2IEsUUE3CRmLfkDZjMLVEos
        eX2FCcQWFoiU2Hf2CDOIzSKgKrH16hOwOK+ApsTkxiYwW1TAS2LLvnaouKDEj8n3WCDmyEvs
        2z+VFcLWkTh7bB0jyBESAj1sEl+nPIX6x0Xi4PXrULawxKvjW9ghbBmJzo6DTBANzYwS33bs
        YYZITGCU2LNeCMK2ljh8/CLUBj6JSdumA9VwAMV5JTraoEo8JD4e2s8EYTtK/PgwnQ0SdrES
        W35fZJ/AKDMLyd2zkNw9C8ndCxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgTG/ul/
        x7/sYNz1J+kQowAHoxIPr0Heiygh1sSy4srcQ4wSHMxKIrwrO55FCfGmJFZWpRblxxeV5qQW
        H2KU5mBREueN06iLEhJITyxJzU5NLUgtgskycXBKNTAWRT888WLF299Tmlr2MPhsU2vYJfF6
        9WE2g5Jt874z8Yo8jgy1b15d/MRh6tMCwb/WenejH/rv1py7fHGmTvjFH66S3u/ES1peW1qI
        6te8rjUp0ayNT/lzsHHpmhdHl2sfbDn2Py1v/VTNTYzOBd9K8n8vvqbNFHlDntWnx/bdvv6T
        CudnlvxQYinOSDTUYi4qTgQAB2+YnvkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVy+t/xa7oWu15GGSyfJmkx/8o1VotT25uY
        LC7vmsNmMXtJP4vF594jjBZPHvaxObB57Jx1l91j8Z6XTB7Hb2xn8vi8SS6AJYrLJiU1J7Ms
        tUjfLoEr4/qlu6wFz9gqpl1dzdrA+IG1i5GTQ0LARGLBgavMXYxcHEICSxglrvxYwgLh/GWU
        eN+zhRGkik3ASmJi+yowW0TATWLWkj9gNrNApcTKhY1gk4QFIiX2nT3CDGKzCKhKbL36hAnE
        5hXQlJjc2ARmiwp4SWzZ1w4VF5T4MfkeC8QceYl9+6eyQthaEut3HmeawMg7C0nZLCRls5CU
        LWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYiNuO/dy8g/HSxuBDjAIcjEo8vAZ5L6KE
        WBPLiitzDzFKcDArifCu7HgWJcSbklhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBAemJJanZq
        akFqEUyWiYNTqoGx3FeuSPyrg1bjMV6nGQFqbreEhUOWPvp+6bOLFJN1surHXZ9+Fgso163v
        lbjz2DZsN8tKk0Xa1wUm/9CJYZ/bv+ej0jMLk4glGm3fV6xIv5a24XbQyS7tOdNUC3hNzlvo
        s06vV0vPWLSy0InJ3mcW82y+WQITVmU1tJaXvVF4lKz64+AcVz8lluKMREMt5qLiRAC2V5mj
        QAIAAA==
X-CMS-MailID: 20180502131640eucas1p257d5217d333c1cc264d71fd401c88cd1
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502131640eucas1p257d5217d333c1cc264d71fd401c88cd1
X-RootMTR: 20180502131640eucas1p257d5217d333c1cc264d71fd401c88cd1
References: <CGME20180502131640eucas1p257d5217d333c1cc264d71fd401c88cd1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

omap5430_adc_to_temp[941] entry has one zero too much. Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
===================================================================
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-04-30 16:23:42.000000000 +0200
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c	2018-05-02 14:16:09.461434201 +0200
@@ -310,7 +310,7 @@ omap5430_adc_to_temp[
 	119800, 120200, 120600, 121000, 121400, 121800, 122400, 122600, 123000,
 	123400,
 	/* Index 940 - 945 */
-	123800, 1242000, 124600, 124900, 125000, 125000,
+	123800, 124200, 124600, 124900, 125000, 125000,
 };
 
 /* OMAP54xx ES2.0 data */
