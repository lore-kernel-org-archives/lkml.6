Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1402221-1520248082-2-15114412000039516823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520248081; b=j7WT1xyzBECRRBYylb6aO47PuNvLpqw1EDF9jqSrYL0qIs+
    46QTagYQ4Lx4c/VoiNzITjdTcYks1jRS5B/PzYYEFrVxpXCazSpom4HKMWGiAC1E
    +6WCV6wuCo/dkxzCSpAeigZ5IO0qtS4IIh8q/o/s/Oe7TNJj54KNydaN5AaY0Mia
    88zWvRK4DhS4n6r6+vy6QqyHJz4JMBMnVTpGratKPWMSp3KQViuFh6lpeYc+47lL
    JsIMnMiMcFCIUnDoiWDUn9sFg8MODerRXC4SK6ErU/zdhgEmxlqX2++f4FjCqqH9
    haZdUInRqQTy/sklIhZD6gxJf2jOwJk9CGBfdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520248081; bh=b/tZA13D2Od9oXV0ydZpIXUhCuPwGyQ5MRNy8o
    GpWSM=; b=WKOQzz253Q4/u7+UMcUoLiCeJQi+lhIYaKJQXAG+HAkcdVR0yFYQPj
    ACKej6gz255zQufmN3iu0foCy29zO6EbEvJGbikOq23ZnmexNbjgG882sTy3Le0X
    uH4GbV+7n+QY1a9uVu8akBE10bQPNfzeXbMdHk4EyDpyXIAkOhGXQwTXb6nfdQ3s
    KNNuI9/Z0lBY21no0WvjGjdezojSJW8qpFcqs36zvxp3OLW+FTKtSu9cTQaSHbm7
    qLKFHsaE+XqRBYEvRapG8BbBxw8ie/k+L1U7Jhke498BZjj5ZHEmovInoiEwfpQM
    5AqlgRlkITmTSyp+6i/8ngjE+c6mBHGg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933032AbeCELHq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 06:07:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:57483 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752630AbeCELHq (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Mar 2018 06:07:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="asc'?scan'208";a="205569076"
From: Felipe Balbi <balbi@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>, Roger Quadros <rogerq@ti.com>
Cc: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com> <87po4i3o1v.fsf@linux.intel.com> <a907787a-dea2-5f15-3d25-693680a42b71@ti.com> <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com>
Date: Mon, 05 Mar 2018 13:06:49 +0200
Message-ID: <87k1uq3ho6.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>>> Roger Quadros <rogerq@ti.com> writes:
>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>> In the following test we get stuck by sleeping forever in _dwc3_set_=
mode()
>>>>>> after which dual-role switching doesn't work.
>>>>>>
>>>>>> On dra7-evm's dual-role port,
>>>>>> - Load g_zero gadget driver and enumerate to host
>>>>>> - suspend to mem
>>>>>> - disconnect USB cable to host and connect otg cable with Pen drive =
in it.
>>>>>> - resume system
>>>>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>>>>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>>>>>    dwc3_gadget_stop()->wait_event_lock_irq()
>>>>>>
>>>>>> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
>>>>>> so we don't wait in dwc3_gadget_stop().
>>>>>>
>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>> ---
>>>>>>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>>>>>>  1 file changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>> index 2bda4eb..0a360da 100644
>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>>>>>
>>>>>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>>>>>  {
>>>>>> +  int epnum;
>>>>>> +  unsigned long flags;
>>>>>> +
>>>>>> +  spin_lock_irqsave(&dwc->lock, flags);
>>>>>> +  for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>>>>> +          struct dwc3_ep  *dep =3D dwc->eps[epnum];
>>>>>> +
>>>>>> +          if (!dep)
>>>>>> +                  continue;
>>>>>> +
>>>>>> +          dep->flags &=3D ~DWC3_EP_END_TRANSFER_PENDING;
>>>>>> +  }
>>>>>> +  spin_unlock_irqrestore(&dwc->lock, flags);
>>>>>> +
>>>>>>    usb_del_gadget_udc(&dwc->gadget);
>>>>>>    dwc3_gadget_free_endpoints(dwc);
>>>>>
>>>>> free endpoints is a better place for this. It's already going to free
>>>>> the memory anyway. Might as well clear all flags to 0 there.
>>>>>
>>>>
>>>> But it won't solve the deadlock issue. Since dwc3_gadget_free_endpoint=
s()
>>>> is called after usb_del_gadget_udc() and the deadlock happens when
>>>>
>>>> usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lock_=
irq()
>>>>
>>>> and DWC3_EP_END_TRANSFER_PENDING flag is set.
>>>
>>> indeed. Iterating twice over the entire endpoint list seems
>>> wasteful. Perhaps we just shouldn't wait when removing the UDC since
>>> that's essentially what this patch will do, right? If you clear the flag
>>> before calling ->udc_stop(), this means the loop in dwc3_gadget_stop()
>>> will do nothing. Might as well remove it.
>>>
>>
>> This means that we will never wait for DWC3_EP_END_TRANSFER_PENDING to c=
lear
>> in dwc3_gadget_stop() like we used to. This is perfectly fine, right?
>>
>> It makes sense to me as dwc3_gadget_stop() calls __dwc3_gadget_stop() wh=
ich
>> masks all interrupts and nobody will ever clear that flag if it was set.
>
> I don't think so. It can not mask the endpoint events, please check
> the events which will be masked in DEVTEN register. The reason why we
> should wait for DWC3_EP_END_TRANSFER_PENDING to clear is that,
> sometimes the DWC3_DEPEVT_EPCMDCMPLT event will be triggered later
> than 100us, but now we may have freed the gadget irq which will cause
> crash.

We could mask command complete events as soon as ->udc_stop() is called,
right? Hmm, actually, __dwc3_gadget_stop() already clears DEVTEN
completely.

/me goes check databook

At least on revision 2.60a of the databook, bit 10 is reserved. I wonder
if that's the start of all the problems. Anybody has access to older and
newer databook revisions so we can cross-check?

best

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqdJMkACgkQzL64meEa
mQbkPg/+IhyiI6ECRdaEt3iUxDVi/gMvAzLcPUN9kIkjp5l2hJAnvZiP4aIX4uMd
7nMEKl4KYylWCoC0e7G4vmfZHQNOZTaVNFxfvRDVGztav89usonDFr+fVgyJOAut
lZmX804V8mpgFiDBOVhjkvfLPn2zf/D/keM9Pj3qIkGwm1X2lCJDdoVcaBOpFOXL
TiKdc0+Rd6g4PaZBuHdMuUDqJovt/In74PxED3hIUfPgp7AAAUcaOUuvYWi57WjK
0FInYno08gf1H/dnSM665AgxRH4OPhL4APw/MGcu12TY9aSNLJ+ddY9AL3jPiZKa
QyCUmdT16vzUXrDHz3HWG5Fdn4K2PrS6MwzJsBEX9esKV5oUaOm702FcS6MTJCqB
o7hJiSZFNTZOtCKhE0I5Yy8Qdm6iIcyN1ezYoun6lU3rokFkpp4trmWVivyhpv8T
0gIRoKMzsh7MHA/rxsODVGUyXZjIg7V7sDqfK/wRgrKElrOKp+tmFJ6ufkgk/tJ8
OJra1gypcV3M+sUfkSrbkAsL6RoMhD7gHl9BLpJMUDrTV5JYz9NeDIdxaX1XYh2X
IAtYLnuCNbxV2/dvLJg1skjOhFsTr6RchaszvzkqAOA44WSp9CN0zPGhhb08OWgL
lx5HPdLm7l8MbC+bZDeKw55J+rG8I5EjZxHGd8UhKKWPz3S5sew=
=OGZF
-----END PGP SIGNATURE-----
--=-=-=--
