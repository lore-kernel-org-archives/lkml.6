Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1594630-1522086867-2-7998700523127208654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522086867; b=t7HC6rNA2NU4EDe7sN6Ktn/XkS3+yaph42tQs6P0yVYvuFy
    CBJVrlEvRAV79EJEZ28McNByrCTLj9UTjCCLuo2VH10bFsnJwzMqg8mke9T+vwMl
    2Zx9PoY/OSp/38ski+NRqLTOM5+TpnjIQHT1mHNb2ei56iB7+ny4mX+HPEp8AKee
    PuGUb5g9/NXDAhxiHM41VAmUMCS/pdOXwFKVPQXp6MSvEyDvncEZ22LOMnL1o47X
    ZQp3WPelERDz4PMpRDmjQrg+O9cxpgv+0wLO06JZCNUCk0OHdlLvg9nNy3zYCcw9
    wPJINRRRS9C6/DYPN9oLEEHYDZtgJtIIPsJYDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1522086867; bh=j0isFeY/fBofarq1DlRNdF4XrLBmite/LoTFi/
    CMb6w=; b=pbXgVPQMEDJuStRNN9A+gcEyR+fJkC1DWxcjouFySecrVsfZUkqGxw
    rAMBDBKttz0lQFIfssXlaGkAhz4JvPEhYfUzzETBgzhCytQvXoMzzRx0uqeAJdq5
    ZRxcs4DwZQIRI3//nIq7bUd+3qBxHAcdSv6Gt43/c/3VG5pwqnJL6hbGPgetgVaM
    dKZywBjaRJ2UvsLhrGbgHTsD5SNg1AhhBMbV+Dijcr5S1y9PCvQxIojAkWn1ruxJ
    BbjA+VbJaw/0Fjk7sXEQTTUIdg8ajSQeYrpVvOz43PPyPD5bASzPK9GSgpdfBh+n
    5tsx9OKYCnJUZDaaBqrgzxut/SN59H3A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tripleback.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tripleback.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tripleback.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tripleback.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFikbOFWtFLDi4PfTibozO6nhVdP6N4YfEE05xNEVnN2T9WcAnHstJFN6n0ekVyzL1IQbeg1xXayZacKvJP/r2LcoKuuoIBLNjzNHZbiXn/4I+7NA/B2
    7Xz3DueuhoMygIvRLHAO3JRNvwqQf1UL81AEEGf+DZtrC5L5JqHBOzYzCZ4BzZ/EhT+Kiuq7mVTw0chvoing9C8p5hvhOWThWqqqENEKIs2aEZ7oGe4Qh+rd
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=DWDKLPo_AOAA:10 a=v2DPQv5-lfwA:10
    a=13zjGPudsaEWiJwPRgMA:9 a=XdXc_duy0lFmXYtPhl4A:9 a=QEXdDO2ut3YA:10
    a=uhJ0MlkbmimekIc2UwEA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeCZRyY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 13:54:24 -0400
