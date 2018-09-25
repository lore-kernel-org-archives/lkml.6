Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0399D20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="m/IagoWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0399D20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeIYSUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:20:49 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:59459 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYSUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:20:49 -0400
Received: from [129.217.43.49] (limnos.cs.uni-dortmund.de [129.217.43.49])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.29) with ESMTPSA id w8PCDU0T016443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Sep 2018 14:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1537877610;
        bh=TXL0pWzabghjnrE6CP7f3ySgaDu+7uqMBeBiUZvYz2o=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=m/IagoWqo4ThKKVIMCS5F9DHnXvQdRO3VY+F+qvH8Ug7aA7Z7OCUqzsonZxLU+/b+
         m45jm4pzRxIZ9B5HdKVkRGRp8hNkShocWYw9thCgnDMD9ZCHNcmtwfztrU7o3QtGiU
         TRlgZCyiKn/V5AZ+JzVjjfxnGJZe2IT9ZS8Ot5q4=
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 6NxCpAsFDwJbauda2prWMzruCg==
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Message-ID: <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
Date:   Tue, 25 Sep 2018 14:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs
Content-Type: multipart/mixed; boundary="srBuUoupMQxGmtk16jvc3cOaIRwQCeh4h";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
In-Reply-To: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>

--srBuUoupMQxGmtk16jvc3cOaIRwQCeh4h
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 25.09.2018 um 14:06 schrieb Arnd Bergmann:
> On Tue, Sep 25, 2018 at 1:35 PM Alexander Lochmann
> <alexander.lochmann@tu-dortmund.de> wrote:
>>
>> Hi Arnd,
>>
>> I recently tried to disable the BUG macros on x86-32. I disabled the
>> config item in 'General Setup -> Configure standard kernel features
>> (expert users) -> BUG() support'.
>> However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
>> include/asm-generic/bug.h (line 181) the code checks for the existence=

>> of architecture-specific variants of those macros.
>> Since x86 defines its own version of BUG(), line 182 is *not* used.
>> In the following, the x86 variant of BUG() is then used to define the
>> BUG_ON() macro.
>>
>> I propose a patch that really disables both macros if the developer
>> wants it.
>> It undefines the respective x86 variants, and defines both macros as
>> 'empty' macros.
>=20
> Maybe we should update the documentation instead. Note that the
> generic version is using 'while (1)' rather than 'while (0)', so this i=
s
> not an empty macro but rather one that does more than the
> arch-specific one-instruction version does.
>=20
> We don't really want an empty macro any more, this was used in
> the past, but causes compile-time warnings and undefined behavior
> for no good reason
I see. So the documentation of the CONFIG_BUG option is wrong?
It currently states that 'Disabling this option eliminates support for
BUG and WARN'.
Is the current implemention (an endless loop) desired behavior?

- Alex
>=20
>        Arnd
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--srBuUoupMQxGmtk16jvc3cOaIRwQCeh4h--

--plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAluqJmoACgkQWT7tBbw+
9v2uLQ//anJDuopN0CqNXjQyuQiVulhUqsDL0zdhMcmJ95dXNkqPiT8gj+tGGbXN
FEqTogl2ixf93cB/f8kprk1E/mB/OBhKr2BU130qVRPS7Vm/JJ+UBTiVFkg2etqT
Ua1lyqBRHXOo93+/t0DWxH1/P4DoDlkblz8/oPO3GKaE9OlXdrU07gCmjlcI4sNN
zFHNMkzNBOHWLDa2HaPRg7rBG+zcELBPDp7Z0Uap8cIKcrARC3QdKGQ5+pnGz64C
4FkHITb2cH2P3O7oo1FgB5iDAv6S/ca6WiDRAZNpLTbzxA9sHtHSocJll4w2T8bN
kMqLUbsg8k5Cf7zh0gVveS2xT7GLW6UmkvCctYS2DjSIiCRAg76OZAwVLpmrDD0E
IX+l4WYs/PHg29aH61LpmNeRwDRxWFehPKrUAjNIUCv/MuFF01rELQTJ+GAQtJzP
WHNGnEC0nN9VokCNjp3LxiGpUvkRRr8nyko/WgPdujAt8n8R5QjmBPTL+nG7XvAV
UEFA/khdyW1piLmgb8LM/Q51c2CGLec9GfRzqx8L9Uv2tdX80bR2vtJf7ebA6UzI
0DTc/2wSen5uVmo5BtRm96QOvlsV+wbF5ziouL0S7GjIAI/4/pEsl1vtscdc2+Rw
a+Ji6s7T6HfMoE0bGb3L0NWgGsdfv+VKoeZyZEYCGX2syGjlIvI=
=KN5L
-----END PGP SIGNATURE-----

--plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs--
