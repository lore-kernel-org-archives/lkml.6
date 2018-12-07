Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5727C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B8C20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jmDmJPTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B8C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLGJGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:06:39 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:55554 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:06:38 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E82CA24E1FDC;
        Fri,  7 Dec 2018 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544173598; bh=3ExysG2zJMdq77Y/mQbCphwGqBq+M4uXhFpDJdrQ7wY=;
        h=From:To:CC:Subject:Date:References:From;
        b=jmDmJPTyoV5taaSXnOo22Sk4J7N56bHqXetFQsrruIhyLuCaw0ADhMRys+Wg6lsq0
         8Gsjg9nsrQ2Y/gn0yEgJdk8FLKhMqA/WSTjPpMXac3IjJCIHGYQJ1nK44DVPpQz4fX
         nQuuAjIKc3bgd3/T20PbQo8X3ce1RgOk9zSlsRthljigLV9SCNfopaa+lUXzyK4pwL
         RQEnAJZZ3suB1AS0zMEVcnVZzZPwviWIc6grl6TtKVqVMMsMLPnsVRUMMfLpW+eaW1
         j/TyPSLN/UyzUDBci/yILzqDuQ1qNj8wXMg5R85HXxiV+ZjAoxZYSzy9I7NP3Eo5e4
         kgD30H7pty7Ng==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id A55EA3D5B;
        Fri,  7 Dec 2018 01:06:37 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 01:06:37 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 7 Dec 2018 13:06:34 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Date:   Fri, 7 Dec 2018 09:06:33 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7B47A2@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
 <2b48a7b5-f806-d761-97f6-885ae6c69a7e@samsung.com>
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

