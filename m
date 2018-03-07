Return-Path: <eric@anholt.net>
X-Google-Smtp-Source: AG47ELuTOPvN70PxL7QrH7dtXNTnuPj/dDkLjIRYzzP4iRwKD0ktTibxp++JyP4AehkZ/Mdkl3q4
ARC-Seal: i=1; a=rsa-sha256; t=1520445072; cv=none;
        d=google.com; s=arc-20160816;
        b=blH2TF5UOfvLZV14+X8pWDOoshMQYcSNVNJBME5h/qVoINavPMjP5e/darg5gQW8lu
         eGFys4pSFewBxgKsql/wSoGtHcQQsdZbiPbhl4r0KZf53j8rH4NpS6/lqiaBujcnV0bl
         wDbgxRtcIihbwWRGAvKdUX2EJnslYBYzNJxq+8zIEJpIoOgftLPupQO/wsSzqBZG4zQN
         D2isgwkL0sCe4rn0ma4e87v1C7s9Z4/ZVCwZvPCFbvlyM+mYgwBCWFT/ZNlHY1ZmjxlT
         wIslR4z5sTVCmHf8SqWG/rY+DDBGC4I6jnxq1Vv6nf+Rk8eo56hSrIHdqz9WfMNWij8Q
         itCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=53FdX7XV0fQRmCFJwoXWfUhOKmvd8cslLQLe1WkhmOM=;
        b=tYm2C3Z3E5cerJOLBAiScmCABobJcPf+YPXt+zCXI5NtObqxmjKChBQnTxq2vcsH+/
         YOt+cR1Wi4qda5CG19hfAKoI0WJUcUSJQ8FyYffMUAk/a8GPsM5xTo7mIz9Ocl1BLR+d
         qBxnbw7nT7h2O2m7laYI9Zcf1PsQnBiggTMtFIkc9lQ8YNHGTpF002LTxQlGrQ/x8Wpe
         12/PratuzTCR4etn6iynYGg4HSxlcPj3BQQTxnFdlbIlW9dZmZxlg1R9oYFU0XqBd2JJ
         0w9bBm64miwB6SkszcYe2M8XF2RUgGQE6WfzNru+QZjrHEO6sN52ZYxnzgsaZVcrEeN3
         kQ4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of eric@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=eric@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Phil Elwell <phil@raspberrypi.org>, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] staging: vc04_services: Remove cache-line-size property.
In-Reply-To: <51dc71d7-e8f5-2785-ad13-a941bc9278ab@raspberrypi.org>
References: <20180305202806.21219-1-eric@anholt.net> <20180305202806.21219-3-eric@anholt.net> <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com> <87muzl9ger.fsf@anholt.net> <638bd870-bb17-a0e1-d2aa-30a364b53279@raspberrypi.org> <1332781939.275857.1520424630939@email.1und1.de> <51dc71d7-e8f5-2785-ad13-a941bc9278ab@raspberrypi.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Wed, 07 Mar 2018 09:51:09 -0800
Message-ID: <87371bydte.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130896333791997?=
X-GMAIL-MSGID: =?utf-8?q?1594302212656152526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Phil Elwell <phil@raspberrypi.org> writes:

> On 07/03/2018 12:10, Stefan Wahren wrote:
>> Hi Phil,
>
> <snip>
>
>>> It is the L2 cache line size that matters, but as long as you end up wi=
th
>>> the numbers Stefan mentioned - 32 on BCM2835, 64 on BCM2836 and BCM2837=
 -
>>> I'm not too bothered how you get there.
>>=20
>> i think a kernel with bcm2835_defconfig on RPi 2 could be such a corncas=
e.
>>=20
>> Am i right that the firmware doesn't rely on the existence of "cache-lin=
e-size"?
>
> Because of the way partial cache lines are handled it is more important t=
hat the
> two sides agree than that the value is correct. As a result, the firmware=
 treats
> the absence of a "cache_line_size" DT parameter (that sets the "cache-lin=
e-size"
> property) in the DTB as an indication that the kernel driver pre-dates th=
e ability
> to switch, and uses the old fixed value of 32 as a fallback. Otherwise it=
 sets the
> parameter and the internal value used by the VPU-side VCHIQ to the correc=
t value.
>
> There are a number of ways to fix this, the easiest of which is to assume=
 that the kernel
> driver will either read the property or be able to work out the correct v=
alue, so
> the VPU should always use the correct value regardless of the success of =
applying
> the parameter/changing the property.

Oh, interesting.  So with my patch, we end up with a mismatch where VPU
is treating things as 32, and the kernel is using 64.  I wasn't seeing
errors in vchiq_test in this state, which is a bit concerning.

I'll go ahead and drop this patch and replace it with a comment in the
code about this discussion.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqgJo0ACgkQtdYpNtH8
nui7ThAAtLCQi7b6EfWvhcD/rnr01h1wRMmVpAEyVUozxYAqf9CaZ2BmUj/8OQgg
mXfjSSghygbsUAvtsKYLXgUkkGwTZiKhneeGpL5uirtLmQYB5xsDxGck2YaG5yxH
rPFRt7sMph9SSxqrKR0k3uUdSFlB9zqz3TkGzP2OBuAAI4aiaOZ8B1xKN9+UKbJC
b/hftzvA97/T1Zfh+L2NWT2mo064CeX5f1B0Oy3j+BgdJfQLpdi19VBB+XPItfSa
9rdp8rz0wysijqxXSAo53NOK/S/m3e07naT8EvKvGt6QLQ5m0kPwBtU99Z9A4mOX
g0r5tjVYJP8JOa4ISZVjq0gXiFe+Gofe/PjD4a+6AU9sWTntAAnLvcBl+XLOyWKU
n6aS9/OKTmFcz9NEuCtE5wd4sSli64jUHaJ/T6DiII21d5qeyzI+7HduMmpEbFow
9GohhThqn3/YXQeKZwhV2DA8Dd3Ih8VICe1N8fWaHrP0qj6K7BrXhtCACMH3pJ/G
ro9AW2dYkYzPqrxsLtnJo61cir6shh5URqcE4y3NRZkwpPFAkdj9ERA+gM6u7Dbk
rN11aP/xeqVNr+TF/+FPKZMpSw3vIJq7R7p8JyKVtNc0wclXGAoBGL9nCy5vL+AV
PZntlxaVGpGH4YDOXzW9vR3AkOF2hK8LfZ9d5GFIFBeZ2lG9RsQ=
=D+hT
-----END PGP SIGNATURE-----
--=-=-=--
