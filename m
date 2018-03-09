Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbeCIQS6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:18:58 -0500
Received: from mout.web.de ([212.227.17.11]:55435 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIQS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:18:57 -0500
Subject: [PATCH v2 08/17] mfd: ti_am335x_tscadc: Delete an error message for a
 failed memory allocation in ti_tscadc_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <f65cc95b-00c5-98b3-e316-372783749a8e@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:VjVFdbspcvG5EQdivAYaFxdxp4O5pJB2mydMpMgR0oQ40PzX+uE
 OCaHjW3/Wj3ey/mHsWy0CCdSiXn+D02+rGUUtkXftrAwXDAsgHGCEzvbihPy4WAHeZlziwg
 /Z6l1Q5zzadEFVY3+1L+dZDmLKxja12cVINMwTlfsVV9LUGiCWNHDLnparnXSEyIXjbb1Iu
 PpkeVOk5ePdvHpwuj/bDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f+XfofWsj64=:9JAtbNq/Y2V6mpEOmqX0XP
 WPjrtM0LbHjuFKkd9e4gXZRLkehpDAgblxhcy8Ir7yaBYawMZk9ERNhTbJCRlNg/tQR8u9BoM
 ZyerHopPx5TBlNKqo4LT1JOLPkA4lGKyDBxirLA0AZh6zgiLDAaMRjqj3t1IitvFLSyQKthxl
 877CrXlvzG7HXTMxFkYUNNo+6xPwI2VnUnid33Ez6NY6WC8BDkUQwH0LrLhLFoOxjOtB6B3So
 G9KEQ4I0X/NisXeIIoezlRYPObr6pj5PjI3MliBQ77/BnBOks/cyWoqNahz3VZjyzHO1fUM7B
 l6YCdPoGIXH3H4bYHu4/KQgBOY/QXIspRIAKawduX79yVBQUyaWEeoBX8QlvP1hLBB8FPjEUi
 m37fI/XuXFG1r3MMgyh1xL4yoKIea1hBYnEoazdzyqSyLWyLtn8YMegMtgWxapwTlvWPpvKz+
 GnvJbGGYUigzobK8CUFeTY55LMpC4IuRmCt6TjlIUhIzKI6dVjUrzvPPqToz3xglUwT6pH3SR
 ICrNJp6x4HfpilHuHADkZnXR7DmUtrIn1gJIUaGLBLdwjhu3bE6OY6vY5/E1Lt2OHzMHm7hAM
 ZExqs3wRYevmaXSaVNaPVF9rqGmnNZFWkjReWBIuumCDQdI969gjvplp11iJoSeZtzW+ceE+a
 AH1cOWaUIWcs6VKSyNuMxgbBWePXIFAwoZCtPh5TM6AuLvAjE0b7fOctyK1E3LI1cTcY+K+12
 dxOaPi8LwbobpR4ynauEBysYnywBGEmIA4jEzZ4Iy2YrW3UXpmyoEmwKiGw8G5fDoai23wm9g
 PhdqOUZJ6tEyu8n2eu3zPFjged4FXSv3gIwGB3G7XauyN6Vh8A=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 15:15:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/ti_am335x_tscadc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 3cd958a31f36..47012c0899cd 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -169,10 +169,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	/* Allocate memory for device */
 	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
-	if (!tscadc) {
-		dev_err(&pdev->dev, "failed to allocate memory.\n");
+	if (!tscadc)
 		return -ENOMEM;
-	}
+
 	tscadc->dev = &pdev->dev;
 
 	err = platform_get_irq(pdev, 0);
-- 
2.16.2
