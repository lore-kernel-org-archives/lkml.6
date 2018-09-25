Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D8F20880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s5svEOxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D8F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeIZDfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:35:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40868 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeIZDfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:35:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so5156300ljr.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usAb0Pr5cOvxjZD5I4ROOdKHwnxzSMvMNSAoSMDaiNc=;
        b=s5svEOxyuLoFfjF+ONjX8mabCgMceFkB/hyCPfOEg9AL3afEwnMkshnMOho6F6RAeH
         WZllOdZA6h+jVvmFobDEW/GRQMrWuZm8tjsXkIS5XklfNMapNprRTdgeGmiHXjnu09dE
         y4ghRopyLgphT93ekmmViUpzqJ1clBAHFXNUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usAb0Pr5cOvxjZD5I4ROOdKHwnxzSMvMNSAoSMDaiNc=;
        b=JEV/Fj7ug97rHyyiGxsp9kC5qbgETS/t+PLjicTbc3ZJBNySzhkm8hYhX7qXIxKjkD
         SuAgmNZ44RCFw+zmyCqtRiPr7ACItwGw4HhhbBDxjNdFCwZUrhBs6IGXrerNObgQdx45
         JFyJ1sVHAoFEa09oxh2aeNmOoiOOtfAXtlcZhRcl4JwKux0QLoT+wS4e8X+g1CgplUbU
         SUGdDliAYV3b3Iz3RjzRZVV7Wg1yB4gNhaKOtdV+lOM25MZh+By1o+ILvFY4uqY6JrOA
         e6hQseMlcPKny7Ls5qFpNQYtPMvrI23Ah1MZkt1QiCxU9gh1mMvIx7EaVDZKgakeBkK2
         w6UQ==
X-Gm-Message-State: ABuFfoiw4hBhbRf4nBvUo4LEcxkxsSFmXoesYXR212OFNaj02Y45CvuY
        4xyb75EKb/SnbySuYMJ0SxgwhNK+NKNMyXANEzy9ZQ==
X-Google-Smtp-Source: ACcGV62oon9gk3yk0obmdPeACNDfxKIG5kYEDZH0WhtdVzdSkg9BRN1Lv0UiSn6NDpFKYKP9tkD9qmN+rKecrwSpYWs=
X-Received: by 2002:a2e:9948:: with SMTP id r8-v6mr2345993ljj.135.1537910745727;
 Tue, 25 Sep 2018 14:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org> <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <f65e9fa6e047b9b14d4f64362f9fe1f89b306050.1536430404.git.saiprakash.ranjan@codeaurora.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Sep 2018 14:25:34 -0700
Message-ID: <CAEXW_YRQtJb=3V0RKHSAejfQXKssh5qBp7nmD1OUC-wTyqGDEQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracing: Add tp_pstore cmdline to have tracepoints go
 to pstore
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 1:28 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add the kernel command line tp_pstore option that will have
> tracepoints go to persistent ram buffer as well as to the
> trace buffer for further debugging. This is similar to tp_printk
> cmdline option of ftrace.
>
> Pstore support for event tracing is already added and we enable
> logging to pstore only if cmdline is specified.
>
> Passing "tp_pstore" will activate logging to pstore. To turn it
> off, the sysctl /proc/sys/kernel/tracepoint_pstore can have '0'
> echoed into it. Note, this only works if the cmdline option is
> used. Echoing 1 into the sysctl file without the cmdline option
> will have no affect.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  .../admin-guide/kernel-parameters.txt         | 21 ++++++++
>  include/linux/ftrace.h                        |  6 ++-
>  kernel/sysctl.c                               |  7 +++
>  kernel/trace/Kconfig                          | 22 +++++++-
>  kernel/trace/trace.c                          | 51 +++++++++++++++++++
>  kernel/trace/trace.h                          |  7 +++
>  6 files changed, 112 insertions(+), 2 deletions(-)
>
[...]
>  config GCOV_PROFILE_FTRACE
>         bool "Enable GCOV profiling on ftrace subsystem"
>         depends on GCOV_KERNEL
> @@ -789,4 +810,3 @@ config GCOV_PROFILE_FTRACE
>  endif # FTRACE
>
>  endif # TRACING_SUPPORT
> -
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bf6f1d70484d..018cbbefb769 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -73,6 +73,11 @@ struct trace_iterator *tracepoint_print_iter;
>  int tracepoint_printk;
>  static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
>
> +/* Pipe tracepoints to pstore */
> +struct trace_iterator *tracepoint_pstore_iter;
> +int tracepoint_pstore;
> +static DEFINE_STATIC_KEY_FALSE(tracepoint_pstore_key);
> +
>  /* For tracers that don't implement custom flags */
>  static struct tracer_opt dummy_tracer_opt[] = {
>         { }
> @@ -238,6 +243,14 @@ static int __init set_tracepoint_printk(char *str)
>  }
>  __setup("tp_printk", set_tracepoint_printk);
>
> +static int __init set_tracepoint_pstore(char *str)
> +{
> +       if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
> +               tracepoint_pstore = 1;
> +       return 1;
> +}
> +__setup("tp_pstore", set_tracepoint_pstore);
> +
>  unsigned long long ns2usecs(u64 nsec)
>  {
>         nsec += 500;
> @@ -2376,11 +2389,45 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
>         return ret;
>  }
>
> +static DEFINE_MUTEX(tracepoint_pstore_mutex);
> +
> +int tracepoint_pstore_sysctl(struct ctl_table *table, int write,
> +                            void __user *buffer, size_t *lenp,
> +                            loff_t *ppos)
> +{
> +       int save_tracepoint_pstore;
> +       int ret;
> +
> +       mutex_lock(&tracepoint_pstore_mutex);
> +       save_tracepoint_pstore = tracepoint_pstore;
> +
> +       ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +       if (!tracepoint_pstore_iter)
> +               tracepoint_pstore = 0;
> +
> +       if (save_tracepoint_pstore == tracepoint_pstore)
> +               goto out;
> +
> +       if (tracepoint_pstore)
> +               static_key_enable(&tracepoint_pstore_key.key);
> +       else
> +               static_key_disable(&tracepoint_pstore_key.key);
> +
> + out:
> +       mutex_unlock(&tracepoint_pstore_mutex);
> +
> +       return ret;
> +}
> +
>  void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
>  {
>         if (static_key_false(&tracepoint_printk_key.key))
>                 output_printk(fbuffer);
>
> +       if (static_key_false(&tracepoint_pstore_key.key))
> +               pstore_event_call(fbuffer);

Can you not find a way to pass the size of the even record here, to
pstore? Then you can directly allocate and store the binary record in
pstore itself instead of rendering and storing the text in pstore
which will be more space (and I think time) efficient. I also think if
you do this, then you will not need to use the spinlock in the pstore
(which AIUI is preventing the warning you're seeing in the
event_call->event.funcs->trace() call).

- Joel
