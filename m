Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FE7213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F31b5Egr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfBYNpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:45:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45072 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfBYNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:45:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so10397505qtg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 05:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QayJ6i1rzIenRCj825fuEFKyOXgU3a8SEAhbsEt2WU8=;
        b=F31b5EgrtPFNMA6HPwM5cOms+7KI5k2DOlW8fVGjNp4gyBLU9i82aRtnDkyTSr53CI
         auvtKmrmc2Wbo7QqntlUQeMTFZ6NgD4RLLSMUMu5yCUfr7djG64XCMg/GDHZs8LSj0/e
         ZKd3eIniYvCzoQBoBo966jbbtTS8G1AyQHN+qaYKzXLluD4LZIM2z9D4qnt1KpYGMSrV
         96zVyz0B8g4SPTy9nneFeglsTAsBtx9yUI1VGQ6jArbEUaBpOPGNwvanxPowuHrgqW1X
         ukoUme32ltcyb4fu/xFSvAbsxE6hvk1zlZ8LEMkCTk8tWodM/bZPuvQ7NYMDd1Ai3Oof
         HRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QayJ6i1rzIenRCj825fuEFKyOXgU3a8SEAhbsEt2WU8=;
        b=S31JPIkbhgh8quOEaPSAHCUNUn4t8LldBGiXZVpT6azAuYdgHMspnq3NA+maQJI0Zk
         aWXBRUt2gaEwhv8ULcozz37qmggP4m+/ctcw2v6pHl2+3mWcv2zuwZZ5dodS4XDfCqA/
         Bb38e0ZOzvc84flqGQruJveR6wxvVNmsZPsz2fdERj89pkCaJthYrNmAp8qjNdvr0V2K
         fzM9lE7JceT2h59NLi0/CNKDf0JIKun481Ezz3fiId0QSUowAyRXlQRmQAXxQIQIHaXc
         GHeMU52PVWxzhNBLllMf8gGVXO6SGpBDh2VWt/sNRC+G0BwMVsNStp0JYdFn1arEWGj1
         q7XQ==
X-Gm-Message-State: AHQUAubT7UAMkd9QVBjfuFYhzKbgzCKPT6Yx3gqjYIdnm8rtSnDfDzCL
        cStVAPOZN8NHYnoiWdQBE5U=
X-Google-Smtp-Source: AHgI3IYLDd7a3889z6eHZlp/Rf02HYp8epDyHPItz8qIZGz2x+COJCTI97H7W3ntqJnghpKWymQIMg==
X-Received: by 2002:a0c:92b1:: with SMTP id b46mr14107613qvb.184.1551102353048;
        Mon, 25 Feb 2019 05:45:53 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id q2sm5210652qtn.47.2019.02.25.05.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 05:45:51 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA8724039C; Mon, 25 Feb 2019 10:45:48 -0300 (-03)
Date:   Mon, 25 Feb 2019 10:45:48 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 10/20] perf data: Add directory support
Message-ID: <20190225134548.GA31136@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
 <20190224190656.30163-11-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224190656.30163-11-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 24, 2019 at 08:06:46PM +0100, Jiri Olsa escreveu:
> Adding support to have directory as perf.data.
> 
> The caller needs to set 'struct perf_data::is_dir flag
> and the path will be treated as directory.
> 
> The 'struct perf_data::file' is initialized and open
> as 'path/header' file.
> 
> Adding check to direcory interface functions to check
> on is_dir flag.
> 
> Link: http://lkml.kernel.org/n/tip-pvot1aywiem9epgqpfi1agaj@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/data.c    | 41 ++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.h    |  6 ++++++
>  tools/perf/util/session.c |  4 ++++
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 7bd5ddeb7a41..72ac4dbb5c69 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  	struct perf_data_file *files = NULL;
>  	int i, ret = -1;
>  
> +	if (WARN_ON(!data->is_dir))
> +		return -EINVAL;
> +
>  	files = zalloc(nr * sizeof(*files));
>  	if (!files)
>  		return -ENOMEM;
> @@ -69,6 +72,9 @@ int perf_data__open_dir(struct perf_data *data)
>  	DIR *dir;
>  	int nr = 0;
>  
> +	if (WARN_ON(!data->is_dir))
> +		return -EINVAL;
> +
>  	dir = opendir(data->path);
>  	if (!dir)
>  		return -EINVAL;
> @@ -173,6 +179,16 @@ static int check_backup(struct perf_data *data)
>  	return 0;
>  }
>  
> +static bool is_dir(struct perf_data *data)
> +{
> +	struct stat st;
> +
> +	if (stat(data->path, &st))
> +		return false;
> +
> +	return (st.st_mode & S_IFMT) == S_IFDIR;
> +}
> +
>  static int open_file_read(struct perf_data *data)
>  {
>  	struct stat st;
> @@ -254,6 +270,22 @@ static int open_file_dup(struct perf_data *data)
>  	return open_file(data);
>  }
>  
> +static int open_dir(struct perf_data *data)
> +{
> +	if (perf_data__is_write(data) &&
> +	    mkdir(data->path, S_IRWXU) < 0)
> +		return -1;
> +
> +	/*
> +	 * So far we open only the header, so we
> +	 * can read the data version and layout.
> +	 */
> +	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
> +		return -ENOMEM;

so, if this fails, then we should unwind the mkdir, if it was
performed, so that we leave things as they were before calling
open_dir(), right?

I processed everything up to here.

- Arnaldo

> +
> +	return open_file(data);
> +}
> +
>  int perf_data__open(struct perf_data *data)
>  {
>  	if (check_pipe(data))
> @@ -265,11 +297,18 @@ int perf_data__open(struct perf_data *data)
>  	if (check_backup(data))
>  		return -1;
>  
> -	return open_file_dup(data);
> +	if (perf_data__is_read(data))
> +		data->is_dir = is_dir(data);
> +
> +	return perf_data__is_dir(data) ?
> +	       open_dir(data) : open_file_dup(data);
>  }
>  
>  void perf_data__close(struct perf_data *data)
>  {
> +	if (perf_data__is_dir(data))
> +		perf_data__close_dir(data);
> +
>  	free(data->file.path);
>  	close(data->file.fd);
>  }
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 14b47be2bd69..06aefeda311f 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -19,6 +19,7 @@ struct perf_data {
>  	const char		*path;
>  	struct perf_data_file	 file;
>  	bool			 is_pipe;
> +	bool			 is_dir;
>  	bool			 force;
>  	enum perf_data_mode	 mode;
>  
> @@ -43,6 +44,11 @@ static inline int perf_data__is_pipe(struct perf_data *data)
>  	return data->is_pipe;
>  }
>  
> +static inline bool perf_data__is_dir(struct perf_data *data)
> +{
> +	return data->is_dir;
> +}
> +
>  static inline int perf_data__fd(struct perf_data *data)
>  {
>  	return data->file.fd;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index c764bbc91009..9991e9a8bc12 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -152,6 +152,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
>  			}
>  
>  			perf_evlist__init_trace_event_sample_raw(session->evlist);
> +
> +			/* Open the directory data. */
> +			if (data->is_dir && perf_data__open_dir(data))
> +				goto out_close;
>  		}
>  	} else  {
>  		session->machines.host.env = &perf_env;
> -- 
> 2.17.2

-- 

- Arnaldo
