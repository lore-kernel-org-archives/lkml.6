Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625563-1524097958-2-374948938132685524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524097957; b=QT8RMvIHjEmaEwghsGrt+L/9fIMQ012N4+3gviNh+SCl2+y+O5
    tHcuLUnNB8AufVjjWG9ywWSrAivVhwAnfeEkhG19AmZc1Uh8H9k+OcLONOIasAWd
    gex9OurwaPHSMwikVcHa3kckE3rJ7vHQYFqJl9PeCXgiUHTKSa8ZQpSPtkWJ+C17
    s1nbSf+OYjK4+pqqxuhJNk6IgNBoAGg0dvNCNOzryEKhVLLbE/XOMxMF/SRRutAc
    KeyqR7K8hCULj8lnJF4pO0Hw09BwPDEwwBFbyChcAFZZ/suYWNmBN5VXl7RpwS4P
    cgA19MygzmZU3bCGa8cWqhErHmvHthJsWhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524097957; bh=NRKCsanvEjo/QA4q/2uQ7g3jcsU0o8YTGaegeaRMeF
    I=; b=JlOcfBMUzyVi9UAWnEiJKkgOkObHw6r6ugrZPvSvFvB7PheE5KipzfSlae
    7R3TY/4sgUH+WvB6Zvy3ECLnyaXlHtOYn5wggXKfjOFnx8mRVt5cefB2pGu8KPev
    Ikp1pQv5vwG3W6idT9O9Ckn/BDKq8erzw3MNYtLjMyEUEy6fCo3RE/3vwh8nQWgh
    YA5pYhtvVOf04OmS4TeGHc3W3E/lgDVFNldfjHJuUUP+xGZLQgoNN0/eWGt9nxIf
    vUHixyRX7me/XiYqKd/VLub76xF6z2Pjw2ZKIc2u8dD2LA7lI9JYLe+IEOknx01B
    e2Sa5t370n1gnqL6V1wvCvHeYwwg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=GjFjprvp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lHBQcviN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=GjFjprvp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lHBQcviN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFHyqBCT5EUluq2YewiD29wTPQWHS8Vw6MjCsc5lq8evMicYFKa5UStsSQBmgY41OyL74eThmmLdLnhM01rQZBn9n3LaxSUkhYAhTBDiP8bXF0mSIwtc
    gO9w7u/+OcJBDh3Sh+tACZPzBXme3tkPAqvEVFiFJIV/n5yh5nV/bhRABlaO0fLku1xLbjYVAUmSALmTJfHHeBzJMULpbp5gYegCUjK115X1FzVejUj6YQDY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=lpeWV5y9mY1kTzv0rkoA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeDSAcU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:32:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42872 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeDSAcS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 20:32:18 -0400
X-Google-Smtp-Source: AIpwx4/obz17+EE/jc0cL+7qLC48AvJfa5Ep9fp52uNDdgOfp4YB6t0/GM0wM6TKp2U8nbmL87d+hTAzK77EhJ4gEio=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <8c7ff567377f4a83edac48e962c1b5b824b523c8.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <8c7ff567377f4a83edac48e962c1b5b824b523c8.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 20:32:15 -0400
Message-ID: <CAHC9VhTy4fX1hYfD5tppbP-fRaVRMXOfeJ=Et96J_rc7Jw12Bw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 05/13] audit: add containerid support for
 ptrace and signals
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Add container ID support to ptrace and signals.  In particular, the "op"
> field provides a way to label the auxiliary record to which it is
> associated.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h | 16 +++++++++++-----
>  kernel/audit.c        | 12 ++++++++----
>  kernel/audit.h        |  2 ++
>  kernel/auditsc.c      | 19 +++++++++++++++----
>  4 files changed, 36 insertions(+), 13 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index a12f21f..b238be5 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -142,6 +142,7 @@ struct audit_net {
>  kuid_t         audit_sig_uid = INVALID_UID;
>  pid_t          audit_sig_pid = -1;
>  u32            audit_sig_sid = 0;
> +u64            audit_sig_cid = INVALID_CID;
>
>  /* Records can be lost in several ways:
>     0) [suppressed in audit_alloc]
> @@ -1438,6 +1439,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                         memcpy(sig_data->ctx, ctx, len);
>                         security_release_secctx(ctx, len);
>                 }
> +               sig_data->cid = audit_sig_cid;
>                 audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
>                                  sig_data, sizeof(*sig_data) + len);
>                 kfree(sig_data);
> @@ -2051,20 +2053,22 @@ void audit_log_session_info(struct audit_buffer *ab)
>
>  /*
>   * audit_log_container_info - report container info
> - * @tsk: task to be recorded
>   * @context: task or local context for record
> + * @op: containerid string description
> + * @containerid: container ID to report
>   */
> -int audit_log_container_info(struct task_struct *tsk, struct audit_context *context)
> +int audit_log_container_info(struct audit_context *context,
> +                             char *op, u64 containerid)
>  {
>         struct audit_buffer *ab;
>
> -       if (!audit_containerid_set(tsk))
> +       if (!cid_valid(containerid))
>                 return 0;
>         /* Generate AUDIT_CONTAINER_INFO with container ID */
>         ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER_INFO);
>         if (!ab)
>                 return -ENOMEM;
> -       audit_log_format(ab, "contid=%llu", audit_get_containerid(tsk));
> +       audit_log_format(ab, "op=%s contid=%llu", op, containerid);
>         audit_log_end(ab);
>         return 0;
>  }

Let's get these changes into the first patch where
audit_log_container_info() is defined.  Why?  This inserts a new field
into the record which is a no-no.  Yes, it is one single patchset, but
they are still separate patches and who knows which patches a given
distribution and/or tree may decide to backport.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 2bba324..2932ef1 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -113,6 +113,7 @@ struct audit_aux_data_pids {
>         kuid_t                  target_uid[AUDIT_AUX_PIDS];
>         unsigned int            target_sessionid[AUDIT_AUX_PIDS];
>         u32                     target_sid[AUDIT_AUX_PIDS];
> +       u64                     target_cid[AUDIT_AUX_PIDS];
>         char                    target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
>         int                     pid_count;
>  };
> @@ -1422,21 +1423,27 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
>         for (aux = context->aux_pids; aux; aux = aux->next) {
>                 struct audit_aux_data_pids *axs = (void *)aux;
>
> -               for (i = 0; i < axs->pid_count; i++)
> +               for (i = 0; i < axs->pid_count; i++) {
> +                       char axsn[sizeof("aux0xN ")];
> +
> +                       sprintf(axsn, "aux0x%x", i);
>                         if (audit_log_pid_context(context, axs->target_pid[i],
>                                                   axs->target_auid[i],
>                                                   axs->target_uid[i],
>                                                   axs->target_sessionid[i],
>                                                   axs->target_sid[i],
> -                                                 axs->target_comm[i]))
> +                                                 axs->target_comm[i])
> +                           && audit_log_container_info(context, axsn, axs->target_cid[i]))

Shouldn't this be an OR instead of an AND?

>                                 call_panic = 1;
> +               }
>         }
>
>         if (context->target_pid &&
>             audit_log_pid_context(context, context->target_pid,
>                                   context->target_auid, context->target_uid,
>                                   context->target_sessionid,
> -                                 context->target_sid, context->target_comm))
> +                                 context->target_sid, context->target_comm)
> +           && audit_log_container_info(context, "target", context->target_cid))

Same question.

>                         call_panic = 1;
>
>         if (context->pwd.dentry && context->pwd.mnt) {

-- 
paul moore
www.paul-moore.com
