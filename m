Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB1C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E462082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBqF52GX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E462082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLBEG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:06:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46797 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeLBEG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:06:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so9372953qtm.13;
        Sat, 01 Dec 2018 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jc/QnxF9T0QZ56XXEaB6RA0B0zW118vMCJCrHHSB4vA=;
        b=eBqF52GXgpGlVCtMOZbvmEfdWv3Sp81/FGjFHUwYTYeIMHfaaZOxb7f4//jupfoI9L
         k89m989AGOiJ7jvm+0Euj/Oqce5OfB9QVVbk06qAmQlKWQLSmJEl0tTycr7wKPZz6x8M
         aYx4MZll6RnGe1dk0VAnsoU9JJzNCAW0ZQin48T11mBKjdDCBD5l1SqE4zlBfChMWTsO
         Z+6IiEb5Hu2Q+3mDmIhQEEM50zgyeVXoYvQjybTiQGpXE8iNtCg3OPE20eg58syLPa2h
         vc3B0XYV7oobOfjwrOl/K5ghLmg2kQDujYtyO5LXvxLkPwb2OUPq8p2capfa8dw38aYR
         GUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jc/QnxF9T0QZ56XXEaB6RA0B0zW118vMCJCrHHSB4vA=;
        b=tg6ETc7VoyW+UHwi6M5UVXKbf34l9ZF5LRab9oJAqvipZC+JTzYgCP3CABFAXzlhjH
         QXhcV4BSbjd5hSMq4ec7LCREzrc5aMBwGw9YVJiF0c+acdGmdDxVVN4n+xTYfOzRjqcd
         fJHQ+FIixNbDA0xczEQO2xDKSCl+qCcqPSRGVyszZ02Su47XVQBpDoq2ems4COKJVWEb
         nbtoq9XQi9U0xiLvVgf2s4pFr07aGwpt9C0vqu3OMb/eDlOKPGfNE9kUgv8D0V0wTHZp
         aCA/p1sSLvr66Jwn6ZIgqhNxCek0J4SQvUcNohjSgua63BhvP9MZ5IXRBgB9vPpR/GWQ
         Kbqg==
X-Gm-Message-State: AA+aEWYEnw83GcauW+w2MkmDhGgcQj5QfxCykJHmJaPNsGCPyht/UnXY
        LKKJFV74/lRFZliGN/LWJIA=
X-Google-Smtp-Source: AFSGD/V7j4iAsmSJ9aCDBjcV2dBB5xgSDqWZhg15vd4997qkpiwUSJ7YhfQE7QWgudGF7HNE7U04bQ==
X-Received: by 2002:ac8:1308:: with SMTP id e8mr9908369qtj.201.1543683241931;
        Sat, 01 Dec 2018 08:54:01 -0800 (PST)
Received: from localhost ([2601:184:4780:7861:6268:7a0b:50be:cebc])
        by smtp.gmail.com with ESMTPSA id c202sm5090331qkb.19.2018.12.01.08.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 08:54:01 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>, hch@lst.de,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of/device: add blacklist for iommu dma_ops
