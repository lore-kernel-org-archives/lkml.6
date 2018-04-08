Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1705864-1523175057-2-3510895286444095612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523175057; b=Yly6YPANndeqnJBpbKDm9pWPiwIXHGh2NuoD6FCnk5fI0Is8dl
    jhfFRglEBzjbS2WgMQFM1Z7mI5NWbcXM01W3iAdtBs8OTHUKNiezRzziCG8zT+Ab
    Rirfj7/jYws4Em/TirlCSqp+vM/8i52fW1BkGdGmGScldHQm6hAy3z4zL75PlvZu
    lEq16owncmkaJxJD5FIUeaL/15AkfXmaduQfSD90AMRISSHYxLxLKixuGOGdL2Ps
    lrJlWshd1EYq5dzZ6kDy3X0X8/kEkre/6fcMeey07Vy5CsXbzrotpam+dsHSFcJE
    P/Ena9iY8WDQOad8Q3ooihzmuuIW8bg5pqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523175057; bh=iyxUF4l3DMTTgn2Snu+VguP4MwSOtn
    dsoBzIuUYTOSQ=; b=XapcfklpC6QMeHZLJ6Y+SiRIWBxBN3uVkJF5h4k/59zbtn
    YUZg4w0OHqjxuRnLT1iv80wPlC0q6CmH+V7tMaDktSlq6W/jIochLVg+e3gJKyB0
    1KTVTGC9v5wfRJHuofPEu1ccHHzxto5+/4cZdqtxn89mFcQ7+p9rBCmQHGD8WYhr
    zkikQgBDFm61gW0a81xxLAvhY9laDf6Zg3zlWDcX8YLIWqnMaEDZnU3uG7zi2epb
    3TyaT9WbdkWN0b1gKjY+oaxvfeklwIz64WcEmZSbMfxTqzIkEG8WNjRpHkYQgpXG
    kLHndI6dXnhXPMS3RrWe163d5RK0vJYUJHCPe3dA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFGVs2L5GcHrPvHSePtcnP3nZS8HY/DVhTSHGKUAsphPh99ckuHgcwWFmohhWTCbZo2iSHilKAhq4AfRLug00tiNNnxFWFSbC4ORU08nMY/AdO7yUf0k
    wmadN0yK5onqjCQZrlDNbBKSbx6HM9gheCvUy/lYWDokHNl+B2wws+CzmwFgyNY6QZe4t587lgvUM263aGcF2RSnibgcN9NLVRMHMJVPn4fhFriSHRvo4IJu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Z4Rwk6OoAAAA:8
    a=1XWaLZrsAAAA:8 a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=SumpCwHsQv_Z2nZDHcgA:9
    a=CjuIK1q_8ugA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10
    a=66f2praVOus5ADcixbUA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDHIKy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 04:10:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59562 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeDHIKw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 8 Apr 2018 04:10:52 -0400
Date: Sun, 8 Apr 2018 10:10:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180408081050.GA4965@amd>
References: <4136.1522452584@warthog.procyon.org.uk>
 <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
 <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
 <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
 <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
 <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-04-03 21:08:54, Matthew Garrett wrote:
> On Tue, Apr 3, 2018 at 2:01 PM Linus Torvalds
> <torvalds@linux-foundation.org>
> wrote:
>=20
> > On Tue, Apr 3, 2018 at 1:54 PM, Matthew Garrett <mjg59@google.com> wrot=
e:
> > >
> > >> .. maybe you don't *want* secure boot, but it's been pushed in your
> > >> face by people with an agenda?
> > >
> > > Then turn it off, or build a self-signed kernel that doesn't do this?
>=20
> > Umm. So you asked a question, and then when you got an answer you said
> > "don't do that then".
>=20
> > The fact is, some hardware pushes secure boot pretty hard. That has
> > *nothing* to do with some "lockdown" mode.
>=20
> Secure Boot ensures that the firmware will only load signed bootloaders. =
If
> a signed bootloader loads a kernel that's effectively an unsigned
> bootloader, there's no point in using Secure Boot - you should just turn =
it
> off instead, because it's not giving you any meaningful
> security. Andy's

Not true.

I have kernel with printk() enabled. Yes, once userland is started,
you can boot another kernel, maybe.

Maybe my kernel is locked down with exception of kexec, and it does
printk(KERN_CRIT "kexecing") followed by mdelay(5000). That's pretty
good security.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrJzooACgkQMOfwapXb+vJyawCgucLLA8QbmX8zLUT7nIWXw5P+
p/sAoI5s8z1MIYAXdUMjuXLq63vVHR7v
=llcn
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
