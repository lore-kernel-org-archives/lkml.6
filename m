Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4/raVyCb1D35OiJWivwtqJ+wYC8ip39KMYS5fXdTVDQR3JNht7QJCysKeRxz/asbUUWCx5l
ARC-Seal: i=1; a=rsa-sha256; t=1522436586; cv=none;
        d=google.com; s=arc-20160816;
        b=Xdka1YpZJFPpcBUfBwFj4sXwElV7CvFP5pUq4QgbFiy5oudKqbTJQ0viZNmn/ZNbeh
         9ZGaRNDPTHvXKlsZS4xlGoNH8sg9gWDE1/su2ZnoBYhhKkK9YsDWFIVVF14VpRLUHWrr
         ECjWPVRtRqJUNX4P01zA3uGjq7axuVQ9BLHvmm2xo/Pgg55VyGa7ga/CkIi2HaSNbuMz
         db81LDpsIJMzLgTrHWhj2ORgGuWEgi1xnOb9cC28hHH2uwEPKoMbc/SU6NnCO8Z1WsPH
         wphqjTNc0rT1kJVd6WNYbYDplbZ1aCNPgQ7SWFDC0VCGuHvFiw1Rle4Acni1jI3XQZyt
         MHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=zZdjVb4Kj7VkDT1Szs9eBUWMhwm0CX+P9JoQDGqn/oE=;
        b=oGEIAGtmfoBdNjah2EGiT5ZUZckd+5n8WFBaH7h4qezUSVVWe519kKIjuPwvBCxl6q
         3fPtEFhss6WpIg4Xs2cU7ke95jPDWEgKBT+WvR53niI6/F42zve/RSa/eScU0nJ5DEZa
         /Xyx8i3pqzZgpe/1S+epJSALkotDzb+PhdFNIW4BKzFUf5s4a765OLRqkJRhmtNl0E4c
         IUv2WeJk3dI5jHzBezpETb54uUN/LZVpf0wYzNKzpduyloKSNEkKQ724NN5XQ5bOAiNr
         dxipiLstzhvJjTFg1HBG2DIo/tj92jgK0jhr6lqQG4hN4CYze7o3oLgi48N95DsuXBUD
         uxUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=N2s+CoOE;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=N2s+CoOE;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 20:03:02 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 13/17] staging: lustre: libcfs: remove
 cfs_timeout_cap()
In-Reply-To: <152229760874.27689.12453214678546053828.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803302002410.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760874.27689.12453214678546053828.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_200302_587822_58D0A8CE 
X-CRM114-Status: GOOD (  25.45  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244858213208850?=
X-GMAIL-MSGID: =?utf-8?q?1596390466280554298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> This wrapper is only used once, so open-code it as max().
> 
> This allows us to remove the libcfs_time.h include file.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  .../staging/lustre/include/linux/libcfs/libcfs.h   |    1 
>  .../lustre/include/linux/libcfs/libcfs_time.h      |   50 --------------------
>  .../lustre/include/linux/libcfs/linux/linux-time.h |    2 -
>  drivers/staging/lustre/lustre/ptlrpc/import.c      |    4 +-
>  4 files changed, 3 insertions(+), 54 deletions(-)
>  delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> index 3b751c436b3d..3d3fa52858e5 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> @@ -43,7 +43,6 @@
>  #include <linux/libcfs/libcfs_private.h>
>  #include <linux/libcfs/libcfs_cpu.h>
>  #include <linux/libcfs/libcfs_prim.h>
> -#include <linux/libcfs/libcfs_time.h>
>  #include <linux/libcfs/libcfs_string.h>
>  #include <linux/libcfs/libcfs_hash.h>
>  #include <linux/libcfs/libcfs_fail.h>
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
> deleted file mode 100644
> index 172a8872e3f3..000000000000
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
> +++ /dev/null
> @@ -1,50 +0,0 @@
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
> - * libcfs/include/libcfs/libcfs_time.h
> - *
> - * Time functions.
> - *
> - */
> -
> -#ifndef __LIBCFS_TIME_H__
> -#define __LIBCFS_TIME_H__
> -/*
> - * return valid time-out based on user supplied one. Currently we only check
> - * that time-out is not shorted than allowed.
> - */
> -static inline long cfs_timeout_cap(long timeout)
> -{
> -	if (timeout < CFS_TICK)
> -		timeout = CFS_TICK;
> -	return timeout;
> -}
> -
> -#endif
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> index ff3aae2f1231..ecb2126a9e6f 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> @@ -78,7 +78,7 @@ static inline int cfs_time_beforeq_64(u64 t1, u64 t2)
>  /*
>   * One jiffy
>   */
> -#define CFS_TICK		(1)
> +#define CFS_TICK		(1UL)
>  
>  #define CFS_DURATION_T	  "%ld"
>  
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/import.c b/drivers/staging/lustre/lustre/ptlrpc/import.c
> index 4a9d1f189d01..dd4fd54128dd 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/import.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/import.c
> @@ -1486,7 +1486,7 @@ int ptlrpc_disconnect_import(struct obd_import *imp, int noclose)
>  	}
>  
>  	if (ptlrpc_import_in_recovery(imp)) {
> -		long timeout;
> +		unsigned long timeout;
>  
>  		if (AT_OFF) {
>  			if (imp->imp_server_timeout)
> @@ -1501,7 +1501,7 @@ int ptlrpc_disconnect_import(struct obd_import *imp, int noclose)
>  
>  		if (wait_event_idle_timeout(imp->imp_recovery_waitq,
>  					    !ptlrpc_import_in_recovery(imp),
> -					    cfs_timeout_cap(timeout)) == 0)
> +					    max(timeout, CFS_TICK)) == 0)
>  			l_wait_event_abortable(
>  				imp->imp_recovery_waitq,
>  				!ptlrpc_import_in_recovery(imp));
> 
> 
> 
