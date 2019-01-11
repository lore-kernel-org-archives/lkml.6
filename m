Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F79CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FED20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfAKGY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:24:59 -0500
Received: from mail.tripleback.net ([198.50.226.104]:40742 "EHLO
        mail.tripleback.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfAKGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:24:58 -0500
Received: from localhost (mail.clusterducks.int [127.0.0.1])
        by mail.tripleback.net (Postfix) with ESMTP id C3647C0E65;
        Fri, 11 Jan 2019 01:26:41 -0500 (EST)
X-Virus-Scanned: amavisd-new at tripleback.net
Received: from mail.tripleback.net ([127.0.0.1])
        by localhost (mail.tripleback.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id psW4Mc9eoHwK; Fri, 11 Jan 2019 01:26:41 -0500 (EST)
Received: from [192.168.0.22] (S010664777daa9143.du.shawcable.net [184.66.63.229])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kash@tripleback.net)
        by mail.tripleback.net (Postfix) with ESMTPSA id 87A80C0CC3;
        Fri, 11 Jan 2019 01:26:40 -0500 (EST)
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190111054058.GA27966 () kroah ! com>
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
Message-ID: <37e65786-1ee6-1ce1-d66a-18e10c969e8b@tripleback.net>
Date:   Thu, 10 Jan 2019 22:24:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190111054058.GA27966 () kroah ! com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2upDJ0FKOu8LXPf81TxwwkG1TfnAElxxK"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2upDJ0FKOu8LXPf81TxwwkG1TfnAElxxK
Content-Type: multipart/mixed; boundary="OcTbKYYLy7oV9EI5hn4vvRFw2hEtyBPKH";
 protected-headers="v1"
From: Kash Pande <kash@tripleback.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Message-ID: <37e65786-1ee6-1ce1-d66a-18e10c969e8b@tripleback.net>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
References: <20190111054058.GA27966 () kroah ! com>
In-Reply-To: <20190111054058.GA27966 () kroah ! com>

--OcTbKYYLy7oV9EI5hn4vvRFw2hEtyBPKH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2019-01-10 9:40 p.m., Greg Kroah-Hartman wrote:
> Sorry, no, we do not keep symbols exported for no in-kernel users.
>
> greg k-h


Hi Greg,


Can you please address the email that Lukas was responding to?


Thanks.



--OcTbKYYLy7oV9EI5hn4vvRFw2hEtyBPKH--

--2upDJ0FKOu8LXPf81TxwwkG1TfnAElxxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlw4NrMACgkQLHWyk7ic
JXj4ZAf/Zn8AZUP/r4o5Lo5By83c69WvXz60yCT/c5c08o9vJ7G4WAKQqjOpy+wG
6rOrBbC8nNmJTn47ku07rfkIaWG5mBZ8fU9PNGfa1FFUXoirCdpzMiAiIDi8Ctgc
7Was6bpvsz7X08P71sKBwww79otnqsJL3Zr1JtvQY8FN57gIL/mKD0pP/6zm0Pd0
h+rL1++zCVft3lFOnlst7vTLrqVZtRb/Dg/iXuhcXmXNC1uLBVBplafQvkyfqQXH
VHMEn0Njm72L7uoWtAXmeeXux2DtwgO8VIM6VecvMER810YyotnlRLffbJthC1wo
wbosGu/jGzCiqUGF6w8vB+PPhw1t2Q==
=1p7u
-----END PGP SIGNATURE-----

--2upDJ0FKOu8LXPf81TxwwkG1TfnAElxxK--
