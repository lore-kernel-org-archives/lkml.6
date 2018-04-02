Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDBRwg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:52:36 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:38027 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeDBRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:52:35 -0400
X-Google-Smtp-Source: AIpwx4+RNgQyc3/CgTKt+thOpBBq3qaWo6F8YZP7Y1vHTvi6vAN2fjTB30wcBgGRQahk1bISODHnB6xy2o5xLIWJBR4=
MIME-Version: 1.0
In-Reply-To: <20180402172701.5D4CA7DD@viggo.jf.intel.com>
References: <20180402172700.65CAE838@viggo.jf.intel.com> <20180402172701.5D4CA7DD@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 10:52:34 -0700
X-Google-Sender-Auth: EJj77aIzE8fLQOCxcffpcXwXViM
Message-ID: <CA+55aFw7mLJrr+VqvEY-T3KqR2-xaYSoyU2Jg7VY1Sb1cu1L-w@mail.gmail.com>
Subject: Re: [PATCH 01/11] x86/mm: factor out pageattr _PAGE_GLOBAL setting
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

On Mon, Apr 2, 2018 at 10:27 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> Aside: _PAGE_GLOBAL is ignored when CR4.PGE=1, so why do we
> even go to the trouble of filtering it anywhere?

I'm assuming this is a typo, and you mean "when CR4.PGE=0".

The question you raise may be valid, but within the particular context
of *this* patch it is not.

In the context of this particular patch, the issue is that we use
_PAGE_GLOBAL as _PAGE_BIT_PROTNONE when the present bit isn't set.

       Linus
