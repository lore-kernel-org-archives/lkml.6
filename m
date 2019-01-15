Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44952C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EB120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfAOSvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:51:25 -0500
Received: from mail.tripleback.net ([198.50.226.104]:48552 "EHLO
        mail.tripleback.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfAOSvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:51:25 -0500
Received: from localhost (mail.clusterducks.int [127.0.0.1])
        by mail.tripleback.net (Postfix) with ESMTP id 8EFC8C0E6A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 13:53:16 -0500 (EST)
X-Virus-Scanned: amavisd-new at tripleback.net
Received: from mail.tripleback.net ([127.0.0.1])
        by localhost (mail.tripleback.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0VYETF33btFe for <linux-kernel@vger.kernel.org>;
        Tue, 15 Jan 2019 13:53:16 -0500 (EST)
Received: from [192.168.0.22] (S010664777daa9143.du.shawcable.net [184.66.63.229])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kash@tripleback.net)
        by mail.tripleback.net (Postfix) with ESMTPSA id E1551C0CC3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 13:53:15 -0500 (EST)
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
To:     linux-kernel@vger.kernel.org
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
 <20190110182413.GA6932@kroah.com>
 <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
 <20190115134221.GB30742@kroah.com>
From:   Kash Pande <kash@tripleback.net>
Openpgp: preference=signencrypt
Autocrypt: addr=kash@tripleback.net; prefer-encrypt=mutual; keydata=
 mQENBFk4mtYBCACd55EsQx9d/7r6jPgo9+Niwyv6QBYGBc5ww9pPOBrN0oSO47Hm+oSOO5Bu
 yywIw4U5DTUtvdj7elfnsJMhunduhc2P8p7rhLxcQeFIm+yghOepkjqhxTdFLsgavmcnubxy
 Olc29b2fByIVXnFAwHypgpHEqEWTHp2cnNVOtuO9GeIr8YxB+wO4Z5rDnNnEsOuLSJq9kG9c
 uoI8RF+StEBmYVRCfELhafBlluURLRPO/Uoax8+wFyq4/d3iDVtKyrDdvxLG0aXkj3Wfc6rY
 l8trOQl1zw8dCfJMw0+LPaj2EVza1HGCdhgIrg2cS1nKNjNDnIZB/8RwBU99FIY1xoGXABEB
 AAG0O0thc2ggUGFuZGUgKEdlbmVyYXRlZCBKdW5lIDd0aCwgMjAxNykgPGthc2hAdHJpcGxl
 YmFjay5uZXQ+iQFOBBMBCAA4FiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlk4mtYCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AACgkQLHWyk7icJXiG1Af9HI1f87UPQPEpsWVHuoeMlPra
 NPrefNZ+O1vnQEdTHEQ+Mc49ozLtpdrpi0VqKYlsdVHxhY5YbzyTC2tdHtiL2LTwbnkrqKMN
 6DJSiogXFLH/q+SzXoAUxqN8rrRptVEHSYrxENt+ZN5R0A071QrURdEa2vLXicjMGitvdVcV
 pxdRLJgSqQygSlKysoQsY2vvgRujD322BEwDqgq3XWCMIo3ld/riMSCiO8ShCvmqojeWRfh2
 ComhNSzzbn2oGUceEJRJ++mv+0i1jMzO+9L5qsrYnH7KnPA1HsORqHGi7+wJdRn4zG/+g+Ey
 hoTk2WVCDC/Gp4t9CYeQOa/rC1kxm7kBDQRZOJrWAQgA75dQD3FhNz1JDUuAEDRpKOJA7A1A
 t11ItkvolADQwJYtAqoMjFybAG+rN+H2+6CLFsShO2RLY8K1FJVPy31am9qeY5WWO1PhU3tg
 PHVeGOYF/mWTxNBKSwZgfWo8cOT9OcUTjTTR8z58kEcbZJ6PtiPyCsk2MKFMT+OcJ3w7GB2K
 KViN5L4f4sBOOgFZ5U+hNNcLOTmYk8ba2w0GnT4ePnidby8XStGIt1sVeNkbD2hdRUdXtpku
 OKQ2iw/j/GBo7+B7lYMBOSZaxKwpyEt7DPSJuLATSu6l16oDk4uqXulXC1td1fXfXfGLudHN
 sXUJDE/0jf2r8Mi3rPUdPn+dpwARAQABiQE2BBgBCAAgFiEE5MQWwRLWQeWW1A0MLHWyk7ic
 JXgFAlk4mtYCGwwACgkQLHWyk7icJXiv4gf7BqzcEq7IYUIMUI/ubyQuKdASfLHxbGmEJkxk
 Q7iPf38zLucS7jL3XnXrhkU4rzNneaQ0jn/bYhyo2ZDrmIloSOIYQPJTdCU53waLqbdgOSZH
 zVm7aFHVs7/C/joNxZ9Qcg75zdhAJP1bTWTBdmvofJFjwV3YXxhW9U0qIt6Dqq4IQ6TB2tzw
 bMiVH+IeWnlIwBScamT3DAXmu4CxKUpgkqmFsDL2aZve1ZUxwMwgblDZqBKdZoLJEYQ4Llf6
 JXZmkBNIuO8GA0ZGamjEOvxwn3OYPd7I2FQESawdKNAzv734vCCYELEQFP2mh04B32bEH4ei
 2oovF94E7UQCVIZg7Q==
Message-ID: <5fcc7fe6-9de3-cf34-075b-c17a28e85efa@tripleback.net>
Date:   Tue, 15 Jan 2019 10:51:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115134221.GB30742@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RURbwfbcaBc1Lzm9JgJni6OAKMlQHOkMd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RURbwfbcaBc1Lzm9JgJni6OAKMlQHOkMd
Content-Type: multipart/mixed; boundary="lHtIHdhAksNhuzQkWdvJo3uC7u28p8ysf";
 protected-headers="v1"
From: Kash Pande <kash@tripleback.net>
To: linux-kernel@vger.kernel.org
Message-ID: <5fcc7fe6-9de3-cf34-075b-c17a28e85efa@tripleback.net>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
 <20190110182413.GA6932@kroah.com>
 <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
 <20190115134221.GB30742@kroah.com>
In-Reply-To: <20190115134221.GB30742@kroah.com>

--lHtIHdhAksNhuzQkWdvJo3uC7u28p8ysf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2019-01-15 5:42 a.m., Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 02:01:48PM +0100, Rene Schickbauer wrote:
>> To be frank, your argument, which boils down to "GPL is the only corre=
ct
>> open source license", makes me ashamed to have been advocating people
>> switching to Linux. This is exactly the kind of argument that made me =
switch
>> away from closed source operating systems like Windows, only then it w=
as
>> Steve Ballmer using it against open source.
> What?
>
> No, my argument is, "If you want to interact directly with Linux kernel=

> code in kernel-space, then you have to abide by it's license, which is
> GPLv2".  That's it.  If you wish to use open source code by another
> license, wonderful, I'm not telling you what you can, and can not do,
> but please, do not violate the license of the code I contributed under
> GPLv2.


You mean "if you want to interact directly with arbitrary Linux kernel
functionality that we deem GPL-only, then you have to abide by its licens=
e"


Because the GPL-only symbol export makes it seem like most symbols are
NOT GPL-only. Why is there any distinction at all?


Why does the Linux kernel allow loading of non-GPL modules? Maybe it's
because the end user is ALLOWED to load non-GPL modules?


ZFS is ALLOWED to exist in the Linux ecosystem. It is not ALLOWED to be
distributed with the Linux kernel in binary form. The source trees can
not be merged without patent issues. No one is debating this.


What the issue here, is that previously a non-GPL module was working,
and now is not. NVIDIA is running GPL code?


>
> ZFS could be the best filesystem ever to grace this planet, that's
> fantastic, but given that the creators of that code placed it under a
> license that was specifically designed to not be compatible with Linux
> to prevent it from ever being used on Linux, well, you can see why I
> really don't care about it.  Why would I?


Asked last week for a source on this and you haven't provided any.
However, the SFLC plainly disagrees with you.


>
> Those copyright owners (well license owner at this point in time) could=

> fix this all tomorrow if they wanted to.  But they do not, so _THEY_ ar=
e
> the people you should be upset at.  Not at the Linux kernel developers
> who are giving you a kernel on which to use on your systems, for free,
> under the GPLv2.  Our position has always been very clear and upfront.
> And really, so has the ZFS license creators.  So why is anyone upset
> about all of this?  Nothing new has changed here with the license of
> anything.


The previous situation was the STATUS QUO for years. Since 2012 we had
working ZFS on Linux with SIMD extensions, and now suddenly being told
that it is a license violation.


This is why people are upset at you, because you stand here waving a big
stick and telling us that we are breaking some rule you have merely
imagined.




>
> best of luck!
>
> greg k-h
>

Message received, loud and clear. We will go back to wrapping GPL-only
exports in our SPL (GPL licensed) kernel module. The Condom Works!


Best of luck with your windmills, Don Quixote.




Kash



--lHtIHdhAksNhuzQkWdvJo3uC7u28p8ysf--

--RURbwfbcaBc1Lzm9JgJni6OAKMlQHOkMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlw+K6YACgkQLHWyk7ic
JXi0nwf8CfjuESeuA/SmIevfmW6yznMR2bQ7UHMqAlnkcoxeFmy93QT7RSiyJwP+
NAsh7up+Lvn1HaiVXa+WGI+H3kFflHV+0z1RDaQBBkD/Db6ze0YKoi8/g+W8yhtC
x12n/EavfIwYMJWwivwofYFDR9Svn3eLR3XDK/NV/633Pnjts8KQcuP+1DfOeSCn
Bhlj62ZCmunjw/R4UnIbKBzmNyrVUesgIXlM0ceav5bN15P393BX9XK9AerSy4nb
duPUgtUwLYz+kJp8jEZLkzIOriEebVIp9hARZyqU8H5New/PiIQCdsRKw2+yZC1I
hL+ydxzi1U4V1bx8a9qxJXSK7IATZQ==
=Eihp
-----END PGP SIGNATURE-----

--RURbwfbcaBc1Lzm9JgJni6OAKMlQHOkMd--
