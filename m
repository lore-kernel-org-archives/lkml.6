Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeCMXmo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:42:44 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:44458 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeCMXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:42:42 -0400
X-Google-Smtp-Source: AG47ELuLLvU5miQcP/QYd6BGFefqe5hTnuDMQQCs8Xf89Pxl0AT8mqJ4IYAnQKZJysa/gLnFNjSyXn+P7tRwqhCef7w=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzTT5fzz__pY2HhxK=GPnJ8vtpgtok672AAXfSGg+ztuQ@mail.gmail.com>
References: <20180313061109.72629-1-dianders@chromium.org> <20180313061109.72629-3-dianders@chromium.org>
 <20180313061603.jsgiumet23uqi6hl@gmail.com> <CAD=FV=UEuWww=H=TY=E8JvEmrobDNi5+rbTXvTAmZ2brpK+sdg@mail.gmail.com>
 <CAKwvOdnPSMSOenPiPqBpDf=hf5q5uQ5MF0pOLAea5T5_VPhmaA@mail.gmail.com>
 <CAD=FV=UvT-BrpZcz4RV=cRW4Nf9rBkYvc2JgcQr465NMYjAvJw@mail.gmail.com> <CA+55aFzTT5fzz__pY2HhxK=GPnJ8vtpgtok672AAXfSGg+ztuQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Mar 2018 16:42:40 -0700
X-Google-Sender-Auth: 7HiS9k1xlhmUwJEKAGhYxBEXVks
Message-ID: <CAD=FV=Vg9d+_ZSr3Qwdxc-N5Hu7GDewPJ7JuJGrGPKr4S_2thA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kbuild: Don't mess with the .cache.mk when root
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Malaterre <malat@debian.org>,
        Dave Hansen <dave.hansen@intel.com>, Yang Shi <yang.s@alibaba-inc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 13, 2018 at 10:39 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 13, 2018 at 9:44 AM, Doug Anderson <dianders@chromium.org> wrote:
>>> Is there any issue if I:
>>>
>>> $ make clean
>>> $ make
>>> $ sudo make install
>>> <hack around>
>>> $ make
>>
>> I don't personally know of any problems with the above flow.
>
> This is my workflow, and what I suggest people do - only do "make
> install" as root, everything else as a normal user.
>
> And in fact, it occasionally _has_ broken, when "make install" has
> done more than just install things, and created root-owned files and
> directories (particularly the generated headers).
>
> And then I complain to people, because then things like "make clean"
> as a normal user ends up breaking too when there's some root-owned
> file.
>
> So it can break, but it's pretty rare. Usually it's something like
> "people didn't use the proper sequence to update a file only if it
> changed, and just blindly over-wrote a new version.
>
> Generally, I prefer "make install" not even checking dependencies at
> all, and just blindly copy things. And I'd definitely be ok with an
> error rather than root generating files, although then I'd not
> special-case mkcache, but all the *other* random file changes we do.
>
> If Ingo wants to build as root, maybe we could even make him set some
> environment flag to avoid errors.
>
> (But I don't actually like the patch in question, because I really
> think KBUILD_NOCACHE is much too specific a special case, and it
> should be way more generic).

Please consider the patch abandoned.  As per other threads pointed to
in this conversation, Masahiro Yamada is planning to fully gut the
".cache.mk" from the build system anyway.  :-)

-Doug