Hi Marek,=0A=
=0A=
On 12/6/2018 7:04 PM, Marek Szyprowski wrote:=0A=
> Dear Minas,=0A=
> =0A=
> On 2018-12-04 13:34, Minas Harutyunyan wrote:=0A=
>> On 11/23/2018 6:43 PM, Dan Carpenter wrote:=0A=
>>> Ugh...  We also had a long thread about the v2 patch but it turns out=
=0A=
>>> the list was not CC'd.  I should have checked for that.=0A=
>>>=0A=
>>> You have to pass a flag to say if the caller holds the lock or not...=
=0A=
>>>=0A=
>>> regards,=0A=
>>> dan carpenter=0A=
>>>=0A=
>> Hi Dan, Marek, Maynard,=0A=
>>=0A=
>> Could you please apply bellow patch over follow patches:=0A=
>>=0A=
>> dccf1bad4be7 usb: dwc2: Disable all EP's on disconnect=0A=
>> 6f774b501928 usb: dwc2: Fix ep disable spinlock flow.=0A=
>>=0A=
>> Please review and test. Feedback is appreciated :-)=0A=
> =0A=
> Okay, I finally managed to find some time to check this. Your diff is=0A=
> mangled, so I had to manually apply it. Frankly, it is very similar to=0A=
> the revert I proposed. I've checked it on my test machines and it fixes=
=0A=
> the issues. I'm not very happy about the unlock/lock design, but it=0A=
> should be safe in this case and doesn't make the code even more complex.=
=0A=
> Feel free to add a following tag to the final patch:=0A=
> =0A=
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>=0A=
Thanks for testing.=0A=
=0A=
> =0A=
>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
>> index 8eb25e3597b0..db438d13c36a 100644=0A=
>> --- a/drivers/usb/dwc2/gadget.c=0A=
>> +++ b/drivers/usb/dwc2/gadget.c=0A=
>> @@ -3165,8 +3165,6 @@ static void kill_all_requests(struct dwc2_hsotg=0A=
>> *hsotg,=0A=
>>                   dwc2_hsotg_txfifo_flush(hsotg, ep->fifo_index);=0A=
>>    }=0A=
>>=0A=
>> -static int dwc2_hsotg_ep_disable(struct usb_ep *ep);=0A=
>> -=0A=
>>    /**=0A=
>>     * dwc2_hsotg_disconnect - disconnect service=0A=
>>     * @hsotg: The device state.=0A=
>> @@ -3185,12 +3183,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hs=
otg)=0A=
>>           hsotg->connected =3D 0;=0A=
>>           hsotg->test_mode =3D 0;=0A=
>>=0A=
>> -       /* all endpoints should be shutdown */=0A=
>>           for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {=0A=
>>                   if (hsotg->eps_in[ep])=0A=
>> -                       dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=
=0A=
>> +                       kill_all_requests(hsotg, hsotg->eps_in[ep],=0A=
>> +                                                         -ESHUTDOWN);=
=0A=
>>                   if (hsotg->eps_out[ep])=0A=
>> -                       dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=
=0A=
>> +                       kill_all_requests(hsotg, hsotg->eps_out[ep],=0A=
>> +                                                         -ESHUTDOWN);=
=0A=
>>           }=0A=
>>=0A=
>>           call_gadget(hsotg, disconnect);=0A=
>> @@ -3234,6 +3233,8 @@ static void dwc2_hsotg_irq_fifoempty(struct=0A=
>> dwc2_hsotg *hsotg, bool periodic)=0A=
>>                           GINTSTS_PTXFEMP |  \=0A=
>>                           GINTSTS_RXFLVL)=0A=
>>=0A=
>> +static int dwc2_hsotg_ep_disable(struct usb_ep *ep);=0A=
>> +=0A=
>>    /**=0A=
>>     * dwc2_hsotg_core_init - issue softreset to the core=0A=
>>     * @hsotg: The device state=0A=
>> @@ -3258,12 +3259,14 @@ void dwc2_hsotg_core_init_disconnected(struct=0A=
>> dwc2_hsotg *hsotg,=0A=
>>                           return;=0A=
>>           } else {=0A=
>>                   /* all endpoints should be shutdown */=0A=
>> +               spin_unlock(&hsotg->lock);=0A=
>>                   for (ep =3D 1; ep < hsotg->num_of_eps; ep++) {=0A=
>>                           if (hsotg->eps_in[ep])=0A=
>>   =0A=
>> dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
>>                           if (hsotg->eps_out[ep])=0A=
>>   =0A=
>> dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
>>                   }=0A=
>> +               spin_lock(&hsotg->lock);=0A=
>>           }=0A=
>>=0A=
>>           /*=0A=
>> @@ -4072,7 +4075,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep=
)=0A=
>>           unsigned long flags;=0A=
>>           u32 epctrl_reg;=0A=
>>           u32 ctrl;=0A=
>> -       int locked;=0A=
>>=0A=
>>           dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);=0A=
>>=0A=
>> @@ -4088,7 +4090,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep=
)=0A=
>>=0A=
>>           epctrl_reg =3D dir_in ? DIEPCTL(index) : DOEPCTL(index);=0A=
>>=0A=
>> -       locked =3D spin_trylock_irqsave(&hsotg->lock, flags);=0A=
>> +       spin_lock_irqsave(&hsotg->lock, flags);=0A=
>>=0A=
>>           ctrl =3D dwc2_readl(hsotg, epctrl_reg);=0A=
>>=0A=
>> @@ -4112,8 +4114,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep=
)=0A=
>>           hs_ep->fifo_index =3D 0;=0A=
>>           hs_ep->fifo_size =3D 0;=0A=
>>=0A=
>> -       if (locked)=0A=
>> -               spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>> +       spin_unlock_irqrestore(&hsotg->lock, flags);=0A=
>>=0A=
>>           return 0;=0A=
>>    }=0A=
>>=0A=
>> Thanks,=0A=
>> Minas=0A=
>>=0A=
>>=0A=
> Best regards=0A=
> =0A=
=0A=
Thanks,=0A=
Minas=0A=
