Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4105806-1524040360-2-14413381283129984164
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524040359; b=uXdbL2PXQ3L3y2YkU4qfAzUyNIna/DIiOJPzcJVDSziX9kEj76
    l5W+U6HdsNozqeQ6KdARgPVaTGHDX7kV3KC1H3tiIppycLII5X/28h0CK9JmYW1y
    HBY9yqjKuIvY1hrbihxqb66xJFRYhuzb9nF1OAmjArCX8/hNSqublJPhmLnpR7Yx
    l9ZTZvaL9s4sO8GekusCu1m29V3Lqp7O0JID/ZTEkKccfTMgB31qhEJO8PXEE5E+
    ge3huNDTGmx0zag8OSuavm3MaDg6VIcFoKJIubzrjMUIV0akC0O3E4VkYUz6HWzH
    u7CW4awjvavl6sE8HkDLNcfHRt94vF3nkhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1524040359; bh=EwOPdqV0ca6F+vwZKwld3qIeRvPtIBA3AxAN/UiO1T
    w=; b=G2BOe+ITkgGuO/rHmeKmu6bHVGRkSmYFiKF6i7KCsqpGP82fl5Y2KZVP1d
    emy5ScJ89AnKtTKRdFEvSBfPnRntYPUcAQtwQzLOwRE3IgRT/7nxZJSpKgnfncqS
    7zlN/CIlk+8wBhkyvaLRRmT/WF4argzdQIBz5tjWpGRTVZjOabJfxLY6R802rX8G
    0DUjeUJ2vkwhvyxXLk0KPgUbxBtYoBnRgJzyLMUB01x1cG49OR6jWlKCLWTyATRR
    JPUIP7Y3D+wEWA1t3sWE76DM29FqCi6Ye/6Rd6BdXOxFdkrV5MrS5P18Gd/RpKHe
    i6gnPVwBq2fa/R0KGKOTn9T2KoOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=I5EfXK/u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Aj2f2K0Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=I5EfXK/u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Aj2f2K0Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfARmTtM1+LRWfFmJ9snEZCSsRI/J9HdO18Jv/+onCF1KFSq9riVkbGeg+ZdkJ/PZtZ24ncDnwIgV3kIGFrEdip5QDieCYeH1Atp31i0OHbY8EZ3JD+GE
    Ay0KTsGdzhaVXMUTq9ivEsp/B96lkE85XUVfc54Sb/YOMlkc9T527XdYwhG3nsSh28WxoUI3sDg1L4x7/qthM6xR5OyPeux2AQB3T4sZyPRz4ZEya2LKO8hj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=ZVeAwwkMJCUA:10
    a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9 a=ZB0zZtmXq-pLflGG_wsA:9
    a=QEXdDO2ut3YA:10 a=ImiROjTVcjACX1TCaDkA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbeDRIc3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 04:32:29 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44757 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeDRIc0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 04:32:26 -0400
X-Google-Smtp-Source: AIpwx4+DoBNliXmJhKtBjDZJuaG7XUUtBN9ReYP+QJ/5BJfa2CEzwgSA62lqyKJzjjQaMXPNkmlJ9g==
Subject: Re: kernel panics with 4.14.X versions
To: Jan Kara <jack@suse.cz>
Cc: Guillaume Morin <guillaume@morinfr.org>, stable@vger.kernel.org,
        decui@microsoft.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
