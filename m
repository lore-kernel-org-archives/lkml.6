Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625563-1524098358-2-6981011569858892313
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524098357; b=Cj2Vf1DWtjMZ6wedlO+VrUwwUFGT8Bv/rnIGCVqCBK5mCCw8X9
    TBoTxdRDW058bcUu7aQF65z25zPxRHOKb+8CK13i6K4iAFjYnhZ5KAPNQkg6Z31q
    GE2YdpI+4+PF5vl7n/+f3YbBa5T4QGcikY9obXdsPxxWKujNaZDI0T7iYW4MDmgf
    GL+1Urkgf7exXn646GX1/zt0Mj92CZK+a4NKAKr6O7NeK85XhGamQmmhn9K//PAL
    kUmshMw+up19wg94JTWdaIycd+loUoPamgQVlQG4xCZoyd3XmD31E0j9ZFkp4h26
    aCbrx6XNE15d7gjyzASLb25gP6huLKB2OQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524098357; bh=VazCu2rIk+OSXtASWY49jq6xmtb2ZSIZX+LqJtVKsD
    g=; b=VHr+KokJHSb5KAQmiI5jfG6L4iYOkFVY1AhJRvnZgB2aYWY7Xp3dVYcPDl
    dKHAGedbfb4AM9wABhuH4btgcb13UXPTcPvL9gyp1Xps5LltAxDcSeHfJjMPB4Mv
    eXVtqYOg46QnNAd9Pr/xrzaNkNkGBRSErkxnoti53F6S6MWccJ8xDgRGjud8rxiw
    ND3n5SlGcNar/Foc8QwjeR3DBwmapvClxvjNVk8cWF3BS+lpI/S4XZjrXiNkV/LQ
    0x6k2ysCT/wYUkagkV5pIIyFXUeGI/e7itekGNdiYjLfCvcgG+yIO27UoG70nZfF
    kWIIF1MNyyOv8gECgYG32QzHTROg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=n7KqngyO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OY1JBk/j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=n7KqngyO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OY1JBk/j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGm0TlZo7FFq2whC5YsL7+rN2wCjCrY/IqP6xZlWjbSylgg+OONUeqPmbGZpGXwPOsb1CfVxdJi+M9W7I0oERdWwa+MQ/I/iK2YaLQ2NyRJ7y/AbgVR4
    bynco1G8Tvb3GHSNuAtHChhPa+3R0imlA2JNbnEfbIT42UrFHsQygwbItfFOOleDX8S+xrQ9LX+Nn6CwFQcLC6thItPow23juyBGUrY9xxc1kdNfpfwaUwoo
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=fsHKhBzUxRW5J4uVMEMA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeDSAjQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:39:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41144 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDSAjO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 20:39:14 -0400
X-Google-Smtp-Source: AIpwx49htUpTW6RtvERJEpziO8b0CB0Jev/LaSRjdnkzgZj9X00tthfV+DKurjHZyAUBY6N55XC4k8otSNYkpU46wtA=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <ee2a945fb09a939b3c214f45e49dab6a770d83e6.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <ee2a945fb09a939b3c214f45e49dab6a770d83e6.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 20:39:12 -0400
Message-ID: <CAHC9VhQbPbnrbxCD1fyTSxWgrXXXYnZw_=nbOhfMCO5Q5eSsWQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 06/13] audit: add support for non-syscall
 auxiliary records
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
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/auditsc.c      | 20 +++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index ed16bb6..c0b83cb 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -227,7 +227,9 @@ static inline int audit_log_container_info(struct audit_context *context,
>  /* These are defined in auditsc.c */
>                                 /* Public API */
>  extern int  audit_alloc(struct task_struct *task);
> +extern struct audit_context *audit_alloc_local(void);
>  extern void __audit_free(struct task_struct *task);
> +extern void audit_free_context(struct audit_context *context);
>  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>                                   unsigned long a2, unsigned long a3);
>  extern void __audit_syscall_exit(int ret_success, long ret_value);
> @@ -472,6 +474,12 @@ static inline int audit_alloc(struct task_struct *task)
>  {
>         return 0;
>  }
> +static inline struct audit_context *audit_alloc_local(void)
> +{
> +       return NULL;
> +}
> +static inline void audit_free_context(struct audit_context *context)
> +{ }
>  static inline void audit_free(struct task_struct *task)
>  { }
>  static inline void audit_syscall_entry(int major, unsigned long a0,
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 2932ef1..7103d23 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -959,8 +959,26 @@ int audit_alloc(struct task_struct *tsk)
>         return 0;
>  }
>
> -static inline void audit_free_context(struct audit_context *context)
> +struct audit_context *audit_alloc_local(void)
>  {
> +       struct audit_context *context;
> +
> +       if (!audit_ever_enabled)
> +               return NULL; /* Return if not auditing. */
> +
> +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT);
> +       if (!context)
> +               return NULL;
> +       context->serial = audit_serial();
> +       context->ctime = current_kernel_time64();
> +       context->in_syscall = 1;
> +       return context;
> +}
> +
> +inline void audit_free_context(struct audit_context *context)
> +{
> +       if (!context)
> +               return;
>         audit_free_names(context);
>         unroll_tree_refs(context, NULL, 0);
>         free_tree_refs(context);

I'm reserving the option to comment on this idea further as I make my
way through the patchset, but audit_free_context() definitely
shouldn't be declared as an inline function.

-- 
paul moore
www.paul-moore.com
