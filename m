Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbeB0Lhp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:37:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:45167 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752097AbeB0Lhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:37:43 -0500
Date: Tue, 27 Feb 2018 12:37:39 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 1/3] livepatch: add sample cumulative patch
In-Reply-To: <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1802271129310.19255@pobox.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com> <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Feb 2018, Joe Lawrence wrote:

> Add a simple atomic replace / cumulative livepatch example.

It's not a cumulative patch, so I'd stick with an atomic replace example. 
The same applies to the subject, module name and also the comments.
 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  samples/livepatch/Makefile               |   1 +
>  samples/livepatch/livepatch-cumulative.c | 216 +++++++++++++++++++++++++++++++
>  2 files changed, 217 insertions(+)
>  create mode 100644 samples/livepatch/livepatch-cumulative.c
> 
> diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> index 2472ce39a18d..dd0e2a8af1af 100644
> --- a/samples/livepatch/Makefile
> +++ b/samples/livepatch/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix2.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-demo.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-mod.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-callbacks-busymod.o
> +obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-cumulative.o
> diff --git a/samples/livepatch/livepatch-cumulative.c b/samples/livepatch/livepatch-cumulative.c
> new file mode 100644
> index 000000000000..ab036439e08c
> --- /dev/null
> +++ b/samples/livepatch/livepatch-cumulative.c
> @@ -0,0 +1,216 @@
> +/*
> + * Copyright (C) 2018 Joe Lawrence <joe.lawrence@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * livepatch-callbacks-cumulative.c - atomic replace / cumulative livepatch demo
> + *
> + *
> + * Purpose
> + * -------
> + *
> + * Demonstration of atomic replace / cumulative livepatching.
> + *
> + *
> + * Usage
> + * -----
> + *
> + * Step 1 - Load the sample livepatch demo
> + *
> + *   insmod samples/livepatch/livepatch-sample.ko
> + *
> + * Notice that /proc/cmdline was modified by the patch.  For the moment,
> + * /proc/meminfo remains unmodified.
> + *
> + *   head /proc/cmdline /proc/meminfo
> + *   ==> /proc/cmdline <==
> + *   this has been live patched

Could you add the module names to the messages in livepatch-sample.c and 
here in the new sample module? It'd be clear what came from where then.

Otherwise it looks good.

Regards,
Miroslav
