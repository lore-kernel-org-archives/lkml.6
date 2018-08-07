Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B8CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FECB2172B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="U9zL7Dre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FECB2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbeHGV7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:59:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36319 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389807AbeHGV7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:59:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so311972wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lg9FpWgISElVEVEjmbUgJg42tPDw+EZxIHXjiMl/Ueg=;
        b=U9zL7Dre1ApDcbbhgWV/c1BwkZ7lcVCqSzQm1rJd/8XYzfTEN8zViKCuwCEksmF/zc
         YFk9bKyw3TF71hxsRKnQZ4cOGwpPTCyImchwnsdo717gBbITk3MnNmPJoaygokontFjF
         fQCBMpCJq5gB+dmf9hYcfd5IvGUMtASBBe7sDchH4fIRrFwzkYNkbWjCpI5Tk8RWqGSH
         zs/Nq9otKcSaHt+D6vjLPITyKjlTbsJ3R0BG6L9ZKBsJ/bcvOf6W+BZW1QLJzVUBapSn
         GQZljZfCepxXTb1GCrGt3W8MsXmYNgw1d56Wd/u2mXC/+WYe1UE49eDGK8D4RLYB3hdV
         650w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lg9FpWgISElVEVEjmbUgJg42tPDw+EZxIHXjiMl/Ueg=;
        b=SiAU9ugi1Bn4O60ZJFoTqSjqwX8USlcaatRX5nERe/rTzVtguMme5KTF48mFawtMFL
         G2m4dJTTxaWScMGRTN+YdDdhHErVCmNPI/a4RDM8wJxLBvkR0OnDDgVtUxx1XXIF5yxA
         DoImTL27UCbbFeL0gTtNfxGupUlJZTCHkBc/EZgy5LhYgIcCDHRL6GsUUdLTS3CHC6Bl
         nk3ZgJoMnDXomxRCj2SzXQqAoNZVyvlO5MOExxvOaSBXBjNUzkMOkKyyilV+htWtU+IF
         cKPrCwlUFUy3zxKH/0q+l54jYZM8X0MkunkdUphY0oUaa9pTkugq+ki9wKjy5bW5AKdq
         OnEw==
X-Gm-Message-State: AOUpUlFU6gK98zg9bcBx3qLvDYHVmjkvrLZFD9ZYFtv2GCCtluGDlh1Y
        ihiFsDVh8MSOjjjYWPqYsPJBYLmFHot4XkFsRW9uxw==
X-Google-Smtp-Source: AA+uWPzT7UuaREnJ89SMAaWn1SBlVk1b1SjNr8ufQ5d063kNQHV5Sr3zHftjW62vRiWpw4sf6V92aXbuEUC/cdrPyLQ=
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr2659287wma.21.1533671036206;
 Tue, 07 Aug 2018 12:43:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 12:43:35 -0700 (PDT)
In-Reply-To: <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
 <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com> <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 7 Aug 2018 12:43:35 -0700
Message-ID: <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 11:54 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hey Andy, Eric, & all,
>
> I've started the work of separating this out into 16 individual
> commits, have addressed numerous other things brought up like the
> ifdef maze, and have begun rewriting (parts of) the original commit
> message. It's still a work in progress, and I still have some work to
> do, but if you want to follow along, things are happening here:
>
> https://git.zx2c4.com/linux-dev/log/?h=jd/wireguard
>
> I'll be rebasing and reworking this continuously, but that's how it's
> shaping up.
>
> As I'm still working on it, I won't be submitting v2 today, but if you
> have suggestions or concerns or want to poke me while I'm working on
> v2, don't hesitate to send me private email or ping me in IRC (I'm
> "zx2c4" there) to chat.
>
> Regards,
> Jason

For "zinc: add simd helper", I think it should be in include/linux,
and include/linux/simd.h should (immediately or maybe in the future)
include <asm/simd.h> to pick up arch-specific stuff.  And the patch
should get sent to linux-arch@vger.kernel.org.

In your blake2s_arch() implementation, you're not passing in a
simd_context_t.  Is that still a work in progress?  I thought the plan
was to pass it in rather than doing the check in the _arch()
functions.
