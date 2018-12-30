Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF7520828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeL3QaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:30:00 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52542
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbeL3Q37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:29:59 -0500
X-IronPort-AV: E=Sophos;i="5.56,417,1539640800"; 
   d="scan'208";a="290435978"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Dec 2018 17:29:57 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] usb: gadget: udc: reduce indentation
Date:   Sun, 30 Dec 2018 16:53:08 +0100
Message-Id: <1546185195-25676-2-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete tab aligning a statement with the right hand side of a
preceding assignment rather than the left hand side.

Found with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/usb/gadget/udc/snps_udc_core.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index d4da47f4f6f4..3fcded31405a 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -947,15 +947,14 @@ static int prep_dma(struct udc_ep *ep, struct udc_request *req, gfp_t gfp)
 				UDC_DMA_STP_STS_BS_HOST_READY,
 				UDC_DMA_STP_STS_BS);
 
-
-			/* clear NAK by writing CNAK */
-			if (ep->naking) {
-				tmp = readl(&ep->regs->ctl);
-				tmp |= AMD_BIT(UDC_EPCTL_CNAK);
-				writel(tmp, &ep->regs->ctl);
-				ep->naking = 0;
-				UDC_QUEUE_CNAK(ep, ep->num);
-			}
+		/* clear NAK by writing CNAK */
+		if (ep->naking) {
+			tmp = readl(&ep->regs->ctl);
+			tmp |= AMD_BIT(UDC_EPCTL_CNAK);
+			writel(tmp, &ep->regs->ctl);
+			ep->naking = 0;
+			UDC_QUEUE_CNAK(ep, ep->num);
+		}
 
 	}
 

