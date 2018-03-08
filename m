Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2448136-1520528535-2-10497923851714542647
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', cc='utf-8', plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520528534; b=Nj/yaVnC2TmnVkt7Kc2zyaaVjJlXBo5DbETNeuARKFXDaqg
    rV3asbvjr8vjmCrJcI8U6TqFmeFSuGeicgrD6wGNskFK1eimPGpvWDf0wd3l2Eg7
    kQoAQ/LRmvPJHZ112h4Lank25OEoNbm35I2FZ7N6iNtT31LVVyn3ChbakB7Y+S3v
    PPCMwZCMdqSAvJG1NWfau3EYqx6s2Fd+wo4o6+AXhRDZY9CsjSwddwn/dbC7cBzV
    NMBtpizILTnM9oMNc0lpshKXufRi1OnQfTuguzAx6GRrN2jj88y/IIvyiCq5UMYA
    B3PLTa2vQa3TEIrolfvByeMq5vGJyoxpbDgQsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520528534; bh=oDiL5xymGGvkMHrJI/jEZzQ+Qh
    s6vqjvnY5hkdjBqNc=; b=uYwo118tGSmpf5SQ/2vRJBNKRHZ9jY1VmE2Cb6BBtZ
    dOdiNu0wpxKJ20KbGv/xGsXWwgBPJW9Yz3Kwl+PFzqIBQRXItbVIc8fjCBr4ofRl
    RXspAgjhPwVvXMu5vJTKOYdRckYx6e68W46XZqijI4R20qRdNQ3dV8gRxJt6aQq4
    F3vnLDBJvLhAwUz3bpep+X6rjW6bBgSriH0wrpSJca3P+iFVVjsvNwyYYom8ugNN
    e/ppw1DwIEIob/mYuKC+yq+0TsuYrnE5w5DoRMREwd1jLKCQD5LZ5Z4j2C1S98S6
    w/kcnznsTNnwlyIeUH8cmaJU7Wsb4bkwOTLO7D4tO36g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eUBzQVt2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oLejmQoT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eUBzQVt2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oLejmQoT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935589AbeCHRB7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 12:01:59 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36677 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeCHRB5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 12:01:57 -0500
X-Google-Smtp-Source: AG47ELvfaxWAsRW0tZzmLBPdxRJHIS44Pmpw8Zrlst/mpYNBaBvCRJ5FRgf3aUqcNRHOxvJ9oBVoGg==
Date: Thu, 8 Mar 2018 18:01:53 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alex Shi <alex.shi@linaro.org>,
        sre@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com,
        khilman@kernel.org, aaro.koskinen@iki.fi,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com,
        serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net,
        martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Message-ID: <20180308170153.376gcwwudwkq3gs7@pali>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180308122715.GB21514@amd>
 <20180308132139.apabmgw4magrp3d7@pali>
 <07d4709b-df73-0107-ce0f-5af55e34913e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xkebunayz44ustzl"
Content-Disposition: inline
In-Reply-To: <07d4709b-df73-0107-ce0f-5af55e34913e@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--xkebunayz44ustzl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 08 March 2018 13:35:49 Marc Zyngier wrote:
> On 08/03/18 13:21, Pali Roh=C3=A1r wrote:
> > On Thursday 08 March 2018 13:27:15 Pavel Machek wrote:
> >> Hi!
> >>
> >>> Resent without non-upstream patches.
> >>>
> >>> This backport patchset fixed the spectre issue, it's original branch:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?=
h=3Dkpti
> >>> A few dependency or fixingpatches are also picked up, if they are nec=
essary
> >>>  and no functional changes.
> >>>
> >>> No bug found from kernelci.org and lkft testing. It also could be got=
ten from:
> >>>
> >>> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upst=
ream-only
> >>>
> >>> Comments are appreciated!
> >>
> >> Not entirely related to this patched, but... I have few older ARM
> >> boards here, and Nokia N9000 I really care about.
> >>
> >> AFAICT Meltdown is arm64 only?
> >=20
> > IIRC ARMv7 is not affected by meltdown.
> >=20
> >> Spectre affects the older boards, too, right? Was there any work done
> >> on that? cpuinfo says "ARMv7" for N900.
> >=20
> > I remember that I saw some spectre patches for ARMv7 on LKML.

This is that patch series:
https://www.spinics.net/lists/arm-kernel/msg632065.html

> > In general for ARMv7 it is problematic as mitigation needs to change IBE
>=20
> Not quite. IBE is part of ACTLR, which is an implementation defined
> register, so generalizing this statement to "ARMv7" is plain wrong. Case
> in point: A9, A12/A17 do not need any bit to be set. A8 needs IBE to
> allow BPIALL to work, A15 needs it for ICIALLUI to perform a BP
> invalidation.

Ok, Nokia N900 has Cortex A8.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xkebunayz44ustzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqFsfgAKCRCL8Mk9A+RD
UsW0AJ99fseDeZ/ryk68VFMT4t/bAcrRpACeP5hLbA3/wfZZ80zRd7UwHmHFcwY=
=x89Z
-----END PGP SIGNATURE-----

--xkebunayz44ustzl--
