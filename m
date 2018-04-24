Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2202739-1524537943-2-18005327035011740262
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524537942; b=CHFnuiHyQC6recIlcOpU4rHdUegBd/5m9GXoXsdasy0hxKyvv5
    o/pVJJhF2ZbQb9dqU+Ty1zc9fbxSRytD+UbZJBqnYbhpS2UGMuSIRL5JG0UbVON5
    VzlSO84HoNqXHFW39crzg3sFbftPcbJAQAmNTZrxHusw1sd5K0FCI2AUFBrAGNyl
    hbwVkG9DO0LqLxaUu5cqES2ueFbYFXWwbv7nwWi0ne+7rrUU9lryb3F4BzCQeUEN
    OODi/oe3XX/kKutd6cVI+x5mJ+5RKwtsatpGOFwl2SdGOqQeRIi+brWHdHeDIgD/
    Y9ffRNWi2zidHy+32oyETi4lJd1U+tImBahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524537942; bh=
    mqOhuVoDlXytf6CmqHBVJXj55FZYDUIoOuk7BMe3bAQ=; b=ExVnbu98V5Orhme/
    7HFtvjT4n4WNWh25XGn/sxWnCMzqp0oK4NkKi+ob/AySz2hm6eO4BVPLRbKtaMie
    tsDCZ9Qw+xkmlwmd+5aHB7ffnDN8NUVO+9fHX4INfhIc2Zil6QC14yaC05/K5h35
    kgltv4d46s/S/PX0AdD+6yCQUTqKcrhhyxPWV/9OXpgFnpiqSqN0n3l8U6Dod/8f
    i6b+TVc8pmcti5VniLihoiX2idIZX7YSngqes/TSx6QwVzs1ZMiZ9/aa/O0Bvu0H
    WkFB2h66plCafo7h4Uox1dsRYpOfgbcR6lD5zJgjpJuDZQbAZzDBBT1FQKBVKJ1/
    6v/JJw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE1/Lr6YyyjKAw+rsWbMozrU7lukYrafrrMEBB3RMmBIg7ywh52q/H5QJHAKgGLWSzsQu0Se8iaf0nC0s6Gt01b43ds4v8N+OoYyt+KUPQws6MtzM1gP
    xS94JTDhDUe6NbqLgZYxpyCNvyXsmd6hbgapQiY9fDaFu/2/r0Hlgw9IKNWK2hCo+A9xUHggNTCRDOxZbAUub5Y+rWKFrDQ85SouLXFvYH3xwl++2zIIQ+zX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=VTZahWlGpNSiuComhMsA:9
    a=v2oIB10csrzcfY5-:21 a=QpNP2CvdTjnrsNku:21 a=x8gzFH9gYPwA:10
    a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeDXCpS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:45:18 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:59513 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeDXCpL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:45:11 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <b0b5ce6da149a94a51584f20a5916d6b>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        frank.wang@rock-chips.com, huangtao@rock-chips.com,
        dianders@google.com, daniel.meng@rock-chips.com,
        John.Youn@synopsys.com, william.wu@rock-chips.com,
        wzz@rock-chips.com, zsq@rock-chips.com, Allen.Hsu@quantatw.com,
        StanTsui@AOPEN.com
Subject: [PATCH 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
Date: Tue, 24 Apr 2018 10:43:43 +0800
Message-Id: <1524537824-22010-2-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1524537824-22010-1-git-send-email-william.wu@rock-chips.com>
References: <1524537824-22010-1-git-send-email-william.wu@rock-chips.com>
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
unaligned, this casue DATA0 packet transmission error.

This patch base on the old way of aligned DMA allocation in the
dwc2 driver to get aligned DMA for isoc split in.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
 drivers/usb/dwc2/hcd.c       | 63 +++++++++++++++++++++++++++++++++++++++++---
 drivers/usb/dwc2/hcd.h       | 10 +++++++
 drivers/usb/dwc2/hcd_intr.c  |  8 ++++++
 drivers/usb/dwc2/hcd_queue.c |  8 +++++-
 4 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 190f959..8c2b35f 100644
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
@@ -2620,6 +2629,33 @@ static void dwc2_hc_init_xfer(struct dwc2_hsotg *hsotg,
 	}
 }
 
+static int dwc2_alloc_split_dma_aligned_buf(struct dwc2_hsotg *hsotg,
+					    struct dwc2_qh *qh,
+					    struct dwc2_host_chan *chan)
+{
+	if (!qh->dw_align_buf) {
+		qh->dw_align_buf = kmalloc(chan->max_packet,
+					   GFP_ATOMIC | GFP_DMA);
+		if (!qh->dw_align_buf)
+			return -ENOMEM;
+
+		qh->dw_align_buf_size = chan->max_packet;
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
@@ -2797,6 +2833,27 @@ static int dwc2_assign_and_init_hc(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 	/* Set the transfer attributes */
 	dwc2_hc_init_xfer(hsotg, chan, qtd);
 
+	/* For non-dword aligned buffers */
+	if (hsotg->params.host_dma > 0 && qh->do_split &&
+	    chan->ep_is_in && (chan->xfer_dma & 0x3)) {
+		dev_vdbg(hsotg->dev, "Non-aligned buffer\n");
+		if (dwc2_alloc_split_dma_aligned_buf(hsotg, qh, chan)) {
+			dev_err(hsotg->dev,
+				"%s: Failed to allocate memory to handle non-dword aligned buffer\n",
+				__func__);
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
+		chan->align_buf = 0;
+	}
+
 	if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
 	    chan->ep_type == USB_ENDPOINT_XFER_ISOC)
 		/*
diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
index 96a9da5..adf1fd0 100644
--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -76,6 +76,8 @@ struct dwc2_qh;
  *                      (micro)frame
  * @xfer_buf:           Pointer to current transfer buffer position
  * @xfer_dma:           DMA address of xfer_buf
+ * @align_buf:		In Buffer DMA mode this will be used if xfer_buf is not
+ *			DWORD aligned
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
+ * @dw_align_buf:	Used instead of original buffer if its physical address
+ *			is not dword-aligned
+ * @dw_align_buf_size:	Size of dw_align_buf
+ * @dw_align_buf_dma:	DMA address for dw_align_buf
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
index a5dfd9d..5e2378f 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -938,6 +938,14 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
 
 	frame_desc->actual_length += len;
 
+	if (chan->align_buf) {
+		dev_vdbg(hsotg->dev, "%s(): non-aligned buffer\n", __func__);
+		dma_unmap_single(hsotg->dev, chan->qh->dw_align_buf_dma,
+				 chan->qh->dw_align_buf_size, DMA_FROM_DEVICE);
+		memcpy(qtd->urb->buf + frame_desc->offset +
+		       qtd->isoc_split_offset, chan->qh->dw_align_buf, len);
+	}
+
 	qtd->isoc_split_offset += len;
 
 	hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index e34ad5e..a120bb0 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1693,8 +1693,14 @@ void dwc2_hcd_qh_free(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 
 	dwc2_host_put_tt_info(hsotg, qh->dwc_tt);
 
-	if (qh->desc_list)
+	if (qh->desc_list) {
 		dwc2_hcd_qh_free_ddma(hsotg, qh);
+	} else {
+		/* kfree(NULL) is safe */
+		kfree(qh->dw_align_buf);
+		qh->dw_align_buf_dma = (dma_addr_t)0;
+	}
+
 	kfree(qh);
 }
 
-- 
2.0.0


