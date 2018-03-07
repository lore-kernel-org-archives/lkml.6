Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeCGCsD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:48:03 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42883 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbeCGCsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:48:01 -0500
X-Google-Smtp-Source: AG47ELvj2L+SA/seBCJtlq6K13U/eBp3/Dj+bapkD2W9d3fjU71ivRuush4qGc/05uf6woJqAVokKA==
Date: Wed, 7 Mar 2018 11:44:41 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: changbin.du@intel.com
Cc: acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2 1/2] perf sched: move thread::shortname to
 thread_runtime
Message-ID: <20180307024441.GA10527@danjae.aot.lge.com>
References: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
 <1520307457-23668-2-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1520307457-23668-2-git-send-email-changbin.du@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 06, 2018 at 11:37:36AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> The thread::shortname only used by sched command, so move it
> to sched private structure.
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---

[SNIP]
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 40cfa36..14d44c3 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -26,7 +26,6 @@ struct thread {
>  	pid_t			ppid;
>  	int			cpu;
>  	refcount_t		refcnt;
> -	char			shortname[3];
>  	bool			comm_set;
>  	int			comm_len;
>  	bool			dead; /* if set thread has exited */

I also suggest to move the 'dead' field to pack two bools.

Thanks,
Namhyung
