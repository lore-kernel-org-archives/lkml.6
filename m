Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeFERPh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:15:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37791 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753404AbeFERFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:51 -0400
X-Google-Smtp-Source: ADUXVKKJnGiETvb6zLxykhF/VCfrR8Nj6j23FDi/qr7FAchrs5Ym1I2fxm4XWNGtfBl6xucl88zXVTgtSNeoqDi/2xc=
MIME-Version: 1.0
In-Reply-To: <cover.1528215659.git.msuchanek@suse.de>
References: <cover.1528215659.git.msuchanek@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 20:05:50 +0300
Message-ID: <CAHp75VdG4Vp2_6LMLv--kwiMkXO4mdc1DUgRQLBCtp2OoEmAZQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Kernel parameter parser cleanup/enhancement
To: Michal Suchanek <msuchanek@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Aaron Wu <Aaron.Wu@analog.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt," <rostedt@goodmis.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Ilya Matveychikov <matvejchikov@gmail.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 7:43 PM, Michal Suchanek <msuchanek@suse.de> wrote:
> Hello,
>
> due to work on the fadump_extra_args I looked at the kernel parameter parser
> and found its grammar rather curious.
>
> It supports double quotes but not any other quoting characters so double quotes
> cannot be quoted. What's more, the quotes can be anywhere in the parameter
> name or value and are interpteted but are removed only from start and end of
> the parameter value.
>
> These are the patches not specific to fadump which somewhat straighten the
> qouting grammar to make it on par with common shell interpreters.

I didn't notice any use of string_unescape_*() functionality. So, your
patch is kinda very specific to some narrow subset of escaping and
unescaping stuff.
Thus, it's still not on par with shell, right?

>
> Specifically double and single quotes can be used for quoting as well as
> backslashes with the usual shell semantic. All quoting characters are removed
> while the parameters are parsed.
>
> Previous versions (including the fadump part) can be found here:
>
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg126148.html
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg123639.html
>
> Thanks
>
> Michal
>
> Michal Suchanek (5):
>   lib/cmdline.c: Add backslash support to kernel commandline parsing.
>   Documentation/admin-guide: backslash support in kernel arguments.
>   init/main.c: simplify repair_env_string.
>   lib/cmdline.c: Implement single quotes in commandline argument
>     parsing.
>   Documentation/admin-guide: single quotes in kernel arguments.
>
>  Documentation/admin-guide/kernel-parameters.rst |  5 +-
>  init/main.c                                     | 13 ++---
>  lib/cmdline.c                                   | 63 +++++++++++++++----------
>  3 files changed, 46 insertions(+), 35 deletions(-)
>
> --
> 2.13.6
>



-- 
With Best Regards,
Andy Shevchenko
