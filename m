Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBKBnU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 20:43:20 -0500
Received: from casper.infradead.org ([85.118.1.10]:57364 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeBKBnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 20:43:19 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] x86/Kconfig: Further simplify the NR_CPUS config
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
 <0b833246-ed4b-e451-c426-c4464725be92@infradead.org>
 <20180210113629.jcv6su3r4suuno63@gmail.com>
 <20180210113842.7j62u7rxp4jscei2@gmail.com>
 <CA+55aFzW=jVmcWGw6bPMwZsZiUFkWOzZYV7FzNFhG1WJ+qgzSw@mail.gmail.com>
Message-ID: <2cfadd13-7101-e6c8-9919-5269e0b29c29@infradead.org>
Date: Sat, 10 Feb 2018 17:11:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFzW=jVmcWGw6bPMwZsZiUFkWOzZYV7FzNFhG1WJ+qgzSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 02:19 PM, Linus Torvalds wrote:
> Looks good to me.
> 
> At the risk of bike-shedding, we could remove all the
> 
>         default    1 if !SMP
> 
> from the BEGIN/END/DEFAULT things, and perhaps just keep that part in NR_CPUS.
> 
> I didn't check, but I *think* it would work to just do
> 
>  config NR_CPUS
>         int "Maximum number of CPUs" if SMP && !MAXSMP
>         range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
>         default "1" if !SMP
>         default NR_CPUS_DEFAULT
> 
> but maybe the "range" line would need an "if !SMP" on it too to avoid
> the issue with "1" being out of range.,

Yeah, I had an early test that failed due to something like that.


-- 
~Randy
