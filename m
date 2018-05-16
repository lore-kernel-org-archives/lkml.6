Return-Path: <fschmaus@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526486881; cv=none;
        d=google.com; s=arc-20160816;
        b=fZatJXUKuvkUpGQ9qUCFh+4rXka05+HFAWKXZENTfvqNqovRiLRSTogD27lDf0bmZK
         oiZ2y7g2zsBT2bKrEtZdPNAC08NZj/8C/n4NYlmPAsGrixZfpqaUu5XUuDSWQmleUr2c
         g136OqF5b29AzgKrDTMxrMTMdkdff7Q+OIBZXU2Kmh1aliCzVGXlnm4U6yeXWj8R8Int
         XNOpoQm4pNJHQYdgNUBruUroyhxs9XMRuBarbVRwJLKDj8fn566DAlTciqyV5pn3VVk7
         uBwplQUcFJaMIh32TWXCfXld8Km90BkYoRvk+Fs4s0Jw5FApfMxlywxKXvKzkIIvDaU3
         R2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:autocrypt
         :openpgp:from:references:cc:to:subject:arc-authentication-results;
        bh=OWD+8wi6BdZoRMDkhfeMqEx3rdv+LV7D9oQ/xq1QazI=;
        b=hdHgeeB1SmKPTGtFdI5PNsymUSX5FMkxBt63+spF+6wfNQWPobDP3L+Dt6xm0B8GXH
         siEjG5zaqixVs+m/5b/emNVimPV8j2cBcKF90Q9+HPQYVjVn527nr+8aN2zrvmK9NHVw
         +2mhWz/DH5Fb+6Nq+eXZtoeqPANoUVzkYL/B+di4sHB15TGDwuBWG7gdBMph022DrfPC
         OcWxTWp9uTH3EZ6c4fHZqtsowueBwExdesqXE3UCHkIMFhNXyfalYsKssxNVFt/2JuOf
         E53qfcMqgdg3mJzidfwr7ZaVe9mo50fkMjMe/i3n3gEIbsfYY6Qi7FEwb0WvLlCuOMD+
         Ks8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fschmaus@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fschmaus@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fschmaus@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fschmaus@gmail.com
X-Google-Smtp-Source: AB8JxZqJMNVH96odin1Ypw9SsFhK/jvLM39MP6zBce5wNragSdP38tkNog3NOBHvsWg6JlVLpLux9g==
Subject: Re: [PATCH v4 1/3] driver-core: return EINVAL error instead of
 BUG_ON()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20180515135114.31939-1-flo@geekplace.eu>
 <20180516120527.29403-2-flo@geekplace.eu> <20180516153904.GD23725@kroah.com>
From: Florian Schmaus <flo@geekplace.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=flo@geekplace.eu; prefer-encrypt=mutual; keydata=
 xsBNBEw8UF4BCAC4H+pf0bJjP8iUvOXtyfM052WptOwK+YCVWx5y8TExQ6u2WuKnsLC5AhdQ
 qChyLU08zIkno2dvfhyRxxMqhUPmo60ckn6AjLrif28vZiHJRWCfJTipxL2mZO0xNW68d23k
 9G4f7+hzNyjWV5SpFG2qg4DWKmwIonZHZMZAK3NtWK7h+3uIVXk32Veuseh/qACZRI63EuQH
 e+BhnHDFLbb7gYhm78tuzVobU1mEqiNSA783BpxoVUSCEine1/qB5kObmq9Nno0cwnPui8GS
 sAUmNItKC270UdwLimFdCnV8qEbVEVj+Nh+nE+LVMdNZJa95x/4HHz9oIj8TGc1/RNiXABEB
 AAHNIkZsb3JpYW4gU2NobWF1cyA8ZmxvQGdlZWtwbGFjZS5ldT7CwIAEEwEIACoCGwMFCwkI
 BwMFFQoJCAsFFgMCAQACHgECF4ACGQEFAlh3gqwFCRHezM4ACgkQjKwqlnhUjjWzQwf/dXwE
 R8QeAwc7hOCHje0qiwq94nNjUgJwvYTGjvKbCgiTuDZmyVqSSjhXAYADFYC5wcW5SwIDKTQ4
 1jxySbpZq6sjEHyAsfyw6cyMaK0J0VImrl5DItYANVVJ+4oGwtd5bBzZYeHzDcfbqWMhH1jZ
 LQIaj905OiX6E9breSN8cBvA0+A65Xh9EAOE2uFRv7HBUQ/GgJA6JL8K/ApsXm/MpvVjsYgp
 2iwzbcB2Wd4ozrmHUAjO1CELcToCUd/nkZMPruRhRJ+bk3IOR+GmPeDgBHrRRvlIph0KmIk7
 o8d3etsJ8DbkS9SE3Tfv/05bkIJCoMliQnjQZ37BojeMjkit+s7ATQRMPFBeAQgA6CUUbbL8
 LtKj22CmRsWvrCeOMw1/KCwa/1A/GhEkz4u517XOVRUUO7+uiRCpCk2KvU/ydvT+R7HcTKJo
 keaW2kVGgI3hDbHMc12PAWU2Vc0qLakOmR8jnhqpCl4TTVVMe6RWRdQDuOm5PDm/vuoxBTQk
 iFDYIg7BYIBsHd54Dy66Q25UELowuaQE/SQel/jpxONXGEkuawmwz2gSh7SMk37XAj8I7IIn
 NKijIV4LYUfOkJp2uGVHhzffvHBLM5Py0hCcrA7+EPo/R4ns0UMRV4Co7DMk3Q/EwKN7laWV
 3O7zqxmoIu2oCuEADLqM5m8FWzqIWL0dMOpmZmBLBLofXwARAQABwsBlBBgBCAAPAhsMBQJX
 VpyaBQkO3LM8AAoJEIysKpZ4VI41kGsH/j8+IbuS+vIdcWgzHXwe8f4sP9+pEQjKCR4LgbVr
 gd+35DCTwZNLFBDdv0rkv3i7wv/Jmgh4UUTXZif9Umw11JOeRdH7L6nCpR7wu+sXfZFyHmNd
 bRyMz4NN75Kah6fumWSCHf6JiZtCU/gpfMVnlb/oBG7viUldYHn6HLIP4CQM+2l/8bDRh+In
 NKBEEm1jHXgHGoM+Cqi5g6lnf59xFFFA8VWr07kZeHn0tjv98gIq9Uk1StWi66Y6WDDtVNq5
 Gyy51NlEgttKhw/c6+tJC807rBccdVtG7AoBsSub89ofJ5stY+A3Uj9AnSJzg5MnCzIR9aeX
 JvmyGcVIPOmLAPA=
