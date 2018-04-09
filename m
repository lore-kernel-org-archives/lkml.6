Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeDISBA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:01:00 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37389 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeDISA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:00:59 -0400
X-Google-Smtp-Source: AIpwx48sZqoZrI7htfphUBXvboCwGDK0hCHBgS/ZGVKHewWKUz8NZdB5i4oPhv1eoHotdyQo2Twvve2amaYPYDqrF4M=
MIME-Version: 1.0
In-Reply-To: <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
 <alpine.LFD.2.21.1804091809310.1698@schleppi> <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
 <CA+55aFy1jJPX2fu7ce2Z7hxn49RaSghtnziwsyUU1Em5WEH2yw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 9 Apr 2018 11:00:56 -0700
X-Google-Sender-Auth: 1d2jk938M1FW5i1rwu9wSynsCoo
Message-ID: <CAGXu5jLSbX-qYx2xWYrsPb-tUFcEhYG86MkhtJ3zMirBHtmurg@mail.gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on s390
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sebastian Ott <sebott@linux.ibm.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 10:14 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 9, 2018 at 10:03 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Our old "min()" had the internal variables called "min1" and "min2",
>> which is crazy too.
>
> Actually, no, it used the really cumbersome "__UNIQUE_ID" and then
> passed that odd as the name 'min1/2',
>
> Ugh, I find that really nasty to read, but it was obviously done
> because we hit this before.

Ooof. Nice find.

> And our __UNIQUE_ID() macro is garbage anyway, since it falls back on
> the line number, which doesn't really work for macros anyway. But we
> have proper macros for both clang and gcc, so maybe we should ignore
> the broken fallback.
>
> A patch like the attached, perhaps?

Can we update the comment near the top to explain why we need
__UNIQUE_ID() since we've now rediscovered why it was originally
there?

-Kees

-- 
Kees Cook
Pixel Security
