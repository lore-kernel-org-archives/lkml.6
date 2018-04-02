Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AIpwx49Q5XAcsNsgcMypj0pm34XrFRtDiP3u42b26Wms+lWm48I+Lzi9Q87GGaT/iZ/Gtv8r5ooF
ARC-Seal: i=1; a=rsa-sha256; t=1522697951; cv=none;
        d=google.com; s=arc-20160816;
        b=wGmLnY7fRaj+n78VA4kvPWZs/HF8vMJifQOfhY0SuWCZ2Lwfxpzw1sDrpxzl2siMzK
         kOfgyt3SuTLKsWxv1fTYibZ/AbyMlZ+KUDPGVMWI/YegudA9/OSqP1B9t5xaUIRHJmK/
         vpreTHlspOCSOG685x3OAD6ZZQqwdJix5/3K6k/N050Eznenubw8oGYe3xoi4BLHAmTD
         hEJ0RQ3x6gTUaj1ggtUXjK/7mhq/53e1hB63C2h9HpUdBNnsT+/70ltJjwpM7WRriiXW
         rVt8460fHpy2kSizDnOdYhMCHhGQlhra64jf4sJ6ObE5O4elP6Alhe4c886zK6bfDGCk
         MHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=9odVi1fK8VUGF6Dkylg8JIi82EpARDOh4zXsKXFEP8U=;
        b=lKAMePaxb5aLTk/UBOMxbCBRQFnqjmU+tI44HlC8of0b3NmdgHvejAOTaz2JJhnYar
         D+U/XDdGWH5vC43dg+3+Op+oftgRTb2Np/Vwu0ZA7I67XGjc3aCmI+P1w6qI4JyTCqzk
         8ILvIbI448eZ0deX4rZXJstgbOvAaR/KqXChlpfxEeepDyoE6pdDviXVwUkLhiMhbZYp
         NmVIrXc9cV3alPLJLF6T2S4tx+mBoowGa7R/YkQUqhEqRUgjS53xMsM7SHWJiQqHLsUW
         vUAI0XWbigZnJH4Ug3romkLbvwXE4Og36whmexVdiURH8PxUUnWTHGkRzNBxfe3WPTKP
         SDGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,397,1517904000";
   d="scan'208";a="188070093"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 13/17] staging: lustre: libcfs: remove cfs_timeout_cap()
Thread-Topic: [PATCH 13/17] staging: lustre: libcfs: remove cfs_timeout_cap()
Thread-Index: AQHTxxZurM6PLLoxp0Wg6oRQsTEAe6PuW6MA
Date: Mon, 2 Apr 2018 19:38:57 +0000
Message-ID: <346B8E2C-5842-4771-86D8-CBB5CEF2DC35@intel.com>
References: <152229732768.27689.4800156943561963977.stgit@noble>
 <152229760874.27689.12453214678546053828.stgit@noble>
In-Reply-To: <152229760874.27689.12453214678546053828.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.110.185]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B53AED58CA62924EA8D9C097EFA855CE@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244858213208850?=
X-GMAIL-MSGID: =?utf-8?q?1596664526770774813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 28, 2018, at 22:26, NeilBrown <neilb@suse.com> wrote:
>=20
> This wrapper is only used once, so open-code it as max().
>=20
> This allows us to remove the libcfs_time.h include file.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> .../staging/lustre/include/linux/libcfs/libcfs.h   |    1=20
> .../lustre/include/linux/libcfs/libcfs_time.h      |   50 ---------------=
-----
> .../lustre/include/linux/libcfs/linux/linux-time.h |    2 -
> drivers/staging/lustre/lustre/ptlrpc/import.c      |    4 +-
> 4 files changed, 3 insertions(+), 54 deletions(-)
> delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_tim=
e.h
>=20
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drive=
rs/staging/lustre/include/linux/libcfs/libcfs.h
> index 3b751c436b3d..3d3fa52858e5 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
> @@ -43,7 +43,6 @@
> #include <linux/libcfs/libcfs_private.h>
> #include <linux/libcfs/libcfs_cpu.h>
> #include <linux/libcfs/libcfs_prim.h>
> -#include <linux/libcfs/libcfs_time.h>
> #include <linux/libcfs/libcfs_string.h>
> #include <linux/libcfs/libcfs_hash.h>
> #include <linux/libcfs/libcfs_fail.h>
> diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_time.h b/=
drivers/staging/lustre/include/linux/libcfs/libcfs_time.h
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
> - * Copyright (c) 2008, 2010, Oracle and/or its affiliates. All rights re=
served.
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
> - * return valid time-out based on user supplied one. Currently we only c=
heck
> - * that time-out is not shorted than allowed.
> - */
> -static inline long cfs_timeout_cap(long timeout)
> -{
> -	if (timeout < CFS_TICK)
> -		timeout =3D CFS_TICK;
> -	return timeout;
> -}
> -
> -#endif
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time=
.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> index ff3aae2f1231..ecb2126a9e6f 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-time.h
> @@ -78,7 +78,7 @@ static inline int cfs_time_beforeq_64(u64 t1, u64 t2)
> /*
>  * One jiffy
>  */
> -#define CFS_TICK		(1)
> +#define CFS_TICK		(1UL)

It seems like CFS_TICK is mostly useless as well and could just be dropped?

> #define CFS_DURATION_T	  "%ld"
>=20
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/import.c b/drivers/stag=
ing/lustre/lustre/ptlrpc/import.c
> index 4a9d1f189d01..dd4fd54128dd 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/import.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/import.c
> @@ -1486,7 +1486,7 @@ int ptlrpc_disconnect_import(struct obd_import *imp=
, int noclose)
> 	}
>=20
> 	if (ptlrpc_import_in_recovery(imp)) {
> -		long timeout;
> +		unsigned long timeout;
>=20
> 		if (AT_OFF) {
> 			if (imp->imp_server_timeout)
> @@ -1501,7 +1501,7 @@ int ptlrpc_disconnect_import(struct obd_import *imp=
, int noclose)
>=20
> 		if (wait_event_idle_timeout(imp->imp_recovery_waitq,
> 					    !ptlrpc_import_in_recovery(imp),
> -					    cfs_timeout_cap(timeout)) =3D=3D 0)
> +					    max(timeout, CFS_TICK)) =3D=3D 0)
> 			l_wait_event_abortable(
> 				imp->imp_recovery_waitq,
> 				!ptlrpc_import_in_recovery(imp));
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
