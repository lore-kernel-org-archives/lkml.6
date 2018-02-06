Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeBFTG4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753086AbeBFTGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:06:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA09214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 6 Feb 2018 16:06:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 06/17] tools lib symbol: Skip non-address kallsyms line
Message-ID: <20180206190649.GC3451@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
 <20180206181813.10943-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206181813.10943-7-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 06, 2018 at 07:18:02PM +0100, Jiri Olsa escreveu:
> Adding check on failed attempt to parse the address
> and skip the line parsing early in that case.

How did you stumble on that? Can you provide an example of a line or
situation where this would happen?

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-djqwni3p6lgctf6o7xhhwpmw@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/symbol/kallsyms.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
> index 914cb8e3d40b..689b6a130dd7 100644
> --- a/tools/lib/symbol/kallsyms.c
> +++ b/tools/lib/symbol/kallsyms.c
> @@ -38,6 +38,10 @@ int kallsyms__parse(const char *filename, void *arg,
>  
>  		len = hex2u64(line, &start);
>  
> +		/* Skip the line if we failed to parse the address. */
> +		if (!len)
> +			continue;
> +
>  		len++;
>  		if (len + 2 >= line_len)
>  			continue;
> -- 
> 2.13.6
