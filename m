Return-Path: <eric@anholt.net>
X-Google-Smtp-Source: AG47ELtMTFms7itYMGo02/a1FaTBZzjKk4GW5rMZfXa5oTulu19yIL+f9aYe/iiNru3XqanWjif7
ARC-Seal: i=1; a=rsa-sha256; t=1520362927; cv=none;
        d=google.com; s=arc-20160816;
        b=K+cDSAp8ZZp23B3KZMwwOn1AXq6PDXof9xYZz7KrvXBv04//ylYzKXjHWlZmSt1myP
         JLbu0heb2ufYW1lDayE60pPr845dqm5B2wlA2c7vpi6OBXkoQCjN7EQiTfqlmDSpb/13
         1RLWGB3RdhWbOdJ+qo6WmndI4Iljj83J4/SpsAivur+ABuofuFs2sXSonUlYiiBm9Zal
         DJO9iWqA2Gxs2lVY60PJdQWe3CHn4qPwvB3Z2vqIAIh0GSMLtRQQLPUPqgL3IXsOJ1k3
         xDn7Xhl9InKkYVNp7BecJtptvX8Ae2ff+F9aYbnyPD6ncJEQ6vN8nH9ONnbchai0XBa9
         nHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=K0iCJ+RShBShTfnjrFkl34eGYURbSSwStF+PpoSIb4U=;
        b=djRlkDBIWsW+/tEm0F1vaZN7vVJ8gWC/i3Hblqt+RJ5s5Im8MHWGVQ3atPAG8EftHp
         awW43MPgDGk8DWkJapkFUuI9/nsBV+HaWDUyovCodato0sedYX0EzGjzluT317POe2Tm
         I2aSQFgjJ3rWM16L/X9FnzN70rO0iEx4D2LmMSNtRng3vq//FrNGlgyJhDk0RCY+NuKh
         Ys7QKtIzrFLTzcjrhztykUSr/9M4dXrLGTT3R33T7FZGWr7U6lU0XvVWy2Vd8a6j/ay9
         1T/bKvAXf9H/+s+49/M08SZwO/2pON8Y7XNKJgW58R1icUZ/CsYgc+QElRPSEj57Hty5
         2a4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Phil Elwell <phil@raspberrypi.org>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] staging: vc04_services: Remove cache-line-size property.
