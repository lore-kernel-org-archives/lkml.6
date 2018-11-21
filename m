Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B5CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957F121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J6GSGbJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957F121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeKVCUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:20:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58610 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeKVCUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:20:19 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181121154520euoutp02d17fc921161d0faccc1f40c921bf0e7a~pLi1_3sJa1571915719euoutp023;
        Wed, 21 Nov 2018 15:45:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181121154520euoutp02d17fc921161d0faccc1f40c921bf0e7a~pLi1_3sJa1571915719euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542815120;
        bh=ZDpHLELrYsVtA381WyXghy7lbPoJAuVimov4S92BukU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=J6GSGbJE8Sr1RNTqFAHj4Ly8CIVi6uL8Omqd6qXucQMn2vlMyza8qXOkwtNmsU0GT
         clGR+0VYJ2g3Pa0827ZQ7FXytlBNljI8grY2slOiLj+EVM++ja103Gv/VQCFN3r7SV
         le4/1BrhWedVtkeVU9+44mFACnVbcv73WsSWtTo4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181121154519eucas1p25b4250e996fd5c55647eee8f60a7d272~pLi1QHSa70093500935eucas1p2S;
        Wed, 21 Nov 2018 15:45:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.BC.04441.F8D75FB5; Wed, 21
        Nov 2018 15:45:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d~pLi0ipU3g0464504645eucas1p2A;
        Wed, 21 Nov 2018 15:45:18 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-5d-5bf57d8f347d
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.DD.04284.E8D75FB5; Wed, 21
        Nov 2018 15:45:18 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PIJ000DJVRDCG50@eusync1.samsung.com>;
        Wed, 21 Nov 2018 15:45:18 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] usb: dwc2: Revert
 "usb: dwc2: Disable all EP's on disconnect"
Date:   Wed, 21 Nov 2018 16:45:04 +0100
Message-id: <20181121154504.13052-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7djPc7r9tV+jDc4t4LPYOGM9q8Xrf9NZ
        LObfTLJ4dmsvk0Xz4vVsFo2/9rJbXN41h81i0bJWZou1R+6yO3B6HDrcwegx72Sgx/65a9g9
        Pj69xeLRt2UVo8eW/Z8ZPT5vkgtgj+KySUnNySxLLdK3S+DKuHC7i62gU7fi/M/jTA2Mx9W6
        GDk5JARMJPqPLmADsYUEVjBKND0u6WLkArI/M0p8b1rIDlP0sOsqK0RiGaPE+purmCGcBiaJ
        r5s+gLWzCRhKdL3tArNFBKwlbm87ClbELHCSSWL1gpcsIAlhgQCJe10/GUFsFgFViRdPO8Di
        vAK2EpcOz4daJy+xesMBsGYJgQ42iVX3nzJDJFwkGvZdhrKFJV4d3wLVICPR2XGQCaKhmVGi
        fcYsdginh1Fi65wdbBBV1hKHj19kBbGZBfgkJm2bDjSJAyjOK9HRJgRR4iGx9s92VkhoxEoc
        WLiLeQKjxAJGhlWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiB8Xj63/FPOxi/Xko6xCjA
        wajEw6sR+TVaiDWxrLgy9xCjBAezkghvRxRQiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4No
        IYH0xJLU7NTUgtQimCwTB6dUA+P+8lPPkzsXfTKtv7KT44LKi01iL26keZnKzDr5+s5UsbcS
        l6SKl7NNmdid//KjMWfDqp6aKwyPtrtnXY15+4BTV6dxInvlw4y9Ex3PrTQKTNJYnVK5K6Q4
        oi5xd6KA3Xa2ur0xL+e6Wtg9crO42ZrMJNj8Qpt3h/Rn2diMg8YP2N4ufHCvbIoSS3FGoqEW
        c1FxIgDZoxIDwwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42I5/e/4Zd2+2q/RBpsWy1lsnLGe1eL1v+ks
        FvNvJlk8u7WXyaJ58Xo2i8Zfe9ktLu+aw2axaFkrs8XaI3fZHTg9Dh3uYPSYdzLQY//cNewe
        H5/eYvHo27KK0WPL/s+MHp83yQWwR3HZpKTmZJalFunbJXBlXLjdxVbQqVtx/udxpgbG42pd
        jJwcEgImEg+7rrJ2MXJxCAksYZS4uuEtlNPEJLGicR0LSBWbgKFE19suNhBbRMBa4va2o8wg
        NrPAWSaJLx9Duhg5OIQF/CRmnXACCbMIqEq8eNoB1sorYCtx6fB8dohl8hKrNxxgnsDItYCR
        YRWjSGppcW56brGhXnFibnFpXrpecn7uJkZguGw79nPzDsZLG4MPMQpwMCrx8GpEfo0WYk0s
        K67MPcQowcGsJMLbEQUU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUI
        JsvEwSnVwBjPvHZq+/3YNnFDuf3d/8w27vtbd3SfveOVxbPjDDNtNNocpfoC5Mt+LjwcbXRu
        zimFrbesQ1y28dk/6/7mn3/fav9Cp8tXk6RenUpdLlCwTz1Z8uoNydX79FlffljcdHUm64l9
        7zrP7NyxTK15193/8xKLRPdxM0ZxTZKcsrRB50fsrcftqlVKLMUZiYZazEXFiQCrvWLzEwIA
        AA==
