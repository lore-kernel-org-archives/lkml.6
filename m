Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DC820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfAVO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:26:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfAVO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:26:59 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1glx0w-00078b-FP; Tue, 22 Jan 2019 14:26:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: fix various indentation issues
Date:   Tue, 22 Jan 2019 14:26:54 +0000
Message-Id: <20190122142654.28380-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a bunch of various indentation issues, clean these up.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/function/f_uac1.c     |  8 ++---
 drivers/usb/gadget/legacy/inode.c        | 40 ++++++++++++------------
 drivers/usb/gadget/udc/aspeed-vhub/hub.c |  2 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.c     |  4 +--
 drivers/usb/gadget/udc/net2280.c         |  2 +-
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 2746a926a8d9..fe42ffccb020 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -459,10 +459,10 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	} else if (intf == uac1->as_in_intf) {
 		uac1->as_in_alt = alt;
 
-			if (alt)
-				ret = u_audio_start_playback(&uac1->g_audio);
-			else
-				u_audio_stop_playback(&uac1->g_audio);
+		if (alt)
+			ret = u_audio_start_playback(&uac1->g_audio);
+		else
+			u_audio_stop_playback(&uac1->g_audio);
 	} else {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return -EINVAL;
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 37ca0e669bd8..354fbaf3e720 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1218,27 +1218,27 @@ ep0_poll (struct file *fd, poll_table *wait)
 	if (dev->state <= STATE_DEV_OPENED)
 		return DEFAULT_POLLMASK;
 
-       poll_wait(fd, &dev->wait, wait);
-
-       spin_lock_irq (&dev->lock);
-
-       /* report fd mode change before acting on it */
-       if (dev->setup_abort) {
-               dev->setup_abort = 0;
-               mask = EPOLLHUP;
-               goto out;
-       }
-
-       if (dev->state == STATE_DEV_SETUP) {
-               if (dev->setup_in || dev->setup_can_stall)
-                       mask = EPOLLOUT;
-       } else {
-               if (dev->ev_next != 0)
-                       mask = EPOLLIN;
-       }
+	poll_wait(fd, &dev->wait, wait);
+
+	spin_lock_irq(&dev->lock);
+
+	/* report fd mode change before acting on it */
+	if (dev->setup_abort) {
+		dev->setup_abort = 0;
+		mask = EPOLLHUP;
+		goto out;
+	}
+
+	if (dev->state == STATE_DEV_SETUP) {
+		if (dev->setup_in || dev->setup_can_stall)
+			mask = EPOLLOUT;
+	} else {
+		if (dev->ev_next != 0)
+			mask = EPOLLIN;
+	}
 out:
-       spin_unlock_irq(&dev->lock);
-       return mask;
+	spin_unlock_irq(&dev->lock);
+	return mask;
 }
 
 static long dev_ioctl (struct file *fd, unsigned code, unsigned long value)
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 35ba0e55a2e9..7c040f56100e 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -295,7 +295,7 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 		dsize = AST_VHUB_HUB_DESC_SIZE;
 		memcpy(ep->buf, &ast_vhub_hub_desc, dsize);
 		BUILD_BUG_ON(dsize > sizeof(ast_vhub_hub_desc));
-	BUILD_BUG_ON(AST_VHUB_HUB_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
+		BUILD_BUG_ON(AST_VHUB_HUB_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
 	default:
 		return std_req_stall;
diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.c b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
index 6305bf2c8b59..44c2a5eef785 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
@@ -311,8 +311,8 @@ int bdc_ep_clear_stall(struct bdc *bdc, int epnum)
 		/* if the endpoint it not stallled */
 		if (!(ep->flags & BDC_EP_STALL)) {
 			ret = bdc_ep_set_stall(bdc, epnum);
-				if (ret)
-					return ret;
+			if (ret)
+				return ret;
 		}
 	}
 	/* Preserve the seq number for ep0 only */
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index e7dae5379e04..17b6c8aba73c 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -2279,7 +2279,7 @@ static void usb_reinit_338x(struct net2280 *dev)
 	 * - It is safe to set for all connection speeds; all chip revisions.
 	 * - R-M-W to leave other bits undisturbed.
 	 * - Reference PLX TT-7372
-	*/
+	 */
 	val = readl(&dev->ll_chicken_reg->ll_tsn_chicken_bit);
 	val |= BIT(RECOVERY_IDLE_TO_RECOVER_FMW);
 	writel(val, &dev->ll_chicken_reg->ll_tsn_chicken_bit);
-- 
2.19.1

