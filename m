Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF20C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E120671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2M2qQBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494E120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeKTVAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:00:44 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44581 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeKTVAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:00:43 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so980138iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+21HGHswGnYjENYIqGn/kvXK0Nsz+J5eHz7rf19uQA=;
        b=N2M2qQBExH0uZGz9+vw+ZVIivlhVE2O9nTd0SntvyDDXYyQkQkwQR+FppqpL6mAkeK
         lUzJ2OLAx1tHjHC+B/pdAkopYqBI3M5C0cBw9937Mur3nvOipWn+8Yr9RYhlKKqGqI/x
         RZyTlF/wtRP02s3wbbFXPCObptqYox7tX6vqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+21HGHswGnYjENYIqGn/kvXK0Nsz+J5eHz7rf19uQA=;
        b=dKkFbA6NU/vC0k+lJYiwdlozMZT3H0VVMWIpdmbVrryCUH0kQjCAgXcCOpnqqo8fMX
         hrJmmdm2REDoqAIhN44EmRIwZpbYrSMzQa8Fiiogpag3u6gibf7+xn64s0tgjWuhbiJk
         WfCyd3iRdfXuIIV8R0axZEtOJU/IlPvR126B7TbGBX/CvAU/s9rAJHN9nFn4FOz2mKDY
         vp1VrCpsPLyTvbtl6WDDE3jI/oXdnuxScFAvsfTmOf3Zu76WTNOzD/MQqy6reWUHBEyH
         EK4Vpj1EaPey82DC7j81jbM+G8NGB3obMzGvIrArdUbGeT8wRDhXxSYaGF34qPaG332d
         k7dw==
X-Gm-Message-State: AA+aEWY7Gsak7EBLOfRiobd9nye7h0smAOn7iSFawe6FY5yB8XiUx7fL
        jFnrLKVaKKl3OBjZy423wEBHh/wShh3nq01TsmaYUA==
X-Google-Smtp-Source: AFSGD/UlE7YQhZcqzViLKIS9q85R/xUxKYjv+xREr7kvFEAdyIAoO4klvdPURDqGzWxkPX/EIPsy+BhgE/2xRqr4viY=
X-Received: by 2002:a6b:7a46:: with SMTP id k6mr1175871iop.60.1542709936366;
 Tue, 20 Nov 2018 02:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20181105232526.173947-1-ebiggers@kernel.org> <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com> <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com> <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au> <20181120060217.t4nccaqpwnxkl4tx@gondor.apana.org.au>
In-Reply-To: <20181120060217.t4nccaqpwnxkl4tx@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 20 Nov 2018 11:32:05 +0100
Message-ID: <CAKv+Gu-SHS2tF665dfqSgmH5EF5vGVtef=3_4WgCE=+8+Jw7Rw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Exporting existing crypto API code through zinc
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 at 07:02, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Nov 19, 2018 at 01:24:51PM +0800, Herbert Xu wrote:
> >
> > In response to Martin's patch-set which I merged last week, I think
> > here is quick way out for the zinc interface.
> >
> > Going through the past zinc discussions it would appear that
> > everybody is quite happy with the zinc interface per se.  The
> > most contentious areas are in fact the algorithm implementations
> > under zinc, as well as the conversion of the crypto API algorithms
> > over to using the zinc interface (e.g., you can no longer access
> > specific implementations).
> >
> > My proposal is to merge the zinc interface as is, but to invert
> > how we place the algorithm implementations.  IOW the implementations
> > should stay where they are now, with in the crypto API.  However,
> > we will provide direct access to them for zinc without going through
> > the crypto API.  IOW we'll just export the functions directly.
> >
> > Here is a proof of concept patch to do it for chacha20-generic.
> > It basically replaces patch 3 in the October zinc patch series.
> > Actually this patch also exports the arm/x86 chacha20 functions
> > too so they are ready for use by zinc.
> >
> > If everyone is happy with this then we can immediately add the
> > zinc interface and expose the existing crypto API algorithms
> > through it.  This would allow wireguard to be merged right away.
> >
> > In parallel, the discussions over replacing the implementations
> > underneath can carry on without stalling the whole project.
> >
> > PS This patch is totally untested :)
>
> Here is an updated version demonstrating how we could access the
> accelerated versions of chacha20.  It also includes a final patch
> to deposit the new zinc version of x86-64 chacha20 into
> arch/x86/crypto where it can be used by both the crypto API as well
> as zinc.
>
> The key differences between this and the last zinc patch series:
>
> 1. The crypto API algorithms remain individually accessible, this
> is crucial as these algorithm names are exported to user-space so
> changing the names to foo-zinc is not going to work.
>

Are you saying user space may use names like "ctr-aes-neon" directly
rather than "ctr(aes)" for any implementation of the mode?

If so, that is highly unfortunate, since it means we'd be breaking
user space by wrapping a crypto library function with its own arch
specific specializations into a generic crypto API wrapper.

Note that I think that using AF_ALG to access software crypto routines
(as opposed to accelerators) is rather pointless to begin with, but if
it permits that today than we're stuck with it.

> 2. The arch-specific algorithm code lives in their own module rather
> than in a monolithic module.
>

This is one of the remaining issues I have with Zinc. However, modulo
the above concerns, I think it does make sense to have a separate
function API for synchronous software routines below the current
crypto API. What I don't want is a separate Zinc kingdom with a
different name, different maintainers and going through a different
tree, and with its own approach to test vectors, arch specific code,
etc etc
