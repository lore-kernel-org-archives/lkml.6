Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92C0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A116721477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="poOBzOY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A116721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeJFAoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeJFAoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:44:06 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64673214AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538761460;
        bh=O9q3VnBXuU3U2B2KsI93KQt4N0OimsBG8KXQ5BMVg/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=poOBzOY8+7zG9Bi3bRYKw8J+IBJeOv5yaPvl/QkFFe1t4QfSEVgBiKIk381j6Wclh
         LUE/4iWIaIfErmp8knn7T7hMyDlKERt4juMLdUWdA/k+ShycbQ0b80p+Gzb5XFy8fi
         065jVb/L5nGtU/ValqOuwCwJ9unuFBZn8XGQxc84=
Received: by mail-wm1-f46.google.com with SMTP id 193-v6so2658737wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:44:20 -0700 (PDT)
X-Gm-Message-State: ABuFfohoJo/Y5UCWhoqm8tMwKXuf3aYDoRoJ5EKrxkAO7/n6F6iUE0hQ
        WFuZZLlK1kdyMTGYKL4CZy7zw3v/inzTyAWrRTfgRw==
X-Google-Smtp-Source: ACcGV63ADM++7G3vmAGudX89A7S4EWFuJ4tukYwkNJ51Np7eV0VnQQINbMsaeej8UbH5GNKpzZqsd1W6fMHPsHKRwUE=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr8430319wmd.128.1538761458721;
 Fri, 05 Oct 2018 10:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net> <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
 <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
 <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
 <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com>
 <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com> <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
In-Reply-To: <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Oct 2018 10:44:07 -0700
X-Gmail-Original-Message-ID: <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com>
Message-ID: <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:38 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Oct 5, 2018 at 7:29 PM Andy Lutomirski <luto@kernel.org> wrote:
> > (None of this is to say that I disagree with Jason, though -- I'm not
> > entirely convinced that this makes sense for Zinc.  But maybe it can
> > be done in a way that makes everyone happy.)
>
> Zinc indeed will continue to push in the simpler and more minimal
> direction. Down the line I'm open to trying and benching a few
> different ways of going about it with dynamic patching -- something
> that will be pretty easy to experiment with given the lean structure
> of Zinc -- but for the initial merge I intend to do it the way it is,
> which is super fast and pretty straightforward to follow.
>

I *think* the only change to Zinc per se would be that the calls like
chacha20_simd() would be static calls or patchable functions or
whatever we want to call them.  And there could be a debugfs to
override the default selection.

Ard, I don't think that sticking this in udev rules makes sense.  The
kernel has bascially complete information as to what the right choice
is, and that will change over time as the implementation gets tuned,
and the udev rules will never get updated in sync.
