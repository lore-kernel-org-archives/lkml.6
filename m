Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756969AbeBPBD2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 20:03:28 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39946 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756953AbeBPBD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 20:03:26 -0500
X-Google-Smtp-Source: AH8x226PXT3X9syo6L3CjPgl07wRIxzzSVlrVYVbyJIlbzaUrAaOLpyL/dVYkq9SuHINsWSD/JddH+nT3PLBd/lW4Hg=
MIME-Version: 1.0
In-Reply-To: <20180216001317.GG30522@ZenIV.linux.org.uk>
References: <20180214063033.GA15579@avx2> <20180214081935.GA17157@avx2>
 <20180215190713.GF30522@ZenIV.linux.org.uk> <20180215214113.GA27190@avx2> <20180216001317.GG30522@ZenIV.linux.org.uk>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Feb 2018 17:03:25 -0800
X-Google-Sender-Auth: yZGBASN2shrL-TwddJg-fWDWHGQ
Message-ID: <CAGXu5jJ20D=Eq0uVgd=7mBeg6Qseob+6G9YktLW02-CEyLeYQA@mail.gmail.com>
Subject: Re: [PATCH -mm 1/3] proc: randomize "struct pde_opener"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 4:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Guess what happens to cache footprint of dcache lookups if the bunch in the
> beginning gets spread over the entire thing?  Right...  And that's besides the
> outright miscompiles.

Mentioned in private communication, but just for posterity:
GCC_PLUGIN_RANDSTRUCT_PERFORMANCE exists specifically to address those
kinds of performance concerns.

As to removing the markings: please don't. Instead, you'd mentioned
wanting to add a TAINT flag for this, and I think that sounds entirely
reasonable. We have TAINT flags for considerably less insane things.
:) I can send that patch.

-Kees

-- 
Kees Cook
Pixel Security
