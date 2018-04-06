Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeDFLni (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:43:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752344AbeDFLng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:43:36 -0400
Date: Fri, 6 Apr 2018 13:43:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Perches <joe@perches.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180406114333.gblf4znpasmkc2wl@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
 <1522971908.11185.46.camel@perches.com>
 <1522972535.11185.49.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522972535.11185.49.camel@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 16:55:35, Joe Perches wrote:
> On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
> > On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
> > > Even just git grep -1 -E '%p"$' finds %pt and %po
> > > which should get fixed before somebody claims those extensions.
> > 
> > Neither %pt nor %po is used in a vsprintf
> > in the kernel.
> 
> Nope, you are right, both are defectively used in the
> kernel via string concatenation.

Ah, I see.

> Also there's a missing space in a concatenation adjacent.


> ---
>  arch/s390/kernel/perf_cpum_sf.c           | 4 +---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 7 ++-----
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> index 1c9ddd7aa5ec..458b8f321043 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -212,9 +212,7 @@ static int realloc_sampling_buffer(struct sf_buffer *sfb,
>  	 * the sampling buffer origin.
>  	 */
>  	if (sfb->sdbt != get_next_sdbt(tail)) {
> -		debug_sprintf_event(sfdbg, 3, "realloc_sampling_buffer: "
> -				    "sampling buffer is not linked: origin=%p"
> -				    "tail=%p\n",
> +		debug_sprintf_event(sfdbg, 3, "%s: sampling buffer is not linked: origin=%p tail=%p\n",
					       ^^
I guess that you wanted to add __func__ as the next parameter?

Otherwise, the changes make perfect sense. Are you going to send
them as proper patches, please?

Best Regards,
Petr
