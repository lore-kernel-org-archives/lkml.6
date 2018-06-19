Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FFE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iTdfSijg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FFE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937892AbeFSNVS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:21:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60006 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937559AbeFSNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:21:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619132113euoutp0237e9b6c25296e922eea69e1794ebe8a8~5klxJ3sDw0347503475euoutp02W
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:21:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619132113euoutp0237e9b6c25296e922eea69e1794ebe8a8~5klxJ3sDw0347503475euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529414473;
        bh=AopyXzZZStgO21ZL2cwN9AcAK+ju6vQDkv2PMdfvhEs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iTdfSijg6n9DKrU7fE0JowzgeLLqxFt/tVlpEMmer5DOZVrihcs3vA/+2F+r/UjcM
         Qz5Y+rNr1Ro6X8O5MzOcEzZFkSSP6JG91ekfp0h1+KX/DkQjHkkzLC92+YvatLifZl
         KDyGwmn7fmX8RJAofh8UJjgSpVpX56KwCpspdbT4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619132110eucas1p2ad2ad43c718d4506bc855b3a438d41fd~5kluZo09m1347613476eucas1p2W;
        Tue, 19 Jun 2018 13:21:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1C.46.10409.343092B5; Tue, 19
        Jun 2018 14:21:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4~5klprrrtK1347113471eucas1p2M;
        Tue, 19 Jun 2018 13:21:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180619132103eusmtrp165b5876e521693d0e4df4c3abe7798c0~5kln5e0rW0837908379eusmtrp1b;
        Tue, 19 Jun 2018 13:21:03 +0000 (GMT)
X-AuditID: cbfec7f5-b5fff700000028a9-7d-5b290343898e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 16.20.04183.F33092B5; Tue, 19
        Jun 2018 14:21:03 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.116.147.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180619132103eusmtip2d3cdce470e6e9eeafbdfc6532d1e2c22~5klndjFX_2740627406eusmtip2I;
        Tue, 19 Jun 2018 13:21:03 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] dmaengine: pl330: report BURST residue granularity
Date:   Tue, 19 Jun 2018 15:20:50 +0200
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87rOzJrRBns3ylhsnLGe1WL11L+s
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i5d9+1kcODwW73nJ5LFpVSebx+Yl9R59W1Yx
        enzeJBfAGsVlk5Kak1mWWqRvl8CV8WPzP+aCJ+wVe7adY2lgvMbWxcjJISFgInH7/zTGLkYu
        DiGBFYwS+x9ch3K+MErc+XuDFcL5zCjx68pRVpiWyS+eQiWWM0qc29TFAuF8ZZQ4/ngWO0gV
        m4ChRNfbLjaQhIhAG6PE7PaTzCAOs8BmRollXy+xgFQJCzhLbHxwC8jm4GARUJVoXckHsUJe
        YvWGA8wQ9n02ie1rhUBsXoEyiXWT7zJCxF0k7vzYB3WSsMSr41vYIWwZidOTe8AukhBoZpRo
        nwFyEYjTwyixdc4OqL+tJQ4fv8gKsphZQFNi/S59iLCjxNOmU4wgYQkBPokbbwVBwsxA5qRt
        05khwrwSHW1CENVqErOOr4Nbe/DCJagSD4mJf+xBTCGBWImL03UmMMrNQti0gJFxFaN4amlx
        bnpqsXFearlecWJucWleul5yfu4mRmBKOP3v+NcdjPv+JB1iFOBgVOLh1VivHi3EmlhWXJl7
        iFGCg1lJhJfhlEa0EG9KYmVValF+fFFpTmrxIUZpDhYlcd44jbooIYH0xJLU7NTUgtQimCwT
        B6dUA+NGw5cb1TYISD85U8sdx9SZWl1Ve+QG3zG/tfutXb/aWknULp6yOmDfa+9WMYNev3vO
        i9ZW1q4VKjWw9T62LbyR55z9oqz+4vufZfYZLI0V25+csc+0vOgCX2py2QPPqNLJ+V/6PkRe
        iHVoCL+TqzuPR+Zqzzy14r8mPX1rP//imTqFe2niaiWW4oxEQy3mouJEAOxR+l4FAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7r2zJrRBg9XK1psnLGe1WL11L+s
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i5d9+1kcODwW73nJ5LFpVSebx+Yl9R59W1Yx
        enzeJBfAGqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CX8WPzP+aCJ+wVe7adY2lgvMbWxcjJISFgIjH5xVPWLkYuDiGBpYwSExuWMEIkZCROTmtg
        hbCFJf5c62KDKPrMKPH09XKwBJuAoUTXW4iEiEAXo8TCXccYQRxmga2MEn9ufgKrEhZwltj4
        4BZLFyMHB4uAqkTrSj6QMK+AjcT+jzuZITbIS6zecIB5AiPPAkaGVYwiqaXFuem5xUZ6xYm5
        xaV56XrJ+bmbGIHhuO3Yzy07GLveBR9iFOBgVOLhbdioHi3EmlhWXJl7iFGCg1lJhJfhlEa0
        EG9KYmVValF+fFFpTmrxIUZToN0TmaVEk/OBsZJXEm9oamhuYWlobmxubGahJM573qAySkgg
        PbEkNTs1tSC1CKaPiYNTqoFx6Z541X3nH4RIfmB5dm/xxvsKS69sd7DO3jgjV+DlnrdbqtRf
        Out57M58EvA7OWVqVJC3hmy3u6t9E/e6Q9brJ0wt1dxnF/dCqNQgeJtSZfz66836AcvLJmZU
        rme+tWKbkUd4MX/d4gZRSebcJ4ob2zzXMB1Q4Sky/mZ0K6LgboL+NKeimiAlluKMREMt5qLi
        RACo3+J6XQIAAA==
Message-Id: <20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4~5klprrrtK1347113471eucas1p2M@eucas1p2.samsung.com>
X-CMS-MailID: 20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4
References: <CGME20180619132105eucas1p2d65cbd799e60a8ab1849c4ae716275c4@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reported residue is already calculated in BURST unit granularity, so
advertise this capability properly to other devices in the system.

Fixes: aee4d1fac887 ("dmaengine: pl330: improve pl330_tx_status() function")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/pl330.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index defcdde4d358..de0957fe9668 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -3033,7 +3033,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->src_addr_widths = PL330_DMA_BUSWIDTHS;
 	pd->dst_addr_widths = PL330_DMA_BUSWIDTHS;
 	pd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	pd->max_burst = ((pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP) ?
 			 1 : PL330_MAX_BURST);
 
-- 
2.17.1