From: Pavlos Parissis <pavlos.parissis@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pavlos.parissis@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFE50ZMBEADWTPWBaVLkaIldRGfinwUAPEeawauL+XUmL+3KDMGm/ujxbyWw65vydmu1
 9svBd/OkII0bnf/r/8f5oBXcmYvkARqgu3V2B4L2vFzGDJw+7+5Dex3afg/T1/mvZdo2fUpu
 uWIVyWYIvK/MnVNx5uQpJoP3NwY7OqBUH3tOBTxFCtBSXVyXPLAQnV83GY584tmgvee9o8HU
 5YQhaxxYb6S8ROarAL74K4KAZ2nzlfgjCH5p3wg2lZuNNTzxKln44qIb5Q6HxpAOHiFOPg5d
 yUZd7dcdakegQru2A3MuhHKXVN04SEe5wLMeNdSsu1X+PdWSVvecX5kY/9axzoSvaazt92Vp
 CDovpgN0t7WE7Qcl17Uq76tlJAhCqLZldTMxMaXNtDH7l5csSHC8SHNKvQvhFa+sWc9Wbqya
 cSodO3+anHaAZ5qa7iICQUf0hTqlVu5wlQtIryn+dG/gh6+trp/tYqOOYg8JFfko7o6XHoYC
 v5eUSVbJDxyRkbZ/sUTJFO0/2hAwz3var48nTDYPYxCXxuk+1OaOWGHPGEUmq63fWNX0kOgk
 4o3QDeoivuzXOC8qi0yCW3+uWKT/sVEYPgFAey2/8CJCH+s776oUvdONPlpnQOuQ/6ea9ESF
 WfJNc8JayRhucRzoC2sPgB3wNJe2wBgICNch7JFy1SW+87SruQARAQABzTpQYXZsb3MgUGFy
 aXNzaXMgKHVuaXhzdXJmZXIpIDxwYXZsb3MucGFyaXNzaXNAYm9va2luZy5jb20+wsGYBBMB
 AgBCAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBB2Q2SugwbvmFI+vnYP8ktof
 cXa5BQJaacnZBQkM8l9GAAoJEIP8ktofcXa5wrcQAI1bpgoLNWUQdWEVXGEQDmymUGoiJd+L
 vDYRh0PV8bEh6hXbpWxBJyMQgyZDPtGlpojI6azwfloFg4bmVpx8tuGzxOSamUj12HSRQIcH
 6fZFhVqXXtHxaR/Ar+X25PxXYxzPKbbwlPs6Y5H/5sC7Yn3N9O86m0tBCG/735DYzm0w3KM1
 zvI2MgeNXZVJKdkr4qLhl+4bRZY1g02Pb7VZ2Wr1wc+kY1qe3htt0eq6dYNZn92XNLRtezhn
 H1gN8/RMCJL4WlsuXhMaGoKT1eB84dWzpJG6ZATYzFriAWS2MbZR76ouG60Wfe18YqVIOO8j
 umYve3J0aICxwlYwtFlqKYiNaahCB3YXUubkeLTHYQZkLr8IKSyqzuY8o4D9nq5/++6tscOW
 oT+ptpY9BzhhYuJGT+yBttqDGneJxZ333NyFsDy0GWnsTZTwgSE2NrUEI2M7tBwyunqfEMtF
 lfpF16lQ/+96WyhyB4OTf9TA/iyCaGAZ09wQ8H3fd2tVRjlmJ7szogmZepczpXv48MTXfr34
 mtJ8WEfVsQHkSssO3Vybnnm3bb+L8rbUg7DXDP5yTs7jpdseI57Lo1w8eoiuyhDQ19UN1eEj
 1YUdioXDJT3aLruUkkhboWnZxRRQ8eK9NE2uGs2M2oQrPewFDzcodixePpoSd+9pnSUIh/m3
 eOSdzsFNBFE50ZMBEAC/1BH//nQj2hIdDiBEKegibb8CiM2FrB9f1j0DjKMG68ZxbyqEyZoe
 zWNlREaNhkKmAZAz72/SMRkwQTXZ61UnllKdafppxdoMopcF9pXD6FM/a2Sx7VgBJVDBIx83
 sZpHrw5Pcuk8AuqNZkx+YJQyPIoGJL7wVoeLIkMaz2MVJ9BT3gP73XgsVS0AxBUUndxGbxQ1
 RdEyXSU2F4LEJ5HIJhqW6qppy5uLDZ0Ts6DL9uZYBj++MDkB3YnzVVVEVccvQeERSYEauSuZ
 fPE5iEY2xsQGXECslhiA/zgo4gZ5vn30ffDeoBOnfMztX/4ViLgE6GAO/VnlDCX4M2UGaX61
 6edtzJi1bDQjj1+BNxSQy7x++Z06E4y9wJHRysKLZarCvYO1y7iO/xLcfZiBgSgZ6nYudtjF
 jacA0kpDwTj7ZS3cn4kO52UXUDmx7eP6O9K9qspXpmjwuj147N7YCmsZwgnIPypxm3fVfldH
 nMFHjGeJl7Xs+5l2oF/LpFa6cpXgYFjRhmVwCNbln/5+HyT3YOFnkLdIEc1uCoMBPTsjr4xQ
 nic//fXlrtse/J5TIQR5S3HIchcJT7RIi3HnlAYfRVj1Dy+xvn8BsEkDPSLU5LcnUc8GFGmr
 Vubdz00W5K7vJy9AwvAqh6Sqh/v4+vYvun+BYv64sJxw4o16AcqPhwARAQABwsF8BBgBAgAm
 AhsMFiEEHZDZK6DBu+YUj6+dg/yS2h9xdrkFAlppyb0FCQzyXyoACgkQg/yS2h9xdrlKnA//
 SF0ZAosVWMinrajdSp9euRxWfdsp2Vn1vfEHT2S7V4p8APJZE8wE/I9UcSuPDUPjjB8Vw8iO
 vQoxg9vE11HadGScGaXnC2m5lQP4GgSN+g9AImZRoOkrBzklXBgf12mrrQ92UVJVr3AsflYw
 UBZ0/k4ySkym0KNQjq4Xd0NRbHMaFRHP6KgWTVPn36Cy9j9UwrFBb/QwQKpRbn79B3pWlN3v
 jQxKG4dhTFEburszqTqtEoXBnQeAch6L8wpaNsSNyDzMmoKczjz7dEwWVM65OvANxcflRp8p
 1H9aEWq04ga28fl+fWrNSCMXafHKpX2uz3FQRhtyMLaX8RZsixrTZK9GC+HLPw5Gc7utNFaC
 9WCQP75wE4Re3Z+g4yO7OmdYrOH2WC1Ga3IAEvWpKdf6sx0j4XWOqp4EBJ9GP8wBXZUmm8Xz
 xs0Ui6ayYI4guy08HUsysqcfAp/aGvriqZ01EcjlCkfnvQ/Xs+OIRy47h/mL2XwkT3C0wF+8
 /EYDe4i5XY47vv4cBwoPpw7O7z+AQ85VnQTb6ODJSJIyjIGC3VXb29qsuJOxc+Ina+wgAztE
 0E+eUNN5pjvWx/9v6e8E56bAizJhU/sKbQFk+B4MGYUqHwsSd9xrR8+Y/OtxhaxBU00WLBnw
 CjB2s83SyrTd4UWbbIdiUV5C4QiML5GSewM=
