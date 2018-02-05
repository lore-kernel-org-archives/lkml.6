Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeBEPpj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:45:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:31807 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753136AbeBEPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:45:19 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180205154516epoutp01c7d96b52a766fa0624aaeb8267fa98ed~QeHSbG9c32278922789epoutp01c
X-AuditID: b6c32a35-891ff70000001031-88-5a787c0ca8df
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 3/8] ASoC: samsung: i2s: Prevent external abort on
 exynos5433 I2S1 access
Date: Mon, 05 Feb 2018 16:43:58 +0100
Message-id: <20180205154403.13520-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCmni5PTUWUwaYLIhZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxqeGQ4wF
        HdwVH6Y9ZmpgnM/ZxcjJISFgIvHn81mmLkYuDiGBHYwS2z4+gHK+M0rcW/2XEaZq1eXNzBCJ
        3YwSG473QTm/GCXO9b1jA6liEzCU6D3aB9YhIiAmcXtOJ1gRs8AZJonp+9YwgSSEBaIl1uzY
        D9bAIqAq0bhlITOIzStgLfFmwVJWiHXyEu8X3AcbxClgI7Hn3jJGkEESAjvYJLZ8vgVV5CLx
        6OZMKFtY4tXxLexdjBxAtrTEpaO2EPX9jBIn1jRDNc9glLjTPoEJosFa4vDxi2DNzAJ8Eu++
        9rBCNPNKdLQJQZR4SPy9NB2q3FFiyauZ0IABGjpr5ny2CYxSCxgZVjGKpRYU56anFhsWGOoV
        J+YWl+al6yXn525iBMe1lukOxinnfA4xCnAwKvHwCmRURAmxJpYVV+YeYpTgYFYS4XW6Xh4l
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnDcgwCVKSCA9sSQ1OzW1ILUIJsvEwSnVwCjbPvej4+P1
        pWHSUUskbqyPOXwzZbPI1mdnMsz+3db4a50jxGe6aeq9/8ITHxqsmx/oujpvgb7Jjy07mLbp
        RP4WVi7ZbLRAOPX3j+WplSfaJe6ZejItDC5ZItX6cIdvQubfE2Y7TzCe/5Jzau4yo+bmprkp
        4vURc+Xt3S3d5ZmV1GfldM4/16fEUpyRaKjFXFScCADZUB6y5wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t9jAV3umooogzeTrS2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujE8NhxgL
        OrgrPkx7zNTAOJ+zi5GTQ0LARGLV5c3MXYxcHEICOxkl9u09zA7h/GKUWL7tHxtIFZuAoUTv
        0T5GEFtEQEzi9pxOsA5mgTNMEl8mXgLq4OAQFoiW2DjNGaSGRUBVonHLQmYQm1fAWuLNgqWs
        ENvkJd4vuA82h1PARmLPvWWMIK1CQDVNNwUmMPIsYGRYxSiZWlCcm55bbFRgmJdarlecmFtc
        mpeul5yfu4kRGIDbDmv17WC8vyT+EKMAB6MSD29GVkWUEGtiWXFl7iFGCQ5mJRFep+vlUUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwTld9l3q4yixz
        Q+jTlR7X5p46cMCx+0HySsP3575uPCf6RP6NW5C2Tp2/6bEfP8Nzyta7PmgWXij54fbu79uM
        dyvzbGh11udT2shp2uc0jf3fI6spv1Rf6qiYt+TUpQsy790VcPzKjhOagd3hWY497B+ijyyW
        vbBi9t6r/gLx9svmLX+58NBvZyWW4oxEQy3mouJEADn2rM08AgAA
X-CMS-MailID: 20180205154516epcas1p39c5977145e7b32879b935087ee3865f8
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154516epcas1p39c5977145e7b32879b935087ee3865f8
X-RootMTR: 20180205154516epcas1p39c5977145e7b32879b935087ee3865f8
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
        <CGME20180205154516epcas1p39c5977145e7b32879b935087ee3865f8@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems both PCLK_I2S1 and SCLK_I2S1 clocks need to be enabled before
I2S1 control registers can be accessed on exynos5433, if SCLK clock
is disabled an exception is triggered. To fix this parent clock of
the RCLK_SRC clock is assigned to pri_dai->op_clk so required gate
clock is handled by the runtime PM ops.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b7d25a63da8b..1c05170e4999 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1328,6 +1328,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
 		return ret;
 	}
+
 	pri_dai->dma_playback.addr = regs_base + I2STXD;
 	pri_dai->dma_capture.addr = regs_base + I2SRXD;
 	pri_dai->dma_playback.chan_name = "tx";
@@ -1401,9 +1402,14 @@ static int samsung_i2s_probe(struct platform_device *pdev)
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
