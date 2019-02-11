Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F79EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47110218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="rs9s1uGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfBKMzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:55:22 -0500
Received: from tomli.me ([153.92.126.73]:57836 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKMzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:55:22 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id c32b2060;
        Mon, 11 Feb 2019 12:55:19 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:7b76:76e8)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 11 Feb 2019 12:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=xX4ptvedZCTccKySMZWrF9P94x6VEW/wbqt3obLEj8U=; b=rs9s1uGToUcPYKWens3Ti+EWllEAVY4q5MLoupc2IgO9tETBvmo1OSyZhpV+iEsoPRRZbvOHGo98g2Kqc+smBek00+5dvV9NtXzUgofHtsLAU8kjUbxSV0Vf8vs7qe77aZTsSznqf2XoLSoilpWLhChLKp5VBpWh9r7faunjBWpsgTW41bnAMm8MMgaerN+tbvxdEp+N9J5b9xw7K6dddNnAIpxJotu91EGV/auQkaVoHcq1bOBAfBd861O89KGUpZ7ncewrpgbfxPH9wL/wVWXmvo2ZIEw4krfwgD24Lnjjw8XZN4wGT27GdX7Hsty/WBinC01EFRv9Dgai+wgOPw==
Date:   Mon, 11 Feb 2019 20:55:09 +0800
From:   Tom Li <tomli@tomli.me>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Message-ID: <20190211125506.GA21280@localhost.localdomain>
References: <20190208083038.GA1433@localhost.localdomain>
 <orbm3i5xrn.fsf@lxoliva.fsfla.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <orbm3i5xrn.fsf@lxoliva.fsfla.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:13:00AM -0200, Alexandre Oliva wrote:
> On Feb  8, 2019, Tom Li <tomli@tomli.me> wrote:
>=20
> > found Alexandre Oliva has stopped maintaining his tree
>=20
> ?!?
>=20
> I still merge and tag every one of Torvalds' and Greg KH's releases into
> the loongson-community tree, resolving trivial conflicts and trying to
> verify that it at least builds and passes a smoke test on actual
> hardware (after Linux-libre deblobbing, but still).

What is the current link to your repository? The original one from Lemote
is now a 404, and the GitHub one has been "archived".

> Two issues that bother me a bit are frequent failure to reboot/poweroff,
> that's been around since around 4.10, and, more recently, a very slow
> system overall, that's been present since 4.20.  I haven't checked
> whether they're caused by changes in the loongson-community tree that I
> still carry, or if they're already present in upstream releases.
>=20
> I've already tried to bisect the former, but since the issue is
> intermittent, that proved to be too tricky and time-consuming for me.
>=20
> I haven't tried to bisect the latter yet.

You cannot bisect it. Because I've tried it for 24 hours without sleep, but
failed. ;-)

We've just identified and confirmed the source of the shutdown problem a
few days ago on this mailing list. It's related to a PREEMPT race condition
in the cpufreq framework that triggers a timing-dependent, probabilistic
lockup in the i8259 PIC driver. And it was first noticed by Ville Syrj=E4l=
=E4
on a x86 system, my debugging rediscovered his findings.

You can read the full investigation at here:
https://lkml.org/lkml/2018/11/13/857

You can pick up the patch from:
https://lore.kernel.org/lkml/20190207205812.GA11315@darkstar.musicnaut.iki.=
fi/

A patch has been authored and submitted by Aaro Koskinen, but currently it
seems stuck in the mailing list because the maintainer worries about regres=
sion
and asks for testing on more MIPS systems, although we believe it's a trivi=
al
patch.

In addition, I've discovered and fixed another bug preventing the machine f=
rom
shutting down, this patch has already merged into the Linus tree.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8a96669d77897ff3613157bf43f875739205d66d

> and, more recently, a very slow system overall, that's been present since
> 4.20.

The mainline framebuffer driver doesn't have any hardware drawing, printing
even a single line on the console is required a full screen redraw via memo=
ry-
mapped I/O over the slow PCI interface. I have rebased the 2D acceleration
code against the latest upstream driver and sent the patch to the fbdev mai=
ling
list on February 2nd.=20

But the maintainers seem to be working on other tasks and the patches (incl=
uding
mine and others') on the list didn't receive any response.

It's avaliable from

https://patchwork.kernel.org/project/linux-fbdev/list/?series=3D75029

> I've considered leaving the loongson-community tree behind and using
> upstream releases, but every time I was about to do that, something else
> came up that led me to keep at it.  I think the last such occurrence was
> the removal of the video driver (later reintroduced as a new driver).
> So I've kept at it ;-)

I'll continue working on upstreaming these out-of-tree drivers as my person=
al
project. I hope you'll be able to use a fully-functional machine with the m=
ainline
kernel soon, my current target is Linux 5.3.

Cheers,
Tom Li

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJVIRsjlaWj4OSKDx+tPrBeiOjW0FAlxhcKMACgkQ+tPrBeiO
jW3ZzhAAiz0joTss55XZrxTd0+nTWkFKZ05FdDccvDsiqi6MPhF4YPkKM8hWX2V4
qkSRtH6GM45QnrbTC3tzb2qjEQM8qNB3j/PPNNr8Lsg9eF0gYQZNN+AqbO48K7Gv
/hZyk5vRqv2jYOibkFXqBFb8IQp6I4qHfx6D9SjmVZMVV0f+PrtX+M6hCmHjAclZ
On4KjhffuZ3QPxHbMTcDdGebGOG3/eGHi/ra+9OuksJbPCttv7y8fhaS9uQuBhxR
CdB/1OUeabT5jb7WzAg5Hx7UFRCqAFeMay98VIk4xoGDOk4HC8g7n0Y3Wcwk6TWg
fZJEBqB4N6NyRZ2/OUEYDptFfT7nkF5ddWBpDbUB5Ph9JP8zP3qYG4iysF4IzabY
0yfpvYcCkqPfWeJ1sFl/N6ca3w2OfX1L1DIN++nmmorX05f1dlYzwqPY/kGzJKvn
9CAdtkjsKtkp4OsXhDE2JjM6UeWzp8dBY+PQm5OY0XoPc4GheJGbJYBKgLWcFQm4
EH8hbcGeXwKsQkK2oBDk+zByGWZVZDnBM13exLe9Tahf0KN3Ka+arFgt9nMNvJ1c
zcNPJArhxp2h9QxYfTqB2tpous+9x/PGcb6bNeQvPwK8IJO+jJY+2hDHEa/Eieo6
lR8QkHvP29agk0aWizSsI5hifTM4AX6AW3VcZUL3DnVzFJ7s28c=
=dCmE
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
