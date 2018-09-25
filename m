Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3CDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2883020880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2883020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeIYTF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:05:56 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:42984 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeIYTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:05:56 -0400
Received: from [129.217.43.49] (limnos.cs.uni-dortmund.de [129.217.43.49])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.29) with ESMTPSA id w8PCwQM7023901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Sep 2018 14:58:26 +0200 (CEST)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
 <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
 <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 6NxCpAsFDwJbauda2prWMzruCg==
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Message-ID: <cb93221b-d4b3-d442-7c8d-97022cfdbe80@tu-dortmund.de>
Date:   Tue, 25 Sep 2018 14:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU
Content-Type: multipart/mixed; boundary="cJKPIHbMi1BlL6u3FTCAFsNDb9ONDGZSH";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <cb93221b-d4b3-d442-7c8d-97022cfdbe80@tu-dortmund.de>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
 <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
 <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
In-Reply-To: <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>

--cJKPIHbMi1BlL6u3FTCAFsNDb9ONDGZSH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 25.09.2018 um 14:20 schrieb Arnd Bergmann:
>=20
> I think it's the most reasonable implementation, otherwise a
> function like
>=20
> int something(void)
> {
>       if (x)
>          return 0;
>      else
>           BUG();
> }
>=20
> will return an uninitialized value.
>=20
> The arch specific implementations usually just contain a trapping
> instruction. With CONFIG_BUG() you get a nice console output
> that indicates where this happened, but without CONFIG_BUG(),
> this is just reported as an invalid instruction (if CONFIG_PRINTK
> is still enabled), killing the current process.
>=20
>        Arnd
>=20
I see. In that case, you should really update the documentation and help
page of CONFIG_BUG. In its current version it is misleading. It can be
understood as 'It disables that macro completely.'.

Although I know what the purpose of BUG()/BUG_ON() is, I would not
consider the above example as valid C code....
Defining BUG as an endless loop to overcome GCC warnings about not
returning a value is a dirty hack for me.

- Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--cJKPIHbMi1BlL6u3FTCAFsNDb9ONDGZSH--

--i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAluqMPIACgkQWT7tBbw+
9v2ARBAAln1pTyi+L4yWoHlhEAekRa9SaU6BtKiobke2SvtSEgdbrmqpQLTMPiPi
vpOPBg8seQz40tEl1PbcOu0lP0zU8sBemLZN61GreTXrjUzahBLw1Enjsz3wSwR6
rpifHSso1wjNzQaIGV0YhbRCI+94EUZ0ybZvHUtbh9502rHqhc5VP5Pf7xg4iPob
x11Aqt5ZXXNeY8m7wmrspSn8Iux1F7+tQsOC+25UVziCn7Jh6lM/XRDIeUfYHmo6
PvZkA72I2LXnmX3+DqTja8jrYDIYfbL0b299MQPVLL/hYcbOYLeejjwudiJ3cv6E
v5LRei9K8Q1GK68HpRUk6+emKbkoZKhJdnhqzFHNEW4VvFRE6NufRW7hIHky7LXD
JP/TE1u89b8eZxg0nfNJiysliyoNN8O73kKdeiRQuDETkHcT4MJSrkcXy1zljFsR
emqcOloWJ6Lc1V+tWrby/7hEDiuV/qbDL2XejncgPdNKSHI+2cIiDmn8waU51uA7
fgmLkdwhYUjTGIJx6dJLEcJti7pxADkn/hXHNAY7qFXCH/nv5v7lDC4AGvNZxdcV
ezOHxyrZyHH5/lqJy4zZRwc46UEQOpSj+27M0WOy+8EAEg3aOjbePpuWiFJdXLlp
ZTLfnCQCSb6oJ8l481HhMAFImSYOgts3Mofh+tWSs178GN7lils=
=wr1i
-----END PGP SIGNATURE-----

--i7GBXgWhhOXDNszIRg5BZd7zKotn2cReU--