Message-ID: <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
Date: Wed, 18 Apr 2018 10:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UFUmR4Vwbu75721t8O4xW35cTcncTHMH7"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UFUmR4Vwbu75721t8O4xW35cTcncTHMH7
Content-Type: multipart/mixed; boundary="OD0x0zwTmnxJLqQgUvkt3tsPYxkdgQ2gy";
 protected-headers="v1"
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Guillaume Morin <guillaume@morinfr.org>, stable@vger.kernel.org,
 decui@microsoft.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mszeredi@redhat.com
Message-ID: <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
Subject: Re: kernel panics with 4.14.X versions
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
In-Reply-To: <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>

--OD0x0zwTmnxJLqQgUvkt3tsPYxkdgQ2gy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/04/2018 02:12 =CE=BC=CE=BC, Jan Kara wrote:
> On Tue 17-04-18 01:31:24, Pavlos Parissis wrote:
>> On 16/04/2018 04:40 =CE=BC=CE=BC, Jan Kara wrote:
>=20
> <snip>
>=20
>>> How easily can you hit this?
>>
>> Very easily, I only need to wait 1-2 days for a crash to occur.
>=20
> I wouldn't call that very easily but opinions may differ :). Anyway it'=
s
> good (at least for debugging) that it's reproducible.
>=20

Unfortunately, I can't reproduce it, so waiting 1-2 days is the only opti=
on I have.

