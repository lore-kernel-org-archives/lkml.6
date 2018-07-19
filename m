Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0CAECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5845E20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5845E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGSBrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:47:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55765 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbeGSBrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:47:53 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=[10.1.1.142])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1ffxPa-0007Eg-1H; Thu, 19 Jul 2018 01:07:18 +0000
Subject: Re: [PATCH v2 net-next 0/7] Make /sys/class/net per net namespace
 objects belong to container
To:     David Miller <davem@davemloft.net>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org,
        stephen@networkplumber.org, dmitry.torokhov@gmail.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
        containers@lists.linux-foundation.org
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
 <20180718.131734.1797450417729100374.davem@davemloft.net>
 <20180718.134152.1719446664161643330.davem@davemloft.net>
From:   Tyler Hicks <tyhicks@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tyhicks@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dad209c0-563c-d8ea-5f8b-ed4c0021f283@canonical.com>
Date:   Wed, 18 Jul 2018 20:07:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718.134152.1719446664161643330.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk
Content-Type: multipart/mixed; boundary="SYyfqBDulpHiaenaVSsRmxzdaLsVgPkeX";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: David Miller <davem@davemloft.net>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, stephen@networkplumber.org,
 dmitry.torokhov@gmail.com, ebiederm@xmission.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org, containers@lists.linux-foundation.org
Message-ID: <dad209c0-563c-d8ea-5f8b-ed4c0021f283@canonical.com>
Subject: Re: [PATCH v2 net-next 0/7] Make /sys/class/net per net namespace
 objects belong to container
References: <1531497949-1766-1-git-send-email-tyhicks@canonical.com>
 <20180718.131734.1797450417729100374.davem@davemloft.net>
 <20180718.134152.1719446664161643330.davem@davemloft.net>
In-Reply-To: <20180718.134152.1719446664161643330.davem@davemloft.net>

--SYyfqBDulpHiaenaVSsRmxzdaLsVgPkeX
Content-Type: text/plain; charset=iso-8859-7
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/17/2018 11:41 PM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 18 Jul 2018 13:17:34 +0900 (KST)
>=20
>> Ok, I can't let this series rot forever, so I'll apply it to net-next.=

>=20
> Unfortunately, I had to revert, this breaks the build:
>=20
> arch/x86/kernel/cpu/intel_rdt_rdtgroup.c:1506:7: error: too few argumen=
ts to function =A1__kernfs_create_file=A2
>   kn =3D __kernfs_create_file(parent_kn, name, 0444, 0,
>=20

I've got a fix for this. New __kernfs_create_file() users were added
since the v1 of the patch set (defconfig didn't build that code for me).

However, I'm starting to question my assumption that sufficient access
control checks are all in place for the attributes affected by patch #5.
I see a few affected attributes which don't make any capable() calls and
I'm not yet through the entire list.

My current plan is to roll in my build failure fix, drop patch #5,
retest and resubmit as a v3. I wasn't able to get to that today but
should be able to by the end of the week.

Tyler


--SYyfqBDulpHiaenaVSsRmxzdaLsVgPkeX--

--JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAltP5D8ACgkQ1pIAPaoC
xwpKHw/+MIZqS7/PRgROGbYnvtD8DL0Uq9pmxlgxpzF5X4u7IkDXaj8qy835Aiq9
Scs0Up65fKSV1EA9hy89qzwlo8infV+1TpmXMG3OomMsBhmM9wW0xvnnqNZupXvn
rbW1mWl05v/Q/trVdkO2cXsxo2okTXWUWbXYZwmL9gOn1yjqcSzysLPYR4EbHHgR
4br/3cqTrUgifFvcVLnvj4oWX5DxLOSQWLa009dIcow08U8fodZuXSgsi6QPYSF6
YNN5mOwhOY/U+p7mw7txaJ6GG3HEThJfE7+CGwOiEKUdtpUaGaZb/EmEvQMQifBC
9QUDbKcI1RGQnT3ZH8W+g+FD1PV8dMqkfnKXLCvnv10KRHLLDAHDnAJQIAfQyOvi
9M2vPymfVETcOUrtHopvaSkDUEJmzpZbkvapJvc4wetp29PBayE4D0dyK+3OpQsL
/PQfcP0rQmciDZ6DB+ofq+s5cwzJiNLzSljul62Whi1xA2WjoCO7LOnk6ekTQeI9
nTMhitm/9pSVnkv/Ri/KVW0bphlgSdf8WyouYBKTiLVlUjYaIT5ZAM0Tm/PzQyDa
7RMT7iDpH8EVZUZgA7mkZ4BaD7Ok2XAX7oOk4BDn94tIBc9U5XDqKqhpI1P4lIUm
E+CUcB9LBqlD6rT5zb2LNNFwyN/BKjV0j7kAzsK6xNKYIrCdN5A=
=G7fw
-----END PGP SIGNATURE-----

--JSw5pJ8zZCD2mj6t5JXgDnuM08QitYcsk--
