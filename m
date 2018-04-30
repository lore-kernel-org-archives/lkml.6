Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeD3EOy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 00:14:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23096 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeD3EOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 00:14:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180430041450epoutp02adfe7e691db3168c9b862aab1a10b4da~qG4b9Zom32358223582epoutp02S
X-AuditID: b6c32a37-511ff70000001030-44-5ae69839f258
From: CHANDAN VN <chandan.vn@samsung.com>
To: catalin.marinas@arm.com, will.deacon@arm.com,
        takahiro.akashi@linaro.org, james.morse@arm.com, robin.murphy@arm.com,
        labbott@redhat.com, steve.capper@arm.com, kristina.martsenko@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, chandan.vn@samsung.com, vn.chandan@gmail.com
Subject: [PATCHv2 1/1] arm64: To remove initrd reserved area entry from
 memblock
Date: Mon, 30 Apr 2018 09:43:45 +0530
Message-id: <1525061625-7940-1-git-send-email-chandan.vn@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7bCmrq7ljGdRBiePcFq8X9bDaDHhS4TF
        y0OaFvf3LWeyuH+8jdVi5Z4fTBabHl9jtbi8aw6bxcEPT1gtJr3ZxmTxZ/9PFovXty+wW7z8
        eILFgddjzbw1jB47Z91l97hzbQ+bx+Yl9R7v911l8+jbsorR4/MmuQD2qFSbjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKBblRTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGRnomprFWRqZAJQmpGT9W6xWs5aiYsX0NSwPjR7Yu
        Rk4OCQETic6bXSxdjFwcQgI7GCVOvu5jgnC+M0qs3HsXrurAtsPsEIndjBItj6ayQji/GSUO
        rl/EBFLFJqApcWLeNLAqEYF2JomrxzuBEhwczAJOEtev+4PUCAsESZw/95UFxGYRUJW4Pf0s
        2AZeAVeJh8cOMUJsk5M4eWwy2AIJgRVsEouPfGOFSLhI3Hi8hx3CFpZ4dXwLO8h8CQFpiUtH
        bSHC9RLrL19mgejtYJT42XQZ6gV7iRmLtzKD2MwCfBLvvvawQvTySnS0CUGYHhIvXtRBVDtK
        rLp0AmyrkECsxKK1HUwTGCUXMDKsYhRLLSjOTU8tNiww1itOzC0uzUvXS87P3cQITjxa5jsY
        N5zzOcQowMGoxMO7wfpZlBBrYllxZe4hRgkOZiUR3pUdQCHelMTKqtSi/Pii0pzU4kOMpsDQ
        mMgsJZqcD0yKeSXxhiaWBiZmRsYmFoZmhkrivE99zkQJCaQnlqRmp6YWpBbB9DFxcEo1MM56
        NEtvu+C9Qpn2Rw5PpsTPuLcv4LXyDgNbnTOLdmd9rQ0Lu3kg2ZQr+pKUWKPFRTUbk+l8Zdfl
        wkV/8ttMundyztMfX3mPHCjkm7hatV+BfVXeiwMRLIqnIufcOTF3WtfKuPaYhQpXAmINAzxV
        Mpo2TpKu8ftUHLa1ctfr9Tw2dfE6EStd9yuxFGckGmoxFxUnAgCRMDfVUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsVy+t9jAV2LGc+iDK49NbB4v6yH0WLClwiL
        l4c0Le7vW85kcf94G6vFyj0/mCw2Pb7GanF51xw2i4MfnrBaTHqzjcniz/6fLBavb19gt3j5
        8QSLA6/HmnlrGD12zrrL7nHn2h42j81L6j3e77vK5tG3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2
        CVwZP1brFazlqJixfQ1LA+NHti5GTg4JAROJA9sOs3cxcnEICexklDjTvJcVwvnNKLGh6TUz
        SBWbgKbEiXnTwKpEBNqZJJoXfgBKcHAwCzhJXL/uD1IjLBAg8e/eI7CpLAKqErennwWzeQVc
        JR4eO8QIsU1O4uSxyawTGLkWMDKsYpRMLSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIDK9t
        h7X6djDeXxJ/iFGAg1GJh3eD9bMoIdbEsuLK3EOMEhzMSiK8KzuAQrwpiZVVqUX58UWlOanF
        hxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBKNTAGnEuRr6o9a7dRaEfCF6F7vk1Txbhe
        roxlflIUs6FyxZWbG6OVhPeZbPoZrvd7dpNrisnmxAcTl+evFVlRG8X+aP5n8YuMDpyC55Js
        pC62CHf8WJjwfmfdaj29WDYNjp03asIm1blnX2s9sTA592UAk/Ju+dqWfe+aS3Tv8XgeNNI+
        XXOKqUiJpTgj0VCLuag4EQA1Lh8SKwIAAA==
X-CMS-MailID: 20180430041448epcas1p228a727858328da77c67c01c25802b86d
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180430041448epcas1p228a727858328da77c67c01c25802b86d
X-RootMTR: 20180430041448epcas1p228a727858328da77c67c01c25802b86d
References: <CGME20180430041448epcas1p228a727858328da77c67c01c25802b86d@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INITRD reserved area entry is not removed from memblock
even though initrd reserved area is freed. After freeing
the memory it is released from memblock. The same can be
checked from /sys/kernel/debug/memblock/reserved.

The patch makes sure that the initrd entry is removed from
memblock when keepinitrd is not enabled.

The patch only affects accounting and debugging. This does not
fix any memory leak.

Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
---
 arch/arm64/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9f3c47a..1b18b47 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -646,8 +646,10 @@ void free_initmem(void)
 
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd)
+	if (!keep_initrd) {
 		free_reserved_area((void *)start, (void *)end, 0, "initrd");
+		memblock_free(__virt_to_phys(start), end - start);
+	}
 }
 
 static int __init keepinitrd_setup(char *__unused)
-- 
1.9.1
