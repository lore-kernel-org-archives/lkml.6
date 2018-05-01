Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3189361-1525181255-2-5331945880728696447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525181254; b=gkK/0hxAxFCz5w9ccADB9xfitbxZX9YYV36mtJasSgmBPTDxUh
    pcBQNYkNE5smG6rAP+DuirvkV+xwNA02l0BXjWVJf8bi9BMwdoeuE/5tDyBiHfhg
    bb+pUk583DEkeaKNai+TPHYvkh+cGQtP/KRgETeWeinepZLSBhbztxYLc+0/fg1q
    SGoJz9xGR4Fzav7Lkt/OFJlTEBuwEX0h3iVxsJyNWZJvt9FqgI+oX8aSGRAcLJhu
    NEqa4+uBaIOoxGF84KI5TxheDgeLZT/Aj/L0nBzJ4F2/kNaQfrhgGgSOqugOftc6
    LI4yRs7W0EhURss75/RzRzaVph9sIrRacWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version:sender
    :list-id; s=fm2; t=1525181254; bh=3iBi57tKXUgCPfwSgPJSDUBn57nkUb
    A7Ff4521CefG0=; b=FVrbejzK44Fu616av4FtuY23DW/bMNxiXUnFHT1rvNTv+d
    1c1l49BRLo6sHxSiLyIyBY6fSvq7d++YSpHtSqkHKjHntY2mGt5SLJVBa7uZtsYv
    q0tok2v2dDOZeK+2f8cfyj7KFYkg4Qv4PGwYls/fbUoaDPw6iG48GQtbpRrjHHnD
    XzL9uWyE197xmQZB8Sf1psK/dmQn6vAqZswyzY3ymJKeI5Q+I/82H6PzmXSPr1/3
    6o6R1BfpmyX2Do88lFxsiFytSszDIhA5UhleX8j982tFD2UzL9YceTzGm1wTt3y9
    Kk9SnmhhGNoAy2b1kr17Fa3fruMTLh/7s9esr3Dw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paulk.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paulk.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paulk.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paulk.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFoiogW7yAvwYVkAn3pXEEWyYc0ky1BzTnNn6EX/IEg5uxsUSF1OrrZ9G03hIrDrDYlOd6sJQ+TRkfxziD+lF7TdTpNodUAgVgOZladibFszB7Q57RnG
    EygIR/wCYsCu8uSW7emAiwmuIcqQrtnQl4AlVnz+qlYbmyrKRNEqTeNiwP2w+yEUgUeaMkcprZ+8mN6SUrY8Xp//992D6WugXZ61rVDtuAOrJ+NBRWA3Fdcu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=xjq4MWndAAAA:8
    a=Tqc0aaM_rSTQKXfrI8IA:9 a=0RmtFWgCUccI5qos:21 a=Ox-yu5hu_a42-b5s:21
    a=QEXdDO2ut3YA:10 a=bmwtX18i_7DeJ4bG14UA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10 a=LM-bNg79Vred_kxi5WFf:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755177AbeEAN1U (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 09:27:20 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:43472 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbeEAN1H (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 1 May 2018 09:27:07 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on gagarine.paulk.fr
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.1
Message-ID: <5907f644301499eff3e2740e15f16aaffec84817.camel@paulk.fr>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
From: Paul Kocialkowski <contact@paulk.fr>
To: Bin Liu <b-liu@ti.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Date: Tue, 01 May 2018 15:26:57 +0200
In-Reply-To: <20180501122533.GD21238@uda0271908>
References: <20180328215213.29538-1-contact@paulk.fr>
         <20180329092326.dayuccomq5zrywqo@flea>
         <1522324644.1746.19.camel@bootlin.com> <20180420142524.GB29011@uda0271908>
         <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
         <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
         <b24cf58d2f48519893a5051a98bee6579c5e0d98.camel@paulk.fr>
         <20180501122533.GD21238@uda0271908>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6iT3fPaIWE46L17YEAFm"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-6iT3fPaIWE46L17YEAFm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 01 mai 2018 =C3=A0 07:25 -0500, Bin Liu a =C3=A9crit :
> On Mon, Apr 30, 2018 at 11:08:42PM +0200, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > Le samedi 21 avril 2018 =C3=A0 09:34 -0500, Bin Liu a =C3=A9crit :
> > > Okay, this came down to an argument that whether we should require
> > > loading a gadget driver on a dual-role port to work in host mode,
> > > which is currently required on musb since a long long time ago.
> > >=20
> > > I understand the requirement is kinda unnecessary, but since it
> > > already
> > > exists on musb stack for a long time, I don't plan to change it.
> > > Because I
> > > cannot think of a use case in real products that doesn't
> > > automatically
> > > load a gadget function on the dual-role port.
> > >=20
> > > If you can explain a use case in real world (not a engineering
> > > lab)
> > > that the gadget driver will not be loaded at linux booting up, but
> > > later based on user's input, I will reconsider my decision. To
> > > remove
> > > this requirement from musb stack, the work is more than this
> > > patch.
> >=20
> > My use case here is to support common GNU/Linux-based distributions,
> > not
> > use-case-specific varieties of GNU/Linux-based rootfs. So my point
> > here
> > would be that most distros will (and probably should) ship g_ether
> > as a
> > module but without any particular reason to autoload it, or any
> > other
> > gadget module in particular, since the system is general-purpose.
>=20
> This is the case I called it "in a engineering lab", not a real
> product.

To me, this sounds more like "daily use with upstream like on any
laptop/desktop" rather than an engineering lab, but that's not the main
point here.

> > Then, imagine a user wants to plug a USB device through OTG (say,
> > because it's the only USB port available at all on the tablet
> > they're
> > using), it simply won't work. It won't be obvious to that user that
> > this
> > is because no gadget is loaded, since what they want to do does not
> > involve using gadget mode at any point.
>=20
> If a tablet has a dual-role usb port, it is designed to use a gadget
> driver,

I don't understand the logic behind this assertion. If it has a dual-
role USB port, then its hardware allows both use cases. It's obvious
that the use case is up to the user of the device since it can be
switched by software and is not fixed at design time.

>  which has to be loaded at some point. In the case you described
> above, when the gadget driver will be loaded? and how?

Again, loading a gadget driver is not part of the use case. In what I
described, the user only wants to use the dual-role port for its host
capability and does not care about gadget at all. When the device is
plugged into a host, it will simply charge and not propose any USB
device features.

> If a gadget driver will never be used, a host-only port should be on
> the board, not a dual-role port.

Here as well, I think the use case is separate from the hardware design.
 I crafted this patch because I was in the use case I described, with a
tablet that only features a micro B USB OTG port. The form factor simply
does not allow having a full USB A female host-only port.

> > Do you think this is a valid use case? It surely is a common one and
> > perfectly depicts my situation.
>=20
> As I explained above, I don't think so.

I am really surprised that using regular upstream GNU/Linux
distributions out of the box is not a valid use case for the MUSB
driver. The situation I'm describing is exactly the same as buying a
laptop with a preinstalled OS and replacing it with a regular distro. In
my case, that's what I did with the tablet (that had an old Android
version that did expose gadget features via USB) and I installed
upstream Linux and a distro on it.

> > Note that in addition to Allwinner devices, I also have omap3/4/5
> > devices for testing things. I don't think I have other MUSB-enabled
>=20
> Much more than what I have ;)
>=20
> > devices in my collection though, but I would be willing to test
> > fixes to
> > this issue on the ones I have.
>=20
> Appreciated it, but someone has to make the patches first. The one you
> posted might be a good start, but it is not complete. The first=20
> problem

