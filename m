Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeBUACP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:02:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeBUACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:02:14 -0500
Date: Tue, 20 Feb 2018 16:02:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] proc: use set_puts() at /proc/*/wchan
Message-Id: <20180220160212.8f3942d40e0b4014e2aa457c@linux-foundation.org>
In-Reply-To: <CAHp75Vd9ZnC059W2n5=Rx_gz3GN0LORPwt=_AdG5GZPJAUTasw@mail.gmail.com>
References: <20180217072011.GB16074@avx2>
        <CAHp75Vd9ZnC059W2n5=Rx_gz3GN0LORPwt=_AdG5GZPJAUTasw@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2018 16:06:42 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Feb 17, 2018 at 9:20 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> 
> > -               seq_printf(m, "%s", symname);
> > +               seq_puts(m, symname);
> 
> While this might have no security concerns, the pattern might be
> brainlessly used by some janitors and there would have security
> implications.

And I'd like to see a changelog, please.  One which explains why
`symname' cannot have a %s (etc) in it, and never will.