Received: from mail.tripleback.net ([198.50.226.104]:50324 "EHLO
        mail.tripleback.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeCZRyX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 13:54:23 -0400
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180316152329.844663293@linuxfoundation.org>
 <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
 <20180319182032.GA23774@roeck-us.net>
From: Kash Pande <kash@tripleback.net>
Openpgp: preference=signencrypt
Autocrypt: addr=kash@tripleback.net; keydata=
 xsBNBFk4mtYBCACd55EsQx9d/7r6jPgo9+Niwyv6QBYGBc5ww9pPOBrN0oSO47Hm+oSOO5Bu
 yywIw4U5DTUtvdj7elfnsJMhunduhc2P8p7rhLxcQeFIm+yghOepkjqhxTdFLsgavmcnubxy
 Olc29b2fByIVXnFAwHypgpHEqEWTHp2cnNVOtuO9GeIr8YxB+wO4Z5rDnNnEsOuLSJq9kG9c
 uoI8RF+StEBmYVRCfELhafBlluURLRPO/Uoax8+wFyq4/d3iDVtKyrDdvxLG0aXkj3Wfc6rY
 l8trOQl1zw8dCfJMw0+LPaj2EVza1HGCdhgIrg2cS1nKNjNDnIZB/8RwBU99FIY1xoGXABEB
 AAHNO0thc2ggUGFuZGUgKEdlbmVyYXRlZCBKdW5lIDd0aCwgMjAxNykgPGthc2hAdHJpcGxl
 YmFjay5uZXQ+wsCOBBMBCAA4FiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlk4mtYCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AACgkQLHWyk7icJXiG1Af9HI1f87UPQPEpsWVHuoeMlPra
 NPrefNZ+O1vnQEdTHEQ+Mc49ozLtpdrpi0VqKYlsdVHxhY5YbzyTC2tdHtiL2LTwbnkrqKMN
 6DJSiogXFLH/q+SzXoAUxqN8rrRptVEHSYrxENt+ZN5R0A071QrURdEa2vLXicjMGitvdVcV
 pxdRLJgSqQygSlKysoQsY2vvgRujD322BEwDqgq3XWCMIo3ld/riMSCiO8ShCvmqojeWRfh2
 ComhNSzzbn2oGUceEJRJ++mv+0i1jMzO+9L5qsrYnH7KnPA1HsORqHGi7+wJdRn4zG/+g+Ey
 hoTk2WVCDC/Gp4t9CYeQOa/rC1kxm87ATQRZOJrWAQgA75dQD3FhNz1JDUuAEDRpKOJA7A1A
 t11ItkvolADQwJYtAqoMjFybAG+rN+H2+6CLFsShO2RLY8K1FJVPy31am9qeY5WWO1PhU3tg
 PHVeGOYF/mWTxNBKSwZgfWo8cOT9OcUTjTTR8z58kEcbZJ6PtiPyCsk2MKFMT+OcJ3w7GB2K
 KViN5L4f4sBOOgFZ5U+hNNcLOTmYk8ba2w0GnT4ePnidby8XStGIt1sVeNkbD2hdRUdXtpku
 OKQ2iw/j/GBo7+B7lYMBOSZaxKwpyEt7DPSJuLATSu6l16oDk4uqXulXC1td1fXfXfGLudHN
 sXUJDE/0jf2r8Mi3rPUdPn+dpwARAQABwsB2BBgBCAAgFiEE5MQWwRLWQeWW1A0MLHWyk7ic
 JXgFAlk4mtYCGwwACgkQLHWyk7icJXiv4gf7BqzcEq7IYUIMUI/ubyQuKdASfLHxbGmEJkxk
 Q7iPf38zLucS7jL3XnXrhkU4rzNneaQ0jn/bYhyo2ZDrmIloSOIYQPJTdCU53waLqbdgOSZH
 zVm7aFHVs7/C/joNxZ9Qcg75zdhAJP1bTWTBdmvofJFjwV3YXxhW9U0qIt6Dqq4IQ6TB2tzw
 bMiVH+IeWnlIwBScamT3DAXmu4CxKUpgkqmFsDL2aZve1ZUxwMwgblDZqBKdZoLJEYQ4Llf6
 JXZmkBNIuO8GA0ZGamjEOvxwn3OYPd7I2FQESawdKNAzv734vCCYELEQFP2mh04B32bEH4ei
 2oovF94E7UQCVIZg7Q==
Message-ID: <6b6fca54-9cd9-3c62-6c0f-b5e8477947ac@tripleback.net>
Date: Mon, 26 Mar 2018 13:54:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180319182032.GA23774@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u2sqS8FNQGc7gRycDNQmr2Vvx0mdXT5DD"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u2sqS8FNQGc7gRycDNQmr2Vvx0mdXT5DD
Content-Type: multipart/mixed; boundary="iwQPvyWA5gPyjQs2htvxqWffC6h6DV7CN";
 protected-headers="v1"
From: Kash Pande <kash@tripleback.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuahkh@osg.samsung.com, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
Message-ID: <6b6fca54-9cd9-3c62-6c0f-b5e8477947ac@tripleback.net>
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
References: <20180316152329.844663293@linuxfoundation.org>
 <7ec4a6aa-72cb-9fb6-5168-d1c4d49f1a6c@tripleback.net>
 <20180319182032.GA23774@roeck-us.net>
In-Reply-To: <20180319182032.GA23774@roeck-us.net>

--iwQPvyWA5gPyjQs2htvxqWffC6h6DV7CN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2018-03-19 02:20 PM, Guenter Roeck wrote:
> Ryzen and Threadripper are only supported in v4.15+.


Nope, the offset for 1900X is not available in 4.15, I've had to
manually patch all systems otherwise monitoring complains they idle at 53=
C.



--iwQPvyWA5gPyjQs2htvxqWffC6h6DV7CN--

--u2sqS8FNQGc7gRycDNQmr2Vvx0mdXT5DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlq5M80ACgkQLHWyk7ic
JXhwDQgAhJh4bdd6iG8zerLvvFK3aImzPDhzxt7UML5a4XsGDuV6e2ncp9Xnjg2M
1u9m0nzHvQkrZ9LRBjVHjVNmJ3KVSyshIG8RWGoKvR4NKTyZAUx8OBvWAcmiewob
nHNJf6o4c4sp18VdXVfjDxIIliPhiHLTBcxXknzlH3kLRWoq6Cba+aGm4YY3T57p
9W6jfWDRfQ9oaqGcuT4GNQ+WcISw9Q2b4g+Tp7T4/B03Xt4grbijLG1BM3ITN/+D
LXRvW95ISb+soLrksJQvsPELPLFY/1TyPFU+53Nad5gjHhsRTkTyBN6QYOP6SqMq
XWT7U8rOL4s/FvY64bugkIDTX4ut1w==
=C/dm
-----END PGP SIGNATURE-----

--u2sqS8FNQGc7gRycDNQmr2Vvx0mdXT5DD--