X-CMS-MailID: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit dccf1bad4be7eaa096c1f3697bd37883f9a08ecb.

The reverted commit breaks locking in the DWC2 driver. It causes random
crashes or memory corruption related issues on SMP machines. Here is an
example of the observed reproducible issue (other are a bit more random):

=====================================
WARNING: bad unlock balance detected!
4.19.0-rc6-00027-gdccf1bad4be7-dirty #1119 Not tainted
-------------------------------------
ip/1464 is trying to release lock (&(&hsotg->lock)->rlock) at:
[<c0615494>] dwc2_hsotg_complete_request+0x84/0x218
but there are no more locks to release!

other info that might help us debug this:
2 locks held by ip/1464:
 #0: d69babd3 (rtnl_mutex){+.+.}, at: rtnetlink_rcv_msg+0x224/0x488
 #1: 5fb350d2 (&(&dev->lock)->rlock){-.-.}, at: eth_stop+0x24/0xa8

stack backtrace:
CPU: 1 PID: 1464 Comm: ip Not tainted 4.19.0-rc6-00027-gdccf1bad4be7-dirty #1119
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0111f9c>] (unwind_backtrace) from [<c010deb8>] (show_stack+0x10/0x14)
[<c010deb8>] (show_stack) from [<c09d3398>] (dump_stack+0x90/0xc8)
[<c09d3398>] (dump_stack) from [<c017d02c>] (print_unlock_imbalance_bug+0xb0/0xe0)
[<c017d02c>] (print_unlock_imbalance_bug) from [<c01800dc>] (lock_release+0x1a4/0x374)
[<c01800dc>] (lock_release) from [<c09ef7fc>] (_raw_spin_unlock+0x18/0x54)
[<c09ef7fc>] (_raw_spin_unlock) from [<c0615494>] (dwc2_hsotg_complete_request+0x84/0x218)
[<c0615494>] (dwc2_hsotg_complete_request) from [<c0617530>] (kill_all_requests+0x44/0xb4)
[<c0617530>] (kill_all_requests) from [<c0617690>] (dwc2_hsotg_ep_disable+0xf0/0x200)
[<c0617690>] (dwc2_hsotg_ep_disable) from [<c0659698>] (usb_ep_disable+0xd0/0x1c8)
[<c0659698>] (usb_ep_disable) from [<c065d4a8>] (eth_stop+0x68/0xa8)
[<c065d4a8>] (eth_stop) from [<c077e0b8>] (__dev_close_many+0x94/0xfc)
[<c077e0b8>] (__dev_close_many) from [<c078a064>] (__dev_change_flags+0xa0/0x198)
[<c078a064>] (__dev_change_flags) from [<c078a17c>] (dev_change_flags+0x18/0x48)
[<c078a17c>] (dev_change_flags) from [<c07a1a98>] (do_setlink+0x298/0x990)
[<c07a1a98>] (do_setlink) from [<c07a29f0>] (rtnl_newlink+0x4a0/0x6fc)
[<c07a29f0>] (rtnl_newlink) from [<c079dd74>] (rtnetlink_rcv_msg+0x254/0x488)
[<c079dd74>] (rtnetlink_rcv_msg) from [<c07c47f4>] (netlink_rcv_skb+0xe0/0x118)
[<c07c47f4>] (netlink_rcv_skb) from [<c07c4094>] (netlink_unicast+0x180/0x1c8)
[<c07c4094>] (netlink_unicast) from [<c07c4428>] (netlink_sendmsg+0x2bc/0x348)
[<c07c4428>] (netlink_sendmsg) from [<c0760b9c>] (sock_sendmsg+0x14/0x24)
[<c0760b9c>] (sock_sendmsg) from [<c0761af8>] (___sys_sendmsg+0x22c/0x248)
[<c0761af8>] (___sys_sendmsg) from [<c0762740>] (__sys_sendmsg+0x40/0x6c)
[<c0762740>] (__sys_sendmsg) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xede65fa8 to 0xede65ff0)
...

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
The suspicious locking has been already pointed in the review of the
first version of this patch, but sadly the v2 didn't change it and
landed in v4.20-rc1.
---
 drivers/usb/dwc2/gadget.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 79189db4bf17..220c0f9b89b0 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3109,8 +3109,6 @@ static void kill_all_requests(struct dwc2_hsotg *hsotg,
 		dwc2_hsotg_txfifo_flush(hsotg, ep->fifo_index);
 }
 
