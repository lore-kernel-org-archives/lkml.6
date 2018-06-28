Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A85C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29833279A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GjeFD3MN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29833279A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966989AbeF1WZj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:25:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41199 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966506AbeF1WZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:25:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id a17-v6so2624286ljd.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6R2lfP904LhmmzgXcFm8EoGldETTmubQTwkyQc3jzM=;
        b=GjeFD3MNaAosGrx7NE7+5kYrnsEHIOpsAoloPl41LYGM0JQXwcL6dTJ37GoLqJshRy
         S0WfzwhW8tuUYQLxtU2gobCsHfOteYr7Uy18F4bdbtk/10K7Jc6yJk1OKoqsuqex+Nz/
         ayHu4yKtv3FrGE2qioUQeL5PIfPMH0FHBmMMMOxogFv+LXKsxDPFz8mQ4Ns3vM6WLwFt
         Vc9HkvkgLPjpJnv1i15ATDhFpa5Ps8WCw+VsQHYmYYPbdYuq1oZ3FucSNTMvNcUYMma1
         S+OLyHooW9aboXRfe7sw573KzDeZ7LM8vaXI7+uae863HHYr+MWfKkg1TvyjDFADl5pJ
         gUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6R2lfP904LhmmzgXcFm8EoGldETTmubQTwkyQc3jzM=;
        b=KOpj6koalRx44HBANacbVrIcBmrXrN6psV9+qXufy6vb1xGpFJC7DuiS0ETRH5g8bO
         oAQDuxUuErheQBhlHJn4Dw46ABX1ebjPXW1SWJyMaPAsRKDvhUmv2WlkT1H+dhT/jZ0S
         61S2O24b2St713f+W9O4bV6X6XIQn5WSuqPL1qRPk/dX3z6w/BTfvJk1Zy40OY25t2xY
         RhZMuepTEIpQoFtCNpjfYoun6sT9u5DW/5cvgZc/Mi2ZIZB42+EwNl0gV2fZNePAcxSi
         tuljhdVngGvPOVkHcJI+o4ocNHHAMFYiBQWhWfHu2WYVZTw6Qn4h+DfMlggIwcu0TqW9
         d3lQ==
X-Gm-Message-State: APt69E2p+K8vLyvL1yaKeytg2PRWiXqBnxkIgrskTXuMwZfAv+Vtjueq
        wmCn08GQVyzFWprj5MQS1QbWvRVJcCWCrJbOIlHG
X-Google-Smtp-Source: ADUXVKLeTsNAapwEZn+VuMi441WmePtfh3QVXGZe7GCt0G5gz6J1sXQ0/IUVY6BQhp2JSU+lxX05p4fwyaoE71WRDe4=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr8226732ljd.72.1530224736275;
 Thu, 28 Jun 2018 15:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <65299efddc04e19e6ad4b06fbde0bb3db2643cb5.1529003588.git.rgb@redhat.com>
In-Reply-To: <65299efddc04e19e6ad4b06fbde0bb3db2643cb5.1529003588.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 18:25:25 -0400
Message-ID: <CAHC9VhTffdnaymGk0LiCqXQfDK_7TW-_wxVTNuT9deS5SwsNBA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 5/6] audit: move EOE record after kill_trees
 for exit/free
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        aviro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> The EOE record was being issued prior to the pruning of the killed_tree
> list.
>
> Move the EOE record creation out of audit_log_exit() and into its
> callers __audit_free() and __audit_syscall_exit() so that
> audit_kill_trees() can be called prior to the EOE record creation and
> any purged trees CONFIG_CHANGE records included in the syscall record
> event.
>
> See: https://github.com/linux-audit/audit-kernel/issues/50
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

See my comments in 4/6.  Assuming we are able to shuffle the ordering
of audit_log_exit() and audit_kill_trees() this patch would no longer
be needed, yes?

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 2590c9e..d56aead 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1460,10 +1460,6 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
>
>         audit_log_proctitle(tsk, context);
>
> -       /* Send end of event record to help user space know we are finished */
> -       ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
> -       if (ab)
> -               audit_log_end(ab);
>         if (call_panic)
>                 audit_panic("error converting sid to string");
>  }
> @@ -1491,6 +1487,14 @@ void __audit_free(struct task_struct *tsk)
>                 audit_log_exit(context, tsk);
>         if (!list_empty(&context->killed_trees))
>                 audit_kill_trees(context);
> +       if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
> +               struct audit_buffer *ab;
> +
> +               /* Send end of event record to help user space know we are finished */
> +               ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
> +               if (ab)
> +                       audit_log_end(ab);
> +       }
>
>         audit_free_context(context);
>  }
> @@ -1572,13 +1576,19 @@ void __audit_syscall_exit(int success, long return_code)
>
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, current);
> +       if (!list_empty(&context->killed_trees))
> +               audit_kill_trees(context);
> +       if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
> +               struct audit_buffer *ab;
>
> +               /* Send end of event record to help user space know we are finished */
> +               ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
> +               if (ab)
> +                       audit_log_end(ab);
> +       }
>         context->in_syscall = 0;
>         context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
>
> -       if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(context);
> -
>         audit_free_names(context);
>         unroll_tree_refs(context, NULL, 0);
>         audit_free_aux(context);
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
