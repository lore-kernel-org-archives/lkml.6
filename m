Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeBYBjl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 20:39:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55179 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeBYBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 20:39:39 -0500
X-Google-Smtp-Source: AG47ELvNb+GVa+fuDgJkdq+ksfUuJwr5rLEoWw4R+a9n73HOJ/mVkK/4FiY33DwciMCJGhnFKC+tQ/gJgVgjDgSB62Y=
MIME-Version: 1.0
In-Reply-To: <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com> <1519421630-12025-2-git-send-email-joe.lawrence@redhat.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sat, 24 Feb 2018 17:38:57 -0800
Message-ID: <CAOFm3uF8HT=5gRG_AvvZwHnVDgrV1HxByG+Gxaqc+uEFYFnFxw@mail.gmail.com>
Subject: Re: [PATCH v0 1/3] livepatch: add sample cumulative patch
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,

On Fri, Feb 23, 2018 at 1:33 PM, Joe Lawrence <joe.lawrence@redhat.com> wrote:
> Add a simple atomic replace / cumulative livepatch example.
>
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

May be you could use the new SPDX tags instead of this fine but long
legalese? [1]
This would replace ~12 lines of comment by a single line with the same effect.
Thanks!

[1]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
--
Philippe
