Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AG47ELvkv6hSkXyVxBGF39kSgAweZMf6hF7FwUA3N6DJYV1DvxVuCDYDSGNLbHx9pFo+dl5De4bM
ARC-Seal: i=1; a=rsa-sha256; t=1521042408; cv=none;
        d=google.com; s=arc-20160816;
        b=zGCR63SghSkr6Jz6M8kAgnZ3cVhEDA48K2dgjAWIkTioDeAbV4F3EQB95cZbL0URFh
         Z9HN9EhByJNMtw8Q7dukaeDjAk3IVIVMh91EaqFO1Ev3Gk8R0g7CNj6IQ+C33e03pRO4
         ZFe2YY3X+QpMKR7n1/ZHnbRtPkBzyWZ2w/Fbqj17pTpnLRsM3iKJtxxyZQ92R3ePeckM
         vTGcjhNMySQausbBsiKUFSNuQgCN+0e7iChQqpb9u2SIwOoDaNTO6nTLVIPKhl3Q+fWi
         mo+ilFLLcXQeyl5cBHi3wuZkxzsX9013/j95BxDVO7jUSsFRN23vNmlNLFj+HqXMt997
         hZxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=MSwdj7LEtwEU9lu70NTNXu7gbsCehO6JzEMCyYfbjww=;
        b=qAJ78NUMP4GgdC0TSZdktSJixeaQY+5xIRUiLqofKTMRjEQOqF+pUedv+fIg2Bt4jc
         +tMWdvu8BIYxVGLrHOrifvp138kR52M54BoK2DKUjlvFNsG62bln/xpp66UdabCg1ENF
         0XDH0aGSU52DNqnwvJiAe/2QzrgeGUw2ChEJLPX3TpGVCevn/d50Qb0pZy3jQK6YiTHD
         hPlaqIHg+4JZQOm56acKoIlAbT7+Rkbm67cQM7k3clSrCcsOsjQcRky3vdYAKr5o5/ka
         uBwmrI6ZuD3GuiSbSQbF1ARoLpWyDpxQpspwijYtRtQKw2OEeylX+MTh44oLsvKaYR7A
         jgPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A407D20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 14 Mar 2018 15:46:42 +0000
From: James Hogan <jhogan@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
	Jason Cooper <jason@lakedaemon.net>,
	Dengcheng Zhu <dengcheng.zhu@mips.com>,
	linux-kernel@vger.kernel.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Paul Burton <paul.burton@mips.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] irqchip/mips-gic: Enable & use VEIC mode if available
Message-ID: <20180314154641.GA8976@saruman>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
 <c9b5d20c-7adf-5308-1a45-21471d206d10@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <c9b5d20c-7adf-5308-1a45-21471d206d10@arm.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588748156278723185?=
X-GMAIL-MSGID: =?utf-8?q?1594928564431297952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 11:15:47AM +0000, Marc Zyngier wrote:
> Hi Matt,
>=20
> On 05/01/18 10:31, Matt Redfearn wrote:
> >=20
> > This series enables the MIPS GIC driver to make use of the EIC mode
> > supported in some MIPS cores. In this mode, the cores 6 interrupt lines
> > are switched to represent a vector number, 0..63. Currently all GIC
> > interrupts are routed to a single CPU interrupt pin, but this is
> > inefficient since we end up checking both local and shared interrupt
> > flag registers for both local and shared interrupts. This introduces
> > additional latency into the interrupt paths. With EIC mode this can be
> > improved by using separate vectors for local and shared interrupts.
> >=20
> > This series is based on 4.15-rc6 and has been tested on Boston, Malta &
> > SEAD3 MIPS platforms implementing a GIC with and without EIC mode
> > supported in hardware.
>=20
> What the status of this series?

FYI I've been meaning to test it with KVM, since host EIC I think will
affect KVM & guest stuff.

Cheers
James

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqpQ+EACgkQbAtpk944
dnpXVw/9Hg45TxhejxWGfq/M8fj+8mY6Idn8dYyvd8aa5kJON8ojchFU0PaCX5AG
pSnulJNecORbKX4ThakiqQsOPz9qjwSwrI1V2IQE8zlzmjLgu5FjrFM6rY4lt1/h
5466PwTZ7GefAPX0THkbG0hdqDJWGAvjIw54ga3aKE5zaNyiR+0aTYjKUdTnHUL2
XWPxBesE74w2y77q6odsJW6CsEkigIyGq5EFBSw3KJCKxW4BGo5rRY3T8Nypobgq
PB54p/wNKpaUEa4usfBbwnit+oZ/x2dImTboccG3PVxKLGPN6NTtBCa4rM/kX51Q
O3WxnYKrhWBum/q6y9r60u2+PzTZlAD80353eVD03ksUYUmTNI0hV6WL5oZNOKTS
VlHqsHKWdTOvu0tQPR+UKLnsQyoNKfsvbavkZDu1lhuRBYDh4I/ChfFmSIVj2DtM
D184cEkNJXom4LGI/w+WBokKOpMvse6yL8KOgu439XKXy8dX1/MyyQ1tA2TqkBli
ylyYV6My6EYYdxtF9IFRpX2AuzLvuAcJe2GVGOh571WYyWwm8p1HdWT5COjSAG7u
vVYXZlZGM5SPPiMsOeFK+PyIS7k4jV5TC3A0tVGOt7jQ6GkNj6Q1X1rAu7nxFaWC
v58mKXi5FdyM0cP2rDggIo0smoZtlWm/+9+FxRfEtuXCg6JuMJs=
=09L9
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
