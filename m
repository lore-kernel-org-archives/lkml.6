Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968597AbeE3Bz0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:55:26 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42629 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968489AbeE3BzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:55:24 -0400
X-Google-Smtp-Source: ADUXVKIRAMZd1iNMYGNjzoTAoyTrMHMroLCUl1O5Lac17WWXxhOqjFeEDA/Af75wXUnjiy8m1clH/kLVrodOEasUN04=
MIME-Version: 1.0
In-Reply-To: <1527573818-29712-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527573818-29712-1-git-send-email-nick.desaulniers@gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 18:55:23 -0700
Message-ID: <CAH7mPvh_T1YzfGBR+mzcwQ5r6bhz2NxrvY5r7sSY=wMeh-GK+w@mail.gmail.com>
Subject: Re: [PATCH] tracing: prefer strlcpy to strncpy
To: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:03 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes a stringop-truncation warning from gcc-8.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index b9061ed..b53a6c0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -393,7 +393,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
>         else if (system)
>                 snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
>         else
> -               strncpy(err, var, MAX_FILTER_STR_VAL);
> +               strlcpy(err, var, MAX_FILTER_STR_VAL);
>
>         hist_err(str, err);
>  }
> --
> 2.7.4
>

Eric points out this wont initialize the rest of err with zeros.
