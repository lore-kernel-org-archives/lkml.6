Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E083EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CD821473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ugjszM4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CD821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeJFB2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:28:33 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58929 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbeJFB2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:28:33 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b259e641;
        Fri, 5 Oct 2018 18:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Yr6FhUAX3hdxgAc9gx3UpICGflk=; b=ugjszM
        4i9cFKI8xwsjwj3DyW4iSgnSDA3pKaatZQZT2Q92hOQlFxpR0pvpHT0JCX7chaHQ
        N39LZuasqYx6nVWq/lSzosdWxURfHC1tAsLKlZli4tg2Y5EVooTJCMtcvvH7SeAn
        LhEpWIx+IJUBld6ChT8nxmS8lD3DOtl3SAlcTuzTGPmhbIZvupmEZDrmuZLx5QpJ
        v3Ns0vTSjNFTcz16VC6X8RYmOp5Pmx3w+VraUe31oX6kBBmY3FW6OfhQWMRXWSdh
        XctnESSltkTsG2O/xnJKztfIMCpBW1r2FvsG0oEY7je9c9Gh2ZVShHa3GmPWrHa5
        +R72GsKvncZPHGUA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ffbdf639 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 5 Oct 2018 18:28:10 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id o13-v6so13616810otl.4;
        Fri, 05 Oct 2018 11:28:36 -0700 (PDT)
X-Gm-Message-State: ABuFfohoNZb6PNcmKaNYv/gmq6lmvIjQpqJsJVOx2xxin9ROi5MWmeee
        kSGxLdR15DXpU0R4hTn4QU2qhnzLs2M+FkliM0E=
X-Google-Smtp-Source: ACcGV631o5+SpRnetOz1PNx6GXoSDXAqpvDTjpuTTaiCB8bDUF7THvVfmWweexBN3Ut2FMaW+8Sta9CYHmRZe2Pqj10=
X-Received: by 2002:a9d:2992:: with SMTP id n18mr881570otb.54.1538764115077;
 Fri, 05 Oct 2018 11:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net> <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
 <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
 <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
 <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com>
 <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com>
 <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com> <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com>
In-Reply-To: <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 5 Oct 2018 20:28:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9pcQF=FvKRuxnqrJ5R1pvtUVbx3DXvXiUX5HywS2Xgj3A@mail.gmail.com>
Message-ID: <CAHmME9pcQF=FvKRuxnqrJ5R1pvtUVbx3DXvXiUX5HywS2Xgj3A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, benh@kernel.crashing.org,
        paulus@samba.org, Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, richard@nod.at,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

On Fri, Oct 5, 2018 at 7:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> I *think* the only change to Zinc per se would be that the calls like
> chacha20_simd() would be static calls or patchable functions or
> whatever we want to call them.  And there could be a debugfs to
> override the default selection.

Yea, right, exactly. It turns out this is really easy to do with the
way it's structured now. I'd actually experimented considerably with
using the static keys a while back, but couldn't find any performance
difference on any platform at all (four ARM microarchitectures, three
MIPS, various random intel, an old powerpc), so went with the simplest
solution. But we can certainly play with more elaborate patching
mechanisms later on and see how those turn out. Also, even with the
simple bools as we have now, it's quite easy to make all the
parameters toggle-able.

> Ard, I don't think that sticking this in udev rules makes sense.  The
> kernel has bascially complete information as to what the right choice
> is, and that will change over time as the implementation gets tuned,
> and the udev rules will never get updated in sync.

Yes, I agree with this.

Jason
