Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CA920879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfAKDS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:18:29 -0500
Received: from mail.tripleback.net ([198.50.226.104]:40502 "EHLO
        mail.tripleback.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfAKDS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:18:28 -0500
Received: from localhost (mail.clusterducks.int [127.0.0.1])
        by mail.tripleback.net (Postfix) with ESMTP id C0CD4C0E65
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:20:10 -0500 (EST)
X-Virus-Scanned: amavisd-new at tripleback.net
Received: from mail.tripleback.net ([127.0.0.1])
        by localhost (mail.tripleback.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IBzYReyc-vrO for <linux-kernel@vger.kernel.org>;
        Thu, 10 Jan 2019 22:20:10 -0500 (EST)
Received: from [192.168.0.22] (S010664777daa9143.du.shawcable.net [184.66.63.229])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kash@tripleback.net)
        by mail.tripleback.net (Postfix) with ESMTPSA id 410CCC0CC3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:20:10 -0500 (EST)
From:   Kash Pande <kash@tripleback.net>
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
Message-ID: <c9021705-9987-f7c2-e60c-15a09b87d345@tripleback.net>
Date:   Thu, 10 Jan 2019 19:18:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190110182413.GA6932@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="22qyMCs7nZTvjT8mrSQ4UPDVpjfNB3kF2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--22qyMCs7nZTvjT8mrSQ4UPDVpjfNB3kF2
Content-Type: multipart/mixed; boundary="HzI38cCvj5fRe9GmYjc7dA0a6lCD67aSU";
 protected-headers="v1"
From: Kash Pande <kash@tripleback.net>
To: linux-kernel@vger.kernel.org
Message-ID: <c9021705-9987-f7c2-e60c-15a09b87d345@tripleback.net>
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
In-Reply-To: <20190110182413.GA6932@kroah.com>

--HzI38cCvj5fRe9GmYjc7dA0a6lCD67aSU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


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






--HzI38cCvj5fRe9GmYjc7dA0a6lCD67aSU--

--22qyMCs7nZTvjT8mrSQ4UPDVpjfNB3kF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlw4CwAACgkQLHWyk7ic
JXgdswf+OokFiaor7rWVn5pUBtKjzGAmwsJfS5WCxrScSHz7wbBYDfeMWo6vDH6o
CqHTARo8HNfjMlcT5NiuTs9oWecD6N5xCztQr4PkMCtbdJuhZFA8gw0hqUDnUAHH
ndP4RIW5UDz6xmFn6VYKgis0qJlYmLsNYHl3mTb3S0MMb2x481ML0jbaLSByjL2A
+rkCpE64VnthfWTBqVzKq9d1JsW3MTfKGoiJS6eF05ODiJfsuIiTMcR7oTeksV2T
IuOKYar9RVJctFaZv+PCSIFNVKHkBjzeRWJfznFzFrpcO0pba7JBKOf4g7PjlEHN
0bdNE7nH/IjlfI5C7kSIN+nyWirUPQ==
=+33t
-----END PGP SIGNATURE-----

--22qyMCs7nZTvjT8mrSQ4UPDVpjfNB3kF2--
