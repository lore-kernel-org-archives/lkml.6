Return-Path: <andreas@kemnade.info>
X-Google-Smtp-Source: AH8x224WaSBXEIK0bvGQkC6YFdIDtBCasv2g8kgFVgp5LbbcQFhslTZhDrvcs5UCInSjzIJfmP9+
ARC-Seal: i=1; a=rsa-sha256; t=1518765048; cv=none;
        d=google.com; s=arc-20160816;
        b=U6UvMKiZNGQ156q33B2k2jzfrfSxmPptYTzL24UA9rvaKUOPPzrIb9Iyv66s22xEWq
         mHvV8aeG4gPtyWqsIx1QPn7IqJgVu9tdgUY15eRuP4SrHHIZDd9p669eFXQ1YKRXYyQM
         0typ8EYiBlGwOfB0Supboe/AOcWo0jx96CyYEcHG4EbMAtib2JOwBlAeceOFf6HIBnej
         clKBdTBPlbXdz4e4m2oU7ONfKP7s1eYrFDaGsJqHd13LLo2QjV217dP+ZMhxndT1odnR
         Mp/Ln5k4y11e4BAWbN5VArYyHBO37fKbcL4gZ3f1sFd8DGRSzTaSOU0euXLqN5RotMWr
         M7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:arc-authentication-results;
        bh=rxjUPlQsq/DjoXfjZUiPkm5z2OXmn4O5TwZwQOUGwpQ=;
        b=u82Jxhi+FtDg2yYqytfzp1mlbsB2BKYF0mokphpzWy4qF+vFlj26QUM60rc/BkY4ow
         Sftq/zLXLckV49lJ4QJvEc01VdbDwpTF7n/p60ufsLRvrBwauSzwuZ1Dt8sts/ewlbXc
         J+i2xkXfGNQCkAkPH1QDlGg2ONa4phaoFctEutTwyWKfpYJR+RG22PUHte1X9zi0MYQm
         wcW8uk68DSwAfDcqOunVRaSIfM7fzOCTaSPtiYMspCRxTMtAAq7uUERYUwGLMe+AQMXw
         f+OwzQ+SzsGfhzk8GlU803JmETZQ6lOFG/6Xxk/7+n8YYssLy8EZ82ueeZv7052Hcb30
         P7Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a01:238:43f3:0:615b:ee97:1f81:cbf2 is neither permitted nor denied by best guess record for domain of andreas@kemnade.info) smtp.mailfrom=andreas@kemnade.info
Date: Fri, 16 Feb 2018 08:10:19 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Bin Liu <b-liu@ti.com>
Cc: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Message-ID: <20180216081019.2358584f@aktux>
In-Reply-To: <20180207203700.GC3992@uda0271908>
References: <20180127083403.928-1-andreas@kemnade.info>
	<20180206184605.GA3992@uda0271908>
	<20180206200024.18d40735@aktux>
	<20180207203700.GC3992@uda0271908>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pldPNWCzzYBd0rP.lqF1I0/"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590733890514552620?=
X-GMAIL-MSGID: =?utf-8?q?1592540578910007199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/pldPNWCzzYBd0rP.lqF1I0/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Feb 2018 14:37:00 -0600
Bin Liu <b-liu@ti.com> wrote:

> On Tue, Feb 06, 2018 at 08:00:24PM +0100, Andreas Kemnade wrote:
> > Hi,
> >=20
> > On Tue, 6 Feb 2018 12:46:05 -0600
> > Bin Liu <b-liu@ti.com> wrote:
> >  =20
> > > Hi,
> > >=20
> > > On Sat, Jan 27, 2018 at 09:34:03AM +0100, Andreas Kemnade wrote: =20
> > > > On dm3730 there are enumeration problems after resume.
> > > > Investigation led to the cause that the MUSB_POWER_SOFTCONN
> > > > bit is not set. If it was set before suspend (because it
> > > > was enabled via musb_pullup()), it is set in
> > > > musb_restore_context() so the pullup is enabled. But then
> > > > musb_start() is called which overwrites MUSB_POWER and
> > > > therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> > > > enabled and the device is not enumerated.   =20
> > > =20
> > > Do you see the issue with the v4.15?
> > >  =20
> > Yes. Tested without other patches.=20
> > It was also there in earlier kernels but I had not had motivation enough
> > to debug. =20
>=20
> Applied to my tree. Thanks.
>=20
> > So maybe it deserves a CC: Stable =20
>=20
> I would prefer it is first tested on each stable tree.
>=20
Tested with 4.16-rc1 with and without that patch
The problem still exists and can be fixed by that patch.

Regards,
Andreas

--Sig_/pldPNWCzzYBd0rP.lqF1I0/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlqGg9sACgkQfb1qx03i
kyQTdA/+JaigXLuJVsZnMcOw1nY9j9yLZ1YdTe8LLF6urK6xszigXxEXHFkuPB96
gMcpdB2Ely/xQDGrnMp+fBIfgQ68RHEBwbeafRbKSm0bIhA4hDgi+LzgE2oi6OYo
y4UkvQ3kn8PV32pYrQV+BPgnNhM2uefgPjZ/hCCgAGmE7OmqolJBG9AhafgD4ZDf
efKxtvyJxE3kmYC4pW91Ual7SIaOm/xhFWPOHUax+hQZ1EyDqN+18jSAmT33Xrz9
arPKbjPh7BacuN3XvLnXITimUarPnQpv6ODOvLgPAwp0ckbpBhHe3mSFW3VG9OuB
0VgqW7OXRnVhL1nnKraFdUnG4MkwXQW2d2mrNwPEGIW6//+TW0iVYsB+7K19L0k3
zU7mVZBPCMCL1s53wkeKAoVdy9nuap1+cbRA43emOU/xCCrxNRxTSeqT9WVbRIYM
+EqC/vqEqwwkXNLoIK2co1LhxC7uEw7JBbOii5QH91a0I5xGTbtpwE2yGiAuuJRy
5F+FpgjGlWTk08VMrzGC+uaCxa5oEp50auOdmn3waMskMNwmJ+GT1Sd+eEqTMkLk
7vLwkM8nM+698ES0gT7N5R5OHYnMbvwYkF+ubwMwRQmRopnMgDkWGSb9+6jkMJfc
uXk38E3OhFkXxXnwoqFk4+q8ZfvOXDGVa36c4PaohdEyKfLZ9J0=
=UUOx
-----END PGP SIGNATURE-----

--Sig_/pldPNWCzzYBd0rP.lqF1I0/--
