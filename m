Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4+VBja/l9bmEYlLcLB67eOf8bTi+cTqQQlE48okPP6kFJs05YSw1F4bhAFy4RHGFYErjz1p
ARC-Seal: i=1; a=rsa-sha256; t=1522436627; cv=none;
        d=google.com; s=arc-20160816;
        b=NzJUbLA/BlkJRRvXDUHpELsaAZJnS9pW/6S25mnifE7EB2z2WM7cW2VjIY7n8jJdNs
         fzpgX4q0AzaaUHKgAIqxrI9vWOs3w/+CSigTiNriUmlXIsLobh7iB8MwTCWS25kwWYNP
         7aci3CLmL54903XKXzlVYvwyo9PLQZhisMit7bLsERyOswAJlawtaIRLb9lPGcie2D8C
         4eD3hQ7ZhsUyl1UIJEQPAHr1IQUVRu8nQd54zvtaCMDWcS+7Z7/rYQbraqWD41qoOTtr
         Lf0KmKXAaTa4i+hI/LI5taG/uhX6R9pXc+ReQVO2p7rSeY6lORq5J4N83kDOzQnRavVp
         UU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=2ZG2uP4FYfspi1BrE6ZouYgGT2oaREPKemvlRjr8WkA=;
        b=0kGT/aSzkaJOgOd8IzhRVJJyridrj/4zq+ZeZOQErxKgKG4fl2o4sWqce52FjQPMZf
         dJTyr5d9vB3ZLWrkQO6uaOaOmz6U690dIPXGwnIPZKn+bLmgsIVSKeZpBqT2SUAhrfU0
         wiGmwgUULNaqgemUVxrXCnFgFzi/qgqAhwhBpgnurMcMOCE6allILp8LtQgehckk62iz
         DVtBJs1C8+g4DF3v0DsO6YBmjW03aDADNJ/aHqLRrYt0nMY6IKYHO0eU/H0LS9/BkEH9
         LzY5kGbAUGJhS9ht5nTMD/qapV/bN7ZZ2Bk4sn+ZDuK3tmi4PK6ig/QVDPqu/76LDS+o
         uFfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=Fs2eRgrB;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=Fs2eRgrB;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 20:03:43 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 16/17] staging: lustre: discard linux-time.h
In-Reply-To: <152229760884.27689.2832237566424423407.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803302003360.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760884.27689.2832237566424423407.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_200343_373241_CECB56FE 
X-CRM114-Status: GOOD (  25.20  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244879815147026?=
X-GMAIL-MSGID: =?utf-8?q?1596390509145161966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Very little is left in linux-time.h.
> Move CFS_TICK to libcfs.h discard the test.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  .../staging/lustre/include/linux/libcfs/libcfs.h   |    5 ++
>  .../lustre/include/linux/libcfs/linux/libcfs.h     |    1 
>  .../lustre/include/linux/libcfs/linux/linux-time.h |   66 --------------------
>  drivers/staging/lustre/lustre/ptlrpc/pinger.c      |    2 -
>  4 files changed, 6 insertions(+), 68 deletions(-)
>  delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> index 3d3fa52858e5..f183f31da387 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> @@ -52,6 +52,11 @@
>  
>  #define LOWEST_BIT_SET(x)       ((x) & ~((x) - 1))
>  
> +/*
> + * One jiffy
> + */
> +#define CFS_TICK		(1UL)
> +
>  /*
>   * Lustre Error Checksum: calculates checksum
>   * of Hex number by XORing each bit.
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> index 30e333af8d0d..c39c34d74382 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> @@ -80,7 +80,6 @@
>  #include <linux/uaccess.h>
>  #include <stdarg.h>
>  #include "linux-cpu.h"
> -#include "linux-time.h"
>  
>  #define LUSTRE_TRACE_SIZE (THREAD_SIZE >> 5)
>  
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> deleted file mode 100644
> index ecdebccf2b44..000000000000
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * GPL HEADER START
> - *
> - * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 only,
> - * as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License version 2 for more details (a copy is included
> - * in the LICENSE file that accompanied this code).
> - *
> - * You should have received a copy of the GNU General Public License
> - * version 2 along with this program; If not, see
> - * http://www.gnu.org/licenses/gpl-2.0.html
> - *
> - * GPL HEADER END
> - */
> -/*
> - * Copyright (c) 2008, 2010, Oracle and/or its affiliates. All rights reserved.
> - * Use is subject to license terms.
> - */
> -/*
> - * This file is part of Lustre, http://www.lustre.org/
> - * Lustre is a trademark of Sun Microsystems, Inc.
> - *
> - * libcfs/include/libcfs/linux/linux-time.h
> - *
> - * Implementation of portable time API for Linux (kernel and user-level).
> - *
> - * Author: Nikita Danilov <nikita@clusterfs.com>
> - */
> -
> -#ifndef __LIBCFS_LINUX_LINUX_TIME_H__
> -#define __LIBCFS_LINUX_LINUX_TIME_H__
> -
> -#ifndef __LIBCFS_LIBCFS_H__
> -#error Do not #include this file directly. #include <linux/libcfs/libcfs.h> instead
> -#endif
> -
> -#define ONE_BILLION ((u_int64_t)1000000000)
> -#define ONE_MILLION 1000000
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/time.h>
> -#include <asm/div64.h>
> -
> -/*
> - * post 2.5 kernels.
> - */
> -
> -#include <linux/jiffies.h>
> -
> -/*
> - * One jiffy
> - */
> -#define CFS_TICK		(1UL)
> -
> -#define CFS_DURATION_T	  "%ld"
> -
> -#endif /* __LIBCFS_LINUX_LINUX_TIME_H__ */
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/pinger.c b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
> index 3f17c673d1b8..89eef8ec7df4 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/pinger.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/pinger.c
> @@ -251,7 +251,7 @@ static void ptlrpc_pinger_main(struct work_struct *ws)
>  		 * we will SKIP the next ping at next_ping, and the
>  		 * ping will get sent 2 timeouts from now!  Beware.
>  		 */
> -		CDEBUG(D_INFO, "next wakeup in " CFS_DURATION_T " (%ld)\n",
> +		CDEBUG(D_INFO, "next wakeup in %ld (%ld)\n",
>  		       time_to_next_wake,
>  		       this_ping + PING_INTERVAL * HZ);
>  	} while (time_to_next_wake <= 0);
> 
> 
> 
