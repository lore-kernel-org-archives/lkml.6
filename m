Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78541C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368E02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368E02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeLJU41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:56:27 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeLJU41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:56:27 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mt7Ll-1hL8Pc3kbp-00tQGY; Mon, 10 Dec 2018 21:56:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: fix arm64 build error
Date:   Mon, 10 Dec 2018 21:56:12 +0100
Message-Id: <20181210205620.3041207-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J5G1z7eID905HVHqXVHn+k7iZcCWvCQxXxcVFWADVapF9JmJu0Q
 hTFQic1eb7oTgOBPqPKx3jT4xOfeo3B2Nc4acyxNjion7hkmIgm0SmgreNdm5WFi9uSOTSD
 b1lpMjKTgB7y9MhiuX3QFi5UkCfzV/WIHVhJrzRpE4eqZJMADzah/ypgPtDCmNqMZtqUuHe
 fmSM48uqo5dPe1O/TsQcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IiwERIOtWE=:i3+Ucu6/BKdx070CCC+zI8
 pyb5+fVQrKl/NNm6bQmVUOa8fFccQpFGSpgbycNoS1F+NqUI883DDHqXW4nBqfAB9yuQ4ItmQ
 JpnZ50wbjXRO7KGLasDi+jLtcL4kitCnWTouqJonH2ymSuHaunIXgs2lMyDT4uVHaDVlqG6iv
 nXKLPgnTKDmMD2DEOxQjR0Qcc37cFjjTYpn01RBhgtVZEzlXm+PuC+zYGA9PsC2qXnGxTIKaF
 3mt+dveT2jiRnGfeCY9WN+d2WigX51oK07mzkfZDiW3voSjg1jFDu1EgroOJv5bnijFKXpUJP
 lWfjad8eGUPzVIur9MBQHsEVDpPCPPue+bi/DEBSmvbI8LaILkYKfzZfvEQsUV+bl6V+Fwt2f
 9uKEYNx0KqiIsGMV+4KjfKXtGIFn8u15/2EnL4OHwRGKMjHURhRtF0FHiz2oD0c5jrE/GfkPb
 vem9D6dZohciYlN4dQQSB6a+Cacr0kxbLj3MX/mdH7MmAlxkYW8Wlm0ySJQUKgoxUMgTLr/kc
 rVf1315zgBrBBiTSYQnm1/owBTPKDH3Uh+GSeKJPgVknTWfiaK9BLO79HqlFIUsAKnLXdn0cM
 pibg1Ciwigk0RL9X9EEFtNVU+A2YQeor+NC9qb+MM5vRrQm5r5fS9VTSeumoDlzQAT+Cc7uRh
 kKU1MGVSQCtKJosU4n+jYlXotARkRUnbCKsllGJXDf0pHa77XE3amQJLqsihBPa1o1GEwHa+5
 RqcOgrkS9aa6i2Y8x7QuCWhp4GKXE5dEpn52+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new a200 GPU MMU support fails to build on arm64 because
of a conflicting macro name:

drivers/gpu/drm/msm/msm_gpummu.c:17: error: "VA_START" redefined [-Werror]
 #define VA_START SZ_16M

In file included from arch/arm64/include/asm/pgtable-hwdef.h:19,
                 from arch/arm64/include/asm/processor.h:48,
                 from include/linux/mutex.h:19,
                 from include/linux/notifier.h:14,
                 from include/linux/clk.h:17,
                 from drivers/gpu/drm/msm/msm_drv.h:23,
                 from drivers/gpu/drm/msm/msm_gpummu.c:4:
arch/arm64/include/asm/memory.h:51: note: this is the location of the previous definition
 #define VA_START  (UL(0xffffffffffffffff) - \

Rename this and the related macros with a GPU_ prefix.

Fixes: 1c0088f255ae ("drm/msm: implement a2xx mmu")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/msm_gpummu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
index f1dc2b7e5fd3..2a7ddd449d3d 100644
--- a/drivers/gpu/drm/msm/msm_gpummu.c
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -14,10 +14,10 @@ struct msm_gpummu {
 };
 #define to_msm_gpummu(x) container_of(x, struct msm_gpummu, base)
 