Date:   Sat,  1 Dec 2018 11:53:37 -0500
Message-Id: <20181201165348.24140-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This solves a problem we see with drm/msm, caused by getting
iommu_dma_ops while we attach our own domain and manage it directly at
the iommu API level:

  [0000000000000038] user address but active_mm is swapper
  Internal error: Oops: 96000005 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 7 PID: 70 Comm: kworker/7:1 Tainted: G        W         4.19.3 #90
  Hardware name: xxx (DT)
  Workqueue: events deferred_probe_work_func
  pstate: 80c00009 (Nzcv daif +PAN +UAO)
  pc : iommu_dma_map_sg+0x7c/0x2c8
  lr : iommu_dma_map_sg+0x40/0x2c8
  sp : ffffff80095eb4f0
  x29: ffffff80095eb4f0 x28: 0000000000000000
  x27: ffffffc0f9431578 x26: 0000000000000000
  x25: 00000000ffffffff x24: 0000000000000003
  x23: 0000000000000001 x22: ffffffc0fa9ac010
  x21: 0000000000000000 x20: ffffffc0fab40980
  x19: ffffffc0fab40980 x18: 0000000000000003
  x17: 00000000000001c4 x16: 0000000000000007
  x15: 000000000000000e x14: ffffffffffffffff
  x13: ffff000000000000 x12: 0000000000000028
  x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
  x9 : 0000000000000000 x8 : ffffffc0fab409a0
  x7 : 0000000000000000 x6 : 0000000000000002
  x5 : 0000000100000000 x4 : 0000000000000000
  x3 : 0000000000000001 x2 : 0000000000000002
  x1 : ffffffc0f9431578 x0 : 0000000000000000
  Process kworker/7:1 (pid: 70, stack limit = 0x0000000017d08ffb)
  Call trace:
   iommu_dma_map_sg+0x7c/0x2c8
   __iommu_map_sg_attrs+0x70/0x84
   get_pages+0x170/0x1e8
   msm_gem_get_iova+0x8c/0x128
   _msm_gem_kernel_new+0x6c/0xc8
   msm_gem_kernel_new+0x4c/0x58
   dsi_tx_buf_alloc_6g+0x4c/0x8c
   msm_dsi_host_modeset_init+0xc8/0x108
   msm_dsi_modeset_init+0x54/0x18c
   _dpu_kms_drm_obj_init+0x430/0x474
   dpu_kms_hw_init+0x5f8/0x6b4
   msm_drm_bind+0x360/0x6c8
   try_to_bring_up_master.part.7+0x28/0x70
   component_master_add_with_match+0xe8/0x124
   msm_pdev_probe+0x294/0x2b4
   platform_drv_probe+0x58/0xa4
   really_probe+0x150/0x294
   driver_probe_device+0xac/0xe8
   __device_attach_driver+0xa4/0xb4
   bus_for_each_drv+0x98/0xc8
   __device_attach+0xac/0x12c
   device_initial_probe+0x24/0x30
   bus_probe_device+0x38/0x98
   deferred_probe_work_func+0x78/0xa4
   process_one_work+0x24c/0x3dc
   worker_thread+0x280/0x360
   kthread+0x134/0x13c
   ret_from_fork+0x10/0x18
  Code: d2800004 91000725 6b17039f 5400048a (f9401f40)
  ---[ end trace f22dda57f3648e2c ]---
  Kernel panic - not syncing: Fatal exception
  SMP: stopping secondary CPUs
  Kernel Offset: disabled
  CPU features: 0x0,22802a18
  Memory Limit: none

The problem is that when drm/msm does it's own iommu_attach_device(),
now the domain returned by iommu_get_domain_for_dev() is drm/msm's
domain, and it doesn't have domain->iova_cookie.

We kind of avoided this problem prior to sdm845/dpu because the iommu
was attached to the mdp node in dt, which is a child of the toplevel
mdss node (which corresponds to the dev passed in dma_map_sg()).  But
with sdm845, now the iommu is attached at the mdss level so we hit the
iommu_dma_ops in dma_map_sg().

But auto allocating/attaching a domain before the driver is probed was
already a blocking problem for enabling per-context pagetables for the
GPU.  This problem is also now solved with this patch.

Fixes: 97890ba9289c dma-mapping: detect and configure IOMMU in of_dma_configure
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
This is an alternative/replacement for [1].  What it lacks in elegance
it makes up for in practicality ;-)

[1] https://patchwork.freedesktop.org/patch/264930/

 drivers/of/device.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 5957cd4fa262..15ffee00fb22 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -72,6 +72,14 @@ int of_device_add(struct platform_device *ofdev)
 	return device_add(&ofdev->dev);
 }
 
+static const struct of_device_id iommu_blacklist[] = {
+	{ .compatible = "qcom,mdp4" },
+	{ .compatible = "qcom,mdss" },
+	{ .compatible = "qcom,sdm845-mdss" },
+	{ .compatible = "qcom,adreno" },
+	{}
+};
+
 /**
  * of_dma_configure - Setup DMA configuration
  * @dev:	Device to apply DMA configuration
@@ -164,6 +172,20 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
+	/*
+	 * There is at least one case where the driver wants to directly
+	 * manage the IOMMU, but if we end up with iommu dma_ops, that
+	 * interferes with the drivers ability to use dma_map_sg() for
+	 * cache operations.  Since we don't currently have a better
+	 * solution, and this code runs before the driver is probed and
+	 * has a chance to intervene, use a simple blacklist to avoid
+	 * ending up with iommu dma_ops:
+	 */
+	if (of_match_device(iommu_blacklist, dev)) {
+		dev_dbg(dev, "skipping iommu hookup\n");
+		iommu = NULL;
+	}
+
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
 
 	return 0;
-- 
2.19.2

