Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934079AbeE2NIJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:08:09 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36690 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933548AbeE2NII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:08:08 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w4TD7s6S028853
X-Nifty-SrcIP: [209.85.213.48]
X-Google-Smtp-Source: ADUXVKJ+qlS5HB0v+eUQSBAUN+Ne56hUUBG6bgMRPEEfuqxI/aucJIiMUC6Q2UPgAvGSdJTy/drjGBuCGEHemjy7ww8=
MIME-Version: 1.0
In-Reply-To: <20180524031612.79723-1-nixiaoming@huawei.com>
References: <20180524031612.79723-1-nixiaoming@huawei.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 29 May 2018 22:07:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARoYg+qJKir=sC_jVrbLODa-SB5fUmWCiq2eRiJh3VLaw@mail.gmail.com>
Message-ID: <CAK7LNARoYg+qJKir=sC_jVrbLODa-SB5fUmWCiq2eRiJh3VLaw@mail.gmail.com>
Subject: Re: [PATCH] scripts: Fixed printf format mismatch
To: nixiaoming <nixiaoming@huawei.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-24 12:16 GMT+09:00 nixiaoming <nixiaoming@huawei.com>:
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
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>


Applied to linux-kbuild
with Steven's Ack.

Thanks.


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
>         }
>
>         output_label("kallsyms_num_syms");
> -       printf("\tPTR\t%d\n", table_cnt);
> +       printf("\tPTR\t%u\n", table_cnt);
>         printf("\n");
>
>         /* table of offset markers, that give the offset in the compressed stream
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index 8c9691c..895c40e 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -500,7 +500,7 @@ do_file(char const *const fname)
>         gpfx = 0;
>         switch (w2(ehdr->e_machine)) {
>         default:
> -               fprintf(stderr, "unrecognized e_machine %d %s\n",
> +               fprintf(stderr, "unrecognized e_machine %u %s\n",
>                         w2(ehdr->e_machine), fname);
>                 fail_file();
>                 break;
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index b9897e2..2e77937 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -441,7 +441,7 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
>                         return symp - sym0;
>                 }
>         }
> -       fprintf(stderr, "Cannot find symbol for section %d: %s.\n",
> +       fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
>                 txtndx, txtname);
>         fail_file();
>  }
> --
> 2.10.1
>



-- 
Best Regards
Masahiro Yamada
