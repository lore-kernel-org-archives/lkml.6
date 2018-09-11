Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC73C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3542320865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="IAwSHQbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3542320865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeILDRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:17:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34622 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeILDRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:17:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id f6-v6so11977553plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VanPqqc7NFnnpAIXuVyWwpctrkcVQXYFBYwPX5XQFOI=;
        b=IAwSHQbgKo8393Zw3JrkCmSYTF8nQIcXogQMKIx7nwXmKiHtzSmzwou5e1laxgLSjY
         vgVSNeDhDPx8aW+eLBEgn+vdS5pSglibZv2E/woFj4eoSW4NDQWraL/4lolUkG+E1EdP
         QUwQFJ7QrcE18KQ1WS+m0WTBmKB0erhehx7f/O/QtzBJhCE3etPeJ4F8Seehsdz7kNj3
         Mxlq/lahpi9zDyP3NBwQgYkomPYytEcJFq3yni9h1CZ3cKstM3egk4p6la5pnCi44VRi
         +RNZkKKHzu1HIxXBWbI9eAQlADW9b15fezJDFXZKuSZDoGeVelgXgeqUDV+xXF25qt7O
         A4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VanPqqc7NFnnpAIXuVyWwpctrkcVQXYFBYwPX5XQFOI=;
        b=oxHP8lw/Z2an1M3U4MoDkyssvigb+SUN3hFYgmO4HEKxOTBHrjOcRi/yfPaQw5Xj/4
         H2qJNVgBPbEQz5kbdBREvMeb00DJeJG6b7DHO7GN9sDtYjuxUxtvlUERG+s24d3hjDl8
         aC67XdXFjTQHPSf6fCSHHYKKl1pmQekCnpKNhijbN7vD5m3kiPvWOrllTmz3tfiUvk5G
         n485V8Dra6fms6v8Du2tAwlzsYxMd52IWIXnZQZYpPYDb61gLma6NTGl6QunUvHjTWTr
         Dcf+GoSaL7KdEc5I7R0rpy2RGWMkSUvHGqESN3+thgcNNnfS7jc7TAfq2/ougwLe0Kr2
         7dYQ==
X-Gm-Message-State: APzg51AUlLFtYZLBT2nEpzOE/TmQKOQ77Pc5sCqoWwRhv89UtQ7YF0Hb
        3qLYbDxNs+ByXi+VLjD10PqQRQ==
X-Google-Smtp-Source: ANB0VdbxxneZYE/NqRBxCg3HrZkpX+B1aoXCt9w4pNZR0Brv/q60mpWw3a61TZmB4/TZgPy7fSecDQ==
X-Received: by 2002:a17:902:b491:: with SMTP id y17-v6mr29450463plr.160.1536704191383;
        Tue, 11 Sep 2018 15:16:31 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:b8c7:dad3:eb1:4303? ([2601:646:c200:7429:b8c7:dad3:eb1:4303])
        by smtp.gmail.com with ESMTPSA id t141-v6sm28586646pgb.27.2018.09.11.15.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 15:16:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180911214737.GA81235@gmail.com>
Date:   Tue, 11 Sep 2018 15:16:28 -0700
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <49BAF465-B3DC-4155-BFF9-DB6C386C1878@amacapital.net>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com> <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com> <20180911145624.GA21635@kroah.com> <20180911214737.GA81235@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2018, at 2:47 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
>> On Tue, Sep 11, 2018 at 04:56:24PM +0200, Greg Kroah-Hartman wrote:
>> On Tue, Sep 11, 2018 at 12:08:56PM +0200, Ard Biesheuvel wrote:
>>>> As Zinc is simply library code, its config options are un-menued, with
>>>> the exception of CONFIG_ZINC_DEBUG, which enables various selftests and=

>>>> BUG_ONs.
>>>>=20
>>>=20
>>> In spite of the wall of text, you fail to point out exactly why the
>>> existing AEAD API in unsuitable, and why fixing it is not an option.
>>>=20
>>> As I pointed out in a previous version, I don't think we need a
>>> separate crypto API/library in the kernel, and I don't think you have
>>> convinced anyone else yet either.
>>=20
>> Um, then why do people keep sprinkling new crypto/hash code all around
>> the kernel tree?  It's because what we have as a crypto api is complex
>> and is hard to use for many in-kernel users.
>>=20
>> Something like this new interface (zinc) is a much "saner" api for
>> writing kernel code that has to interact with crypto/hash primitives.
>>=20
>> I see no reason why the existing crypto code can be redone to use the
>> zinc crypto primitives over time, making there only be one main location
>> for the crypto algorithms.  But to do it the other way around is pretty
>> much impossible given the complexities in the existing api that has been
>> created over time.
>>=20
>> Not to say that the existing api is not a viable one, but ugh, really?
>> You have to admit it is a pain to try to use in any "normal" type of
>> "here's a bytestream, go give me a hash" type of method, right?
>>=20
>> Also there is the added benefit that the crypto primitives here have
>> been audited by a number of people (so Jason stated), and they are
>> written in a way that the crypto community can more easily interact and
>> contribute to.  Which is _way_ better than what we have today.
>>=20
>> So this gets my "stamp of approval" for whatever it is worth :)
>>=20
>=20
> I think you mean you see no reason why it *cannot* be converted?  The
> conversions definitely *should* be done, just like how some of the existin=
g
> crypto API algorithms like SHA-256 already wrap implementations in lib/.  I=
n my
> view, lib/zinc/ isn't fundamentally different from what we already have fo=
r some
> algorithms.  So it's misguided to design/present it as some novel thing, w=
hich
> unfortunately this patchset still does to a large extent.  (The actual new=
 thing
> is how architecture-specific implementations are handled.)
>=20
> Of course, the real problem is that even after multiple revisions of this
> patchset, there's still no actual conversions of the existing crypto API
> algorithms over to use the new implementations.  "Zinc" is still completel=
y
> separate from the existing crypto API.
>=20

Jason, can you do one of these conversions as an example?

> So, it's not yet clear that the conversions will actually work out without=

> problems that would require changes in "Zinc".  I don't think it makes sen=
se to
> merge all this stuff without doing the conversions, or at the very least
> demonstrating how they will be done.
>=20
> In particular, in its current form "Zinc" is useless for anyone that needs=
 the
> existing crypto API.  For example, for HPolyC,
> (https://lkml.org/lkml/2018/8/6/857), I need to make improvements to ChaCh=
a and
> Poly1305 in the existing crypto API, e.g. to add support for XChaCha and
> NEON-accelerated Poly1305.  Having completely separate ChaCha and Poly1305=

> implementations in Zinc doesn't help at all.  If anything, it makes things=

> harder because people will have to review/maintain both sets of implementa=
tions;
> and when trying to make the improvements I need, I'll find myself in the m=
iddle
> of a holy war between two competing camps who each have their own opinion a=
bout
> The Right Way To Do Crypto, and their own crypto implementations and APIs i=
n the
> kernel.
>=20
> - Eric
