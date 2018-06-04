Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeFDSG4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeFDSGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:06:55 -0400
Date: Mon, 4 Jun 2018 14:06:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] tracing: prefer strlcpy to strncpy
Message-ID: <20180604140652.34f28df7@gandalf.local.home>
In-Reply-To: <1527573818-29712-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527573818-29712-1-git-send-email-nick.desaulniers@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 23:03:38 -0700
Nick Desaulniers <nick.desaulniers@gmail.com> wrote:

> Fixes a stringop-truncation warning from gcc-8.
> 
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index b9061ed..b53a6c0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -393,7 +393,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
>  	else if (system)
>  		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
>  	else
> -		strncpy(err, var, MAX_FILTER_STR_VAL);
> +		strlcpy(err, var, MAX_FILTER_STR_VAL);
>  
>  	hist_err(str, err);
>  }
