Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B597FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE702081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ivhm9rrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE702081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeLDN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:29:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35994 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDN3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:29:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB4DONs2107950;
        Tue, 4 Dec 2018 13:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=IPu+wwHJvl3k3X5rKszooL4xtCWBdfNWweEjy8FgbxA=;
 b=Ivhm9rrKdd6btRfHjhXgUQcf5SBrMv+MVnkWlMXSYYEe4rEXmESvM4r6WwxPbvssQP0c
 Vl/3rX9QScaHHL8qj2VqBcBw7sq3S9cqnZdiZfc82vXCbs1RQ8wHZhdTrpMKbbdKzQ55
 6U+itThXqlDdOgraWoS6AnSi9g5YqLu1yxFdroWLhHVJTRkS9x518x7FrlxrNf4S/NlD
 UVLZsqD/itbg0yOznZsLuY2TlVMfrOgKHNwMHk02nU4wob8EFdl7yH2C7u9Jmo1rQ939
 /uKV1SoYpz/TZkhqWBHazctBU+sT+cO0eB6+49KLoARKcNMW68YWXXs1s/GziTZ9yvWf eA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqtvd2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 13:29:34 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB4DTRu8030418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 13:29:28 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB4DTQZx032696;
        Tue, 4 Dec 2018 13:29:26 GMT
Received: from unbuntlaptop (/197.157.0.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 05:29:25 -0800
Date:   Tue, 4 Dec 2018 16:29:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Message-ID: <20181204132913.GH3073@unbuntlaptop>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 12:34:08PM +0000, Minas Harutyunyan wrote:
> @@ -3185,12 +3183,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
>          hsotg->connected = 0;
>          hsotg->test_mode = 0;
> 
> -       /* all endpoints should be shutdown */
>          for (ep = 0; ep < hsotg->num_of_eps; ep++) {
>                  if (hsotg->eps_in[ep])
> -                       dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> +                       kill_all_requests(hsotg, hsotg->eps_in[ep],
> +                                                         -ESHUTDOWN);
>                  if (hsotg->eps_out[ep])
> -                       dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> +                       kill_all_requests(hsotg, hsotg->eps_out[ep],
> +                                                         -ESHUTDOWN);


Should this part be in a separate patch?

I'm not trying to be rhetorical at all.  I literally don't know the
code very well.  Hopefully the full commit message will explain it.

>          }
> 
>          call_gadget(hsotg, disconnect);
> @@ -3234,6 +3233,8 @@ static void dwc2_hsotg_irq_fifoempty(struct 
> dwc2_hsotg *hsotg, bool periodic)
>                          GINTSTS_PTXFEMP |  \
>                          GINTSTS_RXFLVL)
> 
> +static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
> +
>   /**
>    * dwc2_hsotg_core_init - issue softreset to the core
>    * @hsotg: The device state
> @@ -3258,12 +3259,14 @@ void dwc2_hsotg_core_init_disconnected(struct 
> dwc2_hsotg *hsotg,
>                          return;
>          } else {
>                  /* all endpoints should be shutdown */
> +               spin_unlock(&hsotg->lock);
>                  for (ep = 1; ep < hsotg->num_of_eps; ep++) {
>                          if (hsotg->eps_in[ep])
>  
> dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
>                          if (hsotg->eps_out[ep])
>  
> dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
>                  }
> +               spin_lock(&hsotg->lock);
>          }
> 
>          /*

The idea here is that this is the only caller which is holding the
lock and we drop it here and take it again inside dwc2_hsotg_ep_disable().
I don't know the code very well and can't totally swear that this
doesn't introduce a small race condition...

Another option would be to introduce a new function which takes the lock
and change all the other callers instead.  To me that would be easier to
review...  See below for how it might look:

regards,
dan carpenter

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 94f3ba995580..b17a5dbefd5f 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3166,6 +3166,7 @@ static void kill_all_requests(struct dwc2_hsotg *hsotg,
 }
 
 static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
+static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep);
 
 /**
  * dwc2_hsotg_disconnect - disconnect service
@@ -3188,9 +3189,9 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
 	/* all endpoints should be shutdown */
 	for (ep = 0; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
 		if (hsotg->eps_out[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
 	}
 
 	call_gadget(hsotg, disconnect);
@@ -4069,10 +4070,8 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 	struct dwc2_hsotg *hsotg = hs_ep->parent;
 	int dir_in = hs_ep->dir_in;
 	int index = hs_ep->index;
-	unsigned long flags;
 	u32 epctrl_reg;
 	u32 ctrl;
-	int locked;
 
 	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
 
@@ -4088,10 +4087,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 
 	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
 
-	locked = spin_is_locked(&hsotg->lock);
-	if (!locked)
-		spin_lock_irqsave(&hsotg->lock, flags);
-
 	ctrl = dwc2_readl(hsotg, epctrl_reg);
 
 	if (ctrl & DXEPCTL_EPENA)
@@ -4114,12 +4109,23 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 	hs_ep->fifo_index = 0;
 	hs_ep->fifo_size = 0;
 
-	if (!locked)
-		spin_unlock_irqrestore(&hsotg->lock, flags);
-
 	return 0;
 }
 
+static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep)
+{
+	struct dwc2_hsotg_ep *hs_ep = our_ep(ep);
+	struct dwc2_hsotg *hsotg = hs_ep->parent;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	ret = dwc2_hsotg_ep_disable(ep);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	return ret;
+}
+
 /**
  * on_list - check request is on the given endpoint
  * @ep: The endpoint to check.
@@ -4267,7 +4273,7 @@ static int dwc2_hsotg_ep_sethalt_lock(struct usb_ep *ep, int value)
 
 static const struct usb_ep_ops dwc2_hsotg_ep_ops = {
 	.enable		= dwc2_hsotg_ep_enable,
-	.disable	= dwc2_hsotg_ep_disable,
+	.disable	= dwc2_hsotg_ep_disable_lock,
 	.alloc_request	= dwc2_hsotg_ep_alloc_request,
 	.free_request	= dwc2_hsotg_ep_free_request,
 	.queue		= dwc2_hsotg_ep_queue_lock,
@@ -4407,9 +4413,9 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	/* all endpoints should be shutdown */
 	for (ep = 1; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
 		if (hsotg->eps_out[ep])
-			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
 	}
 
 	spin_lock_irqsave(&hsotg->lock, flags);
@@ -4857,9 +4863,9 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
 
 		for (ep = 0; ep < hsotg->num_of_eps; ep++) {
 			if (hsotg->eps_in[ep])
-				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+				dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
 			if (hsotg->eps_out[ep])
-				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+				dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
 		}
 	}
 
