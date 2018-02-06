Return-Path: <andreas@kemnade.info>
X-Google-Smtp-Source: AH8x2242YnAP1reSqF7u0gFH+om+s3BX6qcPPP1YUWmhRHwmM/Ai9plbmTy+hc6Orb6f7e6l+uHB
ARC-Seal: i=1; a=rsa-sha256; t=1517944202; cv=none;
        d=google.com; s=arc-20160816;
        b=sVAbJMYMOD7xePWiZkFUHsCSgUMJCwcCj0dxfXBFihSSvmEGLfJPz0/xFuAPljGirW
         DmTvHeA+lkRRrgXWjxOl4h+zjAppLCcRzyL44Pi0ZszchmvYDg+5uLUaVf86hNGeDJyL
         KGNsRi0UOTZPxssAcbnY437rLSJk6pZhbi/EJwFOMlCfENgfW5aKN5WOyvyjjWxWlNma
         iv9x2W5ugWH2j0ZoxSbg9pWguU2XGuKXt/25PNt0u4xBjEE8QCOXdrt50bwsXuIYgNmd
         P3FEngHTP6JEwQP3hXXh16wJFWuYAhRxZjUewHhwUUr42MTjcYtDwOufEcXozRZ6JRGw
         5Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:arc-authentication-results;
        bh=0w5fJkx4yyREVvRotLPfpvakw5ptQYsDhYtKjw8+okc=;
        b=eVNP3tnt0zzQboqEkkgiMLO93iGdnGC3/dGVpU9nVPArY2l106uK6Q9wlQ3dIQao39
         aw9RZ6eT9ARKr+TZTAskz6P+5II8JoaOy+vP5Qnl1HnoEGVl3PQm3X/5runjucvmj5oN
         JuO8c4vBr/hHOjRIU3XsFTt8p1W7GztpJUOfAFBPXdQ9xDRo2QLpXI2120802nFvdWye
         QYn55i2TOuBYNij+MuaHyUhVdmNbse8pKAzl8uo0oTcrrYO4gyCrip8fGTfBe+BVP8OM
         0DI014pZQ4tlwHpwZJVAjIv8LKfwUzt7enxmfeHWtPAbRSAp8b3VJa0lAkoEBmtX+Ugv
         lXSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Date: Tue, 6 Feb 2018 20:09:57 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Tony Lindgren <tony@atomide.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Discussions about the Letux Kernel
 <letux-kernel@openphoenux.org>, linux-omap@vger.kernel.org
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Message-ID: <20180206200957.196ab0b3@aktux>
In-Reply-To: <20180206184725.GD21573@atomide.com>
References: <20180127083403.928-1-andreas@kemnade.info>
	<20180206184725.GD21573@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zKUm6DYXUggfst3azIH=XCO"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590733890514552620?=
X-GMAIL-MSGID: =?utf-8?q?1591679859376541766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/zKUm6DYXUggfst3azIH=XCO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 6 Feb 2018 10:47:25 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [180127 08:34]:
> > On dm3730 there are enumeration problems after resume.
> > Investigation led to the cause that the MUSB_POWER_SOFTCONN
> > bit is not set. If it was set before suspend (because it
> > was enabled via musb_pullup()), it is set in
> > musb_restore_context() so the pullup is enabled. But then
> > musb_start() is called which overwrites MUSB_POWER and
> > therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> > enabled and the device is not enumerated. =20
>=20
> I just gave this patch a quick try and things seem to behave
> for me from PM point of view:
>=20
> Tested-by: Tony Lindgren <tony@atomide.com>
>=20
> Unrelated to this patch, I also noticed that we now somehow
> higher idle power consumption initially when musb modules are
> loaded. It used to idle after that but now to get things to
> idle I had to plug and unplug a USB device once to the musb
> port.
>=20
Hmm, I have seen this effect with some earlier kernels but not with
4.15. My observation is that current consumption went down again after
a modprobe g_ether and ifconfig usb0 up

I was loading modules piece by piece and waited 10s after each and then
measured.

Regards,
Andreas

--Sig_/zKUm6DYXUggfst3azIH=XCO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp5/YUACgkQfb1qx03i
kyT2yw//REuINAuyOjtTqW4hlDdn8BYWoxeb9wj4yqlJeETdKerO2nwPHunD+B+l
mLx4IOUMaUUg4RJOEmD/hLVDTftz/cqk+xuZb3daLCldI8Oiacz3bMcwVXN81L0H
sjgQO4zcoAMG/YDZTIIr4rcjdIc86hSCu6/5gM+yhY9QrwOaVZOIQzpGXVhZ0mIZ
FBbACI8dcLpyZExPKhjVJutTRtb1THSi0pTDOWALKoRyJEd+nHguZyFsKhbHMeVg
ejXWgkjxy+CUzp8EwgH0uYfbVA7ij30SCZB+Bq8QhKgdRc2lQXchJwCwXXgguojg
Wom+hYp4r9t1jLjW+Jm+1/KjwjhfC4BrQ7VwPVs8f+SjqvVBLS1YJsMv+deVK68l
prHQbVkUyDMUGp7t7Fsg5NivvYJAWH+PVwM+R5oaXTVPpYLFsjkxBhY54dY0JeDP
N7r+k/7KomYTPi7iGH6pzDg0RIQsH5vSopt3v9DkT+T0xK6qe+4UHfUF/XUByY9P
FYAvykpd0FqO0SAbKWJ1+k65/FhvRN8hwtGwjI9ZIfCBGjDubkVuBaTrOoyNIMIC
Kib06XNZiAEOeE3yeaIhbLLraBCxmKWSkDFqYakX8paeVa7g2p8YHx0zDbwWOuW0
pvolCmuQZOhrK8ToAmy4K/6opynsMe/jlqrCUGnAguaI3IYXXio=
=T3RF
-----END PGP SIGNATURE-----

--Sig_/zKUm6DYXUggfst3azIH=XCO--
