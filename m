Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2036687-1525748958-2-269905520528108673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525748957; b=eNr9Pnrc7d+ZyG9VQjcdTamBgMg8E1ObN1C2aLYdHhRRN0COZt
    r9NuQDbrwfRPmeu5vsIx7kTqanSB3KDLoh8NhN8FjL/XyUw+VUreayvNUEbeaBDz
    qgURUWbootfyaIHbtbidgJc/SjYLGJzn7l+kgcFDIa6MuhCKcbenBBJmF+j0or/C
    CEdE0ecxcRQ19OEsJP1di8qdpQ2y98SrdmhppmBnXvDkpjBuaUJGh2OLw+hIZ+mR
    0ZHRqHAewuoBKVQ2cagCXTenm4VFoIgDaJglQUlimX8y+iO1hcBv3W9QgjU1p4kl
    5vX7mZmUJhrIGwcY2VcyZInDq9xSTVsTq3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525748957; bh=
    axX/29AL0xzQQq4yC8+XP/XnLQPYPsaKDn28b0lw9gU=; b=Zhl+gq0g624dXNwq
    LNbICeLhEWr7PkGhmiPobkyIke6GWyLOYgnY5zOagxZg0k+Em2NieXZ+fUwgPuNa
    11Gsl135l0x39htZ80WqmCiIZw79B6wCQXfvnf9wn4xlM6XL7ZoBBHs/qKIkVv5+
    yZDKRUAQTTFrejUeIID17Jsj9KGld+FHBkJpY+8E97PtEKKelSC6thyfOnZDkm/U
    1amzZ92afG5m+h6ua24R0jFxFZ+3GY0XNz63vACzu7uW7en7UBxnevZfZAplqEUz
    c8oS7YdCeQURG06U38gLtu7eC4wXSVF4iwNXY2r6h+KWZzWpoMDgCpNxR5bjT/zZ
    pMBbhw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rock-chips.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rock-chips.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHiCaNWSm48ZjDVVJupW4GB69Yo2SoZS4VgxPt9qWOAyBPcM0+fN3sQRlu1ustnzJ/iDehiUcBUgYrhZP52uaj82HY//D0aBB031mVNyrrlKPJCZM7XL
    jYDSR5bfaNuGyrDyUQDmDK1YwaNtUsRm3Ex9gl6J/EHZV2A+2Zj7h8JHEshq+LX8x/a1X/aBMH4ym8PTgZ0dMGN4iCMCRPF7pNcHqlFKjN9fps7rT0RH1O1h
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=NsAL0CR8UTnvBYlrXCEA:9
    a=H4HVEcqQ_qoj-G_z:21 a=PxjZ1imhSr_D-b2_:21 a=x8gzFH9gYPwA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbeEHDJA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 23:09:00 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:36755 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeEHDIw (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 23:08:52 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <0a25c3678ed7231d209a46ae7842a4f9>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org
Cc: sergei.shtylyov@cogentembedded.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, dianders@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        william.wu@rock-chips.com, wzz@rock-chips.com, zsq@rock-chips.com,
        Allen.Hsu@quantatw.com, StanTsui@AOPEN.com, Spruce.Wu@quantatw.com,
        Martin.Tsai@quantatw.com, Kevin.Shai@quantatw.com,
        Mon-Jer.Wu@quantatw.com, Claud.Chang@quantatw.com,
        San.Lin@quantatw.com, Ren.Kuo@quantatw.com, davidhtwang@aopen.com,
        fonglin@aopen.com, stevencheng@aopen.com, tomchen@aopen.com,
        donchang@aopen.com, milesschofield@aopen.com
Subject: [PATCH v3 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
Date: Tue,  8 May 2018 11:07:25 +0800
Message-Id: <1525748846-7767-2-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The commit 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in
a more supported way") rips out a lot of code to simply the
allocation of aligned DMA. However, it also introduces a new
issue when use isoc split in transfer.

In my test case, I connect the dwc2 controller with an usb hs
Hub (GL852G-12), and plug an usb fs audio device (Plantronics
headset) into the downstream port of Hub. Then use the usb mic
to record, we can find noise when playback.

It's because that the usb Hub uses an MDATA for the first
transaction and a DATA0 for the second transaction for the isoc
split in transaction. An typical isoc split in transaction sequence
like this:

- SSPLIT IN transaction
- CSPLIT IN transaction
  - MDATA packet
- CSPLIT IN transaction
  - DATA0 packet

The DMA address of MDATA (urb->dma) is always DWORD-aligned, but
the DMA address of DATA0 (urb->dma + qtd->isoc_split_offset) may
not be DWORD-aligned, it depends on the qtd->isoc_split_offset (the
length of MDATA). In my test case, the length of MDATA is usually
unaligned, this cause DATA0 packet transmission error.

This patch use kmem_cache to allocate aligned DMA buf for isoc
split in transaction. Note that according to usb 2.0 spec, the
maximum data payload size is 1023 bytes for each fs isoc ep,
and the maximum allowable interrupt data payload size is 64 bytes
or less for fs interrupt ep. So we set the size of object to be
1024 bytes in the kmem cache.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changes in v3:
- Modify the commit message
- Use Kmem_cache to allocate aligned DMA buf
- Fix coding style

Changes in v2:
- None

 drivers/usb/dwc2/core.h      |  3 ++
 drivers/usb/dwc2/hcd.c       | 85 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc2/hcd.h       | 10 ++++++
 drivers/usb/dwc2/hcd_intr.c  |  8 +++++
 drivers/usb/dwc2/hcd_queue.c |  3 ++
 5 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index d83be56..c1983f8 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -915,6 +915,7 @@ struct dwc2_hregs_backup {
  * @frame_list_sz:      Frame list size
  * @desc_gen_cache:     Kmem cache for generic descriptors
  * @desc_hsisoc_cache:  Kmem cache for hs isochronous descriptors
+ * @unaligned_cache:    Kmem cache for DMA mode to handle non-aligned buf
  *
  * These are for peripheral mode:
  *
@@ -1059,6 +1060,8 @@ struct dwc2_hsotg {
 	u32 frame_list_sz;
 	struct kmem_cache *desc_gen_cache;
 	struct kmem_cache *desc_hsisoc_cache;
+	struct kmem_cache *unaligned_cache;
+#define DWC2_KMEM_UNALIGNED_BUF_SIZE 1024
 
 #endif /* CONFIG_USB_DWC2_HOST || CONFIG_USB_DWC2_DUAL_ROLE */
 
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 190f959..6f22dee 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1562,11 +1562,20 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
 	}
 
 	if (hsotg->params.host_dma) {
-		dwc2_writel((u32)chan->xfer_dma,
-			    hsotg->regs + HCDMA(chan->hc_num));
+		dma_addr_t dma_addr;
+
+		if (chan->align_buf) {
+			if (dbg_hc(chan))
+				dev_vdbg(hsotg->dev, "align_buf\n");
+			dma_addr = chan->align_buf;
+		} else {
+			dma_addr = chan->xfer_dma;
+		}
+		dwc2_writel((u32)dma_addr, hsotg->regs + HCDMA(chan->hc_num));
+
 		if (dbg_hc(chan))
 			dev_vdbg(hsotg->dev, "Wrote %08lx to HCDMA(%d)\n",
-				 (unsigned long)chan->xfer_dma, chan->hc_num);
+				 (unsigned long)dma_addr, chan->hc_num);
 	}
 
 	/* Start the split */
@@ -2620,6 +2629,37 @@ static void dwc2_hc_init_xfer(struct dwc2_hsotg *hsotg,
 	}
 }
 
+static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
+					    struct dwc2_qh *qh,
+					    struct dwc2_host_chan *chan)
+{
+	if (!hsotg->unaligned_cache)
+		return -ENOMEM;
+
+	if (!qh->dw_align_buf) {
+		qh->dw_align_buf = kmem_cache_alloc(hsotg->unaligned_cache,
+						    GFP_ATOMIC | GFP_DMA);
+		if (!qh->dw_align_buf)
+			return -ENOMEM;
+
+		qh->dw_align_buf_size = min_t(u32, chan->max_packet,
+					      DWC2_KMEM_UNALIGNED_BUF_SIZE);
+	}
+
+	qh->dw_align_buf_dma = dma_map_single(hsotg->dev, qh->dw_align_buf,
+					      qh->dw_align_buf_size,
+					      DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(hsotg->dev, qh->dw_align_buf_dma)) {
+		dev_err(hsotg->dev, "can't map align_buf\n");
+		chan->align_buf = 0;
+		return -EINVAL;
+	}
+
+	chan->align_buf = qh->dw_align_buf_dma;
+	return 0;
+}
+
 #define DWC2_USB_DMA_ALIGN 4
 
 struct dma_aligned_buffer {
@@ -2797,6 +2837,32 @@ static int dwc2_assign_and_init_hc(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 	/* Set the transfer attributes */
 	dwc2_hc_init_xfer(hsotg, chan, qtd);
 
+	/* For non-dword aligned buffers */
+	if (hsotg->params.host_dma && qh->do_split &&
+	    chan->ep_is_in && (chan->xfer_dma & 0x3)) {
+		dev_vdbg(hsotg->dev, "Non-aligned buffer\n");
+		if (dwc2_alloc_split_dma_aligned_buf(hsotg, qh, chan)) {
+			dev_err(hsotg->dev,
+				"Failed to allocate memory to handle non-aligned buffer\n");
+			/* Add channel back to free list */
+			chan->align_buf = 0;
+			chan->multi_count = 0;
+			list_add_tail(&chan->hc_list_entry,
+				      &hsotg->free_hc_list);
+			qtd->in_process = 0;
+			qh->channel = NULL;
+			return -ENOMEM;
+		}
+	} else {
+		/*
+		 * We assume that DMA is always aligned in non-split
+		 * case or split out case. Warn if not.
+		 */
+		WARN_ON_ONCE(hsotg->params.host_dma &&
+			     (chan->xfer_dma & 0x3));
+		chan->align_buf = 0;
+	}
+
 	if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
 	    chan->ep_type == USB_ENDPOINT_XFER_ISOC)
 		/*
@@ -5241,6 +5307,17 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 			hsotg->params.dma_desc_enable = false;
 			hsotg->params.dma_desc_fs_enable = false;
 		}
+	} else if (hsotg->params.host_dma) {
+		/*
+		 * Create kmem caches to handle non-aligned buffer
+		 * in Buffer DMA mode.
+		 */
+		hsotg->unaligned_cache = kmem_cache_create("dwc2-unaligned-dma",
+						DWC2_KMEM_UNALIGNED_BUF_SIZE, 4,
+						SLAB_CACHE_DMA, NULL);
+		if (!hsotg->unaligned_cache)
+			dev_err(hsotg->dev,
+				"unable to create dwc2 unaligned cache\n");
 	}
 
 	hsotg->otg_port = 1;
