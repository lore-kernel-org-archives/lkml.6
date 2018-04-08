Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1764334-1523175794-2-9446321484750222310
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
    1523175793; b=Xb2q04VKEFszy2u+jujV2m9dDoU2++MeaOydYqCcufr8msbhZX
    /bTNAJPlSjgnG2aK7xbAnQENYbNWH5fFPFN/MCm/mxduESXXQ7Vn+8nfI5Hmnf4z
    Qc9ObLJkf+SpYJkhjctnP/9BpdcJ/T7Xshw6EOAIEIxUB0KYl3M781TslL+q+h4b
    fZnaH6fMs03K/gfMmQgWTfFIgcopNuMtAlkX0X6awF1DNd2eNost8KaT8DySz9n5
    giq5FidTX/45IqUHU7G/0bohAUpmXJINAdXkqEcKbS+KZ8HBmutzudSkUO4EGT1A
    9CcfwMXkXnqlIRdG1T/jY2iTn/M56R41v9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523175793; bh=ewVqvaFsFioT7SEMfm+V9vAfh0FIaR
    0qxSiSibRzxEE=; b=Udc6k2k/2YqID3tgu5xKTF6JoOyL57zXiWqK3vaE8iumxf
    lX3KbApEfsoGfrnLDN+fycdFWqpho2jm4wG6UGJKwf5blmFYp3Z7IZC99TEo2ZHM
    7d5rigilJci3lKKnODX9mpIfWNC64ezuPgHjCIiHji6pvXV2aJrVGNXIbZXV+Q11
    vGkOJekiyBJK/n25l4mFTfBMIDAx/iCslN/g8DJXdxMcCrzD+TPmm6V5qXDKEQxe
    bG4K21YVB9bZm9Zy8kCQ3G6cCwtZE0LAcykjuAD1g9flJmzT7KuMmf/kMQiFFe0b
    EIRSlGe2SqzGwv+UZs+c3injk65uykXFm1GNDfmw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfCKgWL8NqEYCvkSFYEmCv4iX3BOJ6ABLQ6THoaU7z/c/NEekLO5WYrmS1CL8BWaApp9PA1xG2cw6ybvu1CLf8pMLnn2u7pa+XjTSCfBX9ndNVUaiHfxC
    MuFSDARZ6efyLsPBvjXIEEu0AG5Na0dIJW9HJB9pdtlWLKCDwvZlhGK0m8+qZLA3coI0eJAOOfbQMe2cwaU4ZfdRib4Oj5PkdIA95zS4uXJQBX7ONI38Wbi0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Z4Rwk6OoAAAA:8
    a=M8rcC2nyAAAA:8 a=RXnXJx7MAAAA:8 a=mU1DO7LwCHQtjZHSM04A:9 a=CjuIK1q_8ugA:10
    a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=ZEVxt9_iRh9jiNcIGvkA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=K9tzwgKBnWaK51F8Cre1:22 a=U_UV0sFCMgXoaKVbI-EZ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeDHIXK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 04:23:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59872 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbeDHIXJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 8 Apr 2018 04:23:09 -0400
Date: Sun, 8 Apr 2018 10:23:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180408082306.GB4965@amd>
References: <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk>
 <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk>
 <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk>
 <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <10718.1522798745@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <10718.1522798745@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-04 00:39:05, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
> > The same thing is true of some lockdown patch. Maybe it's a good thing
> > in general. But whether it's a good thing is _entirely_ independent of
> > any secure boot issue. I can see using secure boot without it, but I
> > can very much also see using lockdown without secure boot.
> >=20
> > The two things are simply entirely orthogonal. They have _zero_
> > overlap. I'm not seeing why they'd be linked at all in any way.
>=20
> I'm not sure I agree.  Here's my reasoning:
>=20
>  (1) Lockdown mode really needs to activated during kernel boot, before
>      userspace has a chance to run, otherwise there's a window of opportu=
nity
>      in which the kernel *isn't* locked down.
>=20
>  (2) If the kernel isn't booted in secure boot mode, then there's the
>      opportunity to tamper before the kernel even starts booting.
>=20
>  (3) There doesn't seem any point in booting in secure boot mode if you d=
on't
>      protect the running kernel image against tampering.  What does it me=
an to
>      be in "secure boot mode" in that case?  If the kernel can be tampered
>      with, it would seem to be, by definition, insecure.

This one is not true, either.

If kernel does "printk(KERN_CRIT "loading unsigned module");
mdelay(10000);", it is useful for secure boot and provides way to
owner to play.

Nokia N9 / N950 uses this kind of "security" for example. It is rather
annoying but better than not being able to run custom kernels at all.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrJ0WoACgkQMOfwapXb+vIUpgCfQTVxgQuJIcDh2bJZRy8WyNou
NOMAmwboHWl217wYf3zGmTVqyXi9sm4P
=judE
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
