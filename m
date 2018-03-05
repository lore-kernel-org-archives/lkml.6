Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431414-1520249316-2-2253035667805150283
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
    t=1520249316; b=WSOdrNRxtoRdFq/o1zRfAk69jywtuQs1ZyDQCJSOaKx3NNV
    jlsKclepjYMZ5pEQvZadXYH6D+/ksySBDwKMLSIARoz6Icp70xw7F3ZP1vdvZC1z
    gBOYfE05XCyqq8bWudrEoOtJgK9uzqN2WGs2wl5AoescWg/wWJkOPPJihWwti8co
    k7hv3XY0U9yRTcXfGNwZx3IwgNo6wMwxhjCAB9UQUNNVBi/K5ZDCIuA35brv6c0t
    sz8wc68O+5QHaYFD0Y+ISwC4wZsdJorGuWd4oLSUWSb8XH2CnziX1wbL0gbK2NW3
    ky92tJXnyo35jokmCSnE7EIcK5iLcP/GAOjz7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520249316; bh=qO3RpOR/anNa9WFqqMIgiTjquXPoNFOYgStfHk
    zGuNc=; b=BIAxXG/JRpQEaQwZyhnbOFEPPfJJ3yDV0AuokPvQwSBreAsqsg2Esy
    vvyV5jnSpw6Er/1emM4mNK6N5VDx38NOdDyha3XinlYpXeFh8p97MX+QCEhZ1Xus
    j1FGTXdD/xR7c/WESPMKoFpl6hKPciOUzaG6gDOPBMvGxZIk0zJfm+IjnOe1MjuF
    clP8hd/jtcX9ZzHngNT7qYz7ZoFQiowdVOlG7PgP+wK6YrpcH+aLHxItwNK3dxEl
    6sl3Aa56BnsopAA8U2H/wyPvIN0ZWotspRgbMxsoOe3wA43pr6JcdEh5j5i/61nK
    DOAFw3BpXwJkLpZNIDalqtppZwCIqOfg==
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
        id S933587AbeCEL2X (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 06:28:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:5165 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933439AbeCEL2X (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Mar 2018 06:28:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="asc'?scan'208";a="34695027"
From: Felipe Balbi <balbi@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>, Roger Quadros <rogerq@ti.com>
Cc: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com> <87po4i3o1v.fsf@linux.intel.com> <a907787a-dea2-5f15-3d25-693680a42b71@ti.com> <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com> <87k1uq3ho6.fsf@linux.intel.com> <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com> <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com>
Date: Mon, 05 Mar 2018 13:27:26 +0200
Message-ID: <87h8puwyn5.fsf@linux.intel.com>
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
>>>>>>>>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>>>>>>>>  {
>>>>>>>>> +  int epnum;
>>>>>>>>> +  unsigned long flags;
>>>>>>>>> +
>>>>>>>>> +  spin_lock_irqsave(&dwc->lock, flags);
>>>>>>>>> +  for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>>>>>>>> +          struct dwc3_ep  *dep =3D dwc->eps[epnum];
>>>>>>>>> +
>>>>>>>>> +          if (!dep)
>>>>>>>>> +                  continue;
>>>>>>>>> +
>>>>>>>>> +          dep->flags &=3D ~DWC3_EP_END_TRANSFER_PENDING;
>>>>>>>>> +  }
>>>>>>>>> +  spin_unlock_irqrestore(&dwc->lock, flags);
>>>>>>>>> +
>>>>>>>>>    usb_del_gadget_udc(&dwc->gadget);
>>>>>>>>>    dwc3_gadget_free_endpoints(dwc);
>>>>>>>>
>>>>>>>> free endpoints is a better place for this. It's already going to f=
ree
>>>>>>>> the memory anyway. Might as well clear all flags to 0 there.
>>>>>>>>
>>>>>>>
>>>>>>> But it won't solve the deadlock issue. Since dwc3_gadget_free_endpo=
ints()
>>>>>>> is called after usb_del_gadget_udc() and the deadlock happens when
>>>>>>>
>>>>>>> usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lo=
ck_irq()
>>>>>>>
>>>>>>> and DWC3_EP_END_TRANSFER_PENDING flag is set.
>>>>>>
>>>>>> indeed. Iterating twice over the entire endpoint list seems
>>>>>> wasteful. Perhaps we just shouldn't wait when removing the UDC since
>>>>>> that's essentially what this patch will do, right? If you clear the =
flag
>>>>>> before calling ->udc_stop(), this means the loop in dwc3_gadget_stop=
()
>>>>>> will do nothing. Might as well remove it.
>>>>>>
>>>>>
>>>>> This means that we will never wait for DWC3_EP_END_TRANSFER_PENDING t=
o clear
>>>>> in dwc3_gadget_stop() like we used to. This is perfectly fine, right?
>>>>>
>>>>> It makes sense to me as dwc3_gadget_stop() calls __dwc3_gadget_stop()=
 which
>>>>> masks all interrupts and nobody will ever clear that flag if it was s=
et.
>>>>
>>>> I don't think so. It can not mask the endpoint events, please check
>>>> the events which will be masked in DEVTEN register. The reason why we
>>>> should wait for DWC3_EP_END_TRANSFER_PENDING to clear is that,
>>>> sometimes the DWC3_DEPEVT_EPCMDCMPLT event will be triggered later
>>>> than 100us, but now we may have freed the gadget irq which will cause
>>>> crash.
>>>
>>> We could mask command complete events as soon as ->udc_stop() is called,
>>> right? Hmm, actually, __dwc3_gadget_stop() already clears DEVTEN
>>> completely.
>>
>> But which bit in DEVTEN says Endpoint events are disabled?
>
> When we set up the DWC3_DEPCMD_ENDTRANSFER command in
> dwc3_stop_active_transfer(), we can do not set DWC3_DEPCMD_CMDIOC,
> then there will no endpoint command complete interrupts I think.
>
> cmd |=3D DWC3_DEPCMD_CMDIOC;

I remember some part of the databook mandating CMDIOC to be set. We
could test it out without and see if anything blows up. I would,
however, require a lengthy comment explaining that we're deviating from
databook revision x.yya, section foobar because $reasons. :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqdKZ4ACgkQzL64meEa
mQYUMQ/7BWM2yEv+HZ4zQ0HmbWeYiBsoCtwk9jpkaBy/a/2k0cW99l6xMwRSvQlK
LUkghq+MbWtn0naRHBpI69kQ1QmIr81rowSBIKr+imAoc4lZQQgnZl0VnXh+OsuB
+I56uCKhitmrzF16KBgOy0G8P1bmi8NJmmImyHOy4IFQxQeRMP5X1ETFf10+Ft/s
94irRnGDpyNevg35wW/IVMtJH/jhvy2RZyjp0NICZQLzBMhumjQ8N2Prc+jecPHJ
KUpCA/Nh9ByQG5CZgJ0Taioc2E+o30NEvBMEl4698HWmPa54bAyHI9sy5/1pc8kb
y9j7s3hBDPoyFEqxnM74no+y8cslI9BcMNpDxy5dItizU2vhSPAQ33fj7e3SFyPg
fkhr12VJGKKnPgTc3T5i2Ckc/Jbh9mVC7vYPmHw7ADyLfRBBSVQk830Duvux575r
5FDCjNIXdNvwYpGcxV2eSoB1zhW6xhTwENFppyll3TZeiArFj8RS8YNFiqVvORaj
V1NmLI7pAVZ2ajxODG4evtBrRLWGqvMGknysIkkCQipmpw7kH7dHVv43jS1LFbWe
Mob9B9Lydpxw3WDoQIZ/Q58J9qxEJBZ9BAbGoNN6CtZrtXGPIGVeBktf7+Q4AC9z
tDg4to33j/5qJDPbA35YEur9wHWKDDdKP/isW7VaFKW9IVDShZ8=
=HMBs
-----END PGP SIGNATURE-----
--=-=-=--
