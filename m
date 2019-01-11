Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E31C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E9320660
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfAKDQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:16:49 -0500
Received: from mail.tripleback.net ([198.50.226.104]:40472 "EHLO
        mail.tripleback.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfAKDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:16:49 -0500
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 22:16:48 EST
Received: from localhost (mail.clusterducks.int [127.0.0.1])
        by mail.tripleback.net (Postfix) with ESMTP id 1A999C0E65
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:09:11 -0500 (EST)
X-Virus-Scanned: amavisd-new at tripleback.net
Received: from mail.tripleback.net ([127.0.0.1])
        by localhost (mail.tripleback.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O7vEHoVDEntv for <linux-kernel@vger.kernel.org>;
        Thu, 10 Jan 2019 22:09:10 -0500 (EST)
Received: from [192.168.0.22] (S010664777daa9143.du.shawcable.net [184.66.63.229])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kash@tripleback.net)
        by mail.tripleback.net (Postfix) with ESMTPSA id 3F1B9C0CC3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:09:10 -0500 (EST)
From:   Kash Pande <kash@tripleback.net>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
To:     linux-kernel@vger.kernel.org
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
Message-ID: <a4c5c516-bf38-cc7a-bd4c-f0f3297e855e@tripleback.net>
Date:   Thu, 10 Jan 2019 19:07:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7wDvpqP4iyaq4TMwcpbK9lyiT9BKJF1G4"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7wDvpqP4iyaq4TMwcpbK9lyiT9BKJF1G4
Content-Type: multipart/mixed; boundary="RiJlwvZCYZbDrpFhjxoBOejVTgRNoqYYQ";
 protected-headers="v1"
From: Kash Pande <kash@tripleback.net>
To: linux-kernel@vger.kernel.org
Message-ID: <a4c5c516-bf38-cc7a-bd4c-f0f3297e855e@tripleback.net>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()

--RiJlwvZCYZbDrpFhjxoBOejVTgRNoqYYQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



> On Thu, Jan 10, 2019 at 07:07:52PM +0100, Sebastian Andrzej Siewior wro=
te:
> > On 2019-01-10 17:32:58 [+0000], Hutter, Tony wrote:
> > > > But since when did out-of-tree modules use __kernel_fpu_begin?=C2=
=A0
It's an
> > > > x86-only thing, and shouldn't really be used by anyone, right?
> > >
> > > ZFS on Linux uses it for checksums.=C2=A0 Its removal is currently
breaking ZFS builds against 5.0:
> >
> > So btrfs uses crc32c() / kernel's crypto API for that and ZFS can't?
> > Well the crypto API is GPL only exported so that won't work. crc32c()=
 is
> > EXPORT_SYMBOL() so it would work.
> > On the other hand it does not look right to provide a EXPORT_SYMBOL
> > wrapper around a GPL only interface=C3=A2=E2=82=AC=C2=A6

> Yes, the "GPL condom" attempt doesn't work at all.=C2=A0 It's been shot=
 down
> a long time ago in the courts.

SFLC maintains there is no kernel licensing issue[1].

As a side note, even Hellwig's suit against VMware was dismissed (he may
appeal)[2].

Debian and Canonical base their decision to ship DKMS source for ZFS on
Linux[3].

The GPL does not disqualify a user from compiling ZFS or Linux however
they see fit.
It is only the users' distribution rights that come into question.

No one is combing ZFS into Linux or even distributing binary modules here=
;
we're following the terms of GPL.

> My tolerance for ZFS is pretty non-existant.=C2=A0 Sun explicitly did n=
ot
> want their code to work on Linux, so why would we do extra work to get
> their code to work properly?


1. Should your personal feelings affect the quality of the Linux kernel?
I say no.

2. Did Sun or Oracle ever release any statement of any kind that backs
your statement?

3. What extra work is being done here aside from the dropping of a
pseudo-protection,
the "GPL ONLY" symbol export? Something tells me, even if someone else
did "the work"
and submitted patches, you would find a reason to tell them to get
stuffed and leave
it "as-is".


With all of that... why have ANY kind of tolerance for out of tree
kernel modules at all?


[1] https://www.softwarefreedom.org/resources/2016/linux-kernel-cddl.html=


[2] https://opensource.com/law/16/8/gpl-enforcement-action-hellwig-v-vmwa=
re

[3] https://lists.debian.org/debian-devel-announce/2015/04/msg00006.html




--RiJlwvZCYZbDrpFhjxoBOejVTgRNoqYYQ--

--7wDvpqP4iyaq4TMwcpbK9lyiT9BKJF1G4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlw4CGIACgkQLHWyk7ic
JXh9Mwf/bw/0NH40luX/XVbEwn9LlkwAld8X/nuMnUw08I17FqL9ZQxdlJa78Q3v
JslpAChnVURV5TvpJ4Jb99JuqLwJVRzZWYXfhV/LjVF2Xo6SmSAzkaBHDfj1Q59g
wXjv6f0hDCU1Dw5Fx+bNn/AtPY6/o57Y57CTnM8E+fLB/zp/v/v3Cb7XBpDv4la2
DFkRDv4JcKfi6M7qxsb0Hwjy9Gg5lvfuXJlThTsP8OMIHIOjucRGBQcMzAZqs4d3
kkzfVy//7nnYC9UXe2ZK4wvLLVEHGvT0t8+NprXw3dWG0ZIDZ3gYJ4PW4qIthTIq
JznsVeEEg98I+ocRmYFYjmbZotRHqA==
=9vPG
-----END PGP SIGNATURE-----

--7wDvpqP4iyaq4TMwcpbK9lyiT9BKJF1G4--
