Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA1E2793C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xwiQ69Yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA1E2793C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754983AbeF1Vrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:47:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40416 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeF1Vrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:47:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id a6-v6so5677860ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f67PvkYiEk5xCLciD0OHrN2WWriiPzjecH1ypaYUkzo=;
        b=xwiQ69YpaaugojpkFbdulXKcOvX0YymaKrHUZRuEbs63hk7bbmzbjLhHaNvTEJbjjr
         WFyJ5PegCbrgORMSOMt1z3NzIw4pdkc7xBGdH6gBvL+tM8vEMKCCeObZpORjOHuADVKM
         /Zw2jWfp1DoaaFPBH0WDlhTYxAWwqgcta2p0zOzPccbRd/af6fYGoojcQGFjilR/d4pZ
         /njYIO1K1fg9Gg2ks7KGTQ+MO+LKXomTGRaIlNoHT9bQ6dkwB7M+ScO2Ck1HNCDDUDgR
         zjRsmxCmii4S+2D3ISfqOEBegsh4A7JtKl2oiqnWugY6PFgzmzCYrvl+tbT4SIGHdw19
         l4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f67PvkYiEk5xCLciD0OHrN2WWriiPzjecH1ypaYUkzo=;
        b=TMs4Nw9bgduC+k0yv4fMC3jCu4Dgh2Ic5y1RB0kk4KDM2WuV/2MbMuGyeQlAatgE5o
         1CMDdiTyTOebIIBJg/aOgfoVrAv1BpOLiJIz4ueWjI9bNV+7FE80itI6zgg4Vmepu+CQ
         cjXZ2algqhIBLD8/hy2W8D9fH3ugJYUTyV0+MzX2Lx3icKHKPrrPyTa8bKX4cuJaFBwb
         yjwUM0XbIDT+HpndBwunGNoVHy9nwE1iHJjg7KDmksgI7TC483nG4NpZOJyDk8LYB3sP
         RkRN9I8k66gl5rsabWoH3XNn5BZYBkLHcuAmSVYeQQdxMBjbuerzgQrKcoITw/jzpSPC
         zpmQ==
X-Gm-Message-State: APt69E1cG9sl1EsVh2SMprdFtHoJHn0dLElvU9ARElym1yuap24jwwmE
        QzZ8h7mrRstasv42wFjLVPfMAaHMmrsnYgx8Quik
X-Google-Smtp-Source: AAOMgpex4KeunfN6ZXg8ccM0OXlO9EAhSNDZXG0Omn2MvGZsPhWKZqXOqg5Sh4KtauS0Z8bVKztEcyMqMYZMeNjMTGE=
X-Received: by 2002:a2e:4d51:: with SMTP id a78-v6mr6434450ljb.106.1530222452035;
 Thu, 28 Jun 2018 14:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <244a8049197a23b0cee37dc3f00d070e646fd1b7.1529003588.git.rgb@redhat.com>
In-Reply-To: <244a8049197a23b0cee37dc3f00d070e646fd1b7.1529003588.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 17:47:21 -0400
Message-ID: <CAHC9VhTNOgpOAhi893v7EsMiYXDP47YYXUEcEnpexO+t1i7BgA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 2/6] audit: add syscall information to
 CONFIG_CHANGE records
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
>
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

Merged, thanks.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index ad54339..e469234 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -400,7 +400,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>         struct audit_buffer *ab;
>         int rc = 0;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return rc;
>         audit_log_format(ab, "op=set %s=%u old=%u", function_name, new, old);
> @@ -1067,7 +1067,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>                 return;
>         }
>
> -       *ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
> +       *ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
>         if (unlikely(!*ab))
>                 return;
>         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 52f368b..1640eb6 100644
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
> index 5e9d1e5..a01b9da 100644
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
> index 9b4836b..da2978b 100644
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
> index eaa3201..6e19acb 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1093,7 +1093,7 @@ static void audit_log_rule_change(char *action, struct audit_krule *rule, int re
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
