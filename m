Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDPJZW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752999AbeDPJZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:25:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F62D2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 16 Apr 2018 18:25:16 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: acme@redhat.com, mhiramat@kernel.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH 1/3] tools/parse-options: Add '\n' at the end of error
 messages
Message-Id: <20180416182516.1dcc96cae6a9028216cede5c@kernel.org>
In-Reply-To: <20180409110633.20767-2-ravi.bangoria@linux.vnet.ibm.com>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
        <20180409110633.20767-2-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Apr 2018 16:36:31 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Few error messages does not have '\n' at the end and thus next
> prompt gets printed in the same line. Ex,
> 
>   linux~$ perf buildid-cache -verbose --add ./a.out
>    Error: did you mean `--verbose` (with two dashes ?)linux~$
> 
> Fix it.

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  tools/lib/subcmd/parse-options.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> index f6a1babcbac4..cb7154eccbdc 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -433,7 +433,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
>  
>  	if (ambiguous_option) {
>  		 fprintf(stderr,
> -			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)",
> +			 " Error: Ambiguous option: %s (could be --%s%s or --%s%s)\n",
>  			 arg,
>  			 (ambiguous_flags & OPT_UNSET) ?  "no-" : "",
>  			 ambiguous_option->long_name,
> @@ -458,7 +458,7 @@ static void check_typos(const char *arg, const struct option *options)
>  		return;
>  
>  	if (strstarts(arg, "no-")) {
> -		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
> +		fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
>  		exit(129);
>  	}
>  
> @@ -466,7 +466,7 @@ static void check_typos(const char *arg, const struct option *options)
>  		if (!options->long_name)
>  			continue;
>  		if (strstarts(options->long_name, arg)) {
> -			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)", arg);
> +			fprintf(stderr, " Error: did you mean `--%s` (with two dashes ?)\n", arg);
>  			exit(129);
>  		}
>  	}
> -- 
> 2.14.3
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