-#define VA_START SZ_16M
-#define VA_RANGE (0xfff * SZ_64K)
-#define MMU_PAGE_SIZE SZ_4K
-#define TABLE_SIZE (sizeof(uint32_t) * VA_RANGE / MMU_PAGE_SIZE)
+#define GPU_VA_START SZ_16M
+#define GPU_VA_RANGE (0xfff * SZ_64K)
+#define GPU_MMU_PAGE_SIZE SZ_4K
+#define GPU_TABLE_SIZE (sizeof(uint32_t) * GPU_VA_RANGE / GPU_MMU_PAGE_SIZE)
 
 static int msm_gpummu_attach(struct msm_mmu *mmu, const char * const *names,
 		int cnt)
@@ -34,7 +34,7 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
 		struct sg_table *sgt, unsigned len, int prot)
 {
 	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
-	unsigned idx = (iova - VA_START) / MMU_PAGE_SIZE;
+	unsigned idx = (iova - GPU_VA_START) / GPU_MMU_PAGE_SIZE;
 	struct scatterlist *sg;
 	unsigned prot_bits = 0;
 	unsigned i, j;
@@ -46,9 +46,9 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
 
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		dma_addr_t addr = sg->dma_address;
-		for (j = 0; j < sg->length / MMU_PAGE_SIZE; j++, idx++) {
+		for (j = 0; j < sg->length / GPU_MMU_PAGE_SIZE; j++, idx++) {
 			gpummu->table[idx] = addr | prot_bits;
-			addr += MMU_PAGE_SIZE;
+			addr += GPU_MMU_PAGE_SIZE;
 		}
 	}
 
@@ -62,10 +62,10 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
 static int msm_gpummu_unmap(struct msm_mmu *mmu, uint64_t iova, unsigned len)
 {
 	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
-	unsigned idx = (iova - VA_START) / MMU_PAGE_SIZE;
+	unsigned idx = (iova - GPU_VA_START) / GPU_MMU_PAGE_SIZE;
 	unsigned i;
 
-	for (i = 0; i < len / MMU_PAGE_SIZE; i++, idx++)
+	for (i = 0; i < len / GPU_MMU_PAGE_SIZE; i++, idx++)
                 gpummu->table[idx] = 0;
 
 	gpu_write(gpummu->gpu, REG_A2XX_MH_MMU_INVALIDATE,
@@ -78,7 +78,7 @@ static void msm_gpummu_destroy(struct msm_mmu *mmu)
 {
 	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
 
-	dma_free_attrs(mmu->dev, TABLE_SIZE, gpummu->table, gpummu->pt_base,
+	dma_free_attrs(mmu->dev, GPU_TABLE_SIZE, gpummu->table, gpummu->pt_base,
 		DMA_ATTR_FORCE_CONTIGUOUS);
 
 	kfree(gpummu);
@@ -100,7 +100,7 @@ struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu)
 	if (!gpummu)
 		return ERR_PTR(-ENOMEM);
 
-	gpummu->table = dma_alloc_attrs(dev, TABLE_SIZE + 32, &gpummu->pt_base,
+	gpummu->table = dma_alloc_attrs(dev, GPU_TABLE_SIZE + 32, &gpummu->pt_base,
 		GFP_KERNEL | __GFP_ZERO, DMA_ATTR_FORCE_CONTIGUOUS);
 	if (!gpummu->table) {
 		kfree(gpummu);
@@ -119,5 +119,5 @@ void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
 	dma_addr_t base = to_msm_gpummu(mmu)->pt_base;
 
 	*pt_base = base;
-	*tran_error = base + TABLE_SIZE; /* 32-byte aligned */
+	*tran_error = base + GPU_TABLE_SIZE; /* 32-byte aligned */
 }
-- 
2.20.0

