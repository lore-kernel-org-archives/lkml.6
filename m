Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965008AbeBLQTD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:19:03 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:19791 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934873AbeBLQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:16:49 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180212161647epoutp02d80c4525007282ea3a6e6aa5942513b5~SoDzs1hDn1746617466epoutp02H
X-AuditID: b6c32a37-44bff70000001029-6a-5a81bdefdd73
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 3/7] ASoC: samsung: i2s: Prevent external abort on
 exynos5433 I2S1 access
Date: Mon, 12 Feb 2018 17:15:34 +0100
Message-id: <20180212161538.22669-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180212161538.22669-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCmge77vY1RBstey1lcuXiIyWLjjPWs
        FlMfPmGzmH/kHKvF2/3dzBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu0Xr3iPsFofftLNa
        XFzxhcmB12PD5yY2j52z7rJ7bFrVyebRt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGbf7Ewo6
        OSvWfjvB0sB4ir2LkZNDQsBEYtLSRYxdjFwcQgI7GCV2TF3CCuF8Z5To/L6bCabq+5QtUInd
        jBIvL/8DaxcS+MUosX2FLojNJmAo0Xu0jxHEFhEQk7g9p5MZpIFZ4AyTxPR9a8AmCQvEScz9
        3g9mswioSvyZvJEZxOYVsJZ4ePgVC8Q2eYn3C+6DDeIUsJGYdHk51BVb2CSm3nfsYuQAsl0k
        jt6uhwgLS7w6voUdIiwtcemoLchaCYF+RomPx/ezQDirGSVef9vFCtFgLXH4+EUwm1mAT+Ld
        1x5WiGZeiY42IYgSD4nTq2+xQdiOEs13prNBPA809GrfFpYJjFILGBlWMYqlFhTnpqcWGxYY
        6xUn5haX5qXrJefnbmIEx7OW+Q7GDed8DjEKcDAq8fB2zG6MEmJNLCuuzD3EKMHBrCTC+6cZ
        KMSbklhZlVqUH19UmpNafIhRmoNFSZw3IMAlSkggPbEkNTs1tSC1CCbLxMEp1cBYtmAj8xYP
        ZUOuHXafV5/t++HR8r/r4jFRft17B9m3T7pra7muJVH68Iy9af83G62P23RI7W+pcOW6mbeu
        GwvJRIR+dnFzfec7PyvNnlnfgYvv21wF8yT3EmvPJLO9G7bxNLgVNOom7FszvzPa7WpExY3D
        4r0zWnZ8efn86JrgN38y/jScnNWhxFKckWioxVxUnAgAvOjqC+MCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t9jAd13exujDFYfN7S4cvEQk8XGGetZ
        LaY+fMJmMf/IOVaLt/u7mS3On9/AbvHtSgeTxeVdc9gsZpzfx2Sx9shddovWvUfYLQ6/aWe1
        uLjiC5MDr8eGz01sHjtn3WX32LSqk82jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mm73JxR0
        clas/XaCpYHxFHsXIyeHhICJxPcpW1i7GLk4hAR2MkqsmTQBLCEk8ItR4uRHIxCbTcBQovdo
        HyOILSIgJnF7TiczSAOzwBkmiS8TL4E1CAvEScz93s8EYrMIqEr8mbyRGcTmFbCWeHj4FQvE
        NnmJ9wvugw3iFLCRmHR5ORPEMmuJI8vXM09g5FnAyLCKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0
        L10vOT93EyMwALcd1urbwXh/SfwhRgEORiUe3o7ZjVFCrIllxZW5hxglOJiVRHj/NAOFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYOw9PmPTA73gCRdV
        TKW9mpzku3qzlr5SEMr8LP9OMLDlFasn90oBaePl/tb7v6UUhG1fMmE99+EfDKFmCXdvZc6N
        lWC8+XzNbtkMyZ2mF3R+NfbZFbdJTWF56OXkoKWuJ+hXICbtaTGRu9ToFe/c4O6dbyIlDjtd
        3nrpEL/ElrjHQctyLKRUlFiKMxINtZiLihMBxrl8lDwCAAA=
X-CMS-MailID: 20180212161646epcas1p2dabca4c8d98d3e66b7a78133d926bccb
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180212161646epcas1p2dabca4c8d98d3e66b7a78133d926bccb
X-RootMTR: 20180212161646epcas1p2dabca4c8d98d3e66b7a78133d926bccb
References: <20180212161538.22669-1-s.nawrocki@samsung.com>
        <CGME20180212161646epcas1p2dabca4c8d98d3e66b7a78133d926bccb@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems both PCLK_I2S1 and SCLK_I2S1 clocks need to be enabled before
I2S1 control registers can be accessed on exynos5433. If SCLK clock
is disabled an exception is triggered. To fix this parent clock of
the RCLK_SRC clock is assigned to pri_dai->op_clk so required gate
clock is handled by the runtime PM ops.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - removed stray whitespace change.
---
 sound/soc/samsung/i2s.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 5088d12faeda..7b57ad11ca15 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1404,9 +1404,14 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = i2s_register_clock_provider(pdev);
-	if (!ret)
-		return 0;
+	if (ret < 0)
+		goto err_disable_pm;
+
+	pri_dai->op_clk = clk_get_parent(pri_dai->clk_table[CLK_I2S_RCLK_SRC]);
+
+	return 0;
 
+err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
 err_disable_clk:
 	clk_disable_unprepare(pri_dai->clk);
-- 
2.14.2
