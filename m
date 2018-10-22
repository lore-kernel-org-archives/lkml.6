Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C24C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB05820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB05820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeJVTjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:39:07 -0400
Received: from rhcavuit01.kulnet.kuleuven.be ([134.58.240.129]:60185 "EHLO
        rhcavuit01.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728354AbeJVTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:39:07 -0400
X-KULeuven-Envelope-From: tomer.ashur@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: E0A2B12033A.AF1E8
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit01.kulnet.kuleuven.be (Postfix) with ESMTP id E0A2B12033A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:20:52 +0200 (CEST)
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTP id D1117200A4;
        Mon, 22 Oct 2018 13:20:52 +0200 (CEST)
Received: from [192.168.0.216] (94-225-4-238.access.telenet.be [94.225.4.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 972C42002C;
        Mon, 22 Oct 2018 13:20:52 +0200 (CEST)
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Tomer Ashur <tomer.ashur@esat.kuleuven.be>
To:     Paul Crowley <paulcrowley@google.com>, Jason@zx2c4.com
Cc:     ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        samuel.c.p.neves@gmail.com
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <CA+_SqcDszvqfH7qvEyi8QW2RqkA1kpV6L7VWxhtw5Ogzeovhbg@mail.gmail.com>
 <2395454e-a0dc-408f-4138-9d15ab5f20b8@esat.kuleuven.be>
Openpgp: preference=signencrypt
Autocrypt: addr=tomer.ashur@esat.kuleuven.be; prefer-encrypt=mutual; keydata=
 xsBNBFq7e1cBCADl9o3iK+KE7NmqiPdSi6g7fuVEPVm/jjCNAvngjgQiJxuJUMZVFxJFkrqS
 dPuSa2T4WR8Wq8Vpu4sHzRF1i2FoGRLDVYQqG+aAfbOf0AA0JYT858txrQumHKZmtkIy6kMl
 UV5mKVvhbDf2FOd7VgP5vPzOldxQW2sT1KfvVz4BnEPXW56xVRWGItz/bIOFqMyVcIEBZLv9
 62JJiwkAqqQzUuXqnG1vynNiEFR11xbaHKrHXEzIxaoyWSWeT/Hos0sxPbu8xXNbT7gXw/l/
 xWiWz1SG/+EiLH4kKRX6njc/jocOO+Frp+7Hm4BZijH1kzg64npfiWLn7zZMfyv/RaXTABEB
 AAHNKlRvbWVyIEFzaHVyIDx0b21lci5hc2h1ckBlc2F0Lmt1bGV1dmVuLmJlPsLAlAQTAQgA
 PhYhBAM0ctHuTtFGXc2zVJ4uaAZ1uDC3BQJau3taAhsDBQkB4TOABQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAAAoJEJ4uaAZ1uDC38i0IAN+prJRYKvKGbjhXSbCnRnVRflxg7Sjr18YSatcD
 aWv0wQgNe+h6HYM7nMiaa2HRjuH7vZKTb+By810KSIfb9WuTJW9kmE8q2VXsVc2r2pF19A1D
 rpNdRrT8zYqlwyZDDkLW5UfBieKs0rX/2aCM2uFrou2A4ptLHqH99jy/J705F6ExQbwAHwFg
 rC5Q3SBsInKPr0ud0K6T3swIuOkoG8J90lcr3i4iX+kYB8UC0TlziZCQqdRuTprkXpQIyr4V
 iKyrumDaSldGbPiyEdgVzo7K6O4UOcBwFdqyK+H63hFFZZPp7rjY9aPKZ8gfOXfUtbm9curz
 FSBPiPvgBtv4MnnOwE0EWrt7WQEIALmvnjV8jKXy3Yjv3TcTAp3oSTTFhS5kIzA57orfBR69
 87Oh979e0prMIVv8nUwt+oKN2aTmOZ0NndW+kOQe32evyL5+J4yLYT6HA6Cy/3C67DMTRd0d
 NSV9yew3Q1ZHkHFDtyBruTaZhH6rRY/XspTVm97XXWE74bwS51lBxbax6JPwB1NCBuz7WiJM
 vTCGQJP7NuMJGA8vBV48ByDno52r8tub0a/gX8mgMuQvQgAt7WZvzme9Gh/GFFkDMKnIpkck
 HITry6hWZhX+HdL52L1oZtXuou2nkHsdBChcVCKdR8GK4eZtAhLUI/p1bJHF7qefsdugRbZ5
 cJfHUQtI10MAEQEAAcLAfAQYAQgAJhYhBAM0ctHuTtFGXc2zVJ4uaAZ1uDC3BQJau3tZAhsM
 BQkB4TOAAAoJEJ4uaAZ1uDC3nokH/0RQzQmYBwR/HNAz+xQl8wN0ExT6Ywiapd3dinb6XT+n
 Zn0cFO9gU3FJBaNqeTvhV5JQ0IaiHQ0k+geGTfI4TwmJDrersVpkT+zSmeVUqhGwhksLdnGs
 kx6iw/Z8l/KP9j7upX+dlWJ3WPv7U4rOIhZaGhVk6IRWY/DnMpTalHYvzBGscjCj+8z+bvYy
 3t/AE/YEacnCv9/76Bz+9f+19lYEOeFkeGlkkyha9NCFoW3yz4OswS35lYZ7wI7Ox9q45krv
 zhGCIcSMNKhTg9t/vTKRy8LXt8n5Em1M/Zx1mVUh7O13lcnouyzTdD66JRKwjjlpc7zcmKZU
 6oWKLq8NQ2k=
Message-ID: <ebd9d96e-4a2c-528d-b8e8-67907f2a8be0@esat.kuleuven.be>
Date:   Mon, 22 Oct 2018 13:20:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2395454e-a0dc-408f-4138-9d15ab5f20b8@esat.kuleuven.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZCGfLrfVDy08N23smGRyOzruVLw2UfQ7R"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZCGfLrfVDy08N23smGRyOzruVLw2UfQ7R
Content-Type: multipart/mixed; boundary="qhDwaa5xkREPzW5outG79AHHk1KOV8i1d";
 protected-headers="v1"
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Tomer Ashur <tomer.ashur@esat.kuleuven.be>
To: Paul Crowley <paulcrowley@google.com>, Jason@zx2c4.com
Cc: ebiggers@kernel.org, linux-crypto@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Greg Kaiser <gkaiser@google.com>, Michael Halcrow <mhalcrow@google.com>,
 samuel.c.p.neves@gmail.com
Message-ID: <ebd9d96e-4a2c-528d-b8e8-67907f2a8be0@esat.kuleuven.be>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <CA+_SqcDszvqfH7qvEyi8QW2RqkA1kpV6L7VWxhtw5Ogzeovhbg@mail.gmail.com>
 <2395454e-a0dc-408f-4138-9d15ab5f20b8@esat.kuleuven.be>
In-Reply-To: <2395454e-a0dc-408f-4138-9d15ab5f20b8@esat.kuleuven.be>

--qhDwaa5xkREPzW5outG79AHHk1KOV8i1d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

> On 19-Oct-18 8:19 PM, Paul Crowley wrote:
>> I would prefer not to wait. Unlike a new primitive whose strength can
>> only be known through attempts at cryptanalysis, Adiantum is a
>> construction based on
>> well-understood and trusted primitives; it is secure if the proof
>> accompanying it is correct. Given that (outside competitions or
>> standardization efforts) no-one ever issues public statements that
>> they think algorithms or proofs are good, what I'm expecting from
>> academia is silence :) The most we could hope for would be getting the=

>> paper accepted at a conference, and we're pursuing that but there's a
>> good chance that won't happen simply because it's not very novel. It
>> basically takes existing ideas and applies them using a stream cipher
>> instead of a block cipher, and a faster hashing mode; it's also a
>> small update from HPolyC. I've had some private feedback that the
>> proof seems correct, and that's all I'm expecting to get.
>
I tend to agree with Paul on this point. This is a place where academia
needs to improve. An attempt to do so is the Real World Crypto
conference (RWC; https://rwc.iacr.org/2019/), but the deadline for
submissions was October 1st. For HpolyC I asked a few people to take a
look at the construction and the consensus was that it seems secure but
that the proof style makes it hard to verify. I haven't had the time yet
to read the Adiantum paper (and I'm not a provable security person
anyway) but I suppose Paul took the comments he received on this into
account and that's the best we can hope for. Academia simply moves in a
different pace and has different incentives.

=C2=A0Tomer


--qhDwaa5xkREPzW5outG79AHHk1KOV8i1d--

--ZCGfLrfVDy08N23smGRyOzruVLw2UfQ7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEAzRy0e5O0UZdzbNUni5oBnW4MLcFAlvNspMACgkQni5oBnW4
MLcIRQf/SqN6tRXG9BL2vpVuxnoCUhohnGRKU41x21akRIDoEOt7MkJBntNIpJ7J
byG2eTv6FO7CB5J/6Ecc9S8rODO3rKOHTaV3wUNzH7xd6EQFEqI9i3ScBDWCTI7n
3QPBO25rrGCaWj+cMNBeqzjU6i7Sg3EBE6EYxZZoFnhOBIVpbcGFVXuwPY5Gx5Qt
/9tA9XrzPbRhCBoCmgNelIcZOBFOhWEmWZA/cdXNaTzAKgDEkBPmMmVakdb32QVs
DftFGaug1CuYWeDPScQYkthyIpiOV78YrjX7UI0PluD/55VqUOVYsBNy90uBG9eC
rUhnw6qW7/nVoEyC8tihQT6H6tEKMQ==
=HeL5
-----END PGP SIGNATURE-----

--ZCGfLrfVDy08N23smGRyOzruVLw2UfQ7R--
