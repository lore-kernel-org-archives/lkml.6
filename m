Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBUU1J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:27:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:27:08 -0500
Date: Wed, 21 Feb 2018 12:27:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] proc: use set_puts() at /proc/*/wchan
Message-Id: <20180221122707.69398914a45486a741bdad96@linux-foundation.org>
In-Reply-To: <317b6413-0a46-8f5c-ad24-c5e183bc9a7a@prevas.dk>
References: <20180217072011.GB16074@avx2>
        <CAHp75Vd9ZnC059W2n5=Rx_gz3GN0LORPwt=_AdG5GZPJAUTasw@mail.gmail.com>
        <20180220160212.8f3942d40e0b4014e2aa457c@linux-foundation.org>
        <317b6413-0a46-8f5c-ad24-c5e183bc9a7a@prevas.dk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018 09:57:49 +0100 Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> On 2018-02-21 01:02, Andrew Morton wrote:
> > On Sat, 17 Feb 2018 16:06:42 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > 
> >> On Sat, Feb 17, 2018 at 9:20 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >>
> >>
> >>> -               seq_printf(m, "%s", symname);
> >>> +               seq_puts(m, symname);
> >>
> >> While this might have no security concerns, the pattern might be
> >> brainlessly used by some janitors and there would have security
> >> implications.
> > 
> > And I'd like to see a changelog, please.  One which explains why
> > `symname' cannot have a %s (etc) in it, and never will.
> 
> OK, since #youtoo: It doesn't _matter_ if symname is "%pHAHAHA %fooled
> you <unicode for evil grin emoji>", seq_puts does not interpret it at
> all. There are _never_ security implications with the above replacement.
> Sure, seq_printf(m, symname) would be bad, but that's not what is being
> done.

doh, OK, sorry. RTFP, Andrew.
