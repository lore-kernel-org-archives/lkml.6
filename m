Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeFERZx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:25:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54191 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbeFERZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:25:51 -0400
Date: Tue, 5 Jun 2018 19:25:48 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v10 0/5] Kernel parameter parser cleanup/enhancement
Message-ID: <20180605192548.4ff64b3e@kitsune.suse.cz>
In-Reply-To: <CAHp75VdG4Vp2_6LMLv--kwiMkXO4mdc1DUgRQLBCtp2OoEmAZQ@mail.gmail.com>
References: <cover.1528215659.git.msuchanek@suse.de>
        <CAHp75VdG4Vp2_6LMLv--kwiMkXO4mdc1DUgRQLBCtp2OoEmAZQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018 20:05:50 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 5, 2018 at 7:43 PM, Michal Suchanek <msuchanek@suse.de>
> wrote:
> > Hello,
> >
> > due to work on the fadump_extra_args I looked at the kernel
> > parameter parser and found its grammar rather curious.
> >
> > It supports double quotes but not any other quoting characters so
> > double quotes cannot be quoted. What's more, the quotes can be
> > anywhere in the parameter name or value and are interpteted but are
> > removed only from start and end of the parameter value.
> >
> > These are the patches not specific to fadump which somewhat
> > straighten the qouting grammar to make it on par with common shell
> > interpreters.  
> 
> I didn't notice any use of string_unescape_*() functionality. So, your
> patch is kinda very specific to some narrow subset of escaping and
> unescaping stuff.

It does what it says. It cannot use string_unescape because it needs to
determine the boundaries of quoted strings.

> Thus, it's still not on par with shell, right?

It does not interpret special character sequences other than quoting.

The feature would not be hard to add but I do not see the need.

Unfortunately, the existing string_unescape is totally not fitting to
be integrated into the parser for the purpose.

Thanks

Michal

> 
> >
> > Specifically double and single quotes can be used for quoting as
> > well as backslashes with the usual shell semantic. All quoting
> > characters are removed while the parameters are parsed.
> >
