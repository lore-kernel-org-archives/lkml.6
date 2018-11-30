Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BBDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23052148E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23052148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeK3PD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:03:28 -0500
Received: from mout.gmx.net ([212.227.15.15]:59995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeK3PD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:03:28 -0500
Received: from ovpn-120-135.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Md3ZK-1gknXE3g2s-00IHOL; Fri, 30 Nov 2018 04:55:15 +0100
From:   Qian Cai <cai@gmx.us>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
Date:   Thu, 29 Nov 2018 22:54:56 -0500
Message-Id: <20181130035456.1586-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:cPha8ldYqUK4L+0FCOIaSu2ofykyg9p94+O3w10CFJ1JqMC22k1
 CInDsM9ftALI8zlscDUzJYHlRkqapsvd4EjKgQV8Jy+mOT1s8A1A5GzA/gJy+uzlcV95RIf
 waKSS5w12PsMYYLpbD3VTqASBDyBYVqQNwSVZJ6ArpshRgayysTQzlkNd9/KZXYNdlk6A8k
 0ZPmQWauYLipBRolic7LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:63RQSOhWdn8=:87DnSddf+qKimdQ4FIAfMi
 YTIP7SDnZVYInQR0BBD8/82HcVzngT60lVj4JOdZTlsPq456WrG2/Vwom5wbrDSnsMrpYOOAo
 aQQETHtCCxutytJ4Bmu1PfIBmJJB2W/X84rdaD/QFOXLAuDUwcgSKJk/RSRpMN2Gmigd+O5Rs
 GwlpWx4zJH2xZG6QLPrz365mYGuXwnGdSupK5/MbuHt0GtqESuEv7OLU4+D4BUFZPH9jShiPl
 507WmAdDggxsg3D3lMv10Kp7Eq47OCwGmvgl9cZNCQGiUFBBcgIyUa70yBqrulrkgezZ1WK2+
 MEEipT+HKYt3zFQQsW0u6SwldkCFd/IU/7SStWg52Y9V3GiYepNIaAR4ddu+1R2gasN37QWbW
 PpcFI0a/nZI08zBXiFFKzaFxaQScbkVwkG5yDcOoWceXL36VUEUh0r13+gHCybqJrfUm53qGh
 WsEQcFBR0DaHXbDnGuzt/GXEkwMNAsJxgFnyos/At+YpKf1hf/E7MgBwP8IBlZ2l7WMUGUeNK
 N2sfaCnJldjpijf7L6SCLckyK73HZ0Ac+xpVMGGZx1pku2wj+znVKY/iT2Vqya5jgAXAtgcK0
 Enha3VXvQF5HLBrNQKbrdhv2z7ACOATi89WTRlrDbgCWBfFYCpNmECQObn7SZfNG3SHyE2vAA
 AJnWLj9OR2ci7rFou7hA3UObvZBHsiec20XnbohUDOQDS+Q98TtLcTZjfGURNX6SydhOsCIVx
 U1adOG9ga0kjigFIzoBDR65XFa5HDUXUasyaVFKK+EsMbKMMS/+Y13Fy6+H9iLBOxqd9785d3
 ndCpTxRc571oKsWPcv/xoH5iOwRIDieaa2ed/5pNmFMgtbhTeGmaQRFWrmlZNAHwaYxU0M4DH
 sPCnUU3FL6Moc/cfIwWMEhCc1mrV14T4p9ZbquG4o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
so it could trigger "DMA-API: debugging out of memory - disabling".

hnae_get_handle [1]
  hnae_init_queue
    hnae_init_ring
      hnae_alloc_buffers [2]
        debug_dma_map_page
          dma_entry_alloc

[1] for (i = 0; i < handle->q_num; i++)
[2] for (i = 0; i < ring->desc_num; i++)

On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
already,

4 (ports) x 16 (handles) x 1024 (rings) = 65536

Signed-off-by: Qian Cai <cai@gmx.us>
---
 kernel/dma/debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..ae91689cc9ad 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -43,8 +43,13 @@
 
 /* allow architectures to override this if absolutely required */
 #ifndef PREALLOC_DMA_DEBUG_ENTRIES
+/* amount of DMA mappings on this driver is huge. */
+#ifdef	HNS_ENET
+#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
+#else
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 #endif
+#endif
 
 enum {
 	dma_debug_single,
-- 
2.17.2 (Apple Git-113)