Oh, I am definitely up for making the changes as well, I mentioned
testing to show what level of test coverage I could bring to the table,
since this will probably require making sure that it doesn't break
specific platforms, glue layers, etc.

> I see is that musb_start() will be called twice, one in the place you
> patched, the other is when the gadget driver is bound to the UDC.

Okay, I will look into this and make sure there is only a single call to
musb_start in all scenarios. Are there other things that should be
modified as well?

Cheers,

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-6iT3fPaIWE46L17YEAFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlroayIACgkQhP3B6o/u
lQxYVQ//ZWAJnTfBhVsBZeyfyQDip74hxxlv4/s6/kG9yVq/RsELEWNb9DJ18Mbh
G5EWleWZ+Jka15vwn2y4LG7EfWVJOYl1pCrHvhGkkQmhbL0bxu+4pFP0as8evx07
3nQNUv67917eLwkmGWUyaMsu9Ikt0P3qWu7K0rI8NYz5do1IE0mtEajf1c0lE9SD
2ghctRDOBN6wQNSTI1Tk9vBXjxYzllXZNp+ni3m67EwkIHgMnR2128NuoS2v/LKD
AFIA6IjFnHwuKNr9rjrattLM9KCSkaK6WiB/VtpA96/fWk5Ff9G2gQ7MTOV7opPp
BXcAtwIxT3G3xSJmabfqUGnOn4ctXvMwq4FbJaSB/BcfUWPMIN+tjLg6No5zL3en
Mi8t4IndM7zxfJYY6dYd7fne8wS21nDTWalPy4/xNiQnAFBXABUYx0Gy42hnMMnk
3PIZtYjM9j4FO00wLY0yXg8iCrd5bsuHrQWEFZn5uSKbtuDynldOq2eip9c4/Bpc
+7eYzsA4Nw2m/FBGdlZfrYBzV3hmiAu9NHJ4LeDcttGlAOIqzNNMkHMnQBn6+4Yc
MDnehJFrnACDmqQZwh3LOxklh/FR+ffzmBOanCikNj5iivaO4HSQLobEVmSZBOY2
BhCdyKlgIZ3KoGCF4fQ83nRkYk1fQFYigiyegD22g9WT0Obziwc=
=TDZx
-----END PGP SIGNATURE-----

--=-6iT3fPaIWE46L17YEAFm--

