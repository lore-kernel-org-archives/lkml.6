Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeBKKrj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:47:39 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33120 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBKKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:47:37 -0500
X-Google-Smtp-Source: AH8x225/1V7c/uKrE+WlQbJz5FZzhea+xgPHysf/U2QisKTLtCMN6WLuHXIF7PCuuLL0eyOqsU1/5Q==
Date: Sun, 11 Feb 2018 11:47:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/Kconfig: Further simplify the NR_CPUS config
Message-ID: <20180211104733.fcqt3f7iqsyhzdvw@gmail.com>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
 <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
 <20180210113629.jcv6su3r4suuno63@gmail.com>
 <20180210113842.7j62u7rxp4jscei2@gmail.com>
 <CA+55aFzW=jVmcWGw6bPMwZsZiUFkWOzZYV7FzNFhG1WJ+qgzSw@mail.gmail.com>
 <2cfadd13-7101-e6c8-9919-5269e0b29c29@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cfadd13-7101-e6c8-9919-5269e0b29c29@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> On 02/10/2018 02:19 PM, Linus Torvalds wrote:
> > Looks good to me.
> > 
> > At the risk of bike-shedding, we could remove all the
> > 
> >         default    1 if !SMP
> > 
> > from the BEGIN/END/DEFAULT things, and perhaps just keep that part in NR_CPUS.
> > 
> > I didn't check, but I *think* it would work to just do
> > 
> >  config NR_CPUS
> >         int "Maximum number of CPUs" if SMP && !MAXSMP
> >         range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
> >         default "1" if !SMP
> >         default NR_CPUS_DEFAULT
> > 
> > but maybe the "range" line would need an "if !SMP" on it too to avoid
> > the issue with "1" being out of range.,
> 
> Yeah, I had an early test that failed due to something like that.

I *think* I slightly prefer the current approach, because while it's somewhat 
verbose, the advantage is that this way we have *all* range considerations for a 
given main hardware variant in a single place, and the main NR_CPUS config entry 
is 'passive' in terms of determining the range used.

Plus the verbosity isn't really a problem either, as the whole approach is a 
'verbose' expansion of an overly complex config expression, for better 
readability/maintainability.

Thanks,

	Ingo
