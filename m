Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29997C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33F520652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ+xFtAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfBXJzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 04:55:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38483 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBXJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 04:55:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so6750331wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z2EGlZF9NQEDYntYusFOxed1rsr9en3Tiey6TZSEYso=;
        b=cJ+xFtAJ5AFoA5Hc7z6R8syG3ltwsaW3scjVmqzjliQfXU3TeZsorXiUdSD8m1N6JS
         6vQoKCyWLb/BnoUZj4KMFsJi/m51gx83n2QBQ/0hLl41EmeUlEn/3l0oq3a1qBayjx5u
         cm9H4Q1vHKYDEbMe0Tph2MVNK2U6we5wmYGHQF1kTki9NpDIBGemVsnftvq2jq7ar6di
         vSpLwcQPGZCmaQVXjWSaEjgLcTA9ecmKgMeMxcblSiBR7QIrKq5IjobqH0SRZUa1aNPN
         XSwSetfI+6BpVlcWdkT7VJF126KtxH41Vb1hdCkciAMmxj4el+WQEbA/owt1Pgk5MO85
         NHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z2EGlZF9NQEDYntYusFOxed1rsr9en3Tiey6TZSEYso=;
        b=REBcEgszi5LY6M9r4OgVZCOKPvvl38mtqHguDe2Eipy3Prtd+dGI6f9eZSKp1osLuF
         QSTTKLQasehviRcI+5/o6FurxduB0M6GkG0da3Qp2fGiGNArUbyn5vV628cldnfoUz+h
         /IAhm+fgbsBqQMcs82Vu8RH6bJeS9lu9eCLrnw+XBqY50jNBnDcRzCk5xkTtx/CrkcGy
         KFJP/G1XVj8hoe6Aviw9naerbRNOcBguiQ6cKsRGfnpjXV8KCPmV7p+iKFss00TShnhR
         hO4HbcbuU3lf8HPoRDqWNEt2LB5Av6N/52pefZlIi9UJg/UIrhzE6I24PlJMPfEv5AV9
         /+Tg==
X-Gm-Message-State: AHQUAua6Yv7C8lRaVCt0xmT3iraGS9EF/QFWwk9zvpVBzHlgv5+nqcb/
        Ljr6naYChFRn0iaA2H1raMrqD8DH
X-Google-Smtp-Source: AHgI3IbTAl6zCFh/HvYim+DUPB0DglUHpB2ZKJv/IkYMFWDDPXRR3t5GTBFvO4GJqLDlsyOnadphNA==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr8785907wrh.132.1551002129031;
        Sun, 24 Feb 2019 01:55:29 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id d9sm8495054wrn.72.2019.02.24.01.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 01:55:28 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     rppt@linux.ibm.com
Subject: [PATCH] habanalabs: use u64 when comparing variables' sum to u32_max
Date:   Sun, 24 Feb 2019 11:55:26 +0200
Message-Id: <20190224095526.29183-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two smatch warnings about two if statements that are
always true because of the types of the variables used - u32 when
comparing the sum to u32_max.

The patch changes the types to be u64 so the accumalted sum can be checked
if it is larger than u32_max

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 6 ++++--
 drivers/misc/habanalabs/goya/goyaP.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e6f0d49ab71a..fc53cdb38f23 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3474,7 +3474,8 @@ u32 goya_get_dma_desc_list_size(struct hl_device *hdev,
 					struct sg_table *sgt)
 {
 	struct scatterlist *sg, *sg_next_iter;
-	u32 count, len, dma_desc_cnt, len_next;
+	u32 count, dma_desc_cnt;
+	u64 len, len_next;
 	dma_addr_t addr, addr_next;
 
 	dma_desc_cnt = 0;
@@ -3915,7 +3916,8 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 {
 	struct hl_userptr *userptr;
 	struct scatterlist *sg, *sg_next_iter;
-	u32 count, len, dma_desc_cnt, len_next;
+	u32 count, dma_desc_cnt;
+	u64 len, len_next;
 	dma_addr_t dma_addr, dma_addr_next;
 	enum goya_dma_direction user_dir;
 	u64 device_memory_addr, addr;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 7dc324e4e268..fd1476039226 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -122,7 +122,7 @@
 #define VA_DDR_SPACE_SIZE	(VA_DDR_SPACE_END - \
 					VA_DDR_SPACE_START)	/* 128GB */
 
-#define DMA_MAX_TRANSFER_SIZE	0xFFFFFFFF
+#define DMA_MAX_TRANSFER_SIZE	U32_MAX
 
 #define HW_CAP_PLL		0x00000001
 #define HW_CAP_DDR_0		0x00000002
-- 
2.18.0

