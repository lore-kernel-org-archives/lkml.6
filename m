Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1970493-1523974525-2-10868925133528595332
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
    1523974524; b=f/gKKAhxcKW5INftwmKA++ctYlmwZvH5eX3PiN+6MPQBsDBMVK
    +3OuYGl7yeMXHADM4lSln6EcHT1gKbeQet7VjnM3uNe8b74T2b8gU0IZfEdivrgS
    hOQTY5nTM+IsBXjCqRqrD3OubcYdXIXSkbZZ7WnU7OBUe8DdCFIfbLpqbrrqFKUK
    lH5FIcAKPUtbU0dMKyIkoKqWp/FSmxn3QLT1tbQD++XH3Oyp2IEkWZ4oYX1vGrIm
    x6SDKvN55sBMrZ+wUzhPpLErpA+5teEmjBURaeQ0DCY16IDhuRXDc5Vlcj83TXBU
    QDCAqQRdyYnAcKQ8C2/kOannhHkFvV8UpH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1523974524; bh=DJBQ53vnn60gpzYy7s+ShWfqfkD1jM08OCkoA+AD3i
    0=; b=rgseaY7Ge/6l6ip3j7lRnbH8MX8l3m3w1qrukpQUmqagKNSgh9eKXCT9YW
    AsqMV+1ZjeAt5XGQnmSkbLbhDD4polapaPoEWIiQVtStJEYfJfpC1z3waBeLwK1H
    Al8KVK7LVjDg2kS5ro6Rg7aGwzhvZtbYc3VPvfj0mxhnYlOkl8cW57ZlzsDUFlqf
    h3DiKDpgow5DJGKwpG1bznQy2voRmHjxOSb+coPbM9R9+TyhJ+tBGl2bCAGi8/IN
    Ed0Z7WWXKzqyBwZcdWQ/CVOX1jHfR9UpoLYs7wPgDPFyzp46mx3KoOWguV8rbaFw
    +ek56wUNJAFDCI2obfooKS2zp5xw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uqpRhJx5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L/eUlJJF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uqpRhJx5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L/eUlJJF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDiNdGnvmf9BudAqYruyp1ttvAPor/VuJlIQrfE23AY8ipWza6BKAUYHERFuqudKT0iHTFNy5Qpu4Egis4Sq0pMVQ72YIRebfVV98eATZjfnXt46cmi5
    h3pFQsNG6RpmvW9HmsDLsTUd7cFh1KcNya7YKXH5OgMP1tbWdK+sGXDGEn/5VeF7hvI8Lemy0+7qBUCMuAzCENjehag9Mt6itCqyEY7GdHF6R44GX3zlir5a
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=ZVeAwwkMJCUA:10
    a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9 a=trQnhTgdIfwNgJZQ4sYA:9
    a=QEXdDO2ut3YA:10 a=0m4U5RGAalqmkWOFKGAA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDQOPP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 10:15:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38062 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbeDQOPM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 10:15:12 -0400
X-Google-Smtp-Source: AIpwx49omYVOcSY1zn3Imyy0YXy6gE62sH4+QZ2pF6W2qfKnWdjkPGLL4/QJh1jKEM2EJicHmIKztA==
Subject: Re: kernel 4.14.x crash around fsnotify_mark_connector
To: Jan Kara <jack@suse.cz>
Cc: mszeredi@redhat.com, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <e7323798-3175-3d27-fdd1-349f1422cb26@gmail.com>
 <20180417140231.75fi4ek2q77qilta@quack2.suse.cz>
From: Pavlos Parissis <pavlos.parissis@gmail.com>
Message-ID: <3016af7f-97f0-e28d-96cd-e49fada3e88d@gmail.com>
Date: Tue, 17 Apr 2018 16:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180417140231.75fi4ek2q77qilta@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U4xveoVe93KwCD4ioJf56f49MGuONfZfq"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U4xveoVe93KwCD4ioJf56f49MGuONfZfq
Content-Type: multipart/mixed; boundary="pliiOaWIfp47bu4mmtRCZwtgX9dBeXHV4";
 protected-headers="v1"
From: Pavlos Parissis <pavlos.parissis@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: mszeredi@redhat.com, amir73il@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <3016af7f-97f0-e28d-96cd-e49fada3e88d@gmail.com>
Subject: Re: kernel 4.14.x crash around fsnotify_mark_connector
References: <e7323798-3175-3d27-fdd1-349f1422cb26@gmail.com>
 <20180417140231.75fi4ek2q77qilta@quack2.suse.cz>
In-Reply-To: <20180417140231.75fi4ek2q77qilta@quack2.suse.cz>

--pliiOaWIfp47bu4mmtRCZwtgX9dBeXHV4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/04/2018 04:02 =CE=BC=CE=BC, Jan Kara wrote:
> On Tue 17-04-18 12:39:32, Pavlos Parissis wrote:
>> In one of our production servers where we run kernel version 4.14.32, =
I noticed
>> the following:
>=20
> OK, I was looking into this for some time and couldn't find a problem i=
n
> 4.14.32 code. Can you try running a kernel with CONFIG_DEBUG_SLAB and
> CONFIG_DEBUG_PAGEALLOC enabled to hopefully catch the problem earlier?
> Thanks!
>=20

I can certainly do that, but I can't reproduce that specific crash. So, i=
t may
take days before we get a similar crash. Having said that, the soft locku=
p issue,
which I mentioned in another thread, happens once per day, so I hope runn=
ing a
kernel with those debug settings will help you.

Cheers,
Pavlos


--pliiOaWIfp47bu4mmtRCZwtgX9dBeXHV4--

--U4xveoVe93KwCD4ioJf56f49MGuONfZfq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1gFsAAoJEIP8ktofcXa5NyAP/2TLllQtoWDeIM42THZwHmEB
KxqiXxA4mnDCUvnMxcxNxTpoZBfqDzEU3qTZ5Bjsp2N9MFKWf+IjxSuTb1hEGp9o
kumkUoNS3ZaB/WjV5kHvOGsmcOUK+XV0yzMQEh5XwOPr9L7o00QBk6TS4RJvQWv8
zbGZabigMQVgfWWXwJJShMPrOPcKfaRAL7xwzfAp0BcVwmQa2kXSgBGOlYuYWveW
UhrWsWERU3BOR+f7UROdQsE1pX3m6/Tye1YREPkoYk+HHA9yHWoMtc1QNU+qxSeq
ow89Un1odPhKOMRB5PgsK8hgg5VWZ5w6P9T8/3fIs2KLK28a3iiXFcz96lfY8jY1
N4rERLjPN8F/pSTZC+3UKezyGhADZuNd9vuKxs7CHC9ooiv9CqcvaMUE9E4J+qPA
gxG1FgzVjhwg8l9RsnrMbe6khHWuFlu/YmkfkvBb/Q+zZanEP0f9Xt+qx13IZ0IF
MariVX2GsfWR+v5EEno0XmEGHowxWuuCd6ZAn26ouW6NDLK92YgWN+W8evO1cvK9
87hZELxhGKI4xkzgUrbQDbmsMydRyMxbifqZqzGdNQFd+21HPgOk+ZpL5wCccalB
hPyPl3M3NPwAxDQfufjNj2qg8er4VRkzLBI8m4QDMwSABviNniy1j8w1wK9U0uCE
mjVkgGLdZPD9iRzxw9VB
=61O7
-----END PGP SIGNATURE-----

--U4xveoVe93KwCD4ioJf56f49MGuONfZfq--
