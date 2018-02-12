Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-911174-1518425745-2-9103081165143638922
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518425745; b=YHUklwekPL9i/1its0fD6l+xFxw+DV6mGs9Xa+PX/AMSi1J
    61pl6zOj2GV45m3yRV5CjArFytJdLQuSh8YshQaHPL2occmQyYeWihAge7ZYK5kc
    bgtTtWtXro/jrMC6JaDtm+ZYXXzF0dUJjHOma3EbkxYD9nPOLufYmwYL2uCd3BGS
    J9M39AJQuREG2xTjChQoL1vZL6WStxJTYb5ySVorIi0LFP2kpSemh75HQ8ifNn7i
    sc7Q5ztxLM36I+2PcbSAqKKTKY+zDIbESd2+TLzrgOc+mUGl2pv+/lW8O2ghy6aL
    LZqosAVDBhDX7Pw6JpAJLbI4v+/NkoRSZLgqskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1518425745; bh=2RjsPmiCsbxV7JvrybjvsKXRYZbT2PLaCZ1jW0
    +InPk=; b=YJPsBF2OTcF9e3KfmsK/JDz48y8tmXPmKQuNBEvHNg6sJ2zEHo6+l6
    DVYLL/YNbRLqabgz0OO7GQoEoshUAGWifCexptkzPeMsFOY76z8kbY9DZHDzxp0l
    GNzSc+UYnXWWX9cdcKEIBHjbY/on/R2MgU0wQqONVbm6OnPQ7/E5BhBR0p9j+e1Y
    WsN6/2/738R+hBhoTi57fb1Jy/J1J0JE3tGCaD+4MfMY3vCscXS2cMdTU9561BzO
    yMwjZIhbK27DJSxb7lO+pt/gmImeoImmQDz9r9q7i0nLqfdGPHR6XZDCm29E7aq6
    F1aaNo5G+GexxG0/YA0nF7oPJZMVcuYQ==
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
        id S932794AbeBLIz0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 03:55:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:16977 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932723AbeBLIzY (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Feb 2018 03:55:24 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="asc'?scan'208";a="30705563"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] usb: dwc3: drd: Fix lock-up on ID change during system suspend/resume
In-Reply-To: <1516626103-1969-3-git-send-email-rogerq@ti.com>
References: <1516626103-1969-1-git-send-email-rogerq@ti.com> <1516626103-1969-3-git-send-email-rogerq@ti.com>
Date: Mon, 12 Feb 2018 10:54:56 +0200
Message-ID: <87y3jya8pr.fsf@linux.intel.com>
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
> Adding/removing host/gadget controller before .pm_complete()
> causes a lock-up. Let's prevent any dual-role state change
> between .pm_prepare() and .pm_complete() to fix this.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/dwc3/core.c | 31 +++++++++++++++++++++++++++++++
>  drivers/usb/dwc3/core.h |  5 +++++
>  drivers/usb/dwc3/drd.c  | 10 ++++++----
>  3 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 42379cc..85388dd 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1414,6 +1414,33 @@ static int dwc3_runtime_idle(struct device *dev)
>  #endif /* CONFIG_PM */
>=20=20
>  #ifdef CONFIG_PM_SLEEP
> +static int dwc3_prepare(struct device *dev)
> +{
> +	struct dwc3	*dwc =3D dev_get_drvdata(dev);
> +	unsigned long	flags;
> +
> +	if (dwc->dr_mode =3D=3D USB_DR_MODE_OTG) {
> +		spin_lock_irqsave(&dwc->lock, flags);
> +		dwc->dr_keep_role =3D true;
> +		spin_unlock_irqrestore(&dwc->lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static void dwc3_complete(struct device *dev)
> +{
> +	struct dwc3	*dwc =3D dev_get_drvdata(dev);
> +	unsigned long	flags;
> +
> +	if (dwc->dr_mode =3D=3D USB_DR_MODE_OTG) {
> +		spin_lock_irqsave(&dwc->lock, flags);
> +		dwc->dr_keep_role =3D false;
> +		spin_unlock_irqrestore(&dwc->lock, flags);
> +		dwc3_drd_update(dwc);
> +	}
> +}

wouldn't it be far easier to just disable OTG IRQ in prepare? and,
perhaps, also flush_work_sync() ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqBVmAACgkQzL64meEa
mQY2cA/+KjUpLrCBkeNKoFuescyzHEhSosP3yKh1249YklewzocBH+MGcZmwYQai
5wHp5TsZUKrG2JEVYVTYbqkWWKMRHnguQ0BzeTfs55wZ+nHfqgjB7S0WEdoIJxOa
R7MjlKrPmQ3TZZaobgQIdS8s+N4q5UdzfkwQKDowXPe3TnqxjXjXwpt8Rv6Y1M0N
q0yz30pk6ozZQ+66NWMq5lm9BjV/SjQGKWmqUtP+AW5xBtgj4WZ8DrvhBkKYq3jT
1/KCHRwcDp3P7ei9RLCN11UfnG55R2Wg4z0Ue/ItIqm0eNrlOt6M3a0QGH1ZQTdE
I2etrQNM8PCIdpj+C983HGLCAcHjrQ3zwD+bwsFTYZPC1yRQmnBEBwSGJUeSPaKc
idQPfYij7AFOg006ogIo7iClc9lS0azdo/7WlF+vvqZIekivcD2h97f9pfcl0Vfn
3lbnBSH8ngRH1+1KZoTXmPQik9DNZjA2aaA95LIVA7OKsjrzJreNNuBBMGVaYQRB
wTkyQNX32LDj5lq1sdHz2oAdu1vUQdkQizWYiNyhJZVD4l0gK/0qJgPGJfZfc6Lv
129LOKchp/xqF5ci+LK4meNXN+r9ctYi5FTBluRomkRrEvErQwZ09lH/RHxI5sdz
KZX6FEbBXAXWdzY49fIW1d/Aavpxd22vjCykS5nqWL5LF9kQY1A=
=ad64
-----END PGP SIGNATURE-----
--=-=-=--
