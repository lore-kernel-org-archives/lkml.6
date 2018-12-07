Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABA320868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tc103cb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABA320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGLUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:20:24 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:45088 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:20:23 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BA38D10C1499;
        Fri,  7 Dec 2018 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544181623; bh=VbO/Em3bQwj+QEeF3d+dETZQixVx0Cki7gypBWke2To=;
        h=From:To:CC:Subject:Date:References:From;
        b=Tc103cb1ta1LY7K0PvJFEkQTs3q2nvzciB9XXdH3LRvnil295Vaiqf0bRMFBUBiUl
         /ejjdpjU7DkBDmOCDUWSfpgc3Y3+k7O1WTtQDqNvBKGBmFkbuZtj0YX1dpOciTSLj9
         MvvOaZICBGziHbYW2CKV0v/GsUgZhfT0xazuo/LLN8EfNVpdxhsOph1yE4gxUT6qSa
         /CH8WLLXGFkzGK0HXsQDZ2k18hEAgumhRaJ1AEjDA51t7qOU+6lZmi/FYZk+k6oO3F
         YxWYQft2a1pIKLCM6OxgNh7TJXKAVfbuBkNVRmyABX9K9PciN6RSF+CPS0cMz7wmn9
         m9aM1ORo3wdbQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 84FCC3698;
        Fri,  7 Dec 2018 03:20:22 -0800 (PST)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 03:20:22 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 7 Dec 2018 15:20:19 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Thread-Topic: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Thread-Index: AQHUgbE8ouTBXi+nzkarEEkfP9zP5Q==
Date:   Fri, 7 Dec 2018 11:20:18 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7B4AAF@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
 <20181204132913.GH3073@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B2847@am04wembxa.internal.synopsys.com>
 <20181207101532.GR3073@unbuntlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,=0A=
