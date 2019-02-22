Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E145C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED8820700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQM2X2FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfBVTmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:42:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41750 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBVTmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:42:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so3844547qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L25x4BGuSb1MYT1SCW1HjP5qgx+fZuT62wOZPG3c6M0=;
        b=DQM2X2FF275SIgtw633Mxf48WEqubVZChWbs7+MTNgr52THytXYdngrzBSuYCY8GjB
         ztcaWBCQ74TYHSymrZpFjOgc+voB07gqJSwnvR+r+UyKZTU3vWJwRCA5BsWAcXmmh5rQ
         xQCjYts9EahFxUj0HpcAEwHWr4vW3KLnS5hkcds+3q59BX6c7UFi2w4RNpe/qH4Y0JHm
         Hojd25xgkpaI3TCTxSiCbP29FlAJrbsJw3ykYurkrz3KaqqET2IVw+E62ZV4Fa94xuOx
         mMSpnYPt1JwPHjQ2KMyymrqplhKz4P00GfHULsZccnlwSGjC+YAPHh8eqybyw8GsthjE
         dAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L25x4BGuSb1MYT1SCW1HjP5qgx+fZuT62wOZPG3c6M0=;
        b=HS5s30fXYQAL6sOBjtEZ/81R5g1bL92JfNkOWEK2gzf7SwFis3Co7OXyyOu3ax6RFJ
         lseTaIE5EWjGK/9ye541AV4hOhnEGb7wXQQq3eI4x3AVhilv+NXzMNVHl/4Y69vXe68K
         JQ1uue/foiFaL4sSclj37Y0bB1SkYENBiX4A/mVCNIzB9vMxDmQfO/KH3AS8grfjw/cl
         ouyRxCYtrnnSWZnrY17D4oewJRA9it9zjqckQLnZSXeZLrZLkO0F4wCeyEkKUPtzV9bi
         mBN4vx3Gof7PjKUlBZgFpA8YMjEgShvZ/Qo0NPnuezZMv+IdRSFZ9TwpeINdF2FKrZJf
         VYPA==
X-Gm-Message-State: AHQUAuZbj8i1Xp2Oupk6K5BMC5OiSvzVKbRvFvJhDqmBwz6tdKkEAWdU
        SnV5NnZA18TIaYBL9llAmiI=
X-Google-Smtp-Source: AHgI3IYvf4T359yv2HK4xo6IT2tF1T0n8rJ3lDy/qxdVkpTbIyFHEv1hl1ouaZ564sQigHVXd0SE5Q==
X-Received: by 2002:ac8:2995:: with SMTP id 21mr4394906qts.297.1550864569213;
        Fri, 22 Feb 2019 11:42:49 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f58sm1499433qtc.14.2019.02.22.11.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:42:48 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C73B6410DF; Fri, 22 Feb 2019 16:42:44 -0300 (-03)
Date:   Fri, 22 Feb 2019 16:42:44 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] perf thread-stack: Hide x86 retpolines
Message-ID: <20190222194244.GF26132@kernel.org>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
 <20190109091835.5570-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109091835.5570-7-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 09, 2019 at 11:18:35AM +0200, Adrian Hunter escreveu:
