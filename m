Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968113AbeEXUIT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967287AbeEXUIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:08:17 -0400
Date: Thu, 24 May 2018 16:08:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: nixiaoming <nixiaoming@huawei.com>
Cc: <ard.biesheuvel@linaro.org>, <akpm@linux-foundation.org>,
        <yamada.masahiro@socionext.com>, <caoj.fnst@cn.fujitsu.com>,
        <linux@roeck-us.net>, <peterz@infradead.org>, <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>, trivial@kernel.org
Subject: Re: [PATCH] scripts: Fixed printf format mismatch
Message-ID: <20180524160813.26dbf222@gandalf.local.home>
In-Reply-To: <20180524031612.79723-1-nixiaoming@huawei.com>
References: <20180524031612.79723-1-nixiaoming@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018 11:16:12 +0800
nixiaoming <nixiaoming@huawei.com> wrote:

> scripts/kallsyms.c: function write_src:
> "printf", the #1 format specifier "d" need arg type "int",
> but the according arg "table_cnt" has type "unsigned int"
> 
> scripts/recordmcount.c: function do_file:
> "fprintf", the #1 format specifier "d" need arg type "int",
> but the according arg "(*w2)(ehdr->e_machine)" has type "unsigned int"
> 
> scripts/recordmcount.h: function find_secsym_ndx:
> "fprintf", the #1 format specifier "d" need arg type "int",
> but the according arg "txtndx" has type "unsigned int"

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  scripts/kallsyms.c     | 2 +-
>  scripts/recordmcount.c | 2 +-
>  scripts/recordmcount.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 5abfbf1..e0c416a 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -424,7 +424,7 @@ static void write_src(void)
>  	}
>  
>  	output_label("kallsyms_num_syms");
> -	printf("\tPTR\t%d\n", table_cnt);
> +	printf("\tPTR\t%u\n", table_cnt);
>  	printf("\n");
>  
>  	/* table of offset markers, that give the offset in the compressed stream
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index 8c9691c..895c40e 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -500,7 +500,7 @@ do_file(char const *const fname)
>  	gpfx = 0;
>  	switch (w2(ehdr->e_machine)) {
>  	default:
> -		fprintf(stderr, "unrecognized e_machine %d %s\n",
> +		fprintf(stderr, "unrecognized e_machine %u %s\n",
>  			w2(ehdr->e_machine), fname);
>  		fail_file();
>  		break;
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index b9897e2..2e77937 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -441,7 +441,7 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
>  			return symp - sym0;
>  		}
>  	}
> -	fprintf(stderr, "Cannot find symbol for section %d: %s.\n",
> +	fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
>  		txtndx, txtname);
>  	fail_file();
>  }
