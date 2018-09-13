Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F426C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E814204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vcyFGoJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E814204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeIMTZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:25:16 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52395 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbeIMTZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:25:15 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dc9b8961;
        Thu, 13 Sep 2018 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5WMe66oadYWvlhWyLPWjlk9Op38=; b=vcyFGo
        JGffs0ttkj3zQpUYYYkQFIrB9d5sZ2tntvPW+XYl7SxRXhrmlEAUzocz+VUxXwkA
        yeYyJvMBcziUPQ2hnefL0LMenK8dR4jMY3s1Fe/9F4+LtraMJo4e89kM92M4YZEG
        PJ2dBfrRkL6uyIp+1Fd5D8IDELIDMYw0MqC9K7JFipbWNaaCk8T4JB8h19vZblO1
        f+ajfXfHGpVCrgUY1Sdg5JcJfHYGY7/smQ5MHuWwsRQdckUe69vp0w3dZioxDD2q
        /TlkvgrH4b3fYcMUlOeLKr0yBayym8AI/qRa40aem8XO0Y44RrUWgzfQ5z7/yghk
        ApaW39ttCHTHIXCA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f5e65806 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 13:58:35 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id m11-v6so9600720oic.2;
        Thu, 13 Sep 2018 07:15:30 -0700 (PDT)
X-Gm-Message-State: APzg51BWBKND6+s1kv4vW63X4dETYgGsPPUcTpzUyzA9k1ro3HfuPj4h
        0oklvwEmzL6P6jwsXjq/zZZbuOiheSqEftH/0wQ=
X-Google-Smtp-Source: ANB0VdYWO89/G1TjJKZsDK0Kams62qdEal/Oc5mILuVVJSmoRSx43m7TfB5wuHf09RVy7/cr4gpXdMqmJVR+6LF4gWY=
X-Received: by 2002:aca:fd4f:: with SMTP id b76-v6mr6852820oii.307.1536848130135;
 Thu, 13 Sep 2018 07:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com> <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 16:15:19 +0200
X-Gmail-Original-Message-ID: <CAHmME9oYAEwFQAriVRm5zZKCo0Sh1=t5YheNZ+MtKQLQPoMWeg@mail.gmail.com>
Message-ID: <CAHmME9oYAEwFQAriVRm5zZKCo0Sh1=t5YheNZ+MtKQLQPoMWeg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, Sep 13, 2018 at 12:56 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> In this series, you are dumping a huge volume of unannotated,
> generated asm into the kernel which has been modified [by you] to
> [among other things?] adhere to the kernel API (without documenting
> what the changes are exactly). How does that live up to the promise of
> better, peer reviewed code?

The code still benefits from the review that's gone into OpenSSL. It's
not modified in ways that would affect the cryptographic operations
being done. It's modified to be suitable for kernel space.

> Then there is the performance claim. We know for instance that the
> OpenSSL ARM NEON code for ChaCha20 is faster on cores that happen to
> possess a micro-architectural property that ALU instructions are
> essentially free when they are interleaved with SIMD instructions. But
> we also know that a) Cortex-A7, which is a relevant target, is not one
> of those cores, and b) that chip designers are not likely to optimize
> for that particular usage pattern so relying on it in generic code is
> unwise in general.

That's interesting. I'll bring this up with AndyP. FWIW, if you think
you have a real and compelling claim here, I'd be much more likely to
accept a different ChaCha20 implementation than I would be to accept a
different Poly1305 implementation. (It's a *lot* harder to screw up
ChaCha20 than it is to screw up Poly1305.)

> I am also concerned about your claim that all software algorithms will
> be moved into this crypto library.

I'll defer to Andy's response here, which I think is a correct one:
https://lkml.org/lkml/2018/9/13/27

The short answer is that Zinc is going to be adding the ciphers that
people want to use for normal reasons from normal code. For example,
after this merges, we'll next be working on moving the remaining
non-optimized C code out of lib/ that's called by places (such as
SHA2).

> You are not specific about whose
> responsibility it will be that this is going to happen in a timely
> fashion.

I thought I laid out the roadmap for this in the commit message. In
case I wasn't clear: my plan is to tackle lib/ after merging, and I
plan to do so in a timely manner. It's a pretty common tactic to keep
layering on tasks, "what about X?", "what about Y?", "I won't agree
unless Z!" -- when in reality kernel development and refactorings are
done incrementally. I've been around on this list contributing code
for long enough that you should have a decent amount of confidence
that I'm not just going to disappear working on this or something
insane like that. And neither are the two academic cryptographers CC'd
on this thread. So, as Andy said, we're going to be porting to Zinc
the primitives that are useful for the various applications of Zinc.
This means yes, we'll have SHA2 in there.

> chaining modes
> What are the APIs
> going to look like for block ciphers, taking chaining modes into
> account?

As mentioned in the commit message and numerous times, we're not
trying to make a win32-like crypto API here or to remake the existing
Linux crypto API. Rather we're providing libraries of specific
functions that are useful for various circumstances. For example, if
AES-GCM is desired at some point, then we'll have a similar API for
that as we do for ChaPoly -- one that takes buffers and one that takes
sg. Likewise, hash functions use the familiar init/update/final.
"Generic" chaining modes aren't really part of the equation or design
goals.

Again, I realize you've spent a long time working on the existing
crypto API, and so your questions and concerns are in the line of,
"how are we going to make Zinc look like the existing crypto API in
functionality?" But that's not what we're up to here. We have a
different and complementary design goal. I understand why you're
squirming, but please recognize we're working on different things.

> I'm sure it is rather simple to port the crypto API implementation of
> ChaCha20 to use your library. I am more concerned about how your
> library is going to expand to cover all other software algorithms that
> we currently use in the kernel.

The subset of algorithms we add will be developed with the same
methodology as the present ones. There is nothing making this
particularly difficult or even more difficult for other primitives
than it was for ChaCha20. It's especially easy, in fact, since we're
following similar design methodologies as the vast majority of other
cryptography libraries that have been developed. Namely, we're
creating simple things called "functions".

> Of course. But please respond to all the concerns,
> You have not
> responded to that concern yet.

Sorry, it's certainly not my intention. I've been on vacation with my
family for the last several weeks, and only returned home
sleep-deprived last night after 4 days of plane delays. I've now
rested and will resume working on this full-time and I'll try my best
to address concerns, and also go back through emails to find things I
might have missed. (First, though, I'm going to deal with getting back
the three suitcases the airline lost in transit...)

> > Anyway, it sounds like this whole thing may have ruffled your feathers
> > a bit. Will you be at Linux Plumbers Conference in November? I'm
> > planning on attending, and perhaps we could find some time there to
> > sit down and talk one on one a bit.
>
> That would be good, yes. I will be there.

Looking forward to talking to you there, and hopefully we can put to
rest any lingering concerns.

Jason
