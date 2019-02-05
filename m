Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0537C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD8C2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549374372;
	bh=k1JRpngOz9Ss7nCNY5SI3MaUgEolS/vCDe+V0rmX4lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O5M2smOXpG8fxS2/gFh6ZynlC04BF4cr0yPc9nY13VwZa3gp/xMP+GDOb7CZglrt6
	 dS5TkS8dquImo57DxGg7QC2HWD9GOOQmiENjNY3CmxYOeOWbgBkHVF08Z3pvuOqIip
	 Q3hkdTcZjD8gSP4zFmCv3rirOi8xKAE8Dm/zbCe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfBENqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfBENqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:46:10 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7D0207E0;
        Tue,  5 Feb 2019 13:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549374369;
        bh=k1JRpngOz9Ss7nCNY5SI3MaUgEolS/vCDe+V0rmX4lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/xoAzW0g4oKH2/gS0buuDFn6xKhnnG8MpyOLZkfO2lA+kpdBiHnLctRwEbeIXpyW
         3y4t7sLZG3IDoqNwbMRFZIBK9X43bM5H30GSFPIcKmNZsNYVS+uWqqWf8wlJbGZK2z
         mETWpln2i5TJzGkGvzeErjRqpYfp0WhhYSSb3kA0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 474A84034F; Tue,  5 Feb 2019 10:46:07 -0300 (-03)
Date:   Tue, 5 Feb 2019 10:46:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
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
Subject: Re: [PATCH 06/14] perf data: Add perf_data__(create_dir|free_dir)
 functions
Message-ID: <20190205134607.GA10613@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <20190203153018.9650-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203153018.9650-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 03, 2019 at 04:30:10PM +0100, Jiri Olsa escreveu:
> Adding perf_data__create_dir to create nr files inside
> struct perf_data path directory:
>   int perf_data__create_dir(struct perf_data *data, int nr);
> 
> and function to free that data:
>   void perf_data__free_dir(struct perf_data *data);

Can you please rename this to perf_data__remove_dir(), I think it is
more appropriate, just like that rm_rf() thing.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-kl4s1f13cg6wycrg367p85qm@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/data.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/data.h |  8 +++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 0a3051cc0ea0..ff1d9e5bd68d 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -7,11 +7,58 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <string.h>
> +#include <asm/bug.h>
>  
>  #include "data.h"
>  #include "util.h"
>  #include "debug.h"
>  
> +static void free_dir(struct perf_data_file *files, int nr)
> +{
> +	while (--nr >= 1) {
> +		close(files[nr].fd);
> +		free(files[nr].path);
> +	}
> +	free(files);
> +}
> +
> +void perf_data__free_dir(struct perf_data *data)
> +{
> +	free_dir(data->dir.files, data->dir.nr);
> +}
> +
> +int perf_data__create_dir(struct perf_data *data, int nr)
> +{
> +	struct perf_data_file *files = NULL;
> +	int i, ret = -1;
> +
> +	files = malloc(nr * sizeof(*files));
> +	if (!files)
> +		return -ENOMEM;
> +
> +	data->dir.files = files;
> +	data->dir.nr    = nr;
> +
> +	for (i = 0; i < nr; i++) {
> +		struct perf_data_file *file = &files[i];
> +
> +		if (asprintf(&file->path, "%s/data.%d", data->path, i) < 0)
> +			goto out_err;
> +
> +		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> +		if (ret < 0)
> +			goto out_err;
> +
> +		file->fd = ret;
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	free_dir(files, i);
> +	return ret;
> +}
> +
>  static bool check_pipe(struct perf_data *data)
>  {
>  	struct stat st;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 2bce28117ccf..3b4115dc777f 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -21,6 +21,11 @@ struct perf_data {
>  	bool			 is_pipe;
>  	bool			 force;
>  	enum perf_data_mode	 mode;
> +
> +	struct {
> +		struct perf_data_file	*files;
> +		int			 nr;
> +	} dir;
>  };
>  
>  static inline bool perf_data__is_read(struct perf_data *data)
> @@ -64,4 +69,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
>  int perf_data__switch(struct perf_data *data,
>  			   const char *postfix,
>  			   size_t pos, bool at_exit);
> +
> +int perf_data__create_dir(struct perf_data *data, int nr);
> +void perf_data__free_dir(struct perf_data *data);
>  #endif /* __PERF_DATA_H */
> -- 
> 2.17.2

-- 

- Arnaldo
