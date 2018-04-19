Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4026916-1524172633-2-4239385039867504287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524172632; b=QMVFQDGzwSQ8w3wayEcZptadx7MVqQwL3BKpmU3/9id9GqdCpU
    d5fLM+BcROUO5IwjE7gcE2SqPHwyxNCRez1Zqp6zIvD+fM0vDovtEk0NczQxEyN7
    Y3RzX6a74/paAVy6V0b465mqf8mL5ESnXlvMRtgD/GUOSRgeIHa0kxxYGHnei6lg
    1vxoalAlXyUVMJ4ti6imiQHyiFI01Yj+fLa95LIQPTLZGqFJO4Ntd3SlPNAtj8CZ
    JKtQ2nVfj2SXMlpqx2b4d7Uq/maueqwxRMk3sNjMJr0ZxTmwo8ab5kt9DWqbTI7A
    PE9mkw//OeSpfZdyCZOrC/cNFNlp/YmJDiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1524172632; bh=tO2X1AVikbxp73I4McLw7mx0xGc9p7ctsxmsCU8AKV
    M=; b=mV8iHgID+otwj+MVT2W+XonmY9tIIOLCEg7AXS+ctye1Mn/SgikHE0gD2H
    CwHdMdvEhV+bL1kH6YvEMl8cu23gWhg2bBnSagfXSf2uIU3HtNdtkcZTUEa3uu2w
    hnzLvy+SNofzrOx+zse2aQ1zLV5E40GF7w2KBxkvocqtm1OO88bm3nytL+duF4LR
    vSESvelqvtEMpJvNS8ZU+DIHsif+fku9yl865GuRzEAxcfKbcputhgaXifNs2Y4n
    Hsqx21sjmt9lIBQmp488GjQhIoNfCSuGkhZmAgjMMfgbpJC6mON0qjyemyZPp42p
    JxcBlJxcWUfLrmwjh13p+xJRqObg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TFQAsrH8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YW9IKXzF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TFQAsrH8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YW9IKXzF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDgH7d8MJeUV4JfkEhayEcBPxvTEvuCUwDMKADQXPJ9RiY3PBAJ6L5HldCUj2VT884pZZ1qxkSZyqXKQhrE3sMqgjBv8f5/Qe3C8FiNSkz/ob5FMilMf
    45onOUhUnO/LOpha6GrYmJRaHyvw89Jy8eqGvadEJnPfjZv96f7NJ3tNmnirM5HUbUeXGpsXX8/OQkAksxrNgxAJ65+omcPsr6lau3iMA9F/+VVMxSPx+7X9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=ZVeAwwkMJCUA:10
    a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9 a=fqarOI6e0W5aHbhqASQA:9
    a=QEXdDO2ut3YA:10 a=xmQykDiDE9qe5ma_1DoA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeDSVRB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 17:17:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35337 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSVQ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 17:16:59 -0400
X-Google-Smtp-Source: AIpwx4/+JSYaqAdRLeXlvDPjvtIh8z83T6L0iJ6k2jDDdUZZycxX38JP7Fy/7XOzaXsC3oKKjneswQ==
Subject: Re: kernel panics with 4.14.X versions
To: Jan Kara <jack@suse.cz>
Cc: Guillaume Morin <guillaume@morinfr.org>, stable@vger.kernel.org,
        decui@microsoft.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com,
        Robert Kolchmeyer <rkolchmeyer@google.com>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
 <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
 <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
From: Pavlos Parissis <pavlos.parissis@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pavlos.parissis@gmail.com; prefer-encrypt=mutual; keydata=
 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
 CjB2s83SyrTd4UWbbIdiUV5C4QiML5GSewM=
Message-ID: <13d1dfff-e0dc-38a5-e2c5-87e8e1f2fb9d@gmail.com>
Date: Thu, 19 Apr 2018 23:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R0Dcx93oI5EZluAph9KvalmQJ7I9s6vq6"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R0Dcx93oI5EZluAph9KvalmQJ7I9s6vq6
Content-Type: multipart/mixed; boundary="WCY8CyTttUcRrpV9bqqbbLAk8sbdRBTKI";
 protected-headers="v1"
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Guillaume Morin <guillaume@morinfr.org>, stable@vger.kernel.org,
 decui@microsoft.com, jack@suse.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mszeredi@redhat.com,
 Robert Kolchmeyer <rkolchmeyer@google.com>
