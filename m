Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeDRW4l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 18:56:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbeDRW4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 18:56:36 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 19 Apr 2018 08:56:28 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] rhashtable: remove incorrect comment on r{hl, hash}table_walk_enter()
In-Reply-To: <20180418142854.wacgjdycxvfjh77s@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble> <152403402192.16895.9740762152906281009.stgit2@noble> <20180418142854.wacgjdycxvfjh77s@gondor.apana.org.au>
Message-ID: <87efjcqg2r.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18 2018, Herbert Xu wrote:

> On Wed, Apr 18, 2018 at 04:47:01PM +1000, NeilBrown wrote:
>> Neither rhashtable_walk_enter() or rhltable_walk_enter() sleep, so
>> remove the comments which suggest that they do.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  include/linux/rhashtable.h |    3 ---
>>  lib/rhashtable.c           |    3 ---
>>  2 files changed, 6 deletions(-)
>>=20
>> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
>> index 87d443a5b11d..b01d88e196c2 100644
>> --- a/include/linux/rhashtable.h
>> +++ b/include/linux/rhashtable.h
>> @@ -1268,9 +1268,6 @@ static inline int rhashtable_walk_init(struct rhas=
htable *ht,
>>   * For a completely stable walk you should construct your own data
>>   * structure outside the hash table.
>>   *
>> - * This function may sleep so you must not call it from interrupt
>> - * context or with spin locks held.
>
> It does a naked spin lock so even though we removed the memory
> allocation you still mustn't call it from interrupt context.
>
> Why do you need to do that anyway?

I don't want to do that - I just want the documentation to be correct
(or at least, not be blatantly incorrect).  The function does not sleep,
and is safe to call with spin locks held.
Do we need to spell out when it can be called?  If so, maybe:

   This function may be called from any process context, including
   non-preemptable context, but cannot be called from interrupts.

??

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrXzRwACgkQOeye3VZi
gbn1cBAAr79zd8HX3gJCvKeovw/3weblXx6ALQaQR7V7nNt2K+702LdZbgt26IZp
AH+zZdG+iGtcAGUxjt7qM1xBR4ZkmO/EoxSMY1dfAMgQcPEiGc2Z8u7IjM3FqVFs
hUxmbI1F+eVWYQmrCbR6ZhPhxIp6DeouK3YrBf4paWXZUYRQmsWeTlyjaIeapfm4
j3fTEp/MSvzIJk/vruNijmy0vZQLbII6OEPHgVtND9GAyjj3ZnmmA0KwAfG/BGU4
e+JBH94li63ZPFS8JB6s9thcKRdJ2mu9eDUJQaa5pV92AbkgJLsInGZQfYAB9JnR
RLwofmmNkpa3sSA4YUX4ZlXrfjeQF2n+XPya3DvFUb1R3pbOXE8zyxJtjsESBfwC
E3qP3FJlhgmdKOUe/w3P6lJBRb37pFbk/yhgKf8rGXx85yJdajgIK7svVMzh1wik
AWj77YGCLRxh5Ny69VHDb1hJfL5d3qA4oUs1xU/3o4m5hzW5zckBissP+x3OVtZ9
UhicGJqF/AQhiGHEX374ocxI2c07iVzeMH6Ho2aJ1Wo6NB+2CKsX4FcuQCSOg04/
xFHDNvpPLfQrrMYQVd3nz0quCzRRJi2sdlzJLZmvbPoJZ4uIUmB/tpRsBNSntVwC
xxhqCuo7+kHwbZD3i3qlXuP0pnoXH/PIzd3/yECLd8R5hHuvIQY=
=QwD/
-----END PGP SIGNATURE-----
--=-=-=--
