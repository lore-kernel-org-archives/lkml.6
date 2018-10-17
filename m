Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B114ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B14A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B14A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJQWZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:25:17 -0400
Received: from gateway30.websitewelcome.com ([192.185.145.3]:14997 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbeJQWZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:25:17 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 49E9D2ED00
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:29:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id CmojgyllakBj6Cmotg39sN; Wed, 17 Oct 2018 09:29:16 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:33436 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gCmoi-003KYO-AT; Wed, 17 Oct 2018 09:28:57 -0500
Date:   Wed, 17 Oct 2018 16:28:51 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/nouveau/nvkm: mark expected switch fall-throughs
Message-ID: <20181017142851.GA15329@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gCmoi-003KYO-AT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:33436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch aims to suppress 29 missing-break-in-switch false positives.

Addresses-Coverity-ID: 1456891 ("Missing break in switch")
Addresses-Coverity-ID: 1324063 ("Missing break in switch")
Addresses-Coverity-ID: 1324063 ("Missing break in switch")
Addresses-Coverity-ID: 141432 ("Missing break in switch")
Addresses-Coverity-ID: 141433 ("Missing break in switch")
Addresses-Coverity-ID: 141434 ("Missing break in switch")
Addresses-Coverity-ID: 141435 ("Missing break in switch")
Addresses-Coverity-ID: 141436 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c    | 17 +++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c    |  2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c    |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c    |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c    |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c   |  2 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c     |  1 +
 10 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c
index d131cca..10f2aa9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c
@@ -23,38 +23,55 @@ void pack_hdmi_infoframe(struct packed_hdmi_infoframe *packed_frame,
 		 */
 	case 17:
 		subpack1_high = (raw_frame[16] << 16);
+		/* fall through */
 	case 16:
 		subpack1_high |= (raw_frame[15] << 8);
+		/* fall through */
 	case 15:
 		subpack1_high |= raw_frame[14];
+		/* fall through */
 	case 14:
 		subpack1_low = (raw_frame[13] << 24);
+		/* fall through */
 	case 13:
 		subpack1_low |= (raw_frame[12] << 16);
+		/* fall through */
 	case 12:
 		subpack1_low |= (raw_frame[11] << 8);
+		/* fall through */
 	case 11:
 		subpack1_low |= raw_frame[10];
+		/* fall through */
 	case 10:
 		subpack0_high = (raw_frame[9] << 16);
+		/* fall through */
 	case 9:
 		subpack0_high |= (raw_frame[8] << 8);
+		/* fall through */
 	case 8:
 		subpack0_high |= raw_frame[7];
+		/* fall through */
 	case 7:
 		subpack0_low = (raw_frame[6] << 24);
+		/* fall through */
 	case 6:
 		subpack0_low |= (raw_frame[5] << 16);
+		/* fall through */
 	case 5:
 		subpack0_low |= (raw_frame[4] << 8);
+		/* fall through */
 	case 4:
 		subpack0_low |= raw_frame[3];
+		/* fall through */
 	case 3:
 		header = (raw_frame[2] << 16);
+		/* fall through */
 	case 2:
 		header |= (raw_frame[1] << 8);
+		/* fall through */
 	case 1:
 		header |= raw_frame[0];
+		/* fall through */
 	case 0:
 		break;
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c b/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c
index 49ef7e5..7f1adab 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/dma/usernv04.c
@@ -122,6 +122,7 @@ nv04_dmaobj_new(struct nvkm_dma *dma, const struct nvkm_oclass *oclass,
 		break;
 	case NV_MEM_ACCESS_WO:
 		dmaobj->flags0 |= 0x00008000;
+		/* fall through */
 	case NV_MEM_ACCESS_RW:
 		dmaobj->flags2 |= 0x00000002;
 		break;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
index ad707ff..93493b3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c
@@ -117,8 +117,10 @@ nv04_fifo_swmthd(struct nvkm_device *device, u32 chid, u32 addr, u32 data)
 	switch (mthd) {
 	case 0x0000 ... 0x0000: /* subchannel's engine -> software */
 		nvkm_wr32(device, 0x003280, (engine &= ~mask));
+		/* fall through */
 	case 0x0180 ... 0x01fc: /* handle -> instance */
 		data = nvkm_rd32(device, 0x003258) & 0x0000ffff;
+		/* fall through */
 	case 0x0100 ... 0x017c:
 	case 0x0200 ... 0x1ffc: /* pass method down to sw */
 		if (!(engine & mask) && sw)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c
index 8c7ba32..47c1682 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c
@@ -81,6 +81,7 @@ nv40_fifo_init(struct nvkm_fifo *base)
 	case 0x49:
 	case 0x4b:
 		nvkm_wr32(device, 0x002230, 0x00000001);
+		/* fall through */
 	case 0x40:
 	case 0x41:
 	case 0x42:
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c
index c306835..7112992 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/perf.c
@@ -135,6 +135,7 @@ nvbios_perfEp(struct nvkm_bios *bios, int idx,
 		break;
 	case 0x30:
 		info->script   = nvbios_rd16(bios, perf + 0x02);
+		/* fall through */
 	case 0x35:
 		info->fanspeed = nvbios_rd08(bios, perf + 0x06);
 		info->voltage  = nvbios_rd08(bios, perf + 0x07);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
index e6e804c..bda6cc9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
@@ -134,6 +134,7 @@ pll_map(struct nvkm_bios *bios)
 		    device->chipset == 0xaa ||
 		    device->chipset == 0xac)
 			return g84_pll_mapping;
+		/* fall through */
 	default:
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index ba6a868d..40e5645 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -90,6 +90,7 @@ nvkm_cstate_valid(struct nvkm_clk *clk, struct nvkm_cstate *cstate,
 			case NVKM_CLK_BOOST_NONE:
 				if (clk->base_khz && freq > clk->base_khz)
 					return false;
+				/* fall through */
 			case NVKM_CLK_BOOST_BIOS:
 				if (clk->boost_khz && freq > clk->boost_khz)
 					return false;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
index 1c21b8b..4f00023 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
@@ -363,6 +363,7 @@ mcp77_clk_prog(struct nvkm_clk *base)
 	switch (clk->vsrc) {
 	case nv_clk_src_cclk:
 		mast |= 0x00400000;
+		/* fall through */
 	default:
 		nvkm_wr32(device, 0x4600, clk->vdiv);
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c
index 2b12e38..5f4c287 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.c
@@ -131,11 +131,13 @@ nv40_ram_prog(struct nvkm_ram *base)
 		nvkm_mask(device, 0x00402c, 0xc0771100, ram->ctrl);
 		nvkm_wr32(device, 0x004048, ram->coef);
 		nvkm_wr32(device, 0x004030, ram->coef);
+		/* fall through */
 	case 0x43:
 	case 0x49:
 	case 0x4b:
 		nvkm_mask(device, 0x004038, 0xc0771100, ram->ctrl);
 		nvkm_wr32(device, 0x00403c, ram->coef);
+		/* fall through */
 	default:
 		nvkm_mask(device, 0x004020, 0xc0771100, ram->ctrl);
 		nvkm_wr32(device, 0x004024, ram->coef);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c
index 844971e..2a6150a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c
@@ -159,6 +159,7 @@ mxm_dcb_sanitise_entry(struct nvkm_bios *bios, void *data, int idx, u16 pdcb)
 		break;
 	case 0x0e: /* eDP, falls through to DPint */
 		ctx.outp[1] |= 0x00010000;
+		/* fall through */
 	case 0x07: /* DP internal, wtf is this?? HP8670w */
 		ctx.outp[1] |= 0x00000004; /* use_power_scripts? */
 		type = DCB_CONNECTOR_eDP;
-- 
2.7.4

