Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30827C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B252020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T+bg95mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B252020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeLEMwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:52:30 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:43466 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeLEMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:52:29 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8E0A010C119B;
        Wed,  5 Dec 2018 04:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544014347; bh=SVoNa69YNVELeXYhMFHQmtKvVVAwqOqHSOD8SBycMIQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=T+bg95mxMazMICZ5cZrI9FHJQZipE0FfUfZOUb4/sMdcnJVfEBhJ1kUQviyaIMfPS
         DCbWNSLlHBw6PDJgCPGEsGUFH2+l3p455fPw9iCx0hgTe9pSLZhblAw8wwHtlNJARP
         7lHxHc7OCHQtS6ylXNB3qq7bctKE0xZ6EipHIJzWR2emOxvUUu3zVrOlMIvkuYWW+c
         gpKDClSfxHjvBdckhxFeFCerxeIWOs5lRpQCWw12OIsUYEhiVRn5iOMKWFMEbZf7N7
         DheNPfMFgVwxq5DNUwF63lIXY3RmdDfggpxQjwJNxamGxRoCdzJY0Q7YkK9a4VQBxn
         xdcAJ1jhzeDHA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7A7CE3E1F;
        Wed,  5 Dec 2018 04:52:26 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 5 Dec 2018 04:52:25 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 5 Dec 2018 16:52:23 +0400
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
Date:   Wed, 5 Dec 2018 12:52:22 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7B2847@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
 <20181204132913.GH3073@unbuntlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaG1pbmFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOWEyYzllYmEtZjg4Yy0xMWU4LWFlZWYtMTA2NTMw?=
 =?us-ascii?Q?YTFkYTJkXGFtZS10ZXN0XDlhMmM5ZWJiLWY4OGMtMTFlOC1hZWVmLTEwNjUz?=
 =?us-ascii?Q?MGExZGEyZGJvZHkudHh0IiBzej0iNzUzNyIgdD0iMTMxODg0ODc5NDE0MDQ4?=
 =?us-ascii?Q?MzQ1IiBoPSJtcktaQzJjOTh0aTZIa3lxNU5NWTJuVklUc2c9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUJa?=
 =?us-ascii?Q?TnJoY21ZelVBVzBzeW9MKzB5em5iU3pLZ3Y3VExPY09BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWVuSUNHZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFH?=
 =?us-ascii?Q?MEFjd0IxQUc0QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQWRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6?=
 =?us-ascii?Q?QUcwQVl3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJQWJ3QmtBSFVBWXdCMEFGOEFk?=
 =?us-ascii?Q?QUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJn?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dCZkFI?=
 =?us-ascii?Q?RUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHNEFjQUJ6QUY4QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBB?=
 =?us-ascii?Q?WHdCekFIUUFkUUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0FaUUI1?=
 =?us-ascii?Q?QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-originating-ip: [10.116.70.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/2018 5:29 PM, Dan Carpenter wrote:
> On Tue, Dec 04, 2018 at 12:34:08PM +0000, Minas Harutyunyan wrote:
>> @@ -3185,12 +3183,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hs=
otg)
>>           hsotg->connected =3D 0;
>>           hsotg->test_mode =3D 0;
>>
>> -       /* all endpoints should be shutdown */
>>           for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {
>>                   if (hsotg->eps_in[ep])
>> -                       dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
>> +                       kill_all_requests(hsotg, hsotg->eps_in[ep],
>> +                                                         -ESHUTDOWN);
>>                   if (hsotg->eps_out[ep])
>> -                       dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
>> +                       kill_all_requests(hsotg, hsotg->eps_out[ep],
>> +                                                         -ESHUTDOWN);
>=20
>=20
> Should this part be in a separate patch?
>=20
> I'm not trying to be rhetorical at all.  I literally don't know the
> code very well.  Hopefully the full commit message will explain it.
>=20

Actually, this fragment of patch revert changes from V2 and keep=20
untouched dwc2_hsotg_disconnect() function.

>>           }
>>
>>           call_gadget(hsotg, disconnect);
>> @@ -3234,6 +3233,8 @@ static void dwc2_hsotg_irq_fifoempty(struct
>> dwc2_hsotg *hsotg, bool periodic)
>>                           GINTSTS_PTXFEMP |  \
>>                           GINTSTS_RXFLVL)
>>
>> +static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
>> +
>>    /**
>>     * dwc2_hsotg_core_init - issue softreset to the core
>>     * @hsotg: The device state
>> @@ -3258,12 +3259,14 @@ void dwc2_hsotg_core_init_disconnected(struct
>> dwc2_hsotg *hsotg,
>>                           return;
>>           } else {
>>                   /* all endpoints should be shutdown */
>> +               spin_unlock(&hsotg->lock);
>>                   for (ep =3D 1; ep < hsotg->num_of_eps; ep++) {
>>                           if (hsotg->eps_in[ep])
>>  =20
>> dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
>>                           if (hsotg->eps_out[ep])
>>  =20
>> dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
>>                   }
>> +               spin_lock(&hsotg->lock);
>>           }
>>
>>           /*
>=20
> The idea here is that this is the only caller which is holding the
> lock and we drop it here and take it again inside dwc2_hsotg_ep_disable()=
.
> I don't know the code very well and can't totally swear that this
> doesn't introduce a small race condition...
>=20
Above fragment of patch allow to keep untouched dwc2_hsotg_ep_disble()=20
function also, without changing spin_lock/_unlock stuff inside function.

My approach here minimally update code to add any races. Just in=20
dwc2_hsotg_core_init_disconnected() function on USB reset interrupt=20
perform disabling all EP's. Because on USB reset interrupt, called from int=
errupt=20
handler with acquired lock and dwc2_hsotg_ep_disble() function (without=20
changes) acquire lock, just need to unlock lock to avoid any troubles.

> Another option would be to introduce a new function which takes the lock
> and change all the other callers instead.  To me that would be easier to
> review...  See below for how it might look:
>=20
> regards,
> dan carpenter
>=20
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index 94f3ba995580..b17a5dbefd5f 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -3166,6 +3166,7 @@ static void kill_all_requests(struct dwc2_hsotg *hs=
otg,
>   }
>  =20
>   static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
> +static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep);
>  =20
>   /**
>    * dwc2_hsotg_disconnect - disconnect service
> @@ -3188,9 +3189,9 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg=
)
>   	/* all endpoints should be shutdown */
>   	for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {
>   		if (hsotg->eps_in[ep])
> -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
>   		if (hsotg->eps_out[ep])
> -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
>   	}
>  =20
>   	call_gadget(hsotg, disconnect);
> @@ -4069,10 +4070,8 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep=
)
>   	struct dwc2_hsotg *hsotg =3D hs_ep->parent;
>   	int dir_in =3D hs_ep->dir_in;
>   	int index =3D hs_ep->index;
> -	unsigned long flags;
>   	u32 epctrl_reg;
>   	u32 ctrl;
> -	int locked;
>  =20
>   	dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
>  =20
> @@ -4088,10 +4087,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep=
)
>  =20
>   	epctrl_reg =3D dir_in ? DIEPCTL(index) : DOEPCTL(index);
>  =20
> -	locked =3D spin_is_locked(&hsotg->lock);
> -	if (!locked)
> -		spin_lock_irqsave(&hsotg->lock, flags);
> -
>   	ctrl =3D dwc2_readl(hsotg, epctrl_reg);
>  =20
>   	if (ctrl & DXEPCTL_EPENA)
> @@ -4114,12 +4109,23 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *e=
p)
>   	hs_ep->fifo_index =3D 0;
>   	hs_ep->fifo_size =3D 0;
>  =20
> -	if (!locked)
> -		spin_unlock_irqrestore(&hsotg->lock, flags);
> -
>   	return 0;
>   }
>  =20
> +static int dwc2_hsotg_ep_disable_lock(struct usb_ep *ep)
> +{
> +	struct dwc2_hsotg_ep *hs_ep =3D our_ep(ep);
> +	struct dwc2_hsotg *hsotg =3D hs_ep->parent;
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&hsotg->lock, flags);
> +	ret =3D dwc2_hsotg_ep_disable(ep);
> +	spin_unlock_irqrestore(&hsotg->lock, flags);
> +
> +	return ret;
> +}
> +
>   /**
>    * on_list - check request is on the given endpoint
>    * @ep: The endpoint to check.
> @@ -4267,7 +4273,7 @@ static int dwc2_hsotg_ep_sethalt_lock(struct usb_ep=
 *ep, int value)
>  =20
>   static const struct usb_ep_ops dwc2_hsotg_ep_ops =3D {
>   	.enable		=3D dwc2_hsotg_ep_enable,
> -	.disable	=3D dwc2_hsotg_ep_disable,
> +	.disable	=3D dwc2_hsotg_ep_disable_lock,
>   	.alloc_request	=3D dwc2_hsotg_ep_alloc_request,
>   	.free_request	=3D dwc2_hsotg_ep_free_request,
>   	.queue		=3D dwc2_hsotg_ep_queue_lock,
> @@ -4407,9 +4413,9 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *g=
adget)
>   	/* all endpoints should be shutdown */
>   	for (ep =3D 1; ep < hsotg->num_of_eps; ep++) {
>   		if (hsotg->eps_in[ep])
> -			dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
>   		if (hsotg->eps_out[ep])
> -			dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> +			dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
>   	}
>  =20
>   	spin_lock_irqsave(&hsotg->lock, flags);
> @@ -4857,9 +4863,9 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
>  =20
>   		for (ep =3D 0; ep < hsotg->num_of_eps; ep++) {
>   			if (hsotg->eps_in[ep])
> -				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> +				dwc2_hsotg_ep_disable_lock(&hsotg->eps_in[ep]->ep);
>   			if (hsotg->eps_out[ep])
> -				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> +				dwc2_hsotg_ep_disable_lock(&hsotg->eps_out[ep]->ep);
>   		}
>   	}
>  =20
>=20

Your code doesn't take care about fifo_map warnings from=20
dwc2_hsotg_init_fifo() function. Before calling dwc2_hsotg_init_fifo()=20
from dwc2_hsotg_core_init_disconnected() function all Ep's should=20
disabled and fifo bitmap should be cleared.


Thanks,
Minas
