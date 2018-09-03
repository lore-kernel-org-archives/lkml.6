Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66094C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893C920779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 22:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893C920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=petrovitsch.priv.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeIDDRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 23:17:38 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4036 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeIDDRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 23:17:38 -0400
Received: from thorin.petrovitsch.priv.at (80-110-72-12.cgn.dynamic.surfer.at [80.110.72.12])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id w83Msg7I015093
        (version=TLSv1 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 4 Sep 2018 00:54:45 +0200
Subject: Re: [PATCH 1/1] docs: kernel-doc: fix parsing of function pointers
To:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180903184153.9368-1-xypron.glpk@gmx.de>
 <20180903130043.059b2e82@lwn.net>
 <b0bff870-c3c1-20e8-6609-f93f59da8624@gmx.de>
 <20180903153804.2b091448@lwn.net>
 <6cfb25aff666e58a376303ce02de8caa481a6599.camel@perches.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <9bd050f6-eba1-a15c-3d42-948975be484b@petrovitsch.priv.at>
Date:   Tue, 4 Sep 2018 00:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6cfb25aff666e58a376303ce02de8caa481a6599.camel@perches.com>
Content-Type: multipart/mixed;
 boundary="------------F3433EB4A65D027C26E67B8D"
Content-Language: en-US
X-DCC-MGTINTERNET-Metrics: esgaroth.tuxoid.at 1170; Body=5 Fuz1=5 Fuz2=5
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F3433EB4A65D027C26E67B8D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/09/18 00:28, Joe Perches wrote:
> On Mon, 2018-09-03 at 15:38 -0600, Jonathan Corbet wrote:
>> On Mon, 3 Sep 2018 22:29:00 +0200
>> Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>>
>>>>>  	    # pointer-to-function
>>>>>  	    $arg =3D~ tr/#/,/;
>>>>> -	    $arg =3D~ m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/; =20
>>>
>>> m/[^\(]+\(\*?\s*([\w\.]*)\s*\)/;
>>>            ^
>>> Here we allow for 0..1 asterixes.

What's with pointers to function pointers and/or function pointer
arrays? ;-)

>>> If there is no asterix it is not a function pointer. Why should we ca=
re
>>> for this case?
>>
>> GCC seems to allow that asterisk (asterix is an indomitable Gaul :) to=
 be

*g*

>> missing; not sure if that's officially allowed by the language or not.=
  I
>> also don't know if any code in the kernel elides it,
>=20
> Many typedefs for function pointers do not use the *
> Dunno if there are many others, I didn't look hard.

----  snip  ----
typedef void (*foo)(int);
----  snip  ----
is a function pointer type (and nothing else;-) and can be used to
declare and/or define a pointer to a function as in
----  snip ----
foo ptr_to_func_with_int_param_and_no_result;
----  snip ----

----  snip  ----
typedef void bar(int);
----  snip  ----
is a function type and can be used for function prototypes as in
----  snip  ----
bar func_with_int_param_and_no_result;
----  snip  ----
and/or function pointers as in
----  snip  ----
bar *also_ptr_to_func_with_int_param_and_no_result;
----  snip  ----
Both of work (in functions) as
----  snip  ----
ptr_to_func_with_int_param_and_no_result =3D
        &func_with_int_param_and_no_result;
ptr_to_func_with_int_param_and_no_result =3D
        func_with_int_param_and_no_result;
also_ptr_to_func_with_int_param_and_no_result =3D
        &func_with_int_param_and_no_result;
also_ptr_to_func_with_int_param_and_no_result =3D
        func_with_int_param_and_no_result;
----  snip  ----
Note the missing "()" in both cases (otherwise it would be a function
call - possibly returning the function pointers).

I don't know if there is a preferred style in the kernel though.

MfG,
	Bernd
--=20
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

--------------F3433EB4A65D027C26E67B8D
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFr26nABCAC94WhTqVPMksk/AErK3NqDKXE0sqO5umWIF3f4DYRidk8SIuNq
Fk3Sc8hqE2HlbCB9lxV9q+eqDQ8bRjMF6ud7rjXortlwmoclRRMUuSJhluKo0C7o
y2fJIwlQAcAKWNfOKqZBTTz81Mntb4j26MsSL7t7JIibst/G7EfoqyB9CkeoI8R2
20WVKV7Cb70G5cYZkLrSdjhSZ8FJn0QTb+r/TTYHRCFvU2sv+wvG3LAdWfHVnyaC
l9rPkglsYXFCtsdx3jW2zvWf+mGEjpANlVc/9M621C/uS7viLzalmFENpgM1UqFx
TEEt8mwepc7dkiiKlslmDGUWSfc/BAcln8BjABEBAAG0LUJlcm5kIFBldHJvdml0
c2NoIDxiZXJuZEBwZXRyb3ZpdHNjaC5wcml2LmF0PokBVAQTAQgAPhYhBBp+6uAd
nwsL14MwOAUgtH2tYL69BQJa9upyAhsDBQkB4TOABQsJCAcCBhUKCQgLAgQWAgMB
Ah4BAheAAAoJEAUgtH2tYL69e+EH/jL5uerVy/JnSTjM4f6UeWSXCT/RoIACccws
gvr84g5mwYy23c6TxUNNLgeCSGFWCkGxiF07kWazSvMSaQJ7Jb0cIxgqAQfR4xm3
g/O2bu8E0ZvMu1naMVdYrA6iXX40fylrEONF85+/93ccU60sa443ZxjzmQy8Hh4/
Siu0tOPrfvBgdovUcIhJaAAStcPLVocYgQ6zu2A9CCHcBTjaCiRiT4s2IPsooEZU
chKObAormMXJS2mdYHcH/a/6E6+NKnrvZ4yfhAkPF3K1M0Bc1Nvc0ADj62Ffpice
Mnrd/ki31ct5yIUeViJzNNxApXFuThxm1Nmpgmn/eRG2eHnlvu25AQ0EWvbqcQEI
AOnQvBVfytvhpeR96YtYTG2VW85Byv92T/FqG7rPHNm7fVxuJtFXZ8L82LKDTl7r
WtwwbnWFpha3/OAhb4Hn4fWZveDNSPNN8BUMh5BbTV/EW/053F4pBX4uq4/L1t3M
JQZH5QJrDRNAEL56JfK0yOOGJOvXBMSNAe1gXfLWiE6gGwtHxsoDZfPbSNYl703d
f4UaSsG0AleVWw+BGGQuYoeD9/icoy673bca22LdcxcV70SWcNaYcutduwAQYZfe
OTsDO0x/VpapLm7KsyQuNW2EYSPM8RjwuApet1TZxfU4opInQ7HbIusz/kWAWCr3
q47TvuD9c0jG8cKM3UP4UdcAEQEAAYkBPAQYAQgAJhYhBBp+6uAdnwsL14MwOAUg
tH2tYL69BQJa9upxAhsMBQkB4TOAAAoJEAUgtH2tYL69YS0H/21k3QUKHj/m3juD
X3yIbebr+/SR7Db0yrZXLh0RvS9DN2u0E+V26lb9jq+PDHDOJlqgHoiNK5MeWKBA
2yhpFvwx65P6DS3EXUhIT+1NN0CwtXcuSCt7DKHwmuSBZq+2FKr6niNllxKGWUhz
EOYtHE71Xm95LPjVi+ETzONF9Xt1ibjFahioSgx8ld/OrsUKv2nVmWVrHErQ+Ed0
m2fhBB0V9hhv7oCiKv0dfDeoPmeQWmiwMEqBYMgMMaJBUBs4pVwrHYVYYvWGLTfV
uyqqdpcKo99ns7ALSI7PGCwM4J9ra77L8PQenc329eEREzhC0Ok/Qgk+rI832lD7
bxT8MO4=3D
=3DpFcw
-----END PGP PUBLIC KEY BLOCK-----

--------------F3433EB4A65D027C26E67B8D--
