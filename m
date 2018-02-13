Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966071AbeBMWil (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:38:41 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39318 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeBMWik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:38:40 -0500
X-Google-Smtp-Source: AH8x226vzzpo8b11oX6lTbuRWTgVa2szQq8ir/9P2g13yiCAoDbMewUvX48qgCD6ykhNakr9j/dfBw==
Date: Tue, 13 Feb 2018 14:38:28 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: rostedt@goodmis.org, daniel@iogearbox.net, songliubraving@fb.com,
        yhs@fb.com, ast@kernel.org, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, davem@davemloft.net, jbacik@fb.com
Subject: Re: [tip:perf/core] perf/headers: Sync new perf_event.h with the
 tools/include/uapi version
Message-ID: <20180213223827.wq4y6xemor6xj4gp@ast-mbp.dhcp.thefacebook.com>
References: <20171206224518.3598254-5-songliubraving@fb.com>
 <tip-0d8dd67be013727ae57645ecd3ea2c36365d7da8@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-0d8dd67be013727ae57645ecd3ea2c36365d7da8@git.kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 03:52:59AM -0800, tip-bot for Song Liu wrote:
> Commit-ID:  0d8dd67be013727ae57645ecd3ea2c36365d7da8
> Gitweb:     https://git.kernel.org/tip/0d8dd67be013727ae57645ecd3ea2c36365d7da8
> Author:     Song Liu <songliubraving@fb.com>
> AuthorDate: Wed, 6 Dec 2017 14:45:14 -0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 6 Feb 2018 10:18:05 +0100

any chance these patches can still make into this release considering
they were ready back in December ?
We have few followups for them and if we don't get them via Linus's tree
into net-next/bpf-next we cannot really proceed further.
The other option would be to cherry-pick them into bpf-next/net-next,
but also a bit scary due to potential conflicts?

Thanks!

> perf/headers: Sync new perf_event.h with the tools/include/uapi version
> 
> perf_event.h is updated in previous patch, this patch applies the same
> changes to the tools/ version. This is part is put in a separate
> patch in case the two files are back ported separately.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Yonghong Song <yhs@fb.com>
> Reviewed-by: Josef Bacik <jbacik@fb.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Cc: <daniel@iogearbox.net>
> Cc: <davem@davemloft.net>
> Cc: <kernel-team@fb.com>
> Cc: <rostedt@goodmis.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: http://lkml.kernel.org/r/20171206224518.3598254-5-songliubraving@fb.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  tools/include/uapi/linux/perf_event.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index c77c9a2..5d49cfc 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -380,10 +380,14 @@ struct perf_event_attr {
>  	__u32			bp_type;
>  	union {
>  		__u64		bp_addr;
> +		__u64		kprobe_func; /* for perf_kprobe */
> +		__u64		uprobe_path; /* for perf_uprobe */
>  		__u64		config1; /* extension of config */
>  	};
>  	union {
>  		__u64		bp_len;
> +		__u64		kprobe_addr; /* when kprobe_func == NULL */
> +		__u64		probe_offset; /* for perf_[k,u]probe */
>  		__u64		config2; /* extension of config1 */
>  	};
>  	__u64	branch_sample_type; /* enum perf_branch_sample_type */
