Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523480736-2-1091314721857771060
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  FREEMAIL_REPLYTO_END_DIGIT 0.25, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523480735; b=QALxidMJfi4ZYDJb8/3wEQqgygyJacc8kTgnxJS+/ba3qvsmED
    A+JbPoFAuMz7bsK/iYJeW6dWctISX5Fa/pLoiQQav0QcyKjv+x6Jr8LlD/NFQAEH
    45NiU2LcZL/BLDGiT7xv9agpXJco4xh9DGpNUwjoCZ1ka6J+nS4rPn57Qy9wzoHx
    l4ms0oV4XK4PTiBErF1JVw7wYegLWm83djo9RzAFiZb7yJPTvum1GBgER5WOJBhM
    SNGb6j1/3l96kJWaxQymVcEDzXUGbUOFxh2/85MCQQXXR6YgDkiUxEZkQP+g/Gll
    PEOjGv25GTa0iCgwq5TXSE/mKyFtNhGIGZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:to:from:cc:reply-to:subject
    :message-id:in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523480735;
    bh=bCIxPirF9L9oDx4o2kL9UdB84g4JNu2HpZoEsmKJ1es=; b=Ff5Ezvq335BD
    B+CeD//4haNgx+dP36Kcj/o2d7uQ5yEGXNry2faCuWUZzVWp0ky+4D7Ot52788ll
    SC2FkP2vPmlHIdf50AW2DPJy/osC30OSJ8VVmFrltHJlD55EA/QPB8VQv32Mobfk
    8f4QufhVQLcNmMhUZOJ7tVUY5K3xnwZtgWqsGH64KzsMbTWB+/gcwhyQIb7zATk/
    GrQATEZD+FVY2dFYeE2aYJ7Q/z5L2Au/VUgU3JWy4lOiCNQBIiSsRNos+KaBRlJ4
    H/Kl+pvA2FHDlyFf+pnp4BHH8Wjp0VpHv11lZjFOVcdZ5zWAr7/KhwYWWB33FHd6
    MN0hePpm3g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=protonmail.ch header.i=@protonmail.ch header.b=rrlGxmZy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=protonmail.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=protonmail.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=protonmail.ch header.i=@protonmail.ch header.b=rrlGxmZy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=protonmail.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=protonmail.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEnxUowNn/WHN4MmXrrWVNBROPgH20pdV5cugHi2/79jxIHkRDg5facTzPTyGicElUwj9FoaccYyxwTBPtEMdPQZKDqX/qRELT7afW6H6BcgKDciRlRu
    +ivAq/6gFmQrGaM0BAl195EO8gaPD/LbndlUwKHXcliGbE4c1ffoFN+58vPijxNnbCFDzj/uIIPUxZX2miO5CeQdx3iS2IEsmnzSiQbhk9PQgz9HPgpgc+az
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QMQ_dRVTYasA:10 a=IkcTkHD0fZMA:10
    a=x7bEGLp0ZPQA:10 a=gl0VdsdmwnAA:10 a=Kd1tUaAdevIA:10 a=Z4Rwk6OoAAAA:8
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=mYQSMu4dMsqlquKM52EA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbeDKVFK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:05:10 -0400
Received: from mail5.protonmail.ch ([185.70.40.28]:42853 "EHLO
        mail5.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755101AbeDKVFI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 17:05:08 -0400
Date: Wed, 11 Apr 2018 17:05:04 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
From: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: David Howells <dhowells@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running kernel image
Message-ID: <8z0aRQyD-6Krqntk8UD9WQjK5JSqEai2Pt5oeFU2EplgxoWiHlX5nlJXwCDHQ1WcS1oIprXimgz7UvwHCWDB9Z3dYFrEmZmtkEJSqaYMel8=@protonmail.ch>
In-Reply-To: <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
 <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Remote-Spam-Status: No, score=-0.6 required=5.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT autolearn=no autolearn_force=no version=3.4.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail.protonmail.ch
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On April 11, 2018 8:09 PM, Linus Torvalds <torvalds@linux-foundation.org> w=
rote:

> On Wed, Apr 11, 2018 at 9:24 AM, David Howells dhowells@redhat.com wrote:
>=20
> > Provide a single call to allow kernel code to determine whether the sys=
tem
> >=20
> > should be locked down, thereby disallowing various accesses that might
> >=20
> > allow the running kernel image to be changed, including:
> >=20
> > -   /dev/mem and similar
> > -   Loading of unauthorised modules
> > -   Fiddling with MSR registers
> > -   Suspend to disk managed by the kernel
> > -   Use of device DMA
>=20
> So what I stlll absolutely detest about this series is that I think
>=20
> many of these things should simply be done as separate config options.
>=20
> For example, if the distro is sure that it doesn't need /dev/mem, then
>=20
> why the hell is this tied to "lockdown" that then may have to be
>=20
> disabled because other changes may not be acceptable (eg people may
>=20
> need that device DMA, or whatever).
>=20
> If that /dev/mem access prevention was just instead done as an even
>=20
> stricter mode of the existing CONFIG_STRICT_DEVMEM, it could just be
>=20
> enabled unconditionally.

CONFIG_DEVMEM=3Dn

>=20
> So none of these patches raise my hackles per se. But what continues
>=20
> to makes me very very uncomfortable is how this is all tied together.
>=20
> Why is this one magical mode that then - because it has such a big
>=20
> impact - has to be enabled/disabled as a single magical mode and with
>=20
> very odd rules?
>=20
> I think a lot of people would be happier if this wasn't so incestuous
>=20
> and mixing together independent things under one name, and one flag.
>=20
> I think a lot of the secure boot problems were exacerbated by that mixup.
>=20
> So I would seriously ask that the distros that have been using these
>=20
> patches look at which parts of lockdown they could make unconditional
>=20
> (because it doesn't break machines), and which ones need that escape
>=20
> clause.
>=20
> Linus
>=20

=E2=80=8BJordan