=0A=
On 12/7/2018 2:16 PM, Dan Carpenter wrote:=0A=
> On Wed, Dec 05, 2018 at 12:52:22PM +0000, Minas Harutyunyan wrote:=0A=
>> Hi,=0A=
>>=0A=
>> On 12/4/2018 5:29 PM, Dan Carpenter wrote:=0A=
>>> On Tue, Dec 04, 2018 at 12:34:08PM +0000, Minas Harutyunyan wrote:=0A=
>>>> @@ -3185,12 +3183,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *=
hsotg)=0A=
>>>>            hsotg->connected =3D 0;=0A=
>>>>            hsotg->test_mode =3D 0;=0A=
>>>>=0A=
>>>> -       /* all endpoints should be shutdown */=0A=
>>>>            for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {=0A=
>>>>                    if (hsotg->eps_in[ep])=0A=
>>>> -                       dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=
=0A=
>>>> +                       kill_all_requests(hsotg, hsotg->eps_in[ep],=0A=
>>>> +                                                         -ESHUTDOWN);=
=0A=
>>>>                    if (hsotg->eps_out[ep])=0A=
>>>> -                       dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep)=
;=0A=
>>>> +                       kill_all_requests(hsotg, hsotg->eps_out[ep],=
=0A=
>>>> +                                                         -ESHUTDOWN);=
=0A=
>>>=0A=
>>>=0A=
>>> Should this part be in a separate patch?=0A=
>>>=0A=
>>> I'm not trying to be rhetorical at all.  I literally don't know the=0A=
>>> code very well.  Hopefully the full commit message will explain it.=0A=
>>>=0A=
>>=0A=
>> Actually, this fragment of patch revert changes from V2 and keep=0A=
>> untouched dwc2_hsotg_disconnect() function.=0A=
>>=0A=
> =0A=
> To me it feels like there are two issues.  The first is this change, and=
=0A=
> the second is fixing the lockdep warning.=0A=
> =0A=
> =0A=
>>>>            }=0A=
>>>>=0A=
>>>>            call_gadget(hsotg, disconnect);=0A=
>>>> @@ -3234,6 +3233,8 @@ static void dwc2_hsotg_irq_fifoempty(struct=0A=
>>>> dwc2_hsotg *hsotg, bool periodic)=0A=
>>>>                            GINTSTS_PTXFEMP |  \=0A=
>>>>                            GINTSTS_RXFLVL)=0A=
>>>>=0A=
>>>> +static int dwc2_hsotg_ep_disable(struct usb_ep *ep);=0A=
>>>> +=0A=
>>>>     /**=0A=
>>>>      * dwc2_hsotg_core_init - issue softreset to the core=0A=
>>>>      * @hsotg: The device state=0A=
>>>> @@ -3258,12 +3259,14 @@ void dwc2_hsotg_core_init_disconnected(struct=
=0A=
>>>> dwc2_hsotg *hsotg,=0A=
>>>>                            return;=0A=
>>>>            } else {=0A=
>>>>                    /* all endpoints should be shutdown */=0A=
>>>> +               spin_unlock(&hsotg->lock);=0A=
>>>>                    for (ep =3D 1; ep < hsotg->num_of_eps; ep++) {=0A=
>>>>                            if (hsotg->eps_in[ep])=0A=
>>>>    =0A=
>>>> dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
>>>>                            if (hsotg->eps_out[ep])=0A=
>>>>    =0A=
>>>> dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
>>>>                    }=0A=
>>>> +               spin_lock(&hsotg->lock);=0A=
>>>>            }=0A=
>>>>=0A=
>>>>            /*=0A=
>>>=0A=
>>> The idea here is that this is the only caller which is holding the=0A=
>>> lock and we drop it here and take it again inside dwc2_hsotg_ep_disable=
().=0A=
>>> I don't know the code very well and can't totally swear that this=0A=
>>> doesn't introduce a small race condition...=0A=
>>>=0A=
>> Above fragment of patch allow to keep untouched dwc2_hsotg_ep_disble()=
=0A=
>> function also, without changing spin_lock/_unlock stuff inside function.=
=0A=
>>=0A=
>> My approach here minimally update code to add any races. Just in=0A=
>> dwc2_hsotg_core_init_disconnected() function on USB reset interrupt=0A=
>> perform disabling all EP's. Because on USB reset interrupt, called from =
interrupt=0A=
>> handler with acquired lock and dwc2_hsotg_ep_disble() function (without=
=0A=
>> changes) acquire lock, just need to unlock lock to avoid any troubles.=
=0A=
>>=0A=
> =0A=
> Yes.  I understand that.  I just don't like it.=0A=
> =0A=
> Although your patch is more "minimal" in that it touches fewer lines of=
=0A=
> code it's actually more complicated because we have to verify that it's=
=0A=
> safe to drop the lock.=0A=
> =0A=
> =0A=
>>> Another option would be to introduce a new function which takes the loc=
k=0A=
>>> and change all the other callers instead.  To me that would be easier t=
o=0A=
>>> review...  See below for how it might look:=0A=
>>>=0A=
>>> regards,=0A=
>>> dan carpenter=0A=
>>>=0A=
>>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
>>> index 94f3ba995580..b17a5dbefd5f 100644=0A=
>>> --- a/drivers/usb/dwc2/gadget.c=0A=
>>> +++ b/drivers/usb/dwc2/gadget.c=0A=
>>> @@ -3166,6 +3166,7 @@ static void kill_all_requests(struct dwc2_hsotg *=
hsotg,=0A=
>>>    }=0A=
>>>    =0A=
>>>    static int dwc2_hsotg_ep_disable(struct usb_ep *ep);=0A=
>>> +static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep);=0A=
>>>    =0A=
>>>    /**=0A=
>>>     * dwc2_hsotg_disconnect - disconnect service=0A=
>>> @@ -3188,9 +3189,9 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hso=
tg)=0A=
>>>    	/* all endpoints should be shutdown */=0A=
>>>    	for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {=0A=
>>>    		if (hsotg->eps_in[ep])=0A=
>>> -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
>>> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);=0A=
>>>    		if (hsotg->eps_out[ep])=0A=
>>> -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
>>> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);=0A=
>>>    	}=0A=
>>>    =0A=
>>>    	call_gadget(hsotg, disconnect);=0A=
>>> @@ -4069,10 +4070,8 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *=
ep)=0A=
>>>    	struct dwc2_hsotg *hsotg =3D hs_ep->parent;=0A=
>>>    	int dir_in =3D hs_ep->dir_in;=0A=
>>>    	int index =3D hs_ep->index;=0A=
>>> -	unsigned long flags;=0A=
>>>    	u32 epctrl_reg;=0A=
>>>    	u32 ctrl;=0A=
>>> -	int locked;=0A=
>>>    =0A=
>>>    	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);=0A=
>>>    =0A=
>>> @@ -4088,10 +4087,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *=
ep)=0A=
>>>    =0A=
>>>    	epctrl_reg =3D dir_in ? DIEPCTL(index) : DOEPCTL(index);=0A=
>>>    =0A=
>>> -	locked =3D spin_is_locked(&hsotg->lock);=0A=
>>> -	if (!locked)=0A=
>>> -		spin_lock_irqsave(&hsotg->lock, flags);=0A=
>>> -=0A=
>>>    	ctrl =3D dwc2_readl(hsotg, epctrl_reg);=0A=
>>>    =0A=
>>>    	if (ctrl & DXEPCTL_EPENA)=0A=
>>> @@ -4114,12 +4109,23 @@ static int dwc2_hsotg_ep_disable(struct usb_ep =
*ep)=0A=
>>>    	hs_ep->fifo_index =3D 0;=0A=
>>>    	hs_ep->fifo_size =3D 0;=0A=
>>>    =0A=
>>> -	if (!locked)=0A=
>>> -		spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>>> -=0A=
>>>    	return 0;=0A=
>>>    }=0A=
>>>    =0A=
>>> +static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep)=0A=
>>> +{=0A=
>>> +	struct dwc2_hsotg_ep *hs_ep =3D our_ep(ep);=0A=
>>> +	struct dwc2_hsotg *hsotg =3D hs_ep->parent;=0A=
>>> +	unsigned long flags;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	spin_lock_irqsave(&hsotg->lock, flags);=0A=
>>> +	ret =3D dwc2_hsotg_ep_disable(ep);=0A=
>>> +	spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>>> +=0A=
>>> +	return ret;=0A=
>>> +}=0A=
>>> +=0A=
>>>    /**=0A=
>>>     * on_list - check request is on the given endpoint=0A=
>>>     * @ep: The endpoint to check.=0A=
>>> @@ -4267,7 +4273,7 @@ static int dwc2_hsotg_ep_sethalt_lock(struct usb_=
ep *ep, int value)=0A=
>>>    =0A=
>>>    static const struct usb_ep_ops dwc2_hsotg_ep_ops =3D {=0A=
>>>    	.enable		=3D dwc2_hsotg_ep_enable,=0A=
>>> -	.disable	=3D dwc2_hsotg_ep_disable,=0A=
>>> +	.disable	=3D dwc2_hsotg_ep_disable_lock,=0A=
>>>    	.alloc_request	=3D dwc2_hsotg_ep_alloc_request,=0A=
>>>    	.free_request	=3D dwc2_hsotg_ep_free_request,=0A=
>>>    	.queue		=3D dwc2_hsotg_ep_queue_lock,=0A=
>>> @@ -4407,9 +4413,9 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget =
*gadget)=0A=
>>>    	/* all endpoints should be shutdown */=0A=
>>>    	for (ep =3D 1; ep < hsotg->num_of_eps; ep++) {=0A=
>>>    		if (hsotg->eps_in[ep])=0A=
>>> -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
>>> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);=0A=
>>>    		if (hsotg->eps_out[ep])=0A=
>>> -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
>>> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);=0A=
>>>    	}=0A=
>>>    =0A=
>>>    	spin_lock_irqsave(&hsotg->lock, flags);=0A=
>>> @@ -4857,9 +4863,9 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)=
=0A=
>>>    =0A=
>>>    		for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {=0A=
>>>    			if (hsotg->eps_in[ep])=0A=
>>> -				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
>>> +				dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);=0A=
>>>    			if (hsotg->eps_out[ep])=0A=
>>> -				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
>>> +				dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);=0A=
>>>    		}=0A=
>>>    	}=0A=
>>>    =0A=
>>>=0A=
>>=0A=
>> Your code doesn't take care about fifo_map warnings from=0A=
>> dwc2_hsotg_init_fifo() function. Before calling dwc2_hsotg_init_fifo()=
=0A=
>> from dwc2_hsotg_core_init_disconnected() function all Ep's should=0A=
>> disabled and fifo bitmap should be cleared.=0A=
>>=0A=
> =0A=
> Correct.  I am only trying to fix the locking.  I hope you can fix the=0A=
> rest in a separate patch.=0A=
> =0A=
Yeah. I'll try deeper investigate driver locking flow and fix it later. =0A=
Actually, I like your idea with introducing dwc2_hsotg_ep_disable_lock() =
=0A=
function. Maybe you yourself will submit new patch for safe locking =0A=
fixes? But please just after my patch will applied :-)=0A=
Currently there are 2-3 high priority issues reported by community and I =
=0A=
should find solutions/fixes.=0A=
Thank you very much for your time and useful feedback.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
=0A=
> regards,=0A=
> dan carpenter=0A=
> =0A=
> =0A=
=0A=