Message-ID: <800f5947-96e0-085d-e127-894ee2a18e69@geekplace.eu>
Date: Wed, 16 May 2018 18:07:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516153904.GD23725@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="O6qDZDJwFNrJEr2E7HDcKGPS7M89Wl4UX"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538307173968753?=
X-GMAIL-MSGID: =?utf-8?q?1600637508239531653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O6qDZDJwFNrJEr2E7HDcKGPS7M89Wl4UX
Content-Type: multipart/mixed; boundary="8WNU3Yixuk0QGn2dRgfE0QBr7SLtYA2Y6";
 protected-headers="v1"
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <800f5947-96e0-085d-e127-894ee2a18e69@geekplace.eu>
Subject: Re: [PATCH v4 1/3] driver-core: return EINVAL error instead of
 BUG_ON()
References: <20180515135114.31939-1-flo@geekplace.eu>
 <20180516120527.29403-2-flo@geekplace.eu> <20180516153904.GD23725@kroah.com>
In-Reply-To: <20180516153904.GD23725@kroah.com>

--8WNU3Yixuk0QGn2dRgfE0QBr7SLtYA2Y6
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 16.05.2018 17:39, Greg Kroah-Hartman wrote:
> On Wed, May 16, 2018 at 02:05:25PM +0200, Florian Schmaus wrote:
>> I triggerd the BUG_ON() in driver_register() when booting a domU Xen
>> domain. Since there was no contextual information logged, I needed to
>> attach kgdb to determine the culprit (the wmi-bmof driver in my
>> case). The BUG_ON() was added in commit f48f3febb2cb ("driver-core: do=

>> not register a driver with bus_type not registered").
>>
>> Instead of running into a BUG_ON() we print an error message
>> identifying the, likely faulty, driver but continue booting.
>>
>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>> ---
>>
>> Notes:
>>     - Also print out the bus name
>>     - Use pr_err() instead of printk()
>>
>>  drivers/base/driver.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
>> index ba912558a510..203fa731e3ee 100644
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -148,7 +148,12 @@ int driver_register(struct device_driver *drv)
>>  	int ret;
>>  	struct device_driver *other;
>> =20
>> -	BUG_ON(!drv->bus->p);
>> +	if (!drv->bus->p) {
>> +		pr_err("Driver '%s' was unable to register with bus_type '%s'"
>> +			   " because it was not initialized.\n",
>=20
> Are you using checkpatch.pl?

I do, I thought this was one of the rare occasions where it is sensible
to split the lines, also given that the other strings within the same
function are also split.

> Anyway, long strings should never be split across lines.  This needs to=

> be one line.

Fixed in v5.

> Sometimes making small changes is hard :)

True words ;)

- Florian


--8WNU3Yixuk0QGn2dRgfE0QBr7SLtYA2Y6--

--O6qDZDJwFNrJEr2E7HDcKGPS7M89Wl4UX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEl3UFnzoh3OFr5PuuIjmn6PWFIFIFAlr8V15fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDk3
NzUwNTlGM0EyMURDRTE2QkU0RkJBRTIyMzlBN0U4RjU4NTIwNTIACgkQIjmn6PWF
IFKM0gf+LO9iGWg/pUOT1sOFUFw4qxSmS4KvQ36CO6jToP9H0EIPLEXHbU7x40LZ
mWBlHf3suS8BiYm+0F1w4XfX2ijlzBvIMEedm7E5Asrcul0kOaojf/65oLw92OUN
c7S5+3j2A9qywTZhgSomXw0tGeU2uSP5yqUHyHadBEm7t4ZqJV47qxEE3is/x/py
4IfnSwWIFrBcODn16dd3fySp1tOtuB5utyp2PXBi262PQW1hnThECv0pjBbb6oJE
dHoP+DEoxj8Gao3ls05UdztUlHf5z2zdU1TjpDnLc9vOk/khUfz/Dq45gcRkKV9u
si+HlpUs/xD9r4OSyAajxlAAECmpSQ==
=XI2p
-----END PGP SIGNATURE-----

--O6qDZDJwFNrJEr2E7HDcKGPS7M89Wl4UX--
