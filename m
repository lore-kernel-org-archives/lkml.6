Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeBQPfs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 10:35:48 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37431 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeBQPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 10:35:47 -0500
X-Google-Smtp-Source: AH8x226Z5wJsIBb6QN/3uDmG1sBlu6e4xM28bmwBkP9dGU5IligYwOEpKbuvI+IT6nHfeCjtVZ8bew==
Date: Sat, 17 Feb 2018 18:35:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] proc: use set_puts() at /proc/*/wchan
Message-ID: <20180217153542.GA3040@avx2>
References: <20180217072011.GB16074@avx2>
 <CAHp75Vd9ZnC059W2n5=Rx_gz3GN0LORPwt=_AdG5GZPJAUTasw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd9ZnC059W2n5=Rx_gz3GN0LORPwt=_AdG5GZPJAUTasw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 04:06:42PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 17, 2018 at 9:20 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > -               seq_printf(m, "%s", symname);
> > +               seq_puts(m, symname);
> 
> While this might have no security concerns, the pattern might be
> brainlessly used by some janitors and there would have security
> implications.

Unless there is some kind of preprocessor which seamlessly converts one
to another I'd continue converting.