> x86 retpoline functions pollute the call graph by showing up everywhere
> there is an indirect branch, but they do not really mean anything. Make
> changes so that the default retpoline functions will no longer appear in
> the call graph. Note this only affects the call graph, since all the
> original branches are left unchanged.
> 
> This does not handle function return thunks, nor is there any improvement
> for the handling of inline thunks or extern thunks.
> 
> Example:
> 
> $ cat simple-retpoline.c
> __attribute__((noinline)) int bar(void)
> {
>         return -1;
> }
> 
> int foo(void)
> {
>         return bar() + 1;
> }
> 
> __attribute__((indirect_branch("thunk"))) int main()
> {
>         int (*volatile fn)(void) = foo;
> 
>         fn();
>         return fn();
> }
> $ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
> $ objdump -d simple-retpoline
> <SNIP>
> 0000000000001040 <main>:
>     1040:       48 83 ec 18             sub    $0x18,%rsp
>     1044:       48 8d 05 25 01 00 00    lea    0x125(%rip),%rax        # 1170 <foo>
>     104b:       48 89 44 24 08          mov    %rax,0x8(%rsp)
>     1050:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>     1055:       e8 1f 01 00 00          callq  1179 <__x86_indirect_thunk_rax>
>     105a:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>     105f:       48 83 c4 18             add    $0x18,%rsp
>     1063:       e9 11 01 00 00          jmpq   1179 <__x86_indirect_thunk_rax>
> <SNIP>
> 0000000000001160 <bar>:
>     1160:       b8 ff ff ff ff          mov    $0xffffffff,%eax
>     1165:       c3                      retq
> <SNIP>
> 0000000000001170 <foo>:
>     1170:       e8 eb ff ff ff          callq  1160 <bar>
>     1175:       83 c0 01                add    $0x1,%eax
>     1178:       c3                      retq
> 0000000000001179 <__x86_indirect_thunk_rax>:
>     1179:       e8 07 00 00 00          callq  1185 <__x86_indirect_thunk_rax+0xc>
>     117e:       f3 90                   pause
>     1180:       0f ae e8                lfence
>     1183:       eb f9                   jmp    117e <__x86_indirect_thunk_rax+0x5>
>     1185:       48 89 04 24             mov    %rax,(%rsp)
>     1189:       c3                      retq
> <SNIP>
> $ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0,017 MB simple-retpoline.perf.data ]
> $ perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
> 2019-01-08 14:03:37.851655 Creating database...
> 2019-01-08 14:03:37.863256 Writing records...
> 2019-01-08 14:03:38.069750 Adding indexes
> 2019-01-08 14:03:38.078799 Done
> $ ~/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db
> 
> Before:
> 
>     main
>         -> __x86_indirect_thunk_rax
>             -> __x86_indirect_thunk_rax
>                 -> foo
>                     -> bar
> 
> After:
> 
>     main
>         -> foo
>             -> bar
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/thread-stack.c | 112 ++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 632c07a125ab..805e30836460 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -20,6 +20,7 @@
>  #include "thread.h"
>  #include "event.h"
>  #include "machine.h"
> +#include "env.h"
>  #include "util.h"
>  #include "debug.h"
>  #include "symbol.h"
> @@ -29,6 +30,19 @@
>  
>  #define STACK_GROWTH 2048
>  
> +/*
> + * State of retpoline detection.
> + *
> + * RETPOLINE_NONE: no retpoline detection
> + * X86_RETPOLINE_POSSIBLE: x86 retpoline possible
> + * X86_RETPOLINE_DETECTED: x86 retpoline detected
> + */
> +enum retpoline_state_t {
> +	RETPOLINE_NONE,
> +	X86_RETPOLINE_POSSIBLE,
> +	X86_RETPOLINE_DETECTED,
> +};
> +
>  /**
>   * struct thread_stack_entry - thread stack entry.
>   * @ret_addr: return address
> @@ -64,6 +78,7 @@ struct thread_stack_entry {
>   * @crp: call/return processor
>   * @comm: current comm
>   * @arr_sz: size of array if this is the first element of an array
> + * @rstate: used to detect retpolines
>   */
>  struct thread_stack {
>  	struct thread_stack_entry *stack;
> @@ -76,6 +91,7 @@ struct thread_stack {
>  	struct call_return_processor *crp;
>  	struct comm *comm;
>  	unsigned int arr_sz;
> +	enum retpoline_state_t rstate;
>  };
>  
>  /*
> @@ -115,10 +131,16 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
>  	if (err)
>  		return err;
>  
> -	if (thread->mg && thread->mg->machine)
> -		ts->kernel_start = machine__kernel_start(thread->mg->machine);
> -	else
> +	if (thread->mg && thread->mg->machine) {
> +		struct machine *machine = thread->mg->machine;
> +		const char *arch = perf_env__arch(machine->env);
> +
> +		ts->kernel_start = machine__kernel_start(machine);
> +		if (!strcmp(arch, "x86"))
> +			ts->rstate = X86_RETPOLINE_POSSIBLE;
> +	} else {
>  		ts->kernel_start = 1ULL << 63;
> +	}
>  	ts->crp = crp;
>  
>  	return 0;
> @@ -733,6 +755,70 @@ static int thread_stack__trace_end(struct thread_stack *ts,
>  				     false, true);
>  }
>  
> +static bool is_x86_retpoline(const char *name)
> +{
> +	const char *p = strstr(name, "__x86_indirect_thunk_");
> +
> +	return p == name || !strcmp(name, "__indirect_thunk_start");
> +}
> +
> +/*
> + * x86 retpoline functions pollute the call graph. This function removes them.
> + * This does not handle function return thunks, nor is there any improvement
> + * for the handling of inline thunks or extern thunks.
> + */
> +static int thread_stack__x86_retpoline(struct thread_stack *ts,
> +				       struct perf_sample *sample,
> +				       struct addr_location *to_al)
> +{
> +	struct thread_stack_entry *tse = &ts->stack[ts->cnt - 1];
> +	struct call_path_root *cpr = ts->crp->cpr;
> +	struct symbol *sym = tse->cp->sym;
> +	struct symbol *tsym = to_al->sym;
> +	struct call_path *cp;
> +
> +	if (sym && sym->name && is_x86_retpoline(sym->name)) {


  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC       /tmp/build/perf/util/intel-pt.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
util/thread-stack.c:780:18: error: address of array 'sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
        if (sym && sym->name && is_x86_retpoline(sym->name)) {
                ~~ ~~~~~^~~~
1 error generated.
mv: cannot stat '/tmp/build/perf/util/.thread-stack.o.tmp': No such file or directory
make[4]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/util/thread-stack.o] Error 1


[acme@quaco perf]$ pahole -C symbol ~/bin/perf
struct symbol {
	struct rb_node             rb_node;              /*     0    24 */
	u64                        start;                /*    24     8 */
	u64                        end;                  /*    32     8 */
	u16                        namelen;              /*    40     2 */
	u8                         type:4;               /*    42: 4  1 */
	u8                         binding:4;            /*    42: 0  1 */
	u8                         idle:1;               /*    43: 7  1 */
	u8                         ignore:1;             /*    43: 6  1 */
	u8                         inlined:1;            /*    43: 5  1 */

	/* XXX 5 bits hole, try to pack */

	u8                         arch_sym;             /*    44     1 */
	_Bool                      annotate2;            /*    45     1 */
	char                       name[0];              /*    46     0 */

	/* size: 48, cachelines: 1, members: 12 */
	/* bit holes: 1, sum bit holes: 5 bits */
	/* padding: 2 */
	/* last cacheline: 48 bytes */
};
[acme@quaco perf]$

I'm removing that sym->name test.

> +		/*
> +		 * This is a x86 retpoline fn. It pollutes the call graph by
> +		 * showing up everywhere there is an indirect branch, but does
> +		 * not itself mean anything. Here the top-of-stack is removed,
> +		 * by decrementing the stack count, and then further down, the
> +		 * resulting top-of-stack is replaced with the actual target.
> +		 * The result is that the retpoline functions will no longer
> +		 * appear in the call graph. Note this only affects the call
> +		 * graph, since all the original branches are left unchanged.
> +		 */
> +		ts->cnt -= 1;
> +		sym = ts->stack[ts->cnt - 2].cp->sym;
> +		if (sym && sym == tsym && to_al->addr != tsym->start) {
> +			/*
> +			 * Target is back to the middle of the symbol we came
> +			 * from so assume it is an indirect jmp and forget it
> +			 * altogether.
> +			 */
> +			ts->cnt -= 1;
> +			return 0;
> +		}
> +	} else if (sym && sym == tsym) {
> +		/*
> +		 * Target is back to the symbol we came from so assume it is an
> +		 * indirect jmp and forget it altogether.
> +		 */
> +		ts->cnt -= 1;
> +		return 0;
> +	}
> +
> +	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 2].cp, tsym,
> +				sample->addr, ts->kernel_start);
> +	if (!cp)
> +		return -ENOMEM;
> +
> +	/* Replace the top-of-stack with the actual target */
> +	ts->stack[ts->cnt - 1].cp = cp;
> +
> +	return 0;
> +}
> +
>  int thread_stack__process(struct thread *thread, struct comm *comm,
>  			  struct perf_sample *sample,
>  			  struct addr_location *from_al,
> @@ -740,6 +826,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  			  struct call_return_processor *crp)
>  {
>  	struct thread_stack *ts = thread__stack(thread, sample->cpu);
> +	enum retpoline_state_t rstate;
>  	int err = 0;
>  
>  	if (ts && !ts->crp) {
> @@ -755,6 +842,10 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  		ts->comm = comm;
>  	}
>  
> +	rstate = ts->rstate;
> +	if (rstate == X86_RETPOLINE_DETECTED)
> +		ts->rstate = X86_RETPOLINE_POSSIBLE;
> +
>  	/* Flush stack on exec */
>  	if (ts->comm != comm && thread->pid_ == thread->tid) {
>  		err = __thread_stack__flush(thread, ts);
> @@ -791,10 +882,25 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  					ts->kernel_start);
>  		err = thread_stack__push_cp(ts, ret_addr, sample->time, ref,
>  					    cp, false, trace_end);
> +
> +		/*
> +		 * A call to the same symbol but not the start of the symbol,
> +		 * may be the start of a x86 retpoline.
> +		 */
> +		if (!err && rstate == X86_RETPOLINE_POSSIBLE && to_al->sym &&
> +		    from_al->sym == to_al->sym &&
> +		    to_al->addr != to_al->sym->start)
> +			ts->rstate = X86_RETPOLINE_DETECTED;
> +
>  	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
>  		if (!sample->ip || !sample->addr)
>  			return 0;
>  
> +		/* x86 retpoline 'return' doesn't match the stack */
> +		if (rstate == X86_RETPOLINE_DETECTED && ts->cnt > 2 &&
> +		    ts->stack[ts->cnt - 1].ret_addr != sample->addr)
> +			return thread_stack__x86_retpoline(ts, sample, to_al);
> +
>  		err = thread_stack__pop_cp(thread, ts, sample->addr,
>  					   sample->time, ref, from_al->sym);
>  		if (err) {
> -- 
> 2.17.1

-- 

- Arnaldo
