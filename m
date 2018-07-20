Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A87E20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sqlJi1ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A87E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbeGTXEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:04:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43574 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731697AbeGTXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:04:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id m12-v6so2758203lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHZ59XqSMuHADW+R57tBef8AdySR0zI+EV3OLndYQx0=;
        b=sqlJi1ci2aaQSjkcjVha0IfOpjP7OABHcNA9SQq12lA+85JBhnhPhsRxlnlnPhg/He
         nZAQDvIBvfECZzVmXqiBaeXsgq27Joa/i2WKZYG4gftAPMjZQyarLVQUmkiVz9VE7By2
         PCROwqTxqulGIhLkgLXbP5HWokY89MjsHREptyWoUiSr2+/bP8FIDQaFTuTx95FKWldP
         HgsEDbgZ/Cdpa0uBvlgrN+fk99te6QCFwVrD9mdDgK/ch+Vm9uEJRKk/PBoDdiimk5ld
         tFpHyDxCrgSwp6Stvf2e0h3CbPBwvg/QElyf1V6yUAxLUzoWgj5oq5vCyjMclL7+vGx9
         oeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHZ59XqSMuHADW+R57tBef8AdySR0zI+EV3OLndYQx0=;
        b=clQ2VVG2i8SNbV5gSxdjDtfHqYUSA0n8j60J+s1I17iAiR238smGrFVoAjXiVma5JZ
         /Pz/8aVPdArFfz5PDHn+EF7S0YWH12Zqj+lxZ6qb1mMmH1CoZzrwTyXC6BcRXyueUdoe
         /PO7qNo7HTrSnsLC9CVA0WPzhxFouPearuV8AvRm5VHckxW66XipkaZme63Lm/9kAE1w
         KIL9+4pkNVwasilFzKEU3pWvltlIaUDYqJVEpv+j2SCoV6+Wv1t9yAXFZ91D5YBE9OaG
         beUZQh4vWEqooYiwQu++86bhMttOezk361rlzdjeG605BKNli+pMckj2J+vDyQ3qfCbW
         wCEg==
X-Gm-Message-State: AOUpUlHTsU2VX/KnEWxAkA6Sl8LGr0G/3yhZw8xu7eXu1Yaboh7DLW8X
        L/kvmeCbftwQ/0SQzhaLYsjoArKSEQdQPNc65q8X
X-Google-Smtp-Source: AAOMgpcRSVJ8A6m/vpvAm0muHJ4dlOKFVtY2vxRGwFMq8GsM65lqc8CRtyv8bTLioSj+BTEb3QlAjR0ZJREZGo32LIA=
X-Received: by 2002:a19:de4e:: with SMTP id v75-v6mr2257374lfg.14.1532124862506;
 Fri, 20 Jul 2018 15:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <28ab8ad3c4e5de6f61b928eeb2af030b04a8820b.1528304204.git.rgb@redhat.com>
In-Reply-To: <28ab8ad3c4e5de6f61b928eeb2af030b04a8820b.1528304204.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Jul 2018 18:14:11 -0400
Message-ID: <CAHC9VhTTJVbFq_Cmu8E7EzQD-JXjkbDz7P1EY8ePVrXpQAqPdw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 05/10] audit: add containerid
 support for tty_audit
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 1:04 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add audit container identifier auxiliary record to tty logging rule
> event standalone records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  drivers/tty/tty_audit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> index e30aa6b..66bd850 100644
> --- a/drivers/tty/tty_audit.c
> +++ b/drivers/tty/tty_audit.c
> @@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
>         uid_t uid = from_kuid(&init_user_ns, task_uid(tsk));
>         uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(tsk));
>         unsigned int sessionid = audit_get_sessionid(tsk);
> +       struct audit_context *context = audit_alloc_local();

We should be using current's audit_context in tty_audit_log().
Actually, we should probably just get rid of the tsk variable in
tty_audit_log() and use current directly to make things a bit more
obvious.

<time passes>

I did some digging and I have a two year old, half-baked patch that
cleans up this tsk/current usage as well as a few others.  I just
rebased it against audit/next and surprisingly it seems to pass a
basic smoke test (kernel boots and audit-testsuite passes); I'll post
it to the list as a RFC once I'm done reviewing these patches.

> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
>         if (ab) {
>                 char name[sizeof(tsk->comm)];
>
> @@ -80,6 +81,8 @@ static void tty_audit_log(const char *description, dev_t dev,
>                 audit_log_n_hex(ab, data, size);
>                 audit_log_end(ab);
>         }
> +       audit_log_contid(context, "tty", audit_get_contid(tsk));
> +       audit_free_context(context);
>  }

--
paul moore
www.paul-moore.com
