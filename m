Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3786749-1519804466-2-794181420343587558
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
    t=1519804466; b=tuu57oEnvA6k6agNfBSSqaJUMTL/ctHszuC64QLwlhUxBEV
    vnrAMBc332JUYRKsFEMnVmcCT9YFtUJ+4CS5utHt4zHVwP3CHUn6fa7Y8nkz2Bbm
    Qii97MWL13ThOjmCiydfmc/PtKwThxpc7cb+f/ITZCzp3ekOc1qT/Xgi7tXCzpG2
    E28XQQ1AJokGHEhJh0516Z7PrYp92EEu6o2tcHiNiX2OR91740OJiS0JiW4J5Xa3
    7WMWdEX8GA8Y4EE6fdH2UiHxLsHDPsvGoPbqCHg0Sf0cWRqsYzJ7KtbF+YYMs+LZ
    dx1+K98viPvSjiX+LYhrD3hRo0PHisoXFguGo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1519804466; bh=RrIx3V56Jq/K/w9RAO8R3nKDhspvWGs96Qe68A
    XiYXk=; b=MQRqOt9PrAd/DHjjQnY2oJPTUntSvItNdgroix0E/uqhLPsQq5s6Gq
    RghmNvJHuwBVlzK5QIIsssj3MSYBK6i52zOMliy0isOiCt2LeIBVDKMua/AjraQD
    a1LFTv+r5G8MJwmUap786P5Gm4RLYnLAqKpJ9ktdhEDjuI1u8/Z+3nO2sHlZxCww
    EYm2f7c9QkFmJYkbctm66E/8kA5Ty3x5SzKJ+Qq5Q5XEkOGiG76tmtN20XBNbQkW
    PAxR9TzbO+OYGhzle5963t5OK2hEcLmHLkuYSyhJTPN1x9XeLmx7DWViWbM9QJUr
    O/ClN9s+D8cfuKcC8plsaeKjLLwwKxZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeB1HyN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 02:54:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:31978 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbeB1HyM (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 28 Feb 2018 02:54:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,404,1515484800";
   d="asc'?scan'208";a="31240030"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <1519730526-22274-1-git-send-email-rogerq@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
Date: Wed, 28 Feb 2018 09:53:14 +0200
Message-ID: <87sh9l5z4l.fsf@linux.intel.com>
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
> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
> after which dual-role switching doesn't work.
>
> On dra7-evm's dual-role port,
> - Load g_zero gadget driver and enumerate to host
> - suspend to mem
> - disconnect USB cable to host and connect otg cable with Pen drive in it.
> - resume system
> - we sleep indefinitely in _dwc3_set_mode due to.
>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
> 	dwc3_gadget_stop()->wait_event_lock_irq()
>
> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
> so we don't wait in dwc3_gadget_stop().
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2bda4eb..0a360da 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>=20=20
>  void dwc3_gadget_exit(struct dwc3 *dwc)
>  {
> +	int epnum;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dwc->lock, flags);
> +	for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
> +		struct dwc3_ep  *dep =3D dwc->eps[epnum];
> +
> +		if (!dep)
> +			continue;
> +
> +		dep->flags &=3D ~DWC3_EP_END_TRANSFER_PENDING;
> +	}
> +	spin_unlock_irqrestore(&dwc->lock, flags);
> +
>  	usb_del_gadget_udc(&dwc->gadget);
>  	dwc3_gadget_free_endpoints(dwc);

free endpoints is a better place for this. It's already going to free
the memory anyway. Might as well clear all flags to 0 there.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqWX+wACgkQzL64meEa
mQYeVg/+Opmu5Cay5iySvIF9sIqB5JysXwVH+YufTmHZG9Kyj260D0ap0qY7ZWmc
XeEZiQpaKc0BEozJfOf8hzgPwtjj4CIRt8Soz3jrkbSEVm35odoZWJ0DO4VMMx23
Fx3bmD1ZYlVzBVydeZMdn/LXQyz0pRFmeZivlY/c6npmR0V1t5SA1IzuNzbl5Ms+
i/8nmw9zKrsB4jrc8F1DEeEhTgky63mDxnOgDiQH8/vBn0QPoEhW3E45KvNeePlL
Wxck+3TEJ7rxvfmPo4e6RhaJ9+fEiNx9FhZ/8JkdVgLO70IUD6OLTOxng7A869tN
bLaAMvLld8aytY8IIoxTky+t0StMParTLjUnUaXaDvTIHWizpDHAcrOTTjj9yXDk
7mNKkFEN2OuZ6OTZ+qca7M30SPCZrsLLe9iHQvgKviWYqPDfpVLGOI8Fl2ePN4qu
qxAUu2ZXClysGeg9UEO62u4H1WSldESHrT5L4189NHsjpQu+ewJTHdV9sn4TarII
TbdUTwfusSpjpSumVdEBuDxtfPwgi3QHQRtxBoGHujC5HNoWSpn/yoH3AMlU2Aqm
OGDdyXVsmeI8WGclyfo/tNkNRi0vo14g8QQ7Wk8CVUGYxnRLBTXvDSsahU0l5B/f
VPBR3Y15aMOLv24ZXUBKq30vYKH+V+tYb5cn1V8TZ96teOyL4Ac=
=TRU/
-----END PGP SIGNATURE-----
--=-=-=--
