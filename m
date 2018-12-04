Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0700BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9515D206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE+hNCOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9515D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeLDNl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbeLDNl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:41:27 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70402081B;
        Tue,  4 Dec 2018 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543930885;
        bh=DLtnNMOaVDhDRqyo/YciSpXyfhCVZ7/bKLUyEhNDRVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gE+hNCOOkSXC34flF364NwNlPztrYeebvDJ/aCu/xq1JDUSeB+D5ncPYmVZthiXWS
         Rp81jESq5TTluF65SZ0Jz2WK0D5XlcPhxbIt5+SK5M05YQYsxLBpBoB9E9cl9Sj2jZ
         b8NKdEAUHILVo42jiUuHSmJ+o9fY0cwadYdRX8TI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66EFB4042C; Tue,  4 Dec 2018 10:41:22 -0300 (-03)
Date:   Tue, 4 Dec 2018 10:41:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools: Fix diverse typos
Message-ID: <20181204134122.GB19069@kernel.org>
References: <20181203102200.GA104797@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203102200.GA104797@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 03, 2018 at 11:22:00AM +0100, Ingo Molnar escreveu:
> Go over the tools/ files that are maintained in Arnaldo's tree and
> fix common typos: half of them were in comments, the other half
> in JSON files.

Steven, Tzvetomir,

I'm going to split this patch into different subsystems, will have you
in the CC list for the libtracecmd ones, so that it becomes easier for
you guys to pick these fixes,

Thanks,

- Arnaldo
 
