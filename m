Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935595AbeEXB4o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:56:44 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:27746 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935372AbeEXB4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:56:40 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w4O1uEJ6023159
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AB8JxZrN/TXLJgVQeTH1BYwM18oSMh0N/oV4cqcoAHwgyi2rAO+L3ENRnxY/DEmpBK++hsoAj3lSUJ0WKf+RafUTw/s=
MIME-Version: 1.0
In-Reply-To: <20180523001939.9431-3-labbott@redhat.com>
References: <20180523001939.9431-1-labbott@redhat.com> <20180523001939.9431-3-labbott@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 24 May 2018 10:55:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRqL8JcnED8L1b6XZbVYVp0j34=XFf=yKCHpSa2d8qKQ@mail.gmail.com>
Message-ID: <CAK7LNATRqL8JcnED8L1b6XZbVYVp0j34=XFf=yKCHpSa2d8qKQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] x86/vdso: Add build salt to the vDSO
To: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-23 9:19 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> The vDSO is linked separately from the kernel and modules. Ensure it picks
> up the comment section, if available.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Invoke the generated linker script. The ".." nightmare is pretty
> ugly but I didn't see an easier way to pick up the generated file.
> That was actually part of my motivation for using an #include since
> paths for those are standardized.


Maybe, you found a different approach.

FWIW,

If you use the linker script approach, you could simply use

scripts/build-salt.lds

  instead of

$(obj)/../../../../scripts/build-salt.lds




-- 
Best Regards
Masahiro Yamada
