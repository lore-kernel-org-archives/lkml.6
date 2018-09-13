Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3F8C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27AE20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3jHcob/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27AE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeIMKth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:49:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38532 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeIMKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:49:37 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so6255306ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 22:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gz+h+HkWDIqojP2WSc+iZI/JlWGaFT+pSzr5Jf3wF3Q=;
        b=N3jHcob/7SGiPNXwgR3KfD/au+Jh09R8HCMtSYDvRhMZL39Fc663BZqmZ/KG/14NDm
         6gNDHWhQk+WqZLfeuiVvlr4ziOs9v0gCfpdSwUU5fR0Thtl1s1NclW1BUPhFqjK3dskA
         Qa5Z4fiNJZeygbFEPwKsWU5LyhRqIB69syNNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gz+h+HkWDIqojP2WSc+iZI/JlWGaFT+pSzr5Jf3wF3Q=;
        b=TDGsoLTyHezd9jqv5eqTJ74OPUu4FE55yZsPfLZ7ELaodSy2YEzo4wLPf4uSr+t/8B
         nZ7FBJw7D4uB3obbkNf0cDfzXpduKkh+Go7dUufbiyUZKUk3UuWseKWuyDErUYxm7pmd
         joRStJ2h7OceTjFiv+katjfr6AC/HhMtM97qQQtCa3+vBPIO5phanUr60h/3o4rnXifK
         EIrAEDgL+rYKOVd9389A5oT6OJWudZhGiozKCrlR/qmlRoOpxAMat5jsyVQRyx4Drv38
         2SW+DtJfIjnYLs5OMw68B2k3SIZg0W1pl2YLmWN5/4al2QD71VIKbnsdjc3oKgJP8waR
         MOfw==
X-Gm-Message-State: APzg51A2Y4hkBNOtvaaVfVJ8Js/VISgp/FLdFi46BbR6YnxpPQYBnr0p
        qfFWt/gh/fEnfxxQFkL4OfaPTlRhjV3dVdo7dIRuqw==
X-Google-Smtp-Source: ANB0Vda0KGQnL2orYcgpVB5bY7vD7Z7NeAhM9K/41xqerh3D+vCPdXtH57HH+l2OByQQG8OVwDiWpBrUgN6YG6i4Ldk=
X-Received: by 2002:a02:4d1b:: with SMTP id l27-v6mr5184619jab.86.1536817301516;
 Wed, 12 Sep 2018 22:41:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 22:41:40
 -0700 (PDT)
In-Reply-To: <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com> <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Sep 2018 07:41:40 +0200
Message-ID: <CAKv+Gu8z1r7F_wbR6-e0Vbryqby7djDy2OR6JJURCsTo6ZMa2g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 September 2018 at 01:45, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Sep 12, 2018 at 3:56 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> I realize you've put a lot of good and hard work into the existing
>> I am also concerned about your claim that all software algorithms will
>> be moved into this crypto library. You are not specific about whose
>> responsibility it will be that this is going to happen in a timely
>> fashion. But more importantly, it is not clear at all how you expect
>> this to work for, e.g., h/w instruction based SHAxxx or AES in various
>> chaining modes, which should be used only on cores that implement
>> those instructions (note that on arm64, we have optional instructions
>> for AES, PMULL, SHA1, SHA256, SHA512, SHA3, SM3 and SM4). Are all
>> those implementations (only few of which will be used on a certain
>> core) going to be part of the monolithic library? What are the APIs
>> going to look like for block ciphers, taking chaining modes into
>> account?
>
> I'm not convinced that there's any real need for *all* crypto
> algorithms to move into lib/zinc or to move at all.  As I see it,
> there are two classes of crypto algorithms in the kernel:
>
> a) Crypto that is used by code that chooses its algorithm statically
> and wants synchronous operations.  These include everything in
> drivers/char/random.c, but also a bunch of various networking things
> that are hardcoded and basically everything that uses stack buffers.
> (This means it includes all the code that I broke when I did
> VMAP_STACK.  Sign.)
>
> b) Crypto that is used dynamically.  This includes dm-crypt
> (aes-xts-plain64, aes-cbc-essiv, etc), all the ALG_IF interfaces, a
> lot of IPSEC stuff, possibly KCM, and probably many more.  These will
> get comparatively little benefit from being converted to a zinc-like
> interface.  For some of these cases, it wouldn't make any sense at all
> to convert them.  Certainly the ones that do async hardware crypto
> using DMA engines will never look at all like zinc, even under the
> hood.
>
> I think that, as a short-term goal, it makes a lot of sense to have
> implementations of the crypto that *new* kernel code (like Wireguard)
> wants to use in style (a) that live in /lib, and it obviously makes
> sense to consolidate their implementations with the crypto/
> implementations in a timely manner.  As a medium-term goal, adding
> more algorithms as needed for things that could use the simpler APIs
> (Bluetooth, perhaps) would make sense.
>
> But I see no reason at all that /lib should ever contain a grab-bag of
> crypto implementations just for the heck of it.  They should have real
> in-kernel users IMO.  And this means that there will probably always
> be some crypto implementations in crypto/ for things like aes-xts.
>

But one of the supposed selling points of this crypto library is that
it gives engineers who are frightened of crypto in general and the
crypto API in particular simple and easy to use crypto primitives
rather than having to jump through the crypto API's hoops.

A crypto library whose only encryption algorithm is a stream cipher
does *not* deliver on that promise, since it is only suitable for
cases where IVs are guaranteed not to be reused. You yourself were
bitten by the clunkiness of the crypto API when attempting to use the
SHA26 code, right? So shouldn't we move that into this crypto library
as well?

I think it is reasonable for WireGuard to standardize on
ChaCha20/Poly1305 only, although I have my concerns about the flag day
that will be required if this 'one true cipher' ever does turn out to
be compromised (either that, or we will have to go back in time and
add some kind of protocol versioning to existing deployments of
WireGuard)

And frankly, if the code were as good as the prose, we wouldn't be
having this discussion. Zinc adds its own clunky ways to mix arch and
generic code, involving GCC -include command line arguments and
#ifdefs everywhere. My review comments on this were completely ignored
by Jason.
