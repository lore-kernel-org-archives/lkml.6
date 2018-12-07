Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0920882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W9+qETb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA0920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLGJGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:06:39 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:41106 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeLGJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:06:38 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9A66210C13A9;
        Fri,  7 Dec 2018 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544173597; bh=Jq/ryhfBTUOJYezd471T4thTstXPiCWH0xUoWuqYSU4=;
        h=From:To:CC:Subject:Date:References:From;
        b=W9+qETb0kydiiCsmIujt3ZRc7AbHTDg6D3K6i4AdgI+lgx2O61Br76rkSAgRxc2L6
         IQgOLODTUtpJ3KU6ut4u4b244K/M6bo7DLkX4Yd15+Pu75TNtzmkOBQFMa0CNZDCaN
         Gjd49UNB+ZQol48Qj/fKBhRfze+/7g1Es/bhk9LgxOMObY0xgk3Ff3JUu51F47rr8e
         bcMC+l0DlWHKRdE3Ti+TO09WU2eosnV3/n6+6jFQ9ZCHEczdUjkfGubDqP6WwOTD07
         UKYFc2lqn49II1T+PTbu2Beg4I18vmHOTTuFzFvD+kz45kDBaQ+/GxEGCagS8EIhNT
         GvcUckBFZZS8Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0B5195C2B;
        Fri,  7 Dec 2018 01:06:30 -0800 (PST)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 01:06:30 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 7 Dec 2018 13:06:27 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Maynard CABIENTE <maynard.cabiente@raritan.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
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
Date:   Fri, 7 Dec 2018 09:06:26 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7B4794@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
 <AM0PR06MB5602BA92755999C69F38D1E297A90@AM0PR06MB5602.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maynard,=0A=
=0A=
On 12/7/2018 3:09 AM, Maynard CABIENTE wrote:=0A=
> Hi Minas,=0A=
> =0A=
> I tried your new patch on top of the other 2 patches for a couple of days=
 now and I do not see the issue that Marek encountered. Of course, I did no=
t see it also on the original two patches you created. I also do not see th=
e original FIFO map warning issue that I have with all 3 patches intact.=0A=
> =0A=
> However, I do have 2 issues that I'm not certain if this was created by t=
hese patches or already there in the beginning (prior to applying all your =
3 patches). Again my system is an Altera Cyclone V SoC FPGA running on linu=
x kernel 4.14.44. We are using both USB HID and mass storage gadget. The 2 =
issues may occur when USB mass storage is in use.=0A=
> =0A=
> First issue I am encountering is (sometimes continuous) multiple USB rese=
ts occurring when using the USB mass storage gadget. When I used a USB snif=
fer (Ellisys) to see the cause of the USB reset, I am seeing an out-of-orde=
r USB mass storage transfer. That is, the transfer is supposed to follow (1=
) Command Block Wrapper (CBW), (2) Data, (3) Command Status Wrapper (CSW). =
When the USB reset occur, I see either one of the following prior to the re=
set:=0A=
> =0A=
> - Data comes in first before the CBW=0A=
> - Request Sense CBW, Data then no CSW followed by a Test Unit Ready CBW a=
nd Data with no CSW again=0A=
> - CBW, CSW and then Data=0A=
> =0A=
> Second issue that I see is a deadlock then my system will reboot. This ha=
ppens when I re-enable the USB mass storage gadget after disabling it befor=
e.=0A=
> =0A=
> The two issues may not be related to your changes. I will revert back all=
 your patches to see if the issue is present already. However, I will hit m=
y original problem when I don't apply at least 2 of your patches, which is =
the WARNING: CPU: 0 PID: 0 at ../drivers/usb/dwc2/gadget.c:300 dwc2_hsotg_i=
nit_fifo+0x34/0x1b4.=0A=
> =0A=
> I will get back to you once I test it without your patches.=0A=
> =0A=
> Regards,=0A=
> Maynard=0A=
> =0A=
Thank you for testing.=0A=
Issue which described looks like not related to these patches. For that =0A=
issue please open another mail thread with more details. We will work on it=
.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
=0A=
> On Tuesday, December 04, 2018 7:34 AM, Minas Harutyunyan wrote:=0A=
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
>>=0A=
>> Hi Dan, Marek, Maynard,=0A=
>>=0A=
>> Could you please apply bellow patch over follow patches:=0A=
>>=0A=
>> dccf1bad4be7 usb: dwc2: Disable all EP's on disconnect=0A=
>> 6f774b501928 usb: dwc2: Fix ep disable spinlock flow.=0A=
>>=0A=
>> Please review and test. Feedback is appreciated :-)=0A=
>>=0A=
>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c index=
=0A=
>> 8eb25e3597b0..db438d13c36a 100644=0A=
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
>> @@ -3185,12 +3183,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg=0A=
>> *hsotg)=0A=
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
>>           call_gadget(hsotg, disconnect); @@ -3234,6 +3233,8 @@ static v=
oid=0A=
>> dwc2_hsotg_irq_fifoempty(struct dwc2_hsotg *hsotg, bool periodic)=0A=
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
>>=0A=
>> dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);=0A=
>>                           if (hsotg->eps_out[ep])=0A=
>>=0A=
>> dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);=0A=
>>                   }=0A=
>> +               spin_lock(&hsotg->lock);=0A=
>>           }=0A=
>>=0A=
>>           /*=0A=
>> @@ -4072,7 +4075,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep=0A=
>> *ep)=0A=
>>           unsigned long flags;=0A=
>>           u32 epctrl_reg;=0A=
>>           u32 ctrl;=0A=
>> -       int locked;=0A=
>>=0A=
>>           dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);=0A=
>>=0A=
>> @@ -4088,7 +4090,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep=0A=
>> *ep)=0A=
>>=0A=
>>           epctrl_reg =3D dir_in ? DIEPCTL(index) : DOEPCTL(index);=0A=
>>=0A=
>> -       locked =3D spin_trylock_irqsave(&hsotg->lock, flags);=0A=
>> +       spin_lock_irqsave(&hsotg->lock, flags);=0A=
>>=0A=
>>           ctrl =3D dwc2_readl(hsotg, epctrl_reg);=0A=
>>=0A=
>> @@ -4112,8 +4114,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep=0A=
>> *ep)=0A=
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
> =0A=
> ________________________________=0A=
> =0A=
> Ce message, ainsi que tous les fichiers joints =E0 ce message, peuvent co=
ntenir des informations sensibles et/ ou confidentielles ne devant pas =EAt=
re divulgu=E9es. Si vous n'=EAtes pas le destinataire de ce message (ou que=
 vous recevez ce message par erreur), nous vous remercions de le notifier i=
mm=E9diatement =E0 son exp=E9diteur, et de d=E9truire ce message. Toute cop=
ie, divulgation, modification, utilisation ou diffusion, non autoris=E9e, d=
irecte ou indirecte, de tout ou partie de ce message, est strictement inter=
dite.=0A=
> =0A=
> =0A=
> This e-mail, and any document attached hereby, may contain confidential a=
nd/or privileged information. If you are not the intended recipient (or hav=
e received this e-mail in error) please notify the sender immediately and d=
estroy this e-mail. Any unauthorized, direct or indirect, copying, disclosu=
re, distribution or other use of the material or parts thereof is strictly =
forbidden.=0A=
> =0A=
=0A=
