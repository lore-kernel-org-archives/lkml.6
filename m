Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeCGT2K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754280AbeCGT2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:28:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947DF2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 16:28:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 16/19] perf tools: Update tags with .cpp files
Message-ID: <20180307192806.GT3701@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
 <20180307155020.32613-17-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307155020.32613-17-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 04:50:17PM +0100, Jiri Olsa escreveu:
> We have some .cpp files, make ctags/cscope aware of them.

Applied
 
> Link: http://lkml.kernel.org/n/tip-37og2tumxswqeyx0htq3zu04@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.perf | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 4679e237a7f5..f7517e1b73f8 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -708,15 +708,15 @@ TAG_FILES= ../../include/uapi/linux/perf_event.h
>  
>  TAGS:
>  	$(QUIET_GEN)$(RM) TAGS; \
> -	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print | xargs etags -a $(TAG_FILES)
> +	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print -o -name '*.cpp' -print | xargs etags -a $(TAG_FILES)
>  
>  tags:
>  	$(QUIET_GEN)$(RM) tags; \
> -	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print | xargs ctags -a $(TAG_FILES)
> +	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print -o -name '*.cpp' -print | xargs ctags -a $(TAG_FILES)
>  
>  cscope:
>  	$(QUIET_GEN)$(RM) cscope*; \
> -	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print | xargs cscope -b $(TAG_FILES)
> +	$(FIND) $(TAG_FOLDERS) -name '*.[hcS]' -print -o -name '*.cpp' -print | xargs cscope -b $(TAG_FILES)
>  
>  ### Testing rules
>  
> -- 
> 2.13.6
