Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C0DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A957F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bh2m4oO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A957F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJTHZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:25:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39727 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeJTHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:25:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id p1-v6so32191009ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njvPKH08ymkyNzwJyzg8QpiuMjxRS5rv01R2//2tiAI=;
        b=bh2m4oO4HDQPFd7IB2qHm8/9GmW7Rd7k2FxyUmGe0OrLbxA8DdQsFjxvtRVV9V18Cw
         kk1oTgAZ8T2kp07wHnazuBusF7GqqmVLyDoOzK7E7gJENSFOWK09d8hUrbS90qZ4GRMD
         FMgizorPc/3nGT5FJR+yohFLJFGZ+DnSgqyg18ScVwxWDJ74d8mp+j7j3aY7fa+uiqfO
         q+/+ANkPK+lVMXgBe4oJZieFcR8lq+T5j95T09/2zjMpBtzyNbj2YJboei4g/3iewDab
         rjPZIzVYZA9HrDpvR7fBeXW4x2mbRCU4RYqxvcimVlgkfUfVbSd8AT14K48yE4Opy9Bs
         iFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njvPKH08ymkyNzwJyzg8QpiuMjxRS5rv01R2//2tiAI=;
        b=JK5BuP8lGgG2/OsZ9V3XlP3swWKUcl4oO0Y+H1iHalUtpe3OscbjKmCfHAivYaCAd/
         chBncrxP33RvOOW1+QilnfgvZR6/VuawODSmLfHshL1VaWUR5fO8QTUDJ6lAE7199koU
         K62H6KOXlImJAWTMRUKfe8JN6/xcsmLmzXXoFVGF7ebROtux/ZGfm2jCRAG6b/xM5oEs
         Bz/BKEm6BQNBmkWz8nizTr4gF/+JSnJFI7T4CYRgj3skuKUAS7Z5kZzEeAnUyQLcI4AK
         GPGAWJ+GRrtwtOJFq1EXUN7gD+WYKycOko0nk/AaBUEtB5OGpdNUogX+01m3uTqx8eXM
         AO0Q==
X-Gm-Message-State: AGRZ1gL8nJt3jQ809SL1I3e7WBVzW1I/+eE4gUR7ZKv7O6bXJwRQ68jp
        GgEhz//+RbZivsi03CM6SbjUv3gQjX+V2QTOj0Om
X-Google-Smtp-Source: ACcGV61JdjbP/NJZ1FvAKYPAxpqevRbF5JSFuQDGvPX4bqpxF5phycqocsJ1JyTb/djldGGz7CD4Tsk4fqBhZ22Bn2g=
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr4930982lja.77.1539991065829;
 Fri, 19 Oct 2018 16:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <e41cb6760a8183c0955c378fce7b500819f9838f.1533065887.git.rgb@redhat.com>
In-Reply-To: <e41cb6760a8183c0955c378fce7b500819f9838f.1533065887.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Oct 2018 19:17:34 -0400
Message-ID: <CAHC9VhRPMAUsgs2zXkPEFZPQS6dmAO1-kBX1Y-7tRkD-kwGEjw@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 06/10] audit: add containerid
 support for tty_audit
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

On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add audit container identifier auxiliary record to tty logging rule
> event standalone records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  drivers/tty/tty_audit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> index 50f567b..3e21477 100644
> --- a/drivers/tty/tty_audit.c
> +++ b/drivers/tty/tty_audit.c
> @@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
>         uid_t uid = from_kuid(&init_user_ns, task_uid(tsk));
>         uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(tsk));
>         unsigned int sessionid = audit_get_sessionid(tsk);
> +       struct audit_context *context = audit_alloc_local(GFP_KERNEL);
>
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

Since I never polished up my task_struct/current fix patch enough to
get it past RFC status during this development window (new job, stolen
laptop, etc.) *and* it looks like you are going to need at least one
more respin of this patchset, go ahead and fix this patch to use
current instead of generating a local context.  I'll deal with the
merge fallout if/when it happens.

Local contexts are a last resort.  If you ever find yourself writing
code that generates a local context, you should first be 100% certain
that the event is not the the result of a process initiated action (in
which case it should take from the task's context).

--
paul moore
www.paul-moore.com
