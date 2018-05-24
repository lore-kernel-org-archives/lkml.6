Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969922AbeEXWbT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:31:19 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:44914 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966192AbeEXWbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:31:18 -0400
X-Google-Smtp-Source: AB8JxZp7D0WYs3YYJV6CnYgLzsqEEcnfAR/T63zhAlb6BxZn9L888MuZ7MD5l3phOvwQWb48MtLWdATMOIvVfKkjVfA=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com>
In-Reply-To: <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 May 2018 15:31:05 -0700
Message-ID: <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 3:05 PM H. Peter Anvin <hpa@zytor.com> wrote:
> COMPILER AR: "=rm" should NEVER generate worse code than "=r". That is
> unequivocally a compiler bug.

Filed: https://bugs.llvm.org/show_bug.cgi?id=37583

> >> You are claiming it doesn't buy us anything, but you are only looking
at
> > the paravirt case which is kind of "special" (in the short bus kind of
way),
> >
> > That's fair.  Is another possible solution to have paravirt maybe not
use
> > native_save_fl() then, but its own
non-static-inline-without-m-constraint
> > implementation?

> KERNEL AR: change native_save_fl() to an extern inline with an assembly
> out-of-line implementation, to satisfy the paravirt requirement that no
> GPRs other than %rax are clobbered.

i'm happy to add that, do you have a recommendation if it should go in an
existing .S file or a new one (and if so where/what shall I call it?).
-- 
Thanks,
~Nick Desaulniers