In-Reply-To: <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com>
References: <20180305202806.21219-1-eric@anholt.net> <20180305202806.21219-3-eric@anholt.net> <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Tue, 06 Mar 2018 11:02:04 -0800
Message-ID: <87muzl9ger.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130896333791997?=
X-GMAIL-MSGID: =?utf-8?q?1594216076966019243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>
> Am 05.03.2018 um 21:28 schrieb Eric Anholt:
>> This was just a way for the DT-passed value to get out of sync with
>> what Linux has configured the ARM for.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>   .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++-------=
--------
>>   .../interface/vchiq_arm/vchiq_pagelist.h           |  1 -
>>   2 files changed, 8 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_283=
5_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> index b59ef14890aa..e0e01c812036 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> @@ -77,7 +77,6 @@ struct vchiq_pagelist_info {
>>   };
>>=20=20=20
>>   static void __iomem *g_regs;
>> -static unsigned int g_cache_line_size =3D sizeof(CACHE_LINE_SIZE);
>>   static unsigned int g_fragments_size;
>>   static char *g_fragments_base;
>>   static char *g_free_fragments;
>> @@ -117,15 +116,7 @@ int vchiq_platform_init(struct platform_device *pde=
v, VCHIQ_STATE_T *state)
>>   	if (err < 0)
>>   		return err;
>>=20=20=20
>> -	err =3D of_property_read_u32(dev->of_node, "cache-line-size",
>> -				   &g_cache_line_size);
>> -
>> -	if (err) {
>> -		dev_err(dev, "Missing cache-line-size property\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	g_fragments_size =3D 2 * g_cache_line_size;
>> +	g_fragments_size =3D 2 * cache_line_size();
>>=20=20=20
>>   	/* Allocate space for the channels in coherent memory */
>>   	slot_mem_size =3D PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
>> @@ -548,9 +539,9 @@ create_pagelist(char __user *buf, size_t count, unsi=
gned short type)
>>=20=20=20
>>   	/* Partial cache lines (fragments) require special measures */
>>   	if ((type =3D=3D PAGELIST_READ) &&
>> -		((pagelist->offset & (g_cache_line_size - 1)) ||
>> +		((pagelist->offset & (cache_line_size() - 1)) ||
>>   		((pagelist->offset + pagelist->length) &
>> -		(g_cache_line_size - 1)))) {
>> +		 (cache_line_size() - 1)))) {
>>   		char *fragments;
>>=20=20=20
>>   		if (down_interruptible(&g_free_fragments_sema) !=3D 0) {
>> @@ -598,10 +589,10 @@ free_pagelist(struct vchiq_pagelist_info *pagelist=
info,
>>   			g_fragments_size;
>>   		int head_bytes, tail_bytes;
>>=20=20=20
>> -		head_bytes =3D (g_cache_line_size - pagelist->offset) &
>> -			(g_cache_line_size - 1);
>> +		head_bytes =3D (cache_line_size() - pagelist->offset) &
>> +			(cache_line_size() - 1);
>>   		tail_bytes =3D (pagelist->offset + actual) &
>> -			(g_cache_line_size - 1);
>> +			(cache_line_size() - 1);
>
> should it be so easy? Back in 2016 we said that cache_line_size() won't=20
> work. I always thought that we need the cache line size of L2 not of the=
=20
> L1 one.
>
> Did you already test the behavior for these combinations?
> BCM2835 ARM32, expected cache line size =3D 32
> BCM2836 ARM32, expected cache line size =3D 64
> BCM2837 ARM32, expected cache line size =3D 64
> BCM2837 ARM64, expected cache line size =3D 64

I didn't explicitly test, but was going by:

config ARM_L1_CACHE_SHIFT_6
	bool
	default y if CPU_V7
	help
	  Setting ARM L1 cache line size to 64 Bytes.

config ARM_L1_CACHE_SHIFT_7
	bool
	help
	  Setting ARM L1 cache line size to 128 Bytes.

config ARM_L1_CACHE_SHIFT
	int
	default 7 if ARM_L1_CACHE_SHIFT_7
	default 6 if ARM_L1_CACHE_SHIFT_6
	default 5

and only L1_CACHE_SHIFT_7 gets selected by UNIPHIER and neither one is
accessible by menus.

I think you're technically correct that it's the size of L2 that matters
(or, specifically, the hardcoded value that the firmware is using on its
side for the fragments list handling.  It overrides a cache-line-size DT
property with that number if present).  However, I think L1=3D=3DL2 cache
line size this should be a safe assumption for us.

Phil, any opinion?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqe5awACgkQtdYpNtH8
nuiVIg/7BCR/T2KYUbPO4Og6lrzuDe3pu4wWtwKytbBiYK5CtBAawnguegrB5Waa
IK3dS/w5c0kLgAZf3kezgW2DvrsYiqyXSR9X00icc/c4parhNq6bntr0i3MsUnHA
13EGee0xI5GXkZXvH6ZNuSY7QtuEuexdaQkBDPQj8WkJeZ9uSzBSwaReyhsZqRWl
RKhxmiBBsx5aaUmRHMlPyvYiMDItVwVSLEkUiKIY1Gw3+OtUUXii/xMPlkx2Py7b
bcX5q+CeB2f7xa6nv0Dvpn+47Q+a6K8nCumShEHUK+zywh9tlMeRqYWaJ18YxxkJ
kci1c+VuHFHMt05dkuiklxf3+7PLQr92IlKFW02svAFz5C/q6ufwPtm7QxRKe8G1
VTVBnmpp0Hoc06Pci1xcKf5VXIoZb024FH6evWqlvXWeXp9KQAKKFRvlP/VTZNo9
x2BajQ+9yJrjSViIZmTPqQB3kz5LYt2URIhRcQ7XR1jECqTfnuFLBlHblLqRHUCG
UjhCfmdwpC+s1gPcsGbWHdQ8Pw9GvMUTi4/AS5RHQoTj8GizXzBDazL58XnJQC4K
vSr0DkVyDAgpGfiUbch4LV15TLsKMecO3MT9eKDYBxybYD/36Me447ssBLVBYKdi
RwfAOMfM9KW2V+1Y7qq0FbatMJ3AYa4E7qX1tydMi7iyTbLFsLk=
=5IJ2
-----END PGP SIGNATURE-----
--=-=-=--
