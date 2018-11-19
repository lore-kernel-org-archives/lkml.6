Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108292086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jr68ydsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108292086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbeKTEas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:30:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38060 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbeKTC4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so13887649lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADHfZzXISaE1BGAlj0ZRvByg4hnEeXMd0eZAa7Q0VMw=;
        b=jr68ydsBkb1mt8w9OXTK1cWxBPP1FWEgC0GmqMxm713cdOnDcoPwgor75KVBeV3BvE
         cdvlwudcbhjV8EWXcgI03LsyZVB/B2kIbr9RM87KCTpvke+mNcruMibgG6Mh6muds10U
         WYOTTqgS4abHjVMZzNR6oveuMJ3eAc9bgZ0ffArvOfvdBGDzPKhD75dz1p8w6VIHQT4W
         jebVvKKZt5+b+dfGM0J9yabUYoQKj5/8I9jetingGB7uK7lH8U1QT4jQpIRPub43hWhi
         oKHmHWXpTeCzqroQJVXl6injQXlZTWV6lmY+ty0bWVkyqhlxw4ugSbrr2n/qSUs4D4Ad
         H3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADHfZzXISaE1BGAlj0ZRvByg4hnEeXMd0eZAa7Q0VMw=;
        b=C3bv+xZez9uVjYZMVJbKteyyvUGV1AMdCCdLX4o9sNlOyKJcluyH5i0We8vo7lIawj
         M764St8p99/PR/hBdz9wM+NZnKpRsZaK0T++bnd00S972e9rWnr98Y//ilY0+zx43RFZ
         Ze7rI6NjpBuNfpk+QWj+ZwTrA1H1Hy6cNJiMhGwcji571pX47UOT4pn6KV1NO9jOchsU
         1Btb0Bq/26hwpVlAwsMCg13m5hFcUrIjbWhOP2gTZwWrxPBt6SuIkIgxWS+I7m95NXMa
         eseVnQ/ZYVFysuDgHZpINTfsEQPieaARZziZS13lJXTBLLn1xwFlod5IFkTLLjwy1Hhd
         zStA==
X-Gm-Message-State: AA+aEWYIEq2tbA8mSnAaIf7vwTuQVhq7lN4xQZjnCufTr2OQrePJX5bq
        VmMbv3IWlcc85Q20hZgP14yFLz90viIOmrplCU4U
X-Google-Smtp-Source: AFSGD/X3NEITbFt9R66PAiNYegc8LJsixxDlR63ZXIdCob4pjpgM4+y8gdpUOc3AcN5j+Y3ZqMqG5hXN2fOJP5FhCt4=
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr1383553lji.145.1542645147069;
 Mon, 19 Nov 2018 08:32:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1532709911.git.rgb@redhat.com> <64557e69dc228577eee0de48409b017da7093920.1532709911.git.rgb@redhat.com>
In-Reply-To: <64557e69dc228577eee0de48409b017da7093920.1532709911.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 11:32:15 -0500
Message-ID: <CAHC9VhR6KLQ+-NsfEY9g8AHgto_fCLS8e6fBzxOM-Nu9tz2ZPA@mail.gmail.com>
Subject: Re: [PATCH ghak59 V2 2/6] audit: add syscall information to
 CONFIG_CHANGE records
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
> Tie syscall information to all CONFIG_CHANGE calls since they are all a
> result of user actions.
>
> See: https://github.com/linux-audit/audit-kernel/issues/59
> See: https://github.com/linux-audit/audit-kernel/issues/50
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c          | 4 ++--
>  kernel/audit_fsnotify.c | 2 +-
>  kernel/audit_tree.c     | 2 +-
>  kernel/audit_watch.c    | 2 +-
>  kernel/auditfilter.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

See my comments in patch 3/6.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 1ed8723..6cfe3c9 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -397,7 +397,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>         struct audit_buffer *ab;
>         int rc = 0;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return rc;
>         audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
> @@ -1064,7 +1064,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>                 return;
>         }
>
> -       *ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
> +       *ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
>         if (unlikely(!*ab))
>                 return;
>         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index fba7804..ae5c89b 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -127,7 +127,7 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
>
>         if (!audit_enabled)
>                 return;
> -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
>         audit_log_format(ab, "auid=%u ses=%u op=%s",
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 9f6eaeb..f0b7d30 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -499,7 +499,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
>
>         if (!audit_enabled)
>                 return;
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
>         audit_log_format(ab, "op=remove_rule");
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 787c7af..26c2fae 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -242,7 +242,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
>
>         if (!audit_enabled)
>                 return;
> -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_NOFS, AUDIT_CONFIG_CHANGE);
>         if (!ab)
>                 return;
>         audit_log_format(ab, "auid=%u ses=%u op=%s",
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index bf309f2..26a80a9 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1091,7 +1091,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
>         if (!audit_enabled)
>                 return;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (!ab)
>                 return;
>         audit_log_session_info(ab);
> --
> 1.8.3.1
>


--
paul moore
www.paul-moore.com
