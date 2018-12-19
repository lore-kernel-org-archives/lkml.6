Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE11BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731ED2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545208833;
	bh=SJ5AgLS9N5te9J0IOMsrBzUC1RqgcMvtWXjA/+RNshU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EP4xTgV9Zyc9cQM6/AgBc5NlCRmPbF9vXMJy+CNgz7zQM0f4yZccgTsLivdP3BCte
	 ou5R2C9Bm848XxXrN2Jh+YFmaxUnm0bmDnmZhJBsUCYCzUTUqJ3cHw4DtfBHmWm0cL
	 KPPOoL+1XX/IsVpOQ4YogszH+HNBGQnhcpfgHm1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeLSIkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:40:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40052 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeLSIkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:40:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so9138238pgp.7;
        Wed, 19 Dec 2018 00:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MdtdVqoXXbGSZi/f9aZ7icjIcEjMwbH8grxTaMnenUg=;
        b=fTfroiSQRu8Oltj3cFvRTfpeq2SbmV7H+VHAJquNnX6zaFZs4mDMbsHr2TLX0Eou6W
         ajchc4s9h7TV8RzB6QgcOJ1Xk/EFcc5aQV7gPJNwMOHFMRX9W6ureQGGbaSUvbZ8ffns
         kMMWTbpcuSLhRbrEek6Y7RfYuNKL4Lk8b3h2WlPBUxdZNeg1NQkj9+9fp9NTxUxebxyi
         WsXM4dPQs9c1LTJrattiTBnnhAVGP9rY/lHiJ+z+MwlXGNFmCq3kYWUvjrlmddUpFzMq
         f9XgdEdfo1exXsTAHB6H6MS8qr4Ib7025xd+Ke7mw6qfBk2aQI/WTV7sKDVncfGjQQDm
         KFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MdtdVqoXXbGSZi/f9aZ7icjIcEjMwbH8grxTaMnenUg=;
        b=RGmyKb8OIxW7DcsxTJrbs2XGxrI/BnoH4sUAhxsMtBmphKzbauPd6VeTbzOn1Epe0/
         lRDuNNR/1GnJ4q2WDH1GFIGH6FLO3Gcc11+EeeJwmQsrlibtz8THxCaq/4axAMMFPa9q
         DC0pyKxYSOaReWWiZeKCwG0NwhpsXfsMv8PzFPJkSPNB0iQCW3WHW/ywRDYA8vEwk/As
         YDhh7kl12TILNc9hxfKBIX6HYGK+eXNgCMFfuMOeBCD8Oq/K7WPQlWy8kbELNKrQ1mVo
         6BD1PV1VAC1tQrioqBLjgSFh8Yz5RYX0E3FTSHCkg7yHsi8ba0YZIQPlQC2BONZ6r4IS
         jAmQ==
X-Gm-Message-State: AA+aEWbKOa2DBCmB/qhCigBgzE715ST1It+dgg4HOK9nDhno5A2eV6YD
        w84cWVGZqUmnhzrvUwQld5Y=
X-Google-Smtp-Source: AFSGD/WtVmv+wuDMBqBp4tw4WeKhGjONuMZF+n3HzTGsWou1rpwqOtIs4GSBGiaclqB1gnLfq55WcA==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr18859898pgb.242.1545208830760;
        Wed, 19 Dec 2018 00:40:30 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id c23sm21904603pfi.83.2018.12.19.00.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 00:40:29 -0800 (PST)
Date:   Wed, 19 Dec 2018 17:40:24 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 35/63] perf trace: Allow specifying a set of events to
 add in perfconfig
Message-ID: <20181219084024.GA18068@danjae.aot.lge.com>
References: <20181218220733.15839-1-acme@kernel.org>
 <20181218220733.15839-36-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218220733.15839-36-acme@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Dec 18, 2018 at 07:07:05PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To add augmented_raw_syscalls to the events speficied by the user, or be
> the only one if no events were specified by the user, one can add this
> to perfconfig:
> 
>   # cat ~/.perfconfig
>   [trace]
> 	  add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
>   #
> 
> I.e. pre-compile the augmented_raw_syscalls.c BPF program and make it
> always load, this way:
> 
>   # perf trace -e open* cat /etc/passwd > /dev/null
>      0.000 ( 0.013 ms): cat/31557 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
>      0.035 ( 0.007 ms): cat/31557 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
>      0.353 ( 0.009 ms): cat/31557 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
>      0.424 ( 0.006 ms): cat/31557 openat(dfd: CWD, filename: /etc/passwd) = 3
>   #
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-0lgj7vh64hg3ce44gsmvj7ud@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-config.txt |  8 ++++++++
>  tools/perf/builtin-trace.c               | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 661b1fb3f8ba..423cb41f6e3f 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -521,6 +521,14 @@ diff.*::
>  		Possible values are 'delta', 'delta-abs', 'ratio' and
>  		'wdiff'.  Default is 'delta'.
>  
> +trace.*::
> +	trace.add_events::
> +		Allows adding a set of events to add to the ones specified
> +		by the user, or use as a default one if none was specified.
> +		The initial use case is to add augmented_raw_syscalls.o to
> +		activate the 'perf trace' logic that looks for syscall
> +		pointer contents after the normal tracepoint payload.
> +
>  SEE ALSO
>  --------
>  linkperf:perf[1]
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 096380e8c213..d754a74aef46 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -22,6 +22,7 @@
>  #include "builtin.h"
>  #include "util/cgroup.h"
>  #include "util/color.h"
> +#include "util/config.h"
>  #include "util/debug.h"
>  #include "util/env.h"
>  #include "util/event.h"
> @@ -3523,6 +3524,21 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
>  	trace->syscalls.map = bpf__find_map_by_name("syscalls");
>  }
>  
> +static int trace__config(const char *var, const char *value, void *arg)
> +{
> +	int err = 0;
> +
> +	if (!strcmp(var, "trace.add_events")) {
> +		struct trace *trace = arg;
> +		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
> +					       "event selector. use 'perf list' to list available events",
> +					       parse_events_option);
> +		err = parse_events_option(&o, value, 0);

It's a bit strange to use parse_events_option() here IMHO.  Why not
using parse_events() instead?

Thanks,
Namhyung


> +	}
> +
> +	return err;
> +}
> +
>  int cmd_trace(int argc, const char **argv)
>  {
>  	const char *trace_usage[] = {
> @@ -3645,6 +3661,10 @@ int cmd_trace(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	err = perf_config(trace__config, &trace);
> +	if (err)
> +		goto out;
> +
>  	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
>  				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>  
> -- 
> 2.19.2
> 