> ( Care should be taken not to re-import these typos in the future,
>   if the JSON files get updated by the vendor without fixing the typos. )
> 
> No change in functionality intended.
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  tools/lib/subcmd/parse-options.h                   |  4 +--
>  tools/lib/traceevent/event-parse.c                 | 12 ++++-----
>  tools/lib/traceevent/plugin_kvm.c                  |  2 +-
>  tools/perf/Documentation/perf-list.txt             |  2 +-
>  tools/perf/Documentation/perf-report.txt           |  2 +-
>  tools/perf/Documentation/perf-stat.txt             |  4 +--
>  tools/perf/arch/x86/tests/insn-x86.c               |  2 +-
>  tools/perf/builtin-top.c                           |  2 +-
>  tools/perf/builtin-trace.c                         |  2 +-
>  .../perf/pmu-events/arch/x86/broadwell/cache.json  |  4 +--
>  .../pmu-events/arch/x86/broadwell/pipeline.json    |  2 +-
>  .../pmu-events/arch/x86/broadwellde/cache.json     |  4 +--
>  .../pmu-events/arch/x86/broadwellde/pipeline.json  |  2 +-
>  .../perf/pmu-events/arch/x86/broadwellx/cache.json |  4 +--
>  .../pmu-events/arch/x86/broadwellx/pipeline.json   |  2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/cache.json |  4 +--
>  .../pmu-events/arch/x86/jaketown/pipeline.json     |  2 +-
>  .../pmu-events/arch/x86/knightslanding/cache.json  | 30 +++++++++++-----------
>  .../pmu-events/arch/x86/sandybridge/cache.json     |  4 +--
>  .../pmu-events/arch/x86/sandybridge/pipeline.json  |  2 +-
>  .../pmu-events/arch/x86/skylakex/uncore-other.json | 12 ++++-----
>  tools/perf/tests/attr.c                            |  2 +-
>  tools/perf/util/annotate.c                         |  2 +-
>  tools/perf/util/bpf-loader.c                       |  2 +-
>  tools/perf/util/header.c                           |  2 +-
>  tools/perf/util/hist.c                             |  2 +-
>  tools/perf/util/jitdump.c                          |  2 +-
>  tools/perf/util/machine.c                          |  2 +-
>  tools/perf/util/probe-event.c                      |  4 +--
>  tools/perf/util/sort.c                             |  2 +-
>  30 files changed, 62 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
> index 6ca2a8bfe716..af9def589863 100644
> --- a/tools/lib/subcmd/parse-options.h
> +++ b/tools/lib/subcmd/parse-options.h
> @@ -71,7 +71,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
>   *
>   * `argh`::
>   *   token to explain the kind of argument this option wants. Keep it
> - *   homogenous across the repository.
> + *   homogeneous across the repository.
>   *
>   * `help`::
>   *   the short help associated to what the option does.
> @@ -80,7 +80,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
>   *
>   * `flags`::
>   *   mask of parse_opt_option_flags.
> - *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEANs)
> + *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
>   *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
>   *   PARSE_OPT_NONEG: says that this option cannot be negated
>   *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 3692f29fee46..934c441d3618 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -1145,7 +1145,7 @@ static enum tep_event_type read_token(char **tok)
>  }
>  
>  /**
> - * tep_read_token - access to utilites to use the pevent parser
> + * tep_read_token - access to utilities to use the pevent parser
>   * @tok: The token to return
>   *
>   * This will parse tokens from the string given by
> @@ -3258,7 +3258,7 @@ static int event_read_print(struct tep_event_format *event)
>   * @name: the name of the common field to return
>   *
>   * Returns a common field from the event by the given @name.
> - * This only searchs the common fields and not all field.
> + * This only searches the common fields and not all field.
>   */
>  struct tep_format_field *
>  tep_find_common_field(struct tep_event_format *event, const char *name)
> @@ -3302,7 +3302,7 @@ tep_find_field(struct tep_event_format *event, const char *name)
>   * @name: the name of the field
>   *
>   * Returns a field by the given @name.
> - * This searchs the common field names first, then
> + * This searches the common field names first, then
>   * the non-common ones if a common one was not found.
>   */
>  struct tep_format_field *
> @@ -3838,7 +3838,7 @@ static void print_bitmask_to_seq(struct tep_handle *pevent,
>  		/*
>  		 * data points to a bit mask of size bytes.
>  		 * In the kernel, this is an array of long words, thus
> -		 * endianess is very important.
> +		 * endianness is very important.
>  		 */
>  		if (pevent->file_bigendian)
>  			index = size - (len + 1);
> @@ -5313,9 +5313,9 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
>   * This returns the cmdline structure that holds a pid for a given
>   * comm, or NULL if none found. As there may be more than one pid for
>   * a given comm, the result of this call can be passed back into
> - * a recurring call in the @next paramater, and then it will find the
> + * a recurring call in the @next parameter, and then it will find the
>   * next pid.
> - * Also, it does a linear seach, so it may be slow.
> + * Also, it does a linear search, so it may be slow.
>   */
>  struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
>  				       struct cmdline *next)
> diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
> index d13c22846fa9..a06f44c91e0d 100644
> --- a/tools/lib/traceevent/plugin_kvm.c
> +++ b/tools/lib/traceevent/plugin_kvm.c
> @@ -387,7 +387,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
>  
>  	/*
>  	 * We can only use the structure if file is of the same
> -	 * endianess.
> +	 * endianness.
>  	 */
>  	if (tep_is_file_bigendian(event->pevent) ==
>  	    tep_is_host_bigendian(event->pevent)) {
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 667c14e56031..138fb6e94b3c 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -172,7 +172,7 @@ like cycles and instructions and some software events.
>  Other PMUs and global measurements are normally root only.
>  Some event qualifiers, such as "any", are also root only.
>  
> -This can be overriden by setting the kernel.perf_event_paranoid
> +This can be overridden by setting the kernel.perf_event_paranoid
>  sysctl to -1, which allows non root to use these events.
>  
>  For accessing trace point events perf needs to have read access to
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 474a4941f65d..0a17a9067bc5 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -244,7 +244,7 @@ OPTIONS
>  	          Usually more convenient to use --branch-history for this.
>  
>  	value can be:
> -	- percent: diplay overhead percent (default)
> +	- percent: display overhead percent (default)
>  	- period: display event period
>  	- count: display event count
>  
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index b10a90b6a718..4bc2085e5197 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -50,7 +50,7 @@ report::
>  	  /sys/bus/event_source/devices/<pmu>/format/*
>  
>  	Note that the last two syntaxes support prefix and glob matching in
> -	the PMU name to simplify creation of events accross multiple instances
> +	the PMU name to simplify creation of events across multiple instances
>  	of the same type of PMU in large systems (e.g. memory controller PMUs).
>  	Multiple PMU instances are typical for uncore PMUs, so the prefix
>  	'uncore_' is also ignored when performing this match.
> @@ -277,7 +277,7 @@ echo 0 > /proc/sys/kernel/nmi_watchdog
>  for best results. Otherwise the bottlenecks may be inconsistent
>  on workload with changing phases.
>  
> -This enables --metric-only, unless overriden with --no-metric-only.
> +This enables --metric-only, unless overridden with --no-metric-only.
>  
>  To interpret the results it is usually needed to know on which
>  CPUs the workload runs on. If needed the CPUs can be forced using
> diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
> index a5d24ae5810d..c3e5f4ab0d3e 100644
> --- a/tools/perf/arch/x86/tests/insn-x86.c
> +++ b/tools/perf/arch/x86/tests/insn-x86.c
> @@ -170,7 +170,7 @@ static int test_data_set(struct test_data *dat_set, int x86_64)
>   *
>   * If the test passes %0 is returned, otherwise %-1 is returned.  Use the
>   * verbose (-v) option to see all the instructions and whether or not they
> - * decoded successfuly.
> + * decoded successfully.
>   */
>  int test__insn_x86(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index aa0c73e57924..4dee10d4c51e 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -595,7 +595,7 @@ static void *display_thread_tui(void *arg)
>  
>  	/*
>  	 * Initialize the uid_filter_str, in the future the TUI will allow
> -	 * Zooming in/out UIDs. For now juse use whatever the user passed
> +	 * Zooming in/out UIDs. For now just use whatever the user passed
>  	 * via --uid.
>  	 */
>  	evlist__for_each_entry(top->evlist, pos) {
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 8e3c3f74a3a4..f9d135d1f242 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2782,7 +2782,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	 * Now that we already used evsel->attr to ask the kernel to setup the
>  	 * events, lets reuse evsel->attr.sample_max_stack as the limit in
>  	 * trace__resolve_callchain(), allowing per-event max-stack settings
> -	 * to override an explicitely set --max-stack global setting.
> +	 * to override an explicitly set --max-stack global setting.
>  	 */
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (evsel__has_callchain(evsel) &&
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
> index bba3152ec54a..0b080b0352d8 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
> @@ -433,7 +433,7 @@
>      },
>      {
>          "PEBS": "1",
> -        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "EventCode": "0xD0",
>          "Counter": "0,1,2,3",
>          "UMask": "0x41",
> @@ -445,7 +445,7 @@
>      },
>      {
>          "PEBS": "1",
> -        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "EventCode": "0xD0",
>          "Counter": "0,1,2,3",
>          "UMask": "0x42",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> index 97c5d0784c6c..999cf3066363 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> @@ -317,7 +317,7 @@
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
>      {
> -        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
> +        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
>          "EventCode": "0x87",
>          "Counter": "0,1,2,3",
>          "UMask": "0x1",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
> index bf243fe2a0ec..4ad425312bdc 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
> @@ -439,7 +439,7 @@
>          "PEBS": "1",
>          "Counter": "0,1,2,3",
>          "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
> -        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      },
> @@ -451,7 +451,7 @@
>          "PEBS": "1",
>          "Counter": "0,1,2,3",
>          "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
> -        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "SampleAfterValue": "100003",
>          "L1_Hit_Indication": "1",
>          "CounterHTOff": "0,1,2,3"
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> index 920c89da9111..0d04bf9db000 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> @@ -322,7 +322,7 @@
>          "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
>          "Counter": "0,1,2,3",
>          "EventName": "ILD_STALL.LCP",
> -        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
> +        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
> index bf0c51272068..141b1080429d 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
> @@ -439,7 +439,7 @@
>          "PEBS": "1",
>          "Counter": "0,1,2,3",
>          "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
> -        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "SampleAfterValue": "100003",
>          "CounterHTOff": "0,1,2,3"
>      },
> @@ -451,7 +451,7 @@
>          "PEBS": "1",
>          "Counter": "0,1,2,3",
>          "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
> -        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "SampleAfterValue": "100003",
>          "L1_Hit_Indication": "1",
>          "CounterHTOff": "0,1,2,3"
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> index 920c89da9111..0d04bf9db000 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> @@ -322,7 +322,7 @@
>          "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
>          "Counter": "0,1,2,3",
>          "EventName": "ILD_STALL.LCP",
> -        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
> +        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
>          "SampleAfterValue": "2000003",
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
> index f723e8f7bb09..ee22e4a5e30d 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
> @@ -31,7 +31,7 @@
>      },
>      {
>          "PEBS": "1",
> -        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "EventCode": "0xD0",
>          "Counter": "0,1,2,3",
>          "UMask": "0x41",
> @@ -42,7 +42,7 @@
>      },
>      {
>          "PEBS": "1",
> -        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "EventCode": "0xD0",
>          "Counter": "0,1,2,3",
>          "UMask": "0x42",
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> index 8a597e45ed84..34a519d9bfa0 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> @@ -778,7 +778,7 @@
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
>      {
> -        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
> +        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
>          "EventCode": "0x03",
>          "Counter": "0,1,2,3",
>          "UMask": "0x2",
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> index 88ba5994b994..e434ec723001 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> @@ -121,7 +121,7 @@
>          "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -187,7 +187,7 @@
>          "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -253,7 +253,7 @@
>          "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -319,7 +319,7 @@
>          "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -385,7 +385,7 @@
>          "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -451,7 +451,7 @@
>          "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -539,7 +539,7 @@
>          "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -605,7 +605,7 @@
>          "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -682,7 +682,7 @@
>          "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -748,7 +748,7 @@
>          "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -869,7 +869,7 @@
>          "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -935,7 +935,7 @@
>          "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -1067,7 +1067,7 @@
>          "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -1133,7 +1133,7 @@
>          "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> @@ -1199,7 +1199,7 @@
>          "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
>          "MSRIndex": "0x1a6",
>          "SampleAfterValue": "100007",
> -        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
> +        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
>          "Offcore": "1"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> index bef73c499f83..16b04a20bc12 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
> @@ -31,7 +31,7 @@
>      },
>      {
>          "PEBS": "1",
> -        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "EventCode": "0xD0",
>          "Counter": "0,1,2,3",
>          "UMask": "0x41",
> @@ -42,7 +42,7 @@
>      },
>      {
>          "PEBS": "1",
> -        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
> +        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
>          "EventCode": "0xD0",
>          "Counter": "0,1,2,3",
>          "UMask": "0x42",
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> index 8a597e45ed84..34a519d9bfa0 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> @@ -778,7 +778,7 @@
>          "CounterHTOff": "0,1,2,3,4,5,6,7"
>      },
>      {
> -        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
> +        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
>          "EventCode": "0x03",
>          "Counter": "0,1,2,3",
>          "UMask": "0x2",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> index de6e70e552e2..adb42c72f5c8 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
> @@ -428,7 +428,7 @@
>          "EventCode": "0x5C",
>          "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
> +        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This response will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
>          "UMask": "0x10",
>          "Unit": "CHA"
>      },
> @@ -967,7 +967,7 @@
>          "EventCode": "0x57",
>          "EventName": "UNC_M2M_PREFCAM_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts when the M2M (Mesh to Memory) recieves a prefetch request and inserts it into its outstanding prefetch queue.  Explanatory Side Note: the prefect queue is made from CAM: Content Addressable Memory",
> +        "PublicDescription": "Counts when the M2M (Mesh to Memory) receives a prefetch request and inserts it into its outstanding prefetch queue.  Explanatory Side Note: the prefect queue is made from CAM: Content Addressable Memory",
>          "Unit": "M2M"
>      },
>      {
> @@ -1041,7 +1041,7 @@
>          "EventCode": "0x31",
>          "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
> +        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
>          "UMask": "0x1",
>          "Unit": "UPI LL"
>      },
> @@ -1051,17 +1051,17 @@
>          "EventCode": "0x31",
>          "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly across the BGF and into the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
> +        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly across the BGF and into the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
>          "UMask": "0x2",
>          "Unit": "UPI LL"
>      },
>      {
> -        "BriefDescription": "FLITs received which bypassed the Slot0 Recieve Buffer",
> +        "BriefDescription": "FLITs received which bypassed the Slot0 Receive Buffer",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x31",
>          "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts incoming FLITs (FLow control unITs) whcih bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
> +        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
>          "UMask": "0x4",
>          "Unit": "UPI LL"
>      },
> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> index 05dfe11c2f9e..d8426547219b 100644
> --- a/tools/perf/tests/attr.c
> +++ b/tools/perf/tests/attr.c
> @@ -182,7 +182,7 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
>  	char path_perf[PATH_MAX];
>  	char path_dir[PATH_MAX];
>  
> -	/* First try developement tree tests. */
> +	/* First try development tree tests. */
>  	if (!lstat("./tests", &st))
>  		return run_dir("./tests", "./perf");
>  
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 6936daf89ddd..8fa31a4c807f 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1758,7 +1758,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	while (!feof(file)) {
>  		/*
>  		 * The source code line number (lineno) needs to be kept in
> -		 * accross calls to symbol__parse_objdump_line(), so that it
> +		 * across calls to symbol__parse_objdump_line(), so that it
>  		 * can associate it with the instructions till the next one.
>  		 * See disasm_line__new() and struct disasm_line::line_nr.
>  		 */
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index f9ae1a993806..0048d16b283d 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -99,7 +99,7 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
>  			if (err)
>  				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
>  		} else
> -			pr_debug("bpf: successfull builtin compilation\n");
> +			pr_debug("bpf: successful builtin compilation\n");
>  		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
>  
>  		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e31f52845e77..4f855b652ab3 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2798,7 +2798,7 @@ static int perf_header__adds_write(struct perf_header *header,
>  	lseek(fd, sec_start, SEEK_SET);
>  	/*
>  	 * may write more than needed due to dropped feature, but
> -	 * this is okay, reader will skip the mising entries
> +	 * this is okay, reader will skip the missing entries
>  	 */
>  	err = do_write(&ff, feat_sec, sec_size);
>  	if (err < 0)
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 828cb9794c76..8aad8330e392 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1160,7 +1160,7 @@ void hist_entry__delete(struct hist_entry *he)
>  
>  /*
>   * If this is not the last column, then we need to pad it according to the
> - * pre-calculated max lenght for this column, otherwise don't bother adding
> + * pre-calculated max length for this column, otherwise don't bother adding
>   * spaces because that would break viewing this with, for instance, 'less',
>   * that would show tons of trailing spaces when a long C++ demangled method
>   * names is sampled.
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index a1863000e972..bf249552a9b0 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -38,7 +38,7 @@ struct jit_buf_desc {
>  	uint64_t	 sample_type;
>  	size_t           bufsize;
>  	FILE             *in;
> -	bool		 needs_bswap; /* handles cross-endianess */
> +	bool		 needs_bswap; /* handles cross-endianness */
>  	bool		 use_arch_timestamp;
>  	void		 *debug_data;
>  	void		 *unwinding_data;
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8f36ce813bc5..c12f59b6d80a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -137,7 +137,7 @@ struct machine *machine__new_kallsyms(void)
>  	struct machine *machine = machine__new_host();
>  	/*
>  	 * FIXME:
> -	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitely
> +	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitly
>  	 *    ask for not using the kcore parsing code, once this one is fixed
>  	 *    to create a map per module.
>  	 */
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index e86f8be89157..18a59fba97ff 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -692,7 +692,7 @@ static int add_exec_to_probe_trace_events(struct probe_trace_event *tevs,
>  		return ret;
>  
>  	for (i = 0; i < ntevs && ret >= 0; i++) {
> -		/* point.address is the addres of point.symbol + point.offset */
> +		/* point.address is the address of point.symbol + point.offset */
>  		tevs[i].point.address -= stext;
>  		tevs[i].point.module = strdup(exec);
>  		if (!tevs[i].point.module) {
> @@ -3062,7 +3062,7 @@ static int try_to_find_absolute_address(struct perf_probe_event *pev,
>  	/*
>  	 * Give it a '0x' leading symbol name.
>  	 * In __add_probe_trace_events, a NULL symbol is interpreted as
> -	 * invalud.
> +	 * invalid.
>  	 */
>  	if (asprintf(&tp->symbol, "0x%lx", tp->address) < 0)
>  		goto errout;
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f96c005b3c41..e551d1b3fb84 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -36,7 +36,7 @@ enum sort_mode	sort__mode = SORT_MODE__NORMAL;
>   * -t, --field-separator
>   *
>   * option, that uses a special separator character and don't pad with spaces,
> - * replacing all occurances of this separator in symbol names (and other
> + * replacing all occurrences of this separator in symbol names (and other
>   * output) with a '.' character, that thus it's the only non valid separator.
>  */
>  static int repsep_snprintf(char *bf, size_t size, const char *fmt, ...)

-- 

- Arnaldo
