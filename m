Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED63C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9732086C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRHcR/j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9732086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeIHS3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:29:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39559 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:29:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id i190-v6so8321347pgc.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzZ3gzHfZrZibZsM6mZGtanXMvI4fwiqg5qpIUfSWrc=;
        b=JRHcR/j3ac6Lx5GVnn9xCj8tPnG/9TOSsoW2NJtGGiqReMvI/3Oln4ctvTx8MnBmc+
         /VlJyOUwXW89IZVcbq9Zy2+c+SbUaNSxS8Ln2RzY12+umC3wYAUVj64fUEi4bxRJIze0
         4lHj4R5v7zxGTPKGpo8xkfNrL9ZwWhN0RXLkDQrybDPO/KtQ9aFGbBKYMDM0nHGq0lAT
         eqjZdzoL3JyPGWgl50s48iRO+4GD7gACgkcgyG2C8Kh2+zZJOI/r0442/eWKVeJu8s89
         6eEivcuRn9bsdMsOgn8zuBC9fyRNelhZXkyHcLMAPYOlIBVBHhsfzEHTkCn0yNerIYoj
         9R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzZ3gzHfZrZibZsM6mZGtanXMvI4fwiqg5qpIUfSWrc=;
        b=f0zPSC+Q2oAvndiBdhYiyDbT56HS3RSryy7RKo/BCIlrNI1DOgIncbmXZT+ptvRope
         eQ/A0w+o2mJvdJi+yb3l5I6ApCwze8u1xygPWw5LqoFojq99Y2ZLt317lOiI4+IdnW6l
         HTaJoBOsCO8qMbqbCSEniQda+2DZU2g53TF8ichucQbrRxAn6o+u0Eks32nVNpVe/UZ1
         U/YyDB3tT8dk4YwlNkkinee9Q1xSTj5MxWMComFzdQthC4QvoMvXiiZblcEnPIFkfEQS
         ZZCgNEKpFC8mw6ID4YtQ+J/NU2wKrJFOQta36ncLKvPK4Bmx/283neHYFo4MimAT2ioG
         /9JQ==
X-Gm-Message-State: APzg51CeiJsK0MKntqzDPx9D4gycBBox44VQgyB7FR2lqSgObMYtnWw2
        hMTzwoTFfN4YFgG6CcxlCug=
X-Google-Smtp-Source: ANB0VdZ6ILt9NP+TdKTWr9syKCvBoPO/Z1l8vixCHsC1qM93gPKzrgWvmb/4tfc5Nv3qdPpNhjbZkw==
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr13791573pfx.49.1536414243415;
        Sat, 08 Sep 2018 06:44:03 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id u25-v6sm14869094pfk.177.2018.09.08.06.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 06:44:02 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 91EEF200700; Sat,  8 Sep 2018 22:44:00 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] treewide: Fix typos in printk
Date:   Sat,  8 Sep 2018 22:43:58 +0900
Message-Id: <20180908134358.4106-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos found in printk messages.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/dma/ep93xx_dma.c                           | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              | 2 +-
 drivers/gpu/drm/drm_kms_helper_common.c            | 2 +-
 drivers/gpu/drm/selftests/test-drm_mm.c            | 2 +-
 drivers/media/v4l2-core/videobuf-core.c            | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c | 2 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     | 2 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  | 4 ++--
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                 | 2 +-
 drivers/soc/imx/gpcv2.c                            | 2 +-
 fs/gfs2/super.c                                    | 2 +-
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index a15592383d4e..7997e9bb7e10 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -993,7 +993,7 @@ ep93xx_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 	for (offset = 0; offset < len; offset += bytes) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1063,7 +1063,7 @@ ep93xx_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1141,7 +1141,7 @@ ep93xx_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 	for (offset = 0; offset < buf_len; offset += period_len) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 9fc1c37344ce..8300c735c9c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -516,7 +516,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 
 	/* wait until RCV_MSG become 3 */
 	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
