Return-Path: <fschmaus@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520436980; cv=none;
        d=google.com; s=arc-20160816;
        b=BwGEGh2SDqGQOgtNnP42cgZVBrUlR5pjAPzQcuwuSZVa87PuLJ87+9uArU3hvv1nXx
         H8/DdFD8H8WPGna4Edl38NwFRuoOisiebbXTETckImcD+GGWwBe099Oz+RN34wTNmUOv
         DShgKyCTrHOQ4mVrkCeihEmOfG4noModiTkb1ncwLx/GE9J50PxxzN/9rdBoso/5HaJZ
         7VMtDvyqJR8jCu8n6Ep0vlv7KuUPIB9H75p2u1Y+jFLC06SCxV20O7YkAr5zbZamTVqH
         4gmEMr5YQmgMvKV7o4W0jbylyrSeJNMdUQoqCRm1iOHYDSwv5JP+X1gfAGe8hpPoDwPd
         SmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:arc-authentication-results;
        bh=SiEkgHLqXwvmH1h9eqtjJwkENocPX5bOZjXWFujvI2U=;
        b=QCZGcoVl8VK+QVcdETQDUwqxBTMz3Obf+xBaGfsqmhAYSeR6jnG5rmha6NjhyDx4kl
         me1sqO8pK9d26biQCfm/4jq0rzFnksADuKyhGdVNZoibIu+sEYxOMHE6C4pISSRjOnoj
         rB789BLgIBq8elp+K266040dau5FpfAxVBZQT0uQdsOsgnId7RQlNmqJ9zIa6H0aDqXc
         PQNdTWK6x73jnniiTcbQfOVPk5Jze8l8Wiu3zzbDwl/lZaOhmuwfSFdiVKcQnAow20Ko
         zCTYC+Qy3l4jROFp5tEC8C7FMZafIHBqpM3R+xGPP7iH0oUDBzNazhJhkgRacMmYXTbM
         CgEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fschmaus@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fschmaus@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fschmaus@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fschmaus@gmail.com
X-Google-Smtp-Source: AG47ELvvWsYM/zr3upuQ64uVDajgPKHRbHk72WB3pvKgRyqpo5KFskCLhf2SHpPaRn3A8dww4KNT/g==
Subject: Re: [PATCH] driver-core: Log the BUG() causing driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20180307094902.20316-1-flo@geekplace.eu>
 <20180307151351.GA1598@kroah.com>
From: Florian Schmaus <flo@geekplace.eu>
Message-ID: <50014600-7538-3aaf-e785-907102a14561@geekplace.eu>
Date: Wed, 7 Mar 2018 16:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180307151351.GA1598@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4CAMVPny5suoL6Xqd5oUxaR4ua4zpXGQb"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594271878826578823?=
X-GMAIL-MSGID: =?utf-8?q?1594293727860065200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4CAMVPny5suoL6Xqd5oUxaR4ua4zpXGQb
Content-Type: multipart/mixed; boundary="ruEE1IgAxYteLkIflv0gL82jjKOV9e13q";
 protected-headers="v1"
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <50014600-7538-3aaf-e785-907102a14561@geekplace.eu>
Subject: Re: [PATCH] driver-core: Log the BUG() causing driver
References: <20180307094902.20316-1-flo@geekplace.eu>
 <20180307151351.GA1598@kroah.com>
In-Reply-To: <20180307151351.GA1598@kroah.com>

--ruEE1IgAxYteLkIflv0gL82jjKOV9e13q
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 07.03.2018 16:13, Greg Kroah-Hartman wrote:
> On Wed, Mar 07, 2018 at 10:49:02AM +0100, Florian Schmaus wrote:
>> I triggerd the BUG_ON(), which was added in
>> f48f3febb2cbfd0f2ecee7690835ba745c1034a4, when booting a domU Xen
>> domain.
>=20
> How?

Basically just by booting the domU kernel with the wmi-bmof driver
compiled in. After I deselected the wmi-bmof driver, the kernel booted
just fine.

I'd probably be able to re-create the faulty kernel and show you the
image and/or kernel config if you want.

>> Since there was no contextual information logged, I needed to
>> attach kgdb to determine the culprit (the wmi-bmof driver in my case).=

>>
>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>> ---
>>  drivers/base/driver.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
>> index ba912558a510..55f8db41df2b 100644
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -148,7 +148,11 @@ int driver_register(struct device_driver *drv)
>>  	int ret;
>>  	struct device_driver *other;
>> =20
>> -	BUG_ON(!drv->bus->p);
>> +	if (!drv->bus->p) {
>> +		printk(KERN_ERR "Driver '%s' was unable to register bus_type\n",
>> +			   drv->name);
>> +		BUG();
>> +	}
>=20
> We could just log the error and return with an error, that would be
> nicer, right?  Crashing the system isn't usually a good idea, even at
> boot time :)

It sure is, and I did consider it. I just wasn't sure which return value
to use in that case. Probably the best solution would be to use the
return value of bus_register(), which caused p to become NULL. Although
that possibly requires extending the bus_type struct by an 'int' storing
the return value (Or could the return value be mangled into the 'p'
pointer?).

I'd be happy to hear your thoughts on this.

BTW: Should I retain the 'unlikely' semantic of BUG_ON() in this case?

- Florian


--ruEE1IgAxYteLkIflv0gL82jjKOV9e13q--

--4CAMVPny5suoL6Xqd5oUxaR4ua4zpXGQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGlBAEBCgCPFiEEl3UFnzoh3OFr5PuuIjmn6PWFIFIFAlqgBvJfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDk3
NzUwNTlGM0EyMURDRTE2QkU0RkJBRTIyMzlBN0U4RjU4NTIwNTIRHGZsb0BnZWVr
cGxhY2UuZXUACgkQIjmn6PWFIFJTlQgAhcwrmAHMepwRE+9+hRRicZBEVuEt147j
d9H8uwj67BSb616qH3fHtuKhjTMVoXfAM/q6rSVVfhnNaO3T8MSuRweozzzJmm2m
W7bdlJC++nzX4nowemPRDa8GvQ9apRbA1485IEYiqrnOm+Kq5d92Thpaj8hNao5n
+OZJxBd7V1LMp7oUd8EOZT4Nvhfajua3NItZfO147qFKzze82An9FdIdpf6dsM00
E0gTAymWysWeVJP66qSE0GiDrbvvru+DW8tonP46t/EGOwP2H+fsOiZs1wVQzaRe
7SABjvs2X0lAywB7RecK2FWRVAVnCPFCO65fTMcyqKas2MIixYyPBg==
=ZRz5
-----END PGP SIGNATURE-----

--4CAMVPny5suoL6Xqd5oUxaR4ua4zpXGQb--