-static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
-
 /**
  * dwc2_hsotg_disconnect - disconnect service
  * @hsotg: The device state.
@@ -3129,12 +3127,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
 	hsotg->connected = 0;
 	hsotg->test_mode = 0;
 
-	/* all endpoints should be shutdown */
 	for (ep = 0; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+			kill_all_requests(hsotg, hsotg->eps_in[ep],
+					  -ESHUTDOWN);
 		if (hsotg->eps_out[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+			kill_all_requests(hsotg, hsotg->eps_out[ep],
+					  -ESHUTDOWN);
 	}
 
 	call_gadget(hsotg, disconnect);
@@ -3192,23 +3191,13 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	u32 val;
 	u32 usbcfg;
 	u32 dcfg = 0;
-	int ep;
 
 	/* Kill any ep0 requests as controller will be reinitialized */
 	kill_all_requests(hsotg, hsotg->eps_out[0], -ECONNRESET);
 
-	if (!is_usb_reset) {
+	if (!is_usb_reset)
 		if (dwc2_core_reset(hsotg, true))
 			return;
-	} else {
-		/* all endpoints should be shutdown */
-		for (ep = 1; ep < hsotg->num_of_eps; ep++) {
-			if (hsotg->eps_in[ep])
-				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
-			if (hsotg->eps_out[ep])
-				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
-		}
-	}
 
 	/*
 	 * we must now enable ep0 ready for host detection and then
@@ -4004,7 +3993,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 	unsigned long flags;
 	u32 epctrl_reg;
 	u32 ctrl;
-	int locked;
 
 	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
 
@@ -4020,9 +4008,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 
 	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
 
-	locked = spin_is_locked(&hsotg->lock);
-	if (!locked)
-		spin_lock_irqsave(&hsotg->lock, flags);
+	spin_lock_irqsave(&hsotg->lock, flags);
 
 	ctrl = dwc2_readl(hsotg, epctrl_reg);
 
@@ -4046,9 +4032,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 	hs_ep->fifo_index = 0;
 	hs_ep->fifo_size = 0;
 
-	if (!locked)
-		spin_unlock_irqrestore(&hsotg->lock, flags);
-
+	spin_unlock_irqrestore(&hsotg->lock, flags);
 	return 0;
 }
 
-- 
2.17.1

