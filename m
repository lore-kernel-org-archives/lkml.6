Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD08C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B5721A39
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLdIT2ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B5721A39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeHFQDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:03:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36719 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbeHFQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:03:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so6911269pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EoCXDd8CPRhAGxGhtg43SvJ9hOo3vQWZBKjhQ4G/9LA=;
        b=oLdIT2ER3OG9iA7gQjrEZqLlHaE0o1kXEt8ZhKzwlR05BZhD//PV2iWw0lUiUKO/DV
         +CWxkLTjh9DbO64n3ZbOnBRFF6fAnJ/LKG71x5GEkTQrnQxeh/q5UxqMx+UmkXoCdhWq
         2Sc/B3piQfdfg1rFvDo5MG2kGl/xKjFCjrR/VtXT8xkxm8V+Y2hO7ZPm4UZNMMAA3iwI
         2xEMnz/kTvEfB2BnWqOhtnTdlV88WcDWH4nZuZwC6p4Vhmeo/N/bc0O8eiZjP8oj8Ob/
         Zm1cBsOcmgvrUpyWk3SZp4A0HLIDux5kRE+TBlUXghVT1X2kv4FNwLCbGlv+cHuJUfNz
         7GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EoCXDd8CPRhAGxGhtg43SvJ9hOo3vQWZBKjhQ4G/9LA=;
        b=IyNole6FH9vZ5bIilaFzbCko205uwCGVcz+/l/Z+j4P4FwRgnafFzLQLCrJnJJWYxx
         2Yb2maONszkNYrBdG8BMuD8XsmhRX00l2VedyERb/Iu/10bli6B7+2zVvRFxb/mV9HiJ
         wdn36rswbcMJfo8bKoihi08MUV0/rh6DGTsbdVXH1VGhVABkUlSSGmOC13APpAoyunwg
         G40vR7wHHy+zvD8f8PXzpUdLsMlNiN0s8DcmIL7J5k3DUx13lNfXyM//Q2VZIa9nNYZo
         7XYPQTFSN77XuNtR8agXB689/5/fxZZePw6ObgRf+qFWiFW6q8GgSY0t3sFb83XDnflC
         PasA==
X-Gm-Message-State: AOUpUlFdcp4gJ++d7ThWCZM+2Z5Ksb+0gafMN/WLWtIDTKkT9HsaNGaO
        E2KXaStAGLMlOAzFZgk7L+0=
X-Google-Smtp-Source: AAOMgpeULAaUapfkWNqJ2L+zEdWNqqu6IW01FYV+ntDe14TkH8eaIYIlCMoZjksoE1ykVVOS96xmIg==
X-Received: by 2002:a63:1c13:: with SMTP id c19-v6mr14703439pgc.332.1533563658546;
        Mon, 06 Aug 2018 06:54:18 -0700 (PDT)
Received: from danjae.aot.lge.com ([182.210.106.170])
        by smtp.gmail.com with ESMTPSA id y20-v6sm12264008pgv.31.2018.08.06.06.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 06:54:17 -0700 (PDT)
Date:   Mon, 6 Aug 2018 22:49:12 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>, kernel-team@lge.com
Subject: Re: [PATCH 19/20] perf annotate: Add --percent-type option
Message-ID: <20180806134912.GB6983@danjae.aot.lge.com>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-20-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-20-jolsa@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 03:05:20PM +0200, Jiri Olsa wrote:
> Adding --percent-type option to set annotation percent type
> from following choices:
>   global-period, local-period, global-hits, local-hits
> 
> Examples:
>   $ perf annotate --percent-type period-local --stdio | head -1
>    Percent         |      Source code ... es, percent: local period)
>   $ perf annotate --percent-type hits-local --stdio | head -1
>    Percent         |      Source code ... es, percent: local hits)
>   $ perf annotate --percent-type hits-global --stdio | head -1
>    Percent         |      Source code ... es, percent: global hits)
>   $ perf annotate --percent-type period-global --stdio | head -1
>    Percent         |      Source code ... es, percent: global period)
> 
> The local/global keywords set if the percentage is computed
> in the scope of the function (local) or the whole data (global).
> 
> The period/hits keywords set the base the percentage is computed
> on - the samples period or the number of samples (hits).

What about adding "period" as an alias to "local-period" (and same for
"hits" as well)?

Thanks,
Namhyung


> 
> Link: http://lkml.kernel.org/n/tip-ahnswy1p9rnjlkudhl2ig3gc@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  9 ++++
>  tools/perf/builtin-annotate.c              |  4 ++
>  tools/perf/util/annotate.c                 | 53 ++++++++++++++++++++++
>  tools/perf/util/annotate.h                 |  3 ++
>  4 files changed, 69 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index 749cc6055dac..e8c972f89357 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -118,6 +118,15 @@ OPTIONS
>  --group::
>  	Show event group information together
>  
> +--percent-type::
> +	Set annotation percent type from following choices:
> +	  global-period, local-period, global-hits, local-hits
> +
> +	The local/global keywords set if the percentage is computed
> +	in the scope of the function (local) or the whole data (global).
> +	The period/hits keywords set the base the percentage is computed
> +	on - the samples period or the number of samples (hits).
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-report[1]
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 8180319285af..830481b8db26 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -542,6 +542,10 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
>  			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
>  			     stdio__config_color, "always"),
> +	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
> +		     "Set percent type local/global-period/hits",
> +		     annotate_parse_percent_type),
> +
>  	OPT_END()
>  	};
>  	int ret;
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 6316fa96d984..f68636c0d95a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2799,3 +2799,56 @@ void annotation_config__init(void)
>  	annotation__default_options.show_total_period = symbol_conf.show_total_period;
>  	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
>  }
> +
> +static unsigned int parse_percent_type(char *str1, char *str2)
> +{
> +	unsigned int type = (unsigned int) -1;
> +
> +	if (!strcmp("period", str1)) {
> +		if (!strcmp("local", str2))
> +			type = PERCENT_PERIOD_LOCAL;
> +		else if (!strcmp("global", str2))
> +			type = PERCENT_PERIOD_GLOBAL;
> +	}
> +
> +	if (!strcmp("hits", str1)) {
> +		if (!strcmp("local", str2))
> +			type = PERCENT_HITS_LOCAL;
> +		else if (!strcmp("global", str2))
> +			type = PERCENT_HITS_GLOBAL;
> +	}
> +
> +	return type;
> +}
> +
> +int
> +annotate_parse_percent_type(const struct option *opt, const char *_str,
> +			    int unset __maybe_unused)
> +{
> +	struct annotation_options *opts = opt->value;
> +	unsigned int type;
> +	char *str1, *str2;
> +	int err = -1;
> +
> +	str1 = strdup(_str);
> +	if (!str1)
> +		return -ENOMEM;
> +
> +	str2 = strchr(str1, '-');
> +	if (!str2)
> +		goto out;
> +
> +	*str2++ = 0;
> +
> +	type = parse_percent_type(str1, str2);
> +	if (type == (unsigned int) -1)
> +		type = parse_percent_type(str2, str1);
> +	if (type != (unsigned int) -1) {
> +		opts->percent_type = type;
> +		err = 0;
> +	}
> +
> +out:
> +	free(str1);
> +	return err;
> +}
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 760a6678edff..c7337f0a1823 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -397,4 +397,7 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
>  
>  void annotation_config__init(void);
>  
> +int
> +annotate_parse_percent_type(const struct option *opt, const char *_str,
> +			    int unset);
>  #endif	/* __PERF_ANNOTATE_H */
> -- 
> 2.17.1
> 