-		pr_err("failed to recieve FLR_CMPL\n");
+		pr_err("failed to receive FLR_CMPL\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 93e2b30fe1a5..9c5ae825c507 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -39,7 +39,7 @@ MODULE_LICENSE("GPL and additional rights");
 /* Backward compatibility for drm_kms_helper.edid_firmware */
 static int edid_firmware_set(const char *val, const struct kernel_param *kp)
 {
-	DRM_NOTE("drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware intead.\n");
+	DRM_NOTE("drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware instead.\n");
 
 	return __drm_set_edid_firmware_path(val);
 }
diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index fbed2c90fd51..880bf92bb524 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -2360,7 +2360,7 @@ static int __init test_drm_mm_init(void)
 	while (!random_seed)
 		random_seed = get_random_int();
 
-	pr_info("Testing DRM range manger (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
+	pr_info("Testing DRM range manager (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
 		random_seed, max_iterations, max_prime);
 	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
 
diff --git a/drivers/media/v4l2-core/videobuf-core.c b/drivers/media/v4l2-core/videobuf-core.c
index 7491b337002c..67c5dbbe3802 100644
--- a/drivers/media/v4l2-core/videobuf-core.c
+++ b/drivers/media/v4l2-core/videobuf-core.c
@@ -214,7 +214,7 @@ int videobuf_queue_is_busy(struct videobuf_queue *q)
 			return 1;
 		}
 		if (q->bufs[i]->state == VIDEOBUF_ACTIVE) {
-			dprintk(1, "busy: buffer #%d avtive\n", i);
+			dprintk(1, "busy: buffer #%d active\n", i);
 			return 1;
 		}
 	}
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c
index b25048c6c761..73be7019d772 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c
@@ -138,7 +138,7 @@ static int mlxsw_sp_port_headroom_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	err = mlxsw_sp_port_pg_destroy(mlxsw_sp_port, my_ets->prio_tc,
 				       ets->prio_tc);
 	if (err)
-		netdev_warn(dev, "Failed to remove ununsed PGs\n");
+		netdev_warn(dev, "Failed to remove unused PGs\n");
 
 	return 0;
 
diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index c67a8e7be310..db29da909b69 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -364,7 +364,7 @@ static int if_usb_send_fw_pkt(struct if_usb_card *cardp)
 			     cardp->fwseqnum, cardp->totalbytes);
 	} else if (fwdata->hdr.dnldcmd == cpu_to_le32(FW_HAS_LAST_BLOCK)) {
 		lbs_deb_usb2(&cardp->udev->dev, "Host has finished FW downloading\n");
-		lbs_deb_usb2(&cardp->udev->dev, "Donwloading FW JUMP BLOCK\n");
+		lbs_deb_usb2(&cardp->udev->dev, "Downloading FW JUMP BLOCK\n");
 
 		cardp->fwfinalblk = 1;
 	}
diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index e92fc5001171..b9ad3128c379 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -319,10 +319,10 @@ static int if_usb_send_fw_pkt(struct if_usb_card *cardp)
 	} else if (fwdata->hdr.dnldcmd == cpu_to_le32(FW_HAS_LAST_BLOCK)) {
 		lbtf_deb_usb2(&cardp->udev->dev,
 			"Host has finished FW downloading\n");
-		lbtf_deb_usb2(&cardp->udev->dev, "Donwloading FW JUMP BLOCK\n");
+		lbtf_deb_usb2(&cardp->udev->dev, "Downloading FW JUMP BLOCK\n");
 
 		/* Host has finished FW downloading
-		 * Donwloading FW JUMP BLOCK
+		 * Downloading FW JUMP BLOCK
 		 */
 		cardp->fwfinalblk = 1;
 	}
diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 211da1d5a869..2210d0566a91 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(dbg_level, "Debug flag (default=0)");
 #define CXGB4I_DEFAULT_10G_RCV_WIN (256 * 1024)
 static int cxgb4i_rcv_win = -1;
 module_param(cxgb4i_rcv_win, int, 0644);
-MODULE_PARM_DESC(cxgb4i_rcv_win, "TCP reveive window in bytes");
+MODULE_PARM_DESC(cxgb4i_rcv_win, "TCP receive window in bytes");
 
 #define CXGB4I_DEFAULT_10G_SND_WIN (128 * 1024)
 static int cxgb4i_snd_win = -1;
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 6ef18cf8f243..26abf99fd1f9 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -114,7 +114,7 @@ static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 			break;
 
 		if (time_after(jiffies, deadline)) {
-			dev_err(domain->dev, "falied to command PGC\n");
+			dev_err(domain->dev, "failed to command PGC\n");
 			ret = -ETIMEDOUT;
 			/*
 			 * If we were in a process of enabling a
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index c212893534ed..4dd861205877 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -971,7 +971,7 @@ void gfs2_freeze_func(struct work_struct *work)
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED, 0,
 				   &freeze_gh);
 	if (error) {
-		printk(KERN_INFO "GFS2: couln't get freeze lock : %d\n", error);
+		printk(KERN_INFO "GFS2: couldn't get freeze lock : %d\n", error);
 		gfs2_assert_withdraw(sdp, 0);
 	}
 	else {
-- 
2.19.0.rc2

