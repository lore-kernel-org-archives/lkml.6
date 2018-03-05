Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431414-1520249201-2-9349719961617578991
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
    t=1520249200; b=FhC/5vbtq/g1f6Tp6L+PmjwIOY5k3eu7R9MV97OWEt12Ayj
    d4kqlq0ItAlLEmq/eatL6Rt6P/XqPfeolgC9IHl1tIhTVBUbc6qIuLxv+sgmD9Bt
    MU5UcY6oPCugNwyalQzgtF8L5A1eXkemEDeryU+AoF4SbRR8WUZ3DoeP195EyGN6
    ew1WmZSHkJelW2uJjX/RKjsuCkFAmrEga8p/MuekfhAVkVFl30n3dWFPROcyOldW
    qIhuBFxUioEyAQSQorHjVCyioTlvK8sTPFpIgwTa2tp9r5zverTnTfrl/X+wkPpf
    z/D8bbZQ1JNtPKxquI/8I6FKTTVpo+X3QzDmErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520249200; bh=QaZfKGufEWpEHI72PeholPABbypdM44Cp08TQ3
    zmqAo=; b=IMYDZoN0Wh8R1twWI2OHKukCzjt+rv6KR9ebjc/+XrE6B3Os3W3khy
    dovSl9XNVvXdPQFzQSF+Z7tktpMzpNYrRNXXkd+yUgILpA1n4BPKsXq+IEoTS9sW
    O1C8BT9IhLWVI9LO3hk8KYopectStksiGEsxDPJ5vSz7pl3/nqZtEjxX7ZKtSfGt
    CIn3JHtNJLrnaXNr1IrkVYAoGauIw+WjJPFjxfRE7QjCBNgTvlxeddqojomg9G9d
    xw31nrdtrcTaTbZLjYJnzPjnn8tpQjefkPCqpKJhEfFXJ7oQNY0j1xQfkTiAFioL
    BwnxxdK+bEYoZyGCHveJBbjf9HPRG2VA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S932864AbeCEL0f (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 06:26:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:2481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932797AbeCEL0e (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Mar 2018 06:26:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="asc'?scan'208";a="34694707"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        John Youn <John.Youn@synopsys.com>
Cc: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com> <87po4i3o1v.fsf@linux.intel.com> <a907787a-dea2-5f15-3d25-693680a42b71@ti.com> <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com> <87k1uq3ho6.fsf@linux.intel.com> <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com>
Date: Mon, 05 Mar 2018 13:25:36 +0200
Message-ID: <87k1uqwyq7.fsf@linux.intel.com>
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

Roger Quadros <rogerq@ti.com> writes:
> On 05/03/18 13:06, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>>>> In the following test we get stuck by sleeping forever in _dwc3_se=
t_mode()
>>>>>>>> after which dual-role switching doesn't work.
>>>>>>>>
>>>>>>>> On dra7-evm's dual-role port,
>>>>>>>> - Load g_zero gadget driver and enumerate to host
>>>>>>>> - suspend to mem
>>>>>>>> - disconnect USB cable to host and connect otg cable with Pen driv=
e in it.
>>>>>>>> - resume system
>>>>>>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>>>>>>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>>>>>>>    dwc3_gadget_stop()->wait_event_lock_irq()
>>>>>>>>
>>>>>>>> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
>>>>>>>> so we don't wait in dwc3_gadget_stop().
>>>>>>>>
>>>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>>>> ---
>>>>>>>>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>>>>>>>>  1 file changed, 14 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>>>> index 2bda4eb..0a360da 100644
>>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>>> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>>>>>>>
>>>>>>>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>>>>>>>  {
>>>>>>>> +  int epnum;
>>>>>>>> +  unsigned long flags;
>>>>>>>> +
>>>>>>>> +  spin_lock_irqsave(&dwc->lock, flags);
>>>>>>>> +  for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>>>>>>> +          struct dwc3_ep  *dep =3D dwc->eps[epnum];
>>>>>>>> +
>>>>>>>> +          if (!dep)
>>>>>>>> +                  continue;
>>>>>>>> +
>>>>>>>> +          dep->flags &=3D ~DWC3_EP_END_TRANSFER_PENDING;
>>>>>>>> +  }
>>>>>>>> +  spin_unlock_irqrestore(&dwc->lock, flags);
>>>>>>>> +
>>>>>>>>    usb_del_gadget_udc(&dwc->gadget);
>>>>>>>>    dwc3_gadget_free_endpoints(dwc);
>>>>>>>
>>>>>>> free endpoints is a better place for this. It's already going to fr=
ee
>>>>>>> the memory anyway. Might as well clear all flags to 0 there.
>>>>>>>
>>>>>>
>>>>>> But it won't solve the deadlock issue. Since dwc3_gadget_free_endpoi=
nts()
>>>>>> is called after usb_del_gadget_udc() and the deadlock happens when
>>>>>>
>>>>>> usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_loc=
k_irq()
>>>>>>
>>>>>> and DWC3_EP_END_TRANSFER_PENDING flag is set.
>>>>>
>>>>> indeed. Iterating twice over the entire endpoint list seems
>>>>> wasteful. Perhaps we just shouldn't wait when removing the UDC since
>>>>> that's essentially what this patch will do, right? If you clear the f=
lag
>>>>> before calling ->udc_stop(), this means the loop in dwc3_gadget_stop()
>>>>> will do nothing. Might as well remove it.
>>>>>
>>>>
>>>> This means that we will never wait for DWC3_EP_END_TRANSFER_PENDING to=
 clear
>>>> in dwc3_gadget_stop() like we used to. This is perfectly fine, right?
>>>>
>>>> It makes sense to me as dwc3_gadget_stop() calls __dwc3_gadget_stop() =
which
>>>> masks all interrupts and nobody will ever clear that flag if it was se=
t.
>>>
>>> I don't think so. It can not mask the endpoint events, please check
>>> the events which will be masked in DEVTEN register. The reason why we
>>> should wait for DWC3_EP_END_TRANSFER_PENDING to clear is that,
>>> sometimes the DWC3_DEPEVT_EPCMDCMPLT event will be triggered later
>>> than 100us, but now we may have freed the gadget irq which will cause
>>> crash.
>>=20
>> We could mask command complete events as soon as ->udc_stop() is called,
>> right? Hmm, actually, __dwc3_gadget_stop() already clears DEVTEN
>> completely.
>
> But which bit in DEVTEN says Endpoint events are disabled?
>
>>=20
>> /me goes check databook
>>=20
>> At least on revision 2.60a of the databook, bit 10 is reserved. I wonder
>> if that's the start of all the problems. Anybody has access to older and
>> newer databook revisions so we can cross-check?
>>=20
>
> I can access v2.40 and v3.10 books.
>
> bit 10 is reserved on both
>
> Differences in v2.4 vs v3.10 are:
>
> bit 8	reserved	vs	L1SUSPEN
> bit 13	reserved	vs	StopOnDisconnectEn
> bit 14	reserved	vs	L1WKUPEVTEN

odd, at some point we lost command complete interrupt :-(

That line exists since first commit (see below), so that would mean it
existed in 1.73a (the revision the original was written against), but
vanished on 2.40a. Perhaps 2.00a still had it.

Hey John, do you know, off the top of your head, when we lost DEVTEN[10]
as mask/unmask bit for EP Command Completion IRQs?


commit 72246da40f3719af3bfd104a2365b32537c27d83
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Aug 19 18:10:58 2011 +0300

    usb: Introduce DesignWare USB3 DRD Driver

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqdKTAACgkQzL64meEa
mQYJhhAAiQsN3snKihl8xB8ZMi7OGxwt0PTz/r8xSsjabyxl4HBw1++Z4Wd4VLIz
FWGMpx8KLqljmCybFOWQ9jq7P3hMH1mzAvio6n378oR5vHKv00FOe/ftFwNQRIrv
mAJ0BevKg/Afz60atVbu76fQyY55/iHTLY2Edq1ZUUQt9AZq60P4ZF3XBI/dmYJ6
oS5C3GVuVOh8L4H7WW7Ssl5zjuWV19L9jz8+gZ4S0kbwwb8GEyxYgfg20tuTwULZ
sLWU3IukER+15y/iJt95evVMo87ibr9hPGIjDPG+EzmezLZ+gqyn6O7v64H2Wipw
1OQ5j05Zms4Bt/vVDYoHUduD20MOeNLOLeujnaQSFTguAym79ZZB92c75gRSH94h
HrrNIAwBEuc9XjcNGeZh7YLCeyIji78pHE+mQXEEHdSt0gKnUHLrXqo7hGdCE2me
IuN2kP7QOnyYGUcRQnvhOMwdKtQiHt8SXKSgFRGSZWcpl7KeymH+R7JtF8P8fozM
dZDPoLTAUjU1x/wfaCEavRcPSXSWp4jfPBf3azzlr7eFoN8oyaZNhrV3Ta/m/mVX
nB72kFDfplLzMOcmoMbq6LZml/5wzy8BrAc6Qiv+5IJtuxCo254JpcaAWP5Y+uLj
GUTuv/AJh9etfkY9q5mehiiXoDDAsijUrTP0W8E8+xH3J5aN7nc=
=gb26
-----END PGP SIGNATURE-----
--=-=-=--
