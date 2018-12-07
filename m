Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C7BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5002083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xUeMliVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5002083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLGKP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:15:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53528 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:15:59 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7AE0lt100575;
        Fri, 7 Dec 2018 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dwkAAtLpX7iGJkAe1ZGBnC66bJQk0Ta4ieC8YfEpaXA=;
 b=xUeMliVw/k4thplIdd/LJs7E0EOQzNai2hmyUIZeTkVVIe02bGCJ71mNmPcZ0N4P5u4j
 /HPV/yZrlbikGgfYA0is5q1QACOZ9N2JZwpD/dnZDtbQhRF0NkiQRT/XW5t4ULhLO6pq
 h0ORynNzOeAwa+ufkwvCCbztmb3mR8MYaIcZmOI0kxzzVOPDSOfLGZn4sn6LN9GFnnzb
 S5W1zbke8E2OKlGMwmpqguQdgDcB/xSDjh1TVvAm5y9hf+7akNaxzjXxlRK7s3s8wz2/
 CUYEFXFvmMgK0DFdbpknzZ97hoiknGrLNo6Ltlt5+SStUCLozC+zWeua9+lkEOs1Yo8D gA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftfh2rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 10:15:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB7AFhcv025237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 10:15:44 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB7AFgJ0015452;
        Fri, 7 Dec 2018 10:15:42 GMT
