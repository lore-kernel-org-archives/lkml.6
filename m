Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeCITHT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751205AbeCITHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:07:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D233206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 16:07:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Martin Vuille <jpmv27@aim.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Don't prepend symfs path to
 build_id_filename
Message-ID: <20180309190715.GB25111@kernel.org>
References: <20180211191937.9703-1-jpmv27@aim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211191937.9703-1-jpmv27@aim.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 11, 2018 at 02:19:37PM -0500, Martin Vuille escreveu:
> build_id_filename already contains symfs path if applicable, so
> don't prepend it a second time.

Where is the analysis that shows that that is the case? I looked here at
the implementation for dso__build_id_filename() and couldn't find where
was it that the symfs would be appended, can you clarify?

- Arnaldo
 
> Signed-off-by: Martin Vuille <jpmv27@aim.com>
> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 28b233c3dcbe..425b7f0760ec 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1381,7 +1381,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  
>  	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
>  	if (build_id_filename) {
> -		__symbol__join_symfs(filename, filename_size, build_id_filename);
> +		scnprintf(filename, filename_size, "%s", build_id_filename);
>  		free(build_id_filename);
>  	} else {
>  		if (dso->has_build_id)
> -- 
> 2.13.6