Message-ID: <13d1dfff-e0dc-38a5-e2c5-87e8e1f2fb9d@gmail.com>
Subject: Re: kernel panics with 4.14.X versions
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz>
 <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
 <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>
In-Reply-To: <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz>

--WCY8CyTttUcRrpV9bqqbbLAk8sbdRBTKI
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19/04/2018 10:23 =CE=BC=CE=BC, Jan Kara wrote:
> On Wed 18-04-18 10:32:21, Pavlos Parissis wrote:
>> On 17/04/2018 02:12 =CE=BC=CE=BC, Jan Kara wrote:
>>> On Tue 17-04-18 01:31:24, Pavlos Parissis wrote:
>>>> On 16/04/2018 04:40 =CE=BC=CE=BC, Jan Kara wrote:
>>>
>>> <snip>
>>>
>>>>> How easily can you hit this?
>>>>
>>>> Very easily, I only need to wait 1-2 days for a crash to occur.
>>>
>>> I wouldn't call that very easily but opinions may differ :). Anyway i=
t's
>>> good (at least for debugging) that it's reproducible.
>>>
>>
>> Unfortunately, I can't reproduce it, so waiting 1-2 days is the only
>> option I have.
>=20
> Good news guys, Robert has just spotted a bug which looks like what I'd=

> expect can cause your lockups / crashes. I've merged his patch to my tr=
ee
> and will push it to Linus for -rc3 so eventually it should land in
> appropriate stable trees as well. If you are too eager to test it out, =
it
> is attached for you to try.
>=20
> 								Honza
>=20

Can I apply it on top of 4.14.32?
I am on vacation for the coming 11 days, so I can only provide feedback w=
hen I am back.

Thanks a lot for your support on this issue.

Cheers,
Pavlos


--WCY8CyTttUcRrpV9bqqbbLAk8sbdRBTKI--

--R0Dcx93oI5EZluAph9KvalmQJ7I9s6vq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHZDZK6DBu+YUj6+dg/yS2h9xdrkFAlrZB0cACgkQg/yS2h9x
drlH8RAAnr9EWgoY6bmBJFwfLcGeqCdrvGcStEMioQ2CD8xmA05QfPPWDaiM2B8E
vh/nsMMFU2KvsWHqpRVt7PHSbvmGlhCaazY/9ENNY2T2T6s0XMT5Z0HOY7vrjlSo
Pw1ebAYUoX5F5Uh8p8iuLGZJMcAado3ElTLXQ5wYM524i4DNNXZkpC3Q4GS2rd7k
0cGz+ds7gzeaYGtNvBBowsNJFH/MbY2huOEAzMVZbtsNLsFDbD4aCMhKF0l/JD9B
OmIdXr3K+ERjC+5jeAnru2Py8Du9TgHnst6lJU87BC8PaljeZN+Q/zKu726BfGZZ
o8VJ7CUVrEaL/hu3g24Ug5OLpN/+L1gEdt+MnED6Z5lZ8qrSphK1qxsZ22CrHCp2
p2IZC54a9MMUv0CielvAizGpx0W3K0ers0HpQ/nbW8CAhes0UI2kwkNhhFSjiLby
dkfJ5fLcoJ//wQBVvVxUJ9AjwIHMYhsaGxkLHDvLCq9JyDRmf8YhIznol756uvMT
u1L6l0HiP7gYc8x/mtqW5tEHLmou7N7ezm1vUaNTURYlhi37yTUxvdSbeOoNrbq8
+nP52nxnt5txRkE1GzYPLnfvA2xEfxx+i/kxuvjZX2+IxiboGuYAKqd/YEt8gjyL
i2htqUaYih6TCnRScKRTLF8e75xvCrWOdQX4Zv8X5X5LX7h9wBk=
=BEPg
-----END PGP SIGNATURE-----

--R0Dcx93oI5EZluAph9KvalmQJ7I9s6vq6--
