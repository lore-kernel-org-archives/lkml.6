Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946120AbeBORrO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:47:14 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:39420 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164425AbeBORrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:47:11 -0500
X-Google-Smtp-Source: AH8x226Qba02RzuaGJbrLLR14n1ymXJcKDqgGP979yWq0ibpoOnCVkcBY0Vfs2O3bg9/x8HTijCwey5fWy16YUEw/JY=
MIME-Version: 1.0
In-Reply-To: <20180215132053.6C9B48C8@viggo.jf.intel.com>
References: <20180215132053.6C9B48C8@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2018 09:47:10 -0800
X-Google-Sender-Auth: -uOE777Qr5qGNJVCloirr9KnIXQ
Message-ID: <CA+55aFy8k_zSJ_ASyzkA9C-jLV4mZsHpv1sOxJ9qpvfS_P6eMg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@google.com>, Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 5:20 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> During the switch over to PTI, we seem to have lost our ability to have
> GLOBAL mappings.

Oops. Odd, I have this distinct memory of somebody even _testing_ the
global bit performance when I pointed out that we shouldn't just make
the bit go away entirely.

[ goes back and looks at archives ]

Oh, that was in fact you who did that performance test.

Heh. Anyway, back then you claimed a noticeable improvement on that
will-it-scale test (although a bigger one when pcid wasn't available),
so yes, if we lost the "global pages for the shared user/kernel
mapping" bit we should definitely get this fixed.

Did you perhaps re-run any benchmark numbers just to verify? Because
it's always good to back up patches that should improve performance
with actual numbers..

           Linus
