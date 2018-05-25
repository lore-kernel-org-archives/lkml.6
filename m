Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968360AbeEYUgl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:36:41 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:35030 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968220AbeEYUgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:36:39 -0400
X-Google-Smtp-Source: AB8JxZo7YCMbuDqcqYJj58NLIvIsEYI61DFUONfJzMCbYTj9/GCTEQzSCJqzB6Ur5NXCbisSnABZy+jgeGkima/q/0E=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
 <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com>
 <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com> <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com>
 <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com> <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
 <A042BB2E-FACF-4AE0-8B1E-716061666C5F@zytor.com>
In-Reply-To: <A042BB2E-FACF-4AE0-8B1E-716061666C5F@zytor.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 May 2018 13:36:26 -0700
Message-ID: <CAKwvOdkWsxoyXCnQz+Xwh0RQ0yPPVD3iCqVaWAimW_Z4QU0XiA@mail.gmail.com>
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

On Fri, May 25, 2018 at 10:56 AM <hpa@zytor.com> wrote:
> You need the extern inline in the .h file and the out-of-line .S file
both.

But the out-of-line .S file looks like:

...
    10 ENTRY(native_save_fl)

    11   pushf

    12   pop %_ASM_AX

    13   ret

    14 ENDPROC(native_save_fl)

    15 EXPORT_SYMBOL(native_save_fl)
...

I don't see how you can specify to the linker from assembly source that
this function should be treated as `extern inline`?

I assume you don't literally mean the C keywords `extern inline` but
whatever the equivalent incantation is needed in terms of assembler
directives (which I also don't know).

I'm beginning to think that what you'd like to see cannot be expressed (at
least via `extern inline`).
--
Thanks,
~Nick Desaulniers
