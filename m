Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D71C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A62720645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A62720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeH3Mnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:43:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeH3Mnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:43:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FE3A7DAC2;
        Thu, 30 Aug 2018 08:42:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 733D1B27AB;
        Thu, 30 Aug 2018 08:42:37 +0000 (UTC)
Date:   Thu, 30 Aug 2018 10:42:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: Make perf script easier to use for itrace
Message-ID: <20180830084236.GB16691@krava>
References: <20180829171834.6590-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 08:42:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 08:42:38 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:18:24AM -0700, Andi Kleen wrote:

SNIP

> 
> Filter by a ftrace style graph function:
> 
>  % perf script --graph-function group_sched_in --call-trace
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])          group_sched_in
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])              event_sched_in.isra.107
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_event_set_state.part.71
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_time
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_disable
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_log_itrace_start
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  __x86_indirect_thunk_rax
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                      perf_event_update_userpage
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          calc_timer_values
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_cpu
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          __x86_indirect_thunk_rax
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                          arch_perf_update_userpage
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              __fentry__
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              using_native_sched_clock
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                              sched_clock_stable
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])                  perf_pmu_enable
>                 perf   900 [000] 194167.205652203: ([kernel.kallsyms])              __x86_indirect_thunk_rax
> 
> 
> Also available in
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git pt/easy-script-2

got compile error over your branch, might be one of the new fancy gcc8 checksm not sure
  gcc version 8.1.1 20180712 (Red Hat 8.1.1-5) (GCC) 

jirka


---
[jolsa@krava perf]$ make JOBS=1
  BUILD:   Doing 'make -j1' parallel build
  CC       builtin-script.o
builtin-script.c: In function ‘parse_output_fields’:
builtin-script.c:2571:22: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
     output[j].fields &= ~all_output_options[i].field;
                      ^~
builtin-script.c:2571:22: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
     output[j].fields &= ~all_output_options[i].field;
     ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
builtin-script.c:2574:10: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
    output[j].user_set = true;
    ~~~~~~^~~
builtin-script.c:2575:10: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
    output[j].wildcard_set = true;
    ~~~~~~^~~
builtin-script.c: In function ‘parse_output_fields.constprop’:
builtin-script.c:2571:22: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
     output[j].fields &= ~all_output_options[i].field;
                      ^~
builtin-script.c:2571:22: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
     output[j].fields &= ~all_output_options[i].field;
     ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
builtin-script.c:2574:10: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
    output[j].user_set = true;
    ~~~~~~^~~
builtin-script.c:2575:10: error: array subscript 7 is above array bounds of ‘struct <anonymous>[7]’ [-Werror=array-bounds]
    output[j].wildcard_set = true;
    ~~~~~~^~~
cc1: all warnings being treated as errors
mv: cannot stat './.builtin-script.o.tmp': No such file or directory
make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: builtin-script.o] Error 1
make[2]: *** [Makefile.perf:507: perf-in.o] Error 2
make[1]: *** [Makefile.perf:206: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

