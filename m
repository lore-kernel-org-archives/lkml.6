Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA90C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632EF2242C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e0pRkbue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632EF2242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeGBNI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:08:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56229 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeGBNIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:08:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180702130821euoutp0138c3a5ddc0161a89612c5153061399d6~9jzQBHYmB2481724817euoutp01x
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 13:08:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180702130821euoutp0138c3a5ddc0161a89612c5153061399d6~9jzQBHYmB2481724817euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530536901;
        bh=dH2gO8NhFHBOhSm1w0/dHc5QyFNV3eBy3xi5kax64gM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=e0pRkbueESiJl5QCZRjKULPNVnAe+w77UVrDBvGtg9sjVzHEBjNkjxwUR7SzvQ2D5
         JxDw6KjoZ4FsJu7GvzRmmPRjZYgzFANQCgGNZy1Bw54T/xR7EAI8yANzu1hEjMYtML
         kSfHmXZ8LDwgX6ora9O/lhiLZZwvGQxsljIcFECU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180702130820eucas1p2f5eed38296df902da13618ab8d612bcc~9jzOds-UD1641816418eucas1p2K;
        Mon,  2 Jul 2018 13:08:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8D.A7.05700.3C32A3B5; Mon,  2
        Jul 2018 14:08:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27;
        Mon,  2 Jul 2018 13:08:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180702130818eusmtrp2d2156079f358e2725be26a8fafc3b73f~9jzNGMM6R1434414344eusmtrp2V;
        Mon,  2 Jul 2018 13:08:18 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-26-5b3a23c370c4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6C.14.04178.2C32A3B5; Mon,  2
        Jul 2018 14:08:18 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.116.147.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180702130818eusmtip1c83027ab3e481782ddf1359e4258c515~9jzMr3HVY1214012140eusmtip1Q;
        Mon,  2 Jul 2018 13:08:18 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] dma: add support for reporting pause and resume separately
Date:   Mon,  2 Jul 2018 15:08:10 +0200
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djPc7qHla2iDT49s7C4cvEQk8XGGetZ
        LaY+fMJmMX3qBUaL1VP/slosmTyf1eLyrjlsFmuP3GW32HnnBLMDp8eGz01sHov3vGTy2LSq
        k81jyZtDrB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVMXPdNvaCPvmKox0X2RoY26S6GDk5
        JARMJN62L2PtYuTiEBJYwShxdOpOFgjnC6NEV+M2dgjnM6PErd8r2GBafm6eDlW1nFHi5LQT
        bBDOV0aJXfvWMYNUsQkYSnS97QLrEBGIkpi5+ihYB7PAL0aJC8tuARVxcAgLeEvsbJQGqWER
        UJV4PrGbCWKDvMTqDQeYQeolBF6zSZxY1Qs2lFegTOJx/1tmiCIXiZYrrawQtrDEq+Nb2CFs
        GYn/O+czQTQ3M0q0z5jFDuH0MEpsnbMD6glricPHL7KCXMEsoCmxfpc+RNhRYtLFQ+wgYQkB
        PokbbwVBwsxA5qRt05khwrwSHW1CENVqErOOr4Nbe/DCJajTPCROXH3CAmILCcRKrJ97jGUC
        o9wshF0LGBlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCaL0/+Of9rB+PVS0iFGAQ5G
        JR7eCnmraCHWxLLiytxDjBIczEoivKIfzaOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJ
        CaQnlqRmp6YWpBbBZJk4OKUaGLO3bIjbInrni1/vY/3qztL90Q7/O/PulX8vNb61dpK3km60
        UNO/Xk/uJ3MVFlf6SoYcPqe3KuW6wdXex4d8D3ou1jgeWfiSr6Ohh+O82u88+fVad3w3Xe5Z
        utdtP+vN9z7PlUqd4iYlB2ReVrPl2BXe/pLl9DbOV76/51+cMKV4fl3Lyx+HBZVYijMSDbWY
        i4oTAeomWn8SAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t/xu7qHlK2iDbb06FhcuXiIyWLjjPWs
        FlMfPmGzmD71AqPF6ql/WS2WTJ7PanF51xw2i7VH7rJb7LxzgtmB02PD5yY2j8V7XjJ5bFrV
        yeax5M0hVo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DLmLluG3tBn3zF0Y6LbA2MbVJdjJwcEgImEj83T2fpYuTiEBJYyigx
        qWEvE0RCRuLktAZWCFtY4s+1LjaIos+MEtf2rgRLsAkYSnS9BUlwcogIxEg0TX7IAmIzC/xj
        lLgyRbKLkYNDWMBbYmejNEiYRUBV4vnEbrD5vAK2EjMX3IOaLy+xesMB5gmMPAsYGVYxiqSW
        Fuem5xYb6hUn5haX5qXrJefnbmIEBui2Yz8372C8tDH4EKMAB6MSD2+FvFW0EGtiWXFl7iFG
        CQ5mJRFe0Y/m0UK8KYmVValF+fFFpTmpxYcYTYGWT2SWEk3OB0ZPXkm8oamhuYWlobmxubGZ
        hZI473mDyighgfTEktTs1NSC1CKYPiYOTqkGxi73XNlbi567rgr7V+B6Ok/w89fXHh3GWcF9
        G+0Zmd7k/NL9PD8/ek9YU+cD7VlRS3WP8M84J7S7a9G5C5Wh523X+O3mW5Vut9Rwav3OqvrL
        1yc+/3s7Zbp9jdv5/fkWusXbxWb+PfhFbEJmhfziLTXNfyfckfGObmUotox2EDuT6O/0T3TN
        BiWW4oxEQy3mouJEALnZuYhmAgAA
