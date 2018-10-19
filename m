Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CCB21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="b4mnbcdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CCB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJTHZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:25:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45557 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeJTHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:25:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so32178852ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfpuegup/TP/9yAifY39+A+RryWEosceNaVl4fz7HRE=;
        b=b4mnbcdRRz6EiyF0i/dDXjDI4zdNeXDAWPivdR0aeS8VRPPL2sBGqTXCR3PqI8nVR7
         yGsP8lTNjpkeT9jnJvABdhjhhC5a7O4uA2LL0tjWkloxzgQtsq37x+rfbIJiKAcnJddz
         CGaXAi7Hh7RDiX2p0kjKqfpcroTfXuBDqt76zXqve/377V5SVbU3tX7MsIEq6zfeBoVg
         9ojdlxDdYmm7UEUapZNNC4l8PZhZiZ+bHOoQoLR+sOEebk6LgagSn+/7yTfKt0RdRaf6
         TRU8Ors45G6f8V+Oe3XNnhcLIMZl8mrVNcTFlCs97ti+OeZ3DkcpO/0wvK3zl02/DH1r
         oHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfpuegup/TP/9yAifY39+A+RryWEosceNaVl4fz7HRE=;
        b=bHsebAWrEBd5b1m6i2NsJOlrfKzZmWlJBrQ5QfIbueu+A9mrvkGuXp+zKajz0xzIlq
         RtXDAVFyO4oWBbS60L3vBW/nt0S7nJDbbcz3xsAgKm7jgd6CpVK6KhCkCIWiRuR77Y2p
         YVXjhwxFCRXd7I9/thjmEjsnCLmFrZ1oOUYhTw72+mi6hz9VPbL0cN8ffFmA3S8RD+Ip
         csxgbzhnGvLw0jYF29GUu92jznbpGKjRYbKhS1PLnU/shcWV295XfKphYeAgVwkdI8pf
         y/ZK8HZoPwMzgt6eGV80v/fKfRJsQA/IYQEnG8ZEbflYkVaPqfRziucpLfVH2VYxsYqz
         bQ5g==
X-Gm-Message-State: ABuFfog7Tbm3hqvPg4HF2Y0e3Uh82Lc99CyKv3/lCFGS4Fdsz6juZQlL
        SThf5eNQ2zd/Mv6o8jo/hcZfxGe4tDBpU2pf9dpq
X-Google-Smtp-Source: ACcGV60v47C+7a2131u46yAHIkxcdyz5P/TwgX87XACExR/jq8s1m0KQlRrmC6CVMFRGzJbW41ZcpBzELiBddbamBUg=
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr25910523ljn.18.1539991025422;
 Fri, 19 Oct 2018 16:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <71c7761b5e0289fee7d82ddcc723d39804826e53.1533065887.git.rgb@redhat.com>
In-Reply-To: <71c7761b5e0289fee7d82ddcc723d39804826e53.1533065887.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Oct 2018 19:16:54 -0400
Message-ID: <CAHC9VhSFtNMkSABZivf+C5N5SM9iC2Sh958uC+zYwceUv5zpeQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 04/10] audit: add containerid
 support for ptrace and signals
To:     rgb@redhat.com
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        luto@kernel.org, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 4:11 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add audit container identifier support to ptrace and signals.  In
> particular, the "op" field provides a way to label the auxiliary record
> to which it is associated.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  include/linux/audit.h | 11 +++++------
>  kernel/audit.c        | 13 +++++++------
>  kernel/audit.h        |  2 ++
>  kernel/auditsc.c      | 21 ++++++++++++++++-----
>  4 files changed, 30 insertions(+), 17 deletions(-)

...

> @@ -155,9 +156,8 @@ extern void             audit_log_key(struct audit_buffer *ab,
>  extern int audit_log_task_context(struct audit_buffer *ab);
>  extern void audit_log_task_info(struct audit_buffer *ab,
>                                 struct task_struct *tsk);
> -extern int audit_log_contid(struct task_struct *tsk,
> -                                   struct audit_context *context,
> -                                   char *op);
> +extern int audit_log_contid(struct audit_context *context,
> +                                    char *op, u64 contid);
>
>  extern int                 audit_update_lsm_rules(void);

...

> @@ -2047,23 +2049,22 @@ void audit_log_session_info(struct audit_buffer *ab)
>
>  /*
>   * audit_log_contid - report container info
> - * @tsk: task to be recorded
>   * @context: task or local context for record
>   * @op: contid string description
> + * @contid: container ID to report
>   */
> -int audit_log_contid(struct task_struct *tsk,
> -                            struct audit_context *context, char *op)
> +int audit_log_contid(struct audit_context *context,
> +                             char *op, u64 contid)
>  {
>         struct audit_buffer *ab;
>
> -       if (!audit_contid_set(tsk))
> +       if (!audit_contid_valid(contid))
>                 return 0;
>         /* Generate AUDIT_CONTAINER record with container ID */
>         ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER);
>         if (!ab)
>                 return -ENOMEM;
> -       audit_log_format(ab, "op=%s contid=%llu",
> -                        op, audit_get_contid(tsk));
> +       audit_log_format(ab, "op=%s contid=%llu", op, contid);
>         audit_log_end(ab);
>         return 0;
>  }

My previous comments still apply: these audit_log_contid() changes
should be done earlier in the patchset when you first define
audit_log_contid().

--
paul moore
www.paul-moore.com
