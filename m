Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1083309-1520239815-2-6397943670127512633
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
    t=1520239815; b=Fks4Xcme4wS5SM4ULdZZw27CuKxrGewAuDBtg+Dmm7jH4QF
    aVgoo4rxrGPkT63KZoK/VIPsPupgfkPss8f/N4nNCrrZwGlRrEE8BRyst9iAYO7e
    laDz3j+SURQ29uhvskEKFu8FaxNeEDE7mfjZYiL2nBfCDDjTX0S1sMyR+IxnGh7z
    7K+eFjsIeMUwhHzH/bXmiUSYxBYlDw02qBxnmjWOyXdqgue57V4z5bTm4WGUwaeq
    g+qF2ptqllho6dyRJTw1rUFFmbnYDVgsvoocMWYyUCz2GEA4a+dl9R41pmsQFtC+
    grRWGWLX8bRkLIMSHpkwXlqDCi8lS0fFuLczqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520239815; bh=oj1Xv47fHkGDOjNCYjBpjgCDMjvU6B9oe3ril1
    w8wrw=; b=XTHLImYY5PBmGQAWk2/2dekjX/cddc/2uwv2eRfN10jqfOojtBMJft
    +QQlW7+EQy6Ng0HRkXxdRX22CJFqXURKxRua0LoiXdkdv51FPHWdUmxCQzY1ZYti
    W5qxyd18bn1AatYfL9SQJZCMfzVQCgN/mslXXHB3wvR7JuL4+G7nhcySkP0kAw1y
    Q4ApqMYUOzcrp21FQkjwpT79OZUJuESZGV2HA8wBlcmx9etFTS7+zDuMT+d0CODn
    fxvD7i4Oo3d4yVMPDYIzRZ1iJnBBrq9hVdisrxLDceATEkq0WJSZXEklzGXndcml
    FBsPFT4L08tLBuE9rEoPxnMCIPZTCfag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S933396AbeCEIuA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 03:50:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:12726 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932892AbeCEIuA (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 5 Mar 2018 03:50:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="asc'?scan'208";a="205543538"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com>
Date: Mon, 05 Mar 2018 10:49:00 +0200
Message-ID: <87po4i3o1v.fsf@linux.intel.com>
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
>> Roger Quadros <rogerq@ti.com> writes:
>>> In the following test we get stuck by sleeping forever in _dwc3_set_mod=
e()
>>> after which dual-role switching doesn't work.
>>>
>>> On dra7-evm's dual-role port,
>>> - Load g_zero gadget driver and enumerate to host
>>> - suspend to mem
>>> - disconnect USB cable to host and connect otg cable with Pen drive in =
it.
>>> - resume system
>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>> 	dwc3_gadget_stop()->wait_event_lock_irq()
>>>
>>> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
>>> so we don't wait in dwc3_gadget_stop().
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 2bda4eb..0a360da 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>>=20=20
>>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>>  {
>>> +	int epnum;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&dwc->lock, flags);
>>> +	for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>> +		struct dwc3_ep  *dep =3D dwc->eps[epnum];
>>> +
>>> +		if (!dep)
>>> +			continue;
>>> +
>>> +		dep->flags &=3D ~DWC3_EP_END_TRANSFER_PENDING;
>>> +	}
>>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>>> +
>>>  	usb_del_gadget_udc(&dwc->gadget);
>>>  	dwc3_gadget_free_endpoints(dwc);
>>=20
>> free endpoints is a better place for this. It's already going to free
>> the memory anyway. Might as well clear all flags to 0 there.
>>=20
>
> But it won't solve the deadlock issue. Since dwc3_gadget_free_endpoints()
> is called after usb_del_gadget_udc() and the deadlock happens when
>
> usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lock_irq=
()
>
> and DWC3_EP_END_TRANSFER_PENDING flag is set.

indeed. Iterating twice over the entire endpoint list seems
wasteful. Perhaps we just shouldn't wait when removing the UDC since
that's essentially what this patch will do, right? If you clear the flag
before calling ->udc_stop(), this means the loop in dwc3_gadget_stop()
will do nothing. Might as well remove it.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqdBHwACgkQzL64meEa
mQbe8BAApM8ROUSrH/D3DTIV4VXCPJhFv+0N8KKQaO6iz1DIko2ptR7t+AXBakTi
ZBoZBlqNlc7WAiyhTTgvC57meUz+6QX+PaeuvvbmGld7a2H6/6hTPwpkS6lY4oR+
HPEB1RY2w1ZgboBKs2G82r1agNbgTg9FdssX2eplJbjwoRpHlVYQHP9BEWZ1nu5q
kDEcdUFdAX9BpLUaakOQfm5zuuWAeAok4evPz0gpwn16eJEfwLqgePXjUmZEO9zK
H8JUUouamr/aXfIUZcAzpOPl810g2WOFlcD9icjI+nL2N6Mpnx23iKk4hKC6u5ep
nlgC0AAzM0IyHYsVjzNq/Q0fOy02nTm2yVgkrof6lk4/DvEXdnMij1diK74gH+CK
IAJ5TLDNntACZ6DQgqJf8gwvkM1evTgG2esHJVQgQjozxbJFeP1woErajq4VZ2jg
ybyKw7Oyap59Z1ZZIGSEHmTFCrwo++jLxM82hWtRlypBUosvDuuX5NgxV6AIZ9tl
PDL6erLyBpy3aA3qT5wTh/+eD1Eq5fRJpLpZwBjubctfIts1/WepOglrLen44sEU
CnxlC5xsslbd/Dg74UdY40YC3cbNKrWVqzbmdl7rTV7hW34gN2Yc5cpM8BWsrgnj
ymlT8waELwLi3WhrLFhOlugk5MueJTzJplyaJlcX6qqH1RDiHzc=
=6U7u
-----END PGP SIGNATURE-----
--=-=-=--
