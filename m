Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A1CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF7C2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip+JE5R6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfBVOxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:53:33 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34646 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:53:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id w4so2784445qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H55PxZ1JlDCD9detSJiRe5zSOwJZSN/2qVWyqCAn6DU=;
        b=ip+JE5R6DVuAdE4SCP9V+XpnSYz2/x1EiZMUv3g7PQ59ebB0VxI0fy5z8pyekCcd6B
         8AUEqgpwxFq/mE/G21S1tBG/VY1qa1RjY8HYROa6x7/STu9WuS4RexNO26nBv7g1zlUA
         bPcpcehm2sUFABCOCwa1lgm3wCvIuAZd3xwpmwf13waLJmIUpr12CBcILUZ+GiAM/YtC
         zoVsgMkpECN7bgtHKFzrBdZXtt7O9yPRqoimOII1Sn9YEyqd/5wDMp0JpSMGOaPcEPBl
         oRtJFRhF14i2DXUU2vEJj0G4cP2OTarZjYUsmLaYUqwrRcz7zw62coHz91YTjMAHQwUm
         nmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H55PxZ1JlDCD9detSJiRe5zSOwJZSN/2qVWyqCAn6DU=;
        b=ANKJ50YqY70gtERXQsHGxwfm72Km1afWe2fdx5EZRJOs0QKYlvvCMjyYM4dfnox8T5
         z/rekwVd7QeB0y/AxJouZ/ZnqhUJugKLyn2suV58Sj7vkITKuyG7CxUauEagjA6XsJgw
         vz4UOLMfsVzNC8YvGZYqPms/yXTR1ze6hmpxRokYmboIl5s9HPBXbRx4mICvvwKVmYBU
         MN8Mf3Z72tUnUxpO7fTO5m57SV5ZI9to5fKTVpeDFMvd3hKLLcFVZqzeQThpP383FJ4e
         sdAWmwn5Q4D67LFnWafahwfJUbdM5XN6bmANFkBDo+1/Hs/qqiWw0149UZO3Yl5zXPMU
         QHSQ==
X-Gm-Message-State: AHQUAuYuXJi9Yk/SV2nWjKQyz7ur2LhSP1JkZ2nbW+U8hJsEQ2UB/aEQ
        ddm0utRJvTTwfehCeI0n6ew=
X-Google-Smtp-Source: AHgI3IaeR7HYhvLAe/fDIaWYRg1gdknmUiGLC+v5Pifr8m+Bi+NjfIBpZT0bTnR6jK05LH2AcKrhrA==
X-Received: by 2002:ac8:266d:: with SMTP id v42mr3341268qtv.116.1550847211727;
        Fri, 22 Feb 2019 06:53:31 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id n42sm909028qtb.43.2019.02.22.06.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:53:30 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F135410DA; Fri, 22 Feb 2019 11:53:28 -0300 (-03)
Date:   Fri, 22 Feb 2019 11:53:28 -0300
To:     Jiwei Sun <jiwei.sun@windriver.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf record: Add support for limit perf output file
 size
Message-ID: <20190222145328.GC13225@kernel.org>
References: <20190222071904.25073-1-jiwei.sun@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222071904.25073-1-jiwei.sun@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:19:04PM +0800, Jiwei Sun escreveu:
> The patch adds a new option to limit the output file size, then based
> on it, we can create a wrapper of the perf command that uses the option
> to avoid exhausting the disk space by the unconscious user.
> 
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> ---
> v2 changes:

Please do a v3 adding this new option to
tools/perf/Documentation/perf-record.txt

Please also rename it to --max-size-output, because then we coudl use:

perf record --max-size-output

or:

perf record --max-size

or even:

perf record --max saving typing :-)

Also please show it in use, i.e. the output of it working.


- Arnaldo

>   - make patch based on latest Arnaldo's perf/core,
>   - display warning message when reached the limit.
> ---
>  tools/perf/builtin-record.c | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 6c3719ac901d..dc3648c0816d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -83,6 +83,7 @@ struct record {
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
>  	cpu_set_t		affinity_mask;
> +	unsigned long		output_max_size;	/* = 0: unlimited */
>  };
>  
>  static volatile int auxtrace_record__snapshot_started;
> @@ -112,6 +113,12 @@ static bool switch_output_time(struct record *rec)
>  	       trigger_is_ready(&switch_output_trigger);
>  }
>  
> +static bool record__output_max_size_exceeded(struct record *rec)
> +{
> +	return (rec->output_max_size &&
> +	       rec->bytes_written >= rec->output_max_size);
> +}
> +
>  static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
>  			 void *bf, size_t size)
>  {
> @@ -124,6 +131,12 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
>  
>  	rec->bytes_written += size;
>  
> +	if (record__output_max_size_exceeded(rec)) {
> +		pr_warning("WARNING: The perf data has already reached "
> +			   "the limit, stop recording!\n");
> +		raise(SIGTERM);
> +	}
> +
>  	if (switch_output_size(rec))
>  		trigger_hit(&switch_output_trigger);
>  
> @@ -1671,6 +1684,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>  	return 0;
>  }
>  
> +static int parse_output_max_size(const struct option *opt,
> +				 const char *str, int unset)
> +{
> +	unsigned long *s = (unsigned long *)opt->value;
> +	static struct parse_tag tags_size[] = {
> +		{ .tag  = 'B', .mult = 1       },
> +		{ .tag  = 'K', .mult = 1 << 10 },
> +		{ .tag  = 'M', .mult = 1 << 20 },
> +		{ .tag  = 'G', .mult = 1 << 30 },
> +		{ .tag  = 0 },
> +	};
> +	unsigned long val;
> +
> +	if (unset) {
> +		*s = 0;
> +		return 0;
> +	}
> +
> +	val = parse_tag_value(str, tags_size);
> +	if (val != (unsigned long) -1) {
> +		*s = val;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  static int record__parse_mmap_pages(const struct option *opt,
>  				    const char *str,
>  				    int unset __maybe_unused)
> @@ -1982,6 +2022,8 @@ static struct option __record_options[] = {
>  	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
>  		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
>  		     record__parse_affinity),
> +	OPT_CALLBACK(0, "output-max-size", &record.output_max_size,
> +		     "size", "Output file maximum size", parse_output_max_size),
>  	OPT_END()
>  };
>  
> -- 
> 2.20.1

-- 

- Arnaldo