@@ -5279,6 +5356,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 error4:
 	kmem_cache_destroy(hsotg->desc_gen_cache);
 	kmem_cache_destroy(hsotg->desc_hsisoc_cache);
+	kmem_cache_destroy(hsotg->unaligned_cache);
 error3:
 	dwc2_hcd_release(hsotg);
 error2:
@@ -5321,6 +5399,7 @@ void dwc2_hcd_remove(struct dwc2_hsotg *hsotg)
 
 	kmem_cache_destroy(hsotg->desc_gen_cache);
 	kmem_cache_destroy(hsotg->desc_hsisoc_cache);
+	kmem_cache_destroy(hsotg->unaligned_cache);
 
 	dwc2_hcd_release(hsotg);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
index 96a9da5..854cef5 100644
--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -76,6 +76,8 @@ struct dwc2_qh;
  *                      (micro)frame
  * @xfer_buf:           Pointer to current transfer buffer position
  * @xfer_dma:           DMA address of xfer_buf
+ * @align_buf:          In Buffer DMA mode this will be used if xfer_buf is not
+ *                      DWORD aligned
  * @xfer_len:           Total number of bytes to transfer
  * @xfer_count:         Number of bytes transferred so far
  * @start_pkt_count:    Packet count at start of transfer
@@ -133,6 +135,7 @@ struct dwc2_host_chan {
 
 	u8 *xfer_buf;
 	dma_addr_t xfer_dma;
+	dma_addr_t align_buf;
 	u32 xfer_len;
 	u32 xfer_count;
 	u16 start_pkt_count;
@@ -303,6 +306,10 @@ struct dwc2_hs_transfer_time {
  *                           is tightly packed.
  * @ls_duration_us:     Duration on the low speed bus schedule.
  * @ntd:                Actual number of transfer descriptors in a list
+ * @dw_align_buf:       Used instead of original buffer if its physical address
+ *                      is not dword-aligned
+ * @dw_align_buf_size:  Size of dw_align_buf_dma
+ * @dw_align_buf_dma:   DMA address for dw_align_buf
  * @qtd_list:           List of QTDs for this QH
  * @channel:            Host channel currently processing transfers for this QH
  * @qh_list_entry:      Entry for QH in either the periodic or non-periodic
@@ -350,6 +357,9 @@ struct dwc2_qh {
 	struct dwc2_hs_transfer_time hs_transfers[DWC2_HS_SCHEDULE_UFRAMES];
 	u32 ls_start_schedule_slice;
 	u16 ntd;
+	u8 *dw_align_buf;
+	int dw_align_buf_size;
+	dma_addr_t dw_align_buf_dma;
 	struct list_head qtd_list;
 	struct dwc2_host_chan *channel;
 	struct list_head qh_list_entry;
diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index a5dfd9d..ba6fd852 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -938,6 +938,14 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
 
 	frame_desc->actual_length += len;
 
+	if (chan->align_buf) {
+		dev_vdbg(hsotg->dev, "non-aligned buffer\n");
+		dma_unmap_single(hsotg->dev, chan->qh->dw_align_buf_dma,
+				 chan->qh->dw_align_buf_size, DMA_FROM_DEVICE);
+		memcpy(qtd->urb->buf + (chan->xfer_dma - qtd->urb->dma),
+		       chan->qh->dw_align_buf, len);
+	}
+
 	qtd->isoc_split_offset += len;
 
 	hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index e34ad5e..56464cbd 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1695,6 +1695,9 @@ void dwc2_hcd_qh_free(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 
 	if (qh->desc_list)
 		dwc2_hcd_qh_free_ddma(hsotg, qh);
+	else if (hsotg->unaligned_cache && qh->dw_align_buf)
+		kmem_cache_free(hsotg->unaligned_cache, qh->dw_align_buf);
+
 	kfree(qh);
 }
 
-- 
2.0.0