Received: from unbuntlaptop (/197.157.0.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 02:15:41 -0800
Date:   Fri, 7 Dec 2018 13:15:32 +0300
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
Message-ID: <20181207101532.GR3073@unbuntlaptop>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
 <20181204132913.GH3073@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B2847@am04wembxa.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7B2847@am04wembxa.internal.synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:52:22PM +0000, Minas Harutyunyan wrote:
> Hi,
> 
> On 12/4/2018 5:29 PM, Dan Carpenter wrote:
> > On Tue, Dec 04, 2018 at 12:34:08PM +0000, Minas Harutyunyan wrote:
> >> @@ -3185,12 +3183,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
> >>           hsotg->connected = 0;
> >>           hsotg->test_mode = 0;
> >>
> >> -       /* all endpoints should be shutdown */
> >>           for (ep = 0; ep < hsotg->num_of_eps; ep++) {
> >>                   if (hsotg->eps_in[ep])
> >> -                       dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> >> +                       kill_all_requests(hsotg, hsotg->eps_in[ep],
> >> +                                                         -ESHUTDOWN);
> >>                   if (hsotg->eps_out[ep])
> >> -                       dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> >> +                       kill_all_requests(hsotg, hsotg->eps_out[ep],
> >> +                                                         -ESHUTDOWN);
> > 
> > 
> > Should this part be in a separate patch?
> > 
> > I'm not trying to be rhetorical at all.  I literally don't know the
> > code very well.  Hopefully the full commit message will explain it.
> > 
> 
> Actually, this fragment of patch revert changes from V2 and keep 
> untouched dwc2_hsotg_disconnect() function.
> 

To me it feels like there are two issues.  The first is this change, and
the second is fixing the lockdep warning.


> >>           }
> >>
> >>           call_gadget(hsotg, disconnect);
> >> @@ -3234,6 +3233,8 @@ static void dwc2_hsotg_irq_fifoempty(struct
> >> dwc2_hsotg *hsotg, bool periodic)
> >>                           GINTSTS_PTXFEMP |  \
> >>                           GINTSTS_RXFLVL)
> >>
> >> +static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
> >> +
> >>    /**
> >>     * dwc2_hsotg_core_init - issue softreset to the core
> >>     * @hsotg: The device state
> >> @@ -3258,12 +3259,14 @@ void dwc2_hsotg_core_init_disconnected(struct
> >> dwc2_hsotg *hsotg,
> >>                           return;
> >>           } else {
> >>                   /* all endpoints should be shutdown */
> >> +               spin_unlock(&hsotg->lock);
> >>                   for (ep = 1; ep < hsotg->num_of_eps; ep++) {
> >>                           if (hsotg->eps_in[ep])
> >>   
> >> dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> >>                           if (hsotg->eps_out[ep])
> >>   
> >> dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> >>                   }
> >> +               spin_lock(&hsotg->lock);
> >>           }
> >>
> >>           /*
> > 
> > The idea here is that this is the only caller which is holding the
> > lock and we drop it here and take it again inside dwc2_hsotg_ep_disable().
> > I don't know the code very well and can't totally swear that this
> > doesn't introduce a small race condition...
> > 
> Above fragment of patch allow to keep untouched dwc2_hsotg_ep_disble() 
> function also, without changing spin_lock/_unlock stuff inside function.
> 
> My approach here minimally update code to add any races. Just in 
> dwc2_hsotg_core_init_disconnected() function on USB reset interrupt 
> perform disabling all EP's. Because on USB reset interrupt, called from interrupt 
> handler with acquired lock and dwc2_hsotg_ep_disble() function (without 
> changes) acquire lock, just need to unlock lock to avoid any troubles.
> 

Yes.  I understand that.  I just don't like it.

Although your patch is more "minimal" in that it touches fewer lines of
code it's actually more complicated because we have to verify that it's
safe to drop the lock.


> > Another option would be to introduce a new function which takes the lock
> > and change all the other callers instead.  To me that would be easier to
> > review...  See below for how it might look:
> > 
> > regards,
> > dan carpenter
> > 
> > diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> > index 94f3ba995580..b17a5dbefd5f 100644
> > --- a/drivers/usb/dwc2/gadget.c
> > +++ b/drivers/usb/dwc2/gadget.c
> > @@ -3166,6 +3166,7 @@ static void kill_all_requests(struct dwc2_hsotg *hsotg,
> >   }
> >   
> >   static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
> > +static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep);
> >   
> >   /**
> >    * dwc2_hsotg_disconnect - disconnect service
> > @@ -3188,9 +3189,9 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
> >   	/* all endpoints should be shutdown */
> >   	for (ep = 0; ep < hsotg->num_of_eps; ep++) {
> >   		if (hsotg->eps_in[ep])
> > -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> > +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
> >   		if (hsotg->eps_out[ep])
> > -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> > +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
> >   	}
> >   
> >   	call_gadget(hsotg, disconnect);
> > @@ -4069,10 +4070,8 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
> >   	struct dwc2_hsotg *hsotg = hs_ep->parent;
> >   	int dir_in = hs_ep->dir_in;
> >   	int index = hs_ep->index;
> > -	unsigned long flags;
> >   	u32 epctrl_reg;
> >   	u32 ctrl;
> > -	int locked;
> >   
> >   	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
> >   
> > @@ -4088,10 +4087,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
> >   
> >   	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
> >   
> > -	locked = spin_is_locked(&hsotg->lock);
> > -	if (!locked)
> > -		spin_lock_irqsave(&hsotg->lock, flags);
> > -
> >   	ctrl = dwc2_readl(hsotg, epctrl_reg);
> >   
> >   	if (ctrl & DXEPCTL_EPENA)
> > @@ -4114,12 +4109,23 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
> >   	hs_ep->fifo_index = 0;
> >   	hs_ep->fifo_size = 0;
> >   
> > -	if (!locked)
> > -		spin_unlock_irqrestore(&hsotg->lock, flags);
> > -
> >   	return 0;
> >   }
> >   
> > +static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep)
> > +{
> > +	struct dwc2_hsotg_ep *hs_ep = our_ep(ep);
> > +	struct dwc2_hsotg *hsotg = hs_ep->parent;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&hsotg->lock, flags);
> > +	ret = dwc2_hsotg_ep_disable(ep);
> > +	spin_unlock_irqrestore(&hsotg->lock, flags);
> > +
> > +	return ret;
> > +}
> > +
> >   /**
> >    * on_list - check request is on the given endpoint
> >    * @ep: The endpoint to check.
> > @@ -4267,7 +4273,7 @@ static int dwc2_hsotg_ep_sethalt_lock(struct usb_ep *ep, int value)
> >   
> >   static const struct usb_ep_ops dwc2_hsotg_ep_ops = {
> >   	.enable		= dwc2_hsotg_ep_enable,
> > -	.disable	= dwc2_hsotg_ep_disable,
> > +	.disable	= dwc2_hsotg_ep_disable_lock,
> >   	.alloc_request	= dwc2_hsotg_ep_alloc_request,
> >   	.free_request	= dwc2_hsotg_ep_free_request,
> >   	.queue		= dwc2_hsotg_ep_queue_lock,
> > @@ -4407,9 +4413,9 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
> >   	/* all endpoints should be shutdown */
> >   	for (ep = 1; ep < hsotg->num_of_eps; ep++) {
> >   		if (hsotg->eps_in[ep])
> > -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> > +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
> >   		if (hsotg->eps_out[ep])
> > -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> > +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
> >   	}
> >   
> >   	spin_lock_irqsave(&hsotg->lock, flags);
> > @@ -4857,9 +4863,9 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
> >   
> >   		for (ep = 0; ep < hsotg->num_of_eps; ep++) {
> >   			if (hsotg->eps_in[ep])
> > -				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> > +				dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
> >   			if (hsotg->eps_out[ep])
> > -				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> > +				dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
> >   		}
> >   	}
> >   
> > 
> 
> Your code doesn't take care about fifo_map warnings from 
> dwc2_hsotg_init_fifo() function. Before calling dwc2_hsotg_init_fifo() 
> from dwc2_hsotg_core_init_disconnected() function all Ep's should 
> disabled and fifo bitmap should be cleared.
> 

Correct.  I am only trying to fix the locking.  I hope you can fix the
rest in a separate patch.

regards,
dan carpenter

