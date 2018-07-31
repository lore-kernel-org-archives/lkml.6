Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF6AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D9920894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D9920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeGaPfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:35:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49308 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732169AbeGaPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:35:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkV7W-0002Qz-PC; Tue, 31 Jul 2018 13:55:26 +0000
Subject: Re: [PATCH][media-next] media: i2c: mt9v111: fix off-by-one array
 bounds check
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180731133343.22337-1-colin.king@canonical.com>
 <20180731135341.GD370@w540>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c2684aa2-71d7-b82e-df18-65ea3f026d97@canonical.com>
Date:   Tue, 31 Jul 2018 14:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180731135341.GD370@w540>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LZ1qMDqUuxCCXYuIsl94ncFyuaq2aEgbe"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LZ1qMDqUuxCCXYuIsl94ncFyuaq2aEgbe
Content-Type: multipart/mixed; boundary="xJWLQlqaIbhqGrEllJgQyVPkM8z6YSdnR";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <c2684aa2-71d7-b82e-df18-65ea3f026d97@canonical.com>
Subject: Re: [PATCH][media-next] media: i2c: mt9v111: fix off-by-one array
 bounds check
References: <20180731133343.22337-1-colin.king@canonical.com>
 <20180731135341.GD370@w540>
In-Reply-To: <20180731135341.GD370@w540>

--xJWLQlqaIbhqGrEllJgQyVPkM8z6YSdnR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31/07/18 14:53, jacopo mondi wrote:
> Hi Colin,
>    thanks for the patch.
>=20
> On Tue, Jul 31, 2018 at 02:33:43PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The check of fse->index is off-by-one and should be using >=3D rather
>> than > to check the maximum allowed array index. Fix this.
>>
>> Detected by CoverityScan, CID#172122 ("Out-of-bounds read")
>>
>> Fixes: aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>=20
> Acked-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>=20
> Thanks
>   j
>=20

Just to note, I also got a build warning on this driver, so that's
something that should be fixed up too.

drivers/media/i2c/mt9v111.c:887:15: warning: 'idx' may be used
uninitialized in this function [-Wmaybe-uninitialized]
  unsigned int idx;



--xJWLQlqaIbhqGrEllJgQyVPkM8z6YSdnR--

--LZ1qMDqUuxCCXYuIsl94ncFyuaq2aEgbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcGLapPABucZhZwDPaMKH38aoAiYFAltgak0ACgkQaMKH38ao
AiakZA//R+e/bYVFB1kP+CDC3nVxffaAMDLFejUiGZfn5xkpyVLkp5cnIas1g4En
Yzxe8IRm9tS3iByFeQA/jZPgg3uyJjAB6qei9sKPx0RWzw/7uFTjycDs8DXpxoY5
ZExZtWd7/Afx+IoXy1O2r6HFKkmOQ1l2uYSYV3wBh9O43rQra9tJna4w5E2dFZmr
DaFUtbD4eynrTXzMC7ct8uaP6ijGDOKPztnLNRSqDRRl9yOmSKcaOzARtluhicn3
stBTjqtqIRhbtejMhNyNjAvmHf+PXCZ7CTS8Vt4vCwBWc0ikeUeNu7he7xP5mA4V
fSSaAZRaLMtk5l2nzJCqeZEOg1ROJ1GmTvYQx/AKn3R+eS3PVxUTqLVmZLUtATNQ
V+6jhA4Av6Von1bXaLgqBbW4tZ5PMEFGQI+vsRTh9n2jGuadYsQgRVobnWvfCqAE
yXDxwes6ILwfEzzEf+VnpEuFQSTDD5Rmdh8pPKc6FhVMXzU1uc2cU09YRZzv0RLJ
Pq4ARPLgkljGilDp266+61I1oDx3uG3HpOuCX4MtjUnsBAYljT4tM9588ioc8B3E
O5qjrZrHhe4Ebumcbb6ZnE+NwkJNLL4QNMSA2lpNNjlTgYhr880gzC4rke1cAq+E
pkfrhWbxRaDwY+rQd4xwmzzvZhzxrsbmt0WIfDqp7kYe0Iiu/tw=
=qqSn
-----END PGP SIGNATURE-----

--LZ1qMDqUuxCCXYuIsl94ncFyuaq2aEgbe--
