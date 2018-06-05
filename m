Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeFEPrh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:47:37 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54355 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeFEPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:47:36 -0400
X-Google-Smtp-Source: ADUXVKIK3sB8N9FV1sjZBIkPjmqYN3phNP5ESS9L/L3TvO/clg0U0t5TAoIwbkdK78alZWlE9SSLU/770Q/Hznzn+qM=
MIME-Version: 1.0
References: <20180604122132.GA3337@gmail.com> <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
 <20180605150514.GA31065@gmail.com>
In-Reply-To: <20180605150514.GA31065@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 08:47:24 -0700
Message-ID: <CA+55aFx3XtbxwfyWLKkx3qxTTXfHqK2_kSzUG993zY4ZFYVtHw@mail.gmail.com>
Subject: Re: x86/asm: __clear_user() micro-optimization (was: "Re: [GIT PULL]
 x86/asm changes for v4.18")
To: Ingo Molnar <mingo@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 8:05 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Ok, fair point and agreed - if Alexey sends some measurements to back the change
> I'll keep this, otherwise queue up a revert.

I don't think it needs to be reverted, it's not like it's likely to
hurt on any modern CPU's. The issues I talked about are fairly
historical - barely even 64-bit cpus - and I'm not sure an extra uop
to carry a constant around even matters in that code sequence.

It was more a generic issue - any micro-optimization should be based
on numbers (and there should be some numbers in the commit message),
not on "this should be faster". Because while intuitively immediates
_should_ be faster than registers, that's simply not always "obviously
true". It _may_ be true. But numbers talk.

                  Linus
