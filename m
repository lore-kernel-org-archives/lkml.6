Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67F4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF5C20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BRkFwPOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF5C20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbeKTC4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39958 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbeKTC4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so5722010lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Loas8xyv2WXia6za8y6plCgZEDWLOZFavqE0JSykZDk=;
        b=BRkFwPOgHxnnL/366B4notEQcYZkCp3iynNwnHDCmz9dr/UMGSsbp21IxmB5RoEj/8
         LqQA1PYG26WO14oRZqIxp29wzvO2TQjflRGbVOCPbXwJOsWzjcDa56rHxQMkz2N/tbv4
         jLLdUCNBwFsLRQ3zVB4c69s41RUJ7gygxLi28iZTtKDId5MGkukulHS34+9Lp4OBh1Q8
         qULRT3DBkHzOnlmTB2ftHJX88HImCyjrn40WX5J9NBECrVoSJ2GK79AdD4eoLO/V4icb
         6nMSlW4zFgL+L2qBdKzJYtQMJj8foabXw8RCf0PggfTdCgu8VWjeL/oOQpDduRnm49ve
         49PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Loas8xyv2WXia6za8y6plCgZEDWLOZFavqE0JSykZDk=;
        b=GQq67ioxuSdWeGykysjsMHTfwGMNRDEt4u78vsj7ZXSnUR1dlvyCteDkmGOARNPwiu
         3aowxu26iZdFFPBnXL46xnyfrhcg2Dm+lpTadrC672PRpKQQRwFNtPJEV8nZDMKU8RuO
         +4E6pJopkCieWmM1dkvNcu6BdW3exT1x4KQpisQGFnluo3oUCGpfZtvi+mJfHYDGuzOL
         HwM3Fe/0wnypEvoD1LnJ1PVX7SPxPkN90ErfAw4cfx7Hh7QArMgIoEea0TgY5EWT9HJN
         r+/i8itlDJML+KdFG9peZX3q1JVO8WX7QuzDayzAuQKV3UEkBrAP9Ps8uKtYaRwUuSEX
         IsRg==
X-Gm-Message-State: AGRZ1gIaGtZvEVwfSx2Zj8aVbURTLaDfPAP4qaMsuqJ9NTcsK9EnzNxi
        6kBkAbC0QhyOxBqYduUqczMKgFqtM7vkIUOiCn4S
X-Google-Smtp-Source: AJdET5cK2N+kXg4eaH+mivGraVkWTtze3GMtK1V/KLsACnqJo6JUOr/DhUQnpsDQ1D2teLu5m3SXB8I7Bdn8D7ydltM=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr12210591ljk.55.1542645158649;
 Mon, 19 Nov 2018 08:32:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1532709911.git.rgb@redhat.com> <01b59195f8ff3c2ec32a2251200f588bd537dff1.1532709911.git.rgb@redhat.com>
In-Reply-To: <01b59195f8ff3c2ec32a2251200f588bd537dff1.1532709911.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 11:32:27 -0500
Message-ID: <CAHC9VhSm0c-DUn_bJsv6NrZ+_NwUVzRQbNiC7rLS1Hu=7nALwg@mail.gmail.com>
Subject: Re: [PATCH ghak59 V2 5/6] audit: kill trees before logging syscall
 exit for exit/free
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 3:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> The EOE record was being issued prior to the pruning of the killed_tree
> list.
>
> Move the kill_trees call before the audit_log_exit call in
> __audit_free() and __audit_syscall_exit() so that the user library
> doesn't leave out any appended pruned trees CONFIG_CHANGE records due to
> the EOE flagging the end of the event.
>
> See: https://github.com/linux-audit/audit-kernel/issues/50
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

This patch and patch 4/6 should be squashed together.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 986c5ce..55fd2a3 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1482,6 +1482,8 @@ void __audit_free(struct task_struct *tsk)
>         if (!context)
>                 return;
>
> +       if (!list_empty(&context->killed_trees))
> +               audit_kill_trees(context);
>         /* Check for system calls that do not go through the exit
>          * function (e.g., exit_group), then free context block.
>          * We use GFP_ATOMIC here because we might be doing this
> @@ -1489,8 +1491,6 @@ void __audit_free(struct task_struct *tsk)
>         /* that can happen only if we are called from do_exit() */
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, tsk);
> -       if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(context);
>
>         audit_free_context(context);
>  }
> @@ -1570,15 +1570,14 @@ void __audit_syscall_exit(int success, long return_code)
>         if (!context)
>                 return;
>
> +       if (!list_empty(&context->killed_trees))
> +               audit_kill_trees(context);
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, current);
>
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