Message-Id: <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
X-CMS-MailID: 20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cmd_pause' DMA channel capability means that respective DMA engine
supports both pausing and resuming given DMA channel. However, in some
cases it is important to know if DMA channel can be paused without the
need to resume it. This is a typical requirement for proper residue
reading on transfer timeout in UART drivers. There are also some DMA
engines with limited hardware, which doesn't really support resuming.

Reporting pause and resume capabilities separately allows UART drivers to
properly check for the really required capabilities and operate in DMA
mode also in systems with limited DMA hardware. On the other hand drivers,
which rely on full channel suspend/resume support, should now check for
both 'pause' and 'resume' features.

Existing clients of dma_get_slave_caps() have been checked and the only
driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
driver, which has been updated to check the newly added capability.
Existing 'cmd_pause' now only indicates that DMA engine support pausing
given DMA channel.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch is a follow-up of the Vinod's advise from the following
discussion:
https://www.spinics.net/lists/linux-samsung-soc/msg63166.html
---
 drivers/dma/dmaengine.c               | 8 ++------
 include/linux/dmaengine.h             | 5 ++++-
 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 08ba8473a284..84ac38dbdb65 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -500,12 +500,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->max_burst = device->max_burst;
 	caps->residue_granularity = device->residue_granularity;
 	caps->descriptor_reuse = device->descriptor_reuse;
-
-	/*
-	 * Some devices implement only pause (e.g. to get residuum) but no
-	 * resume. However cmd_pause is advertised as pause AND resume.
-	 */
-	caps->cmd_pause = !!(device->device_pause && device->device_resume);
+	caps->cmd_pause = !!device->device_pause;
+	caps->cmd_resume = !!device->device_resume;
 	caps->cmd_terminate = !!device->device_terminate_all;
 
 	return 0;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 861be5cab1df..c8c3a7a93802 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -415,7 +415,9 @@ enum dma_residue_granularity {
  *	each type, the dma controller should set BIT(<TYPE>) and same
  *	should be checked by controller as well
  * @max_burst: max burst capability per-transfer
- * @cmd_pause: true, if pause and thereby resume is supported
+ * @cmd_pause: true, if pause is supported (i.e. for reading residue or
+ *	       for resume later)
+ * @cmd_resume: true, if resume is supported
  * @cmd_terminate: true, if terminate cmd is supported
  * @residue_granularity: granularity of the reported transfer residue
  * @descriptor_reuse: if a descriptor can be reused by client and
@@ -427,6 +429,7 @@ struct dma_slave_caps {
 	u32 directions;
 	u32 max_burst;
 	bool cmd_pause;
+	bool cmd_resume;
 	bool cmd_terminate;
 	enum dma_residue_granularity residue_granularity;
 	bool descriptor_reuse;
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 56a541b9ff9e..76c46d793843 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -156,7 +156,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
-		if (dma_caps.cmd_pause)
+		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
 			hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
 		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
 			hw.info |= SNDRV_PCM_INFO_BATCH;
-- 
2.17.1