>>> Are you able to run debug kernels
>>
>> Well, I was under the impression I do as I have:
>>   grep -E 'DEBUG_KERNEL|DEBUG_INFO' /boot/config-4.14.32-1.el7.x86_64
>>   CONFIG_DEBUG_INFO=3Dy
>>   # CONFIG_DEBUG_INFO_REDUCED is not set
>>   # CONFIG_DEBUG_INFO_SPLIT is not set
>>   # CONFIG_DEBUG_INFO_DWARF4 is not set
>>   CONFIG_DEBUG_KERNEL=3Dy
>>
>> Do you think that my kernel doesn't produce a proper crash dump?
>> I have a production cluster where I can run any kernel we need, so if =
I need
>> to compile again with different settings I can certainly do that.
>=20
> OK, good. So please try running 4.16 as you mention below to verify whe=
ther
> this is just a -stable regression or also a problem in the current upst=
ream
> kernel. Based on your results with 4.16 I'll prepare a debug patch for =
you to
> apply on top of 4.14.32 so that we can debug this further.
>=20
>>> / inspect
>>> crash dumps when the issue occurs?
>>
>> I can't do that as the server isn't responsive and I can only power cy=
cle it.
>=20
> Well, kernel crash dumps work in that situation as well - when the kern=
el
> panics, it will kexec into a new kernel and dump memory of the old kern=
el
> to disk. It can then be investigated with the 'crash' utility. But
> obviously you don't have this set up and don't have experience with thi=
s so
> let's go via a standard 'debug patch' route.
>=20
>>> Also testing with the latest mainline
>>> kernel (4.16) would be welcome whether this isn't just an issue with =
the
>>> backport of fsnotify fixes from Miklos.
>>
>> I can try the kernel-ml-4.16.2 from elrepo (we use CentOS 7).
>=20
> Yes, that would be good.
>=20

I have production server running 4.16.2 and no kernel crash dumps yet.
Let's wait another day before we say anything.

Cheers,
Pavlos


--OD0x0zwTmnxJLqQgUvkt3tsPYxkdgQ2gy--

--UFUmR4Vwbu75721t8O4xW35cTcncTHMH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHZDZK6DBu+YUj6+dg/yS2h9xdrkFAlrXApYACgkQg/yS2h9x
drnkLg/9E42gL7RHvAQTvCza/d89rB5HjVORXezDw66xfEEPKHFP+j/EzHxdd+QU
hiW2gXWErFzLMpr8NhVgu4WDc7fOyWXJ58IxF5oneNgPHv1jjoDzkzCFoJzpG8Tg
MdBsrEHajVwZZ1l9xdE1y8Qkhanb8U0lIeoprpBE0upHnT3EkhlWl6bhQDsYp4u8
5Xu15ZM3V+JB5mSgjpJZCiEkd3Xqk9oPgHc714X+MA4Qc7mCrHo6hhd5UpQV5HUz
Iz/PMDjqufqlc8HQR/sc+XJtGufeOyvQa4KcKey8BBusYscc5XrTrODteg9Px8pa
oGPd9BUec9mrxN9kPCsVXAmtcdFRp9/KTuiU9hQc3wfEL1Eo3imzOGVkr5wxvF0f
xigUBOcraoak0eCUkvIEbMRphgtG7rEkTS6PLHZHCUh4KiXtYjnvmwb6Qk6aNhfy
GP7vMTC47kw4lss2gC9jZQjVM9cq7ze7tljmmYRWnzf8k8rB2JmozcmLcTr5pHee
KiC/sD0G0eDVtfnS3uP3GouvMRsQvI2FzjwIBZJI4ML4FSChcbklf0TI1fZbQW6I
qmAsqnoUpencnJvxwvCNsA6x2WfwSdg+lUOC4IAw1Reeza8rNvzoRmF+hFOcwxQS
jWKX8EkABVG/1212d5nZWUjYrDReCV5L7PiswXoHqdDfqQu0Hew=
=8w/O
-----END PGP SIGNATURE-----

--UFUmR4Vwbu75721t8O4xW35cTcncTHMH7--
