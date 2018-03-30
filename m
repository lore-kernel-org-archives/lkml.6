Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4/QUHZeBD3egY1f28XmtA0kan7gp0KJd0o1XQ8QhUMaJGhHO5YsFasUoM9YaFYUSsIjwdZF
ARC-Seal: i=1; a=rsa-sha256; t=1522436860; cv=none;
        d=google.com; s=arc-20160816;
        b=bo6hr8v2TXTMjPnsGETkKNeNsFztdcXyldzXQdDUfv+RzK17UcvgRQIguOi6xSXHlm
         8xrO+K2jGcdFNUcFMWV2rZJZERspRw/P8EUi4Gf8ND2Xf8qSmWi6/gvxqrG/ygxIhQud
         ibXMU8UR6kwLz1zFOr5fPy4yffMFzObj47Vlm5zsnZT/ts/54W9jbaI3ColgYrx+u8Uz
         7/5yXT5MVQAox1T1r2IVQ3H865QngrI3fGqGYRLgBrqel0+wiG+E1oKP6GR95j9pept8
         4oefEkZoeHsS6qd/UDlOhFSWzbTqX8a/nMw3T5Q8o/9bi66a3wgE/08VaMmczui1OYCc
         Kjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=bnhM7jdmj2nAkYIQ4TgzDk3G68RYYt5UyHheW6/GPsI=;
        b=UzhbAxFcnKYkW4nKpweCPP+umRj/EbmDSMpDgp0+5EG98iA+ohqJKf0TfI1SycW3BE
         8cjsjSXsvAHndLm57LYxIbBiOwWHWcKFi6eFhy4ihfPI7Wz+nIdrefVUGy/6m6rJgABE
         0IEl9nP/KHeMYt6kq73bxnQcJmbbXCnjUTgWLG2sa2YqWO3QCPdaZXuOs7uPh+ZBsM66
         /Zf5MJ5VlbYC0spCWQoKFtPsG7tOu7zTgDl82EWMJQy5Cfg9A8X9tOdEf8q30KxhtQ30
         qKSaNWVODtTWg5xW1uNJVJDufNYSk48TT+c48WRB/5ELOjHRo6ITAIxvTz/CGMbR4IBC
         VqRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=qcOuAiEC;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=qcOuAiEC;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 20:07:36 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 17/17] staging: lustre: remove cruft from
 libcfs/linux/libcfs.h
In-Reply-To: <152229760887.27689.4035189219478811109.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803302006410.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760887.27689.4035189219478811109.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_200736_540401_2E714A1B 
X-CRM114-Status: GOOD (  15.32  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244887656932993?=
X-GMAIL-MSGID: =?utf-8?q?1596390753742242297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> These defines are unused or nearly unused, and do not
> help at all.

Reviewed-by: James Simmons <jsimmons@infradead.org>

> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  .../staging/lustre/include/linux/libcfs/curproc.h  |    2 --
>  .../lustre/include/linux/libcfs/linux/libcfs.h     |   17 -----------------
>  drivers/staging/lustre/lnet/libcfs/tracefile.c     |    2 +-
>  3 files changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/lustre/include/linux/libcfs/curproc.h b/drivers/staging/lustre/include/linux/libcfs/curproc.h
> index 4702956805a6..d6e4f47b5daf 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/curproc.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/curproc.h
> @@ -43,8 +43,6 @@
>  /*
>   * Plus, platform-specific constant
>   *
> - * CFS_CURPROC_COMM_MAX,
> - *
>   * and opaque scalar type
>   *
>   * kernel_cap_t
> diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> index c39c34d74382..0dbd01617865 100644
> --- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> +++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
> @@ -81,8 +81,6 @@
>  #include <stdarg.h>
>  #include "linux-cpu.h"
>  
> -#define LUSTRE_TRACE_SIZE (THREAD_SIZE >> 5)
> -
>  #if !defined(__x86_64__)
>  # ifdef __ia64__
>  #  define CDEBUG_STACK() (THREAD_SIZE -				 \
> @@ -114,19 +112,4 @@ do {								    \
>  #define CDEBUG_STACK() (0L)
>  #endif /* __x86_64__ */
>  
> -#define __current_nesting_level() (0)
> -
> -/**
> - * Platform specific declarations for cfs_curproc API (libcfs/curproc.h)
> - *
> - * Implementation is in linux-curproc.c
> - */
> -#define CFS_CURPROC_COMM_MAX (sizeof((struct task_struct *)0)->comm)
> -
> -#include <linux/capability.h>
> -
> -#ifndef WITH_WATCHDOG
> -#define WITH_WATCHDOG
> -#endif
> -
>  #endif /* _LINUX_LIBCFS_H */
> diff --git a/drivers/staging/lustre/lnet/libcfs/tracefile.c b/drivers/staging/lustre/lnet/libcfs/tracefile.c
> index 129430e74d00..514e1845740e 100644
> --- a/drivers/staging/lustre/lnet/libcfs/tracefile.c
> +++ b/drivers/staging/lustre/lnet/libcfs/tracefile.c
> @@ -328,7 +328,7 @@ int libcfs_debug_vmsg2(struct libcfs_debug_msg_data *msgdata,
>  		goto console;
>  	}
>  
> -	depth = __current_nesting_level();
> +	depth = 0;
>  	known_size = strlen(file) + 1 + depth;
>  	if (msgdata->msg_fn)
>  		known_size += strlen(msgdata->msg_fn) + 1;
> 
> 
> 
