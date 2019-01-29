Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4EDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90972054F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="L24tgm8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfA2XHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:07:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34226 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfA2XHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:07:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so19094720lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YiFo/KWLbYF17Zahp6M5hoF9xqDg038FPd6cnIkHZA=;
        b=L24tgm8ebCOaH0RJw2iaDFsCfESsrXIr9HVU9FnQYNuI6I43b2/+Riji2dQcY5UDsQ
         jNMXURlTe4OK4Zg6EaJdf9/6UBFIPXkIPI6txDB7VwzRDTe8SdLjW5G8l7QJfE0gEsAU
         6xI6dLmHGNt81Czy2vGz1vkbl3rBlSY5aY8JXMbfUpSnbHrP+UkwbJcZhl1do2uBFUPc
         /3G5xrr9PPoehGW2qu7v0iEQBAlVgs5JUHTj77xfaT/9o1ZjJgXjGZeivilD15ttkp3d
         a28TRB7B5L/iZZ1DKlF/UeohxabntqcXE2qN6PGk+vJCYeqE+AP1Nc/fHN8PoqqwLjrn
         DdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YiFo/KWLbYF17Zahp6M5hoF9xqDg038FPd6cnIkHZA=;
        b=kAvN4qWAOCoDfHibLyrBI3xhKEJwNtYs/z39UfgRQkLGMadkEhQ8sl6EEuwhA7REL+
         naZh08Agq6pxEDKHtixTF0BFdKaZ2OTt/yIp1C/TrtU9vQJZ2HrYh4mkMan+jtzhOAaU
         SDeb+ySEey0jdMgeciG/6RfFP8SvBZVeiZ8FCsc6wAQ27ws5T0DxVg6fz5lIm1osPPCn
         30DiZofiow4ulnrWCVzH64uEDitQGxTNNwl23KiUu+TJ/Od3pIyK9DSHRk5XY/C3TAtI
         v4914vnPocf/qoHn7NDtMf3D0OHohOK2m2cwZMY7vN3zF+SGJ7/0qJy2aqVlqJ0/Kva7
         lg1A==
X-Gm-Message-State: AHQUAuZsPW+Uk1izEBNgAL2k2raD+CSNFdWop9s6VsHyV74x/a4O+qud
        +pK6Eh2H3R1ylWnMs2jqMOhk2jCK03P3xoftymef
X-Google-Smtp-Source: AHgI3IbhoaRjbX9M//fhafOF/2GJtCsX/JUQ6FgzsNTXjTjtAUx/DVU4ckJEMKn6a/RozWPTGNHBz4JBk4w/oQVLhmQ=
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr6689933ljc.38.1548803253883;
 Tue, 29 Jan 2019 15:07:33 -0800 (PST)
MIME-Version: 1.0
References: <6378bddc2ca871615ebbdaffe17ee0b4482c44a0.1548700115.git.rgb@redhat.com>
In-Reply-To: <6378bddc2ca871615ebbdaffe17ee0b4482c44a0.1548700115.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jan 2019 18:07:22 -0500
Message-ID: <CAHC9VhQkLAgEUf6Rc6ovDyiJuNvm6PaKp0gGzDus6nkKDekWww@mail.gmail.com>
Subject: Re: [PATCH ghak105 V2] audit: remove audit_context when CONFIG_ AUDIT
 and not AUDITSYSCALL
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 1:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Remove audit_context from struct task_struct and struct audit_buffer
> when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.
>
> Also, audit_log_name() (and supporting inode and fcaps functions) should
> have been put back in auditsc.c when soft and hard link logging was
> normalized since it is only used by syscall auditing.
>
> See github issue https://github.com/linux-audit/audit-kernel/issues/105
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Changelog:
> v2:
> - resolve merge conflicts from rebase on upstreamed ghak103 patch
> - wrap task_struct audit_context in CONFIG_AUDITSYSCALL
>
>  include/linux/sched.h |   4 +-
>  kernel/audit.c        | 157 +++-----------------------------------------------
>  kernel/audit.h        |   9 ---
>  kernel/auditsc.c      | 150 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 161 insertions(+), 159 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 3f3f1888cac7..15e41603fd34 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -205,7 +205,9 @@ struct audit_net {
>   * use simultaneously. */
>  struct audit_buffer {
>         struct sk_buff       *skb;      /* formatted skb ready to send */
> +#ifdef CONFIG_AUDITSYSCALL
>         struct audit_context *ctx;      /* NULL or associated context */
> +#endif
>         gfp_t                gfp_mask;
>  };
>
> @@ -1696,7 +1698,9 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
>         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
>                 goto err;
>
> +#ifdef CONFIG_AUDITSYSCALL
>         ab->ctx = ctx;
> +#endif

I vaguely remember reading/hearing something in the past about
kmem_cache_alloc() not returning a zero'd out buffer in all cases, can
you say for certain that "ab" in this case is always going to be
zero'd out?  This is an honest question.

If we can't guarantee that "ab" is zero'd out, we should manually set
ab->ctx to NULL when !CONFIG_AUDITSYSCALL.

>         ab->gfp_mask = gfp_mask;
>
>         return ab;
> @@ -1809,7 +1813,11 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>                 return NULL;
>         }
>
> +#ifdef CONFIG_AUDITSYSCALL
>         audit_get_stamp(ab->ctx, &t, &serial);
> +#else
> +       audit_get_stamp(NULL, &t, &serial);
> +#endif

If ab->ctx is NULL we don't really need this, do we?

>         audit_log_format(ab, "audit(%llu.%03lu:%u): ",
>                          (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
>

-- 
paul moore
www.paul-moore.com
