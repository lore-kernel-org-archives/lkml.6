Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCXAyi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:54:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43487 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeCXAyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:54:36 -0400
X-Google-Smtp-Source: AIpwx4+Y6oppEnyTbGUCxL+G/8kz85dbwUbqHWDzatUL6jpL3Qd2U6MiTDP9Xdv9quECvVABMcj4ltVaWhv5Wqp/mnA=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxn=NiAhtz77nrx1_10em8bume-M0UzYZU2eVm5n71juA@mail.gmail.com>
References: <20180323174447.55F35636@viggo.jf.intel.com> <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
 <be2e683c-bf0a-e9ce-2f02-4905f6bd56d3@linux.intel.com> <CA+55aFxn=NiAhtz77nrx1_10em8bume-M0UzYZU2eVm5n71juA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Mar 2018 17:54:35 -0700
X-Google-Sender-Auth: 6k7sQIolWKxtFWX1whWWoYvyXls
Message-ID: <CA+55aFxZ2-3pOpBRPZ4SmDrhQGQY-+AigsqxWXfXzvv-KDeM8Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 5:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It is, of course, possible that I misunderstood what you actually
> benchmarked. But I assume the above benchmark numbers are with the
> whole "don't even do global entries if you have PCID".

Oh, I went back and read your description, and realized that I _had_
misunderstood what you did.

I thought you didn't bother with global pages at all when you had PCID.

But that's not what you meant. You always do global for the actual
user-mapped kernel pages, but when you don't have PCID you do *all*
kernel test as global, whether shared or not.

So I entirely misread what the latest change was.

                     Linus
