Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7300C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5683720652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xu/h+IOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfARW60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:58:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38317 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfARW6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:58:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so12979241lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMgyORIPEQW5c+fPfBkW1Jz0A+xJk3a8mMoVQKhURRE=;
        b=xu/h+IOLOBSIURFeAiBE1WjbEZZV29ftF4fJMDIY/7oA0c8SBZY12rgMKyi6aG4Tck
         h51NX2U9luIz4hBC3ZcDjKlZaCuSqZfkGv9rnGqJiJNxFnwmRG+3+Lm/1o7TTpPqAJCb
         HlIwqkdkeDbOZl7rpkUB3ZVnNvUikbouwl+JrR8U8GNn4S4M5dWu3DQIRYxsxPehC+dI
         ZwFx9/mJ62I5KOZ9V3AbUWUjaBcxWWGBXKA8RhDfjZlf6EExfYRMZN8uKPAQdLOrsR8x
         ecKRgWsktqweIqKgJIoEBZmZexpGzBXv7Wg0c0kJUfPQrgygH3GGp1WJBDU6g/EZ3/Vy
         tzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMgyORIPEQW5c+fPfBkW1Jz0A+xJk3a8mMoVQKhURRE=;
        b=IPgs3xZwIzyhazAZ4mhOANSxda8eOGCmkLBwzjL931W2hlKpPx98Il9JYxIQTdfcZu
         khDPGI/vkaIyS1s3R59fSmpXZ5FMeEmrLk7yyZlGjRufhzNyOqLpV4Aq9F4KpyeBZn3d
         SKAScQfNoRVs7WG5KIIMDdJ+agJtGs4QYjp3msnlR5pkMExnNWcOzHNXLZI+7mmzUpKC
         2s53y8YjZYYk3iO5HCGs5JEERFVBOxuyCjnxl73VluDaMl5JCSHOWSP0VvgzmcGNT7u0
         fFQNB9mVHzFXSpEvfVm8uXKokeEz39XvPGRb/r7Jv6q94ipkyNZRXdEIe4+us8RmSHQs
         Qn+Q==
X-Gm-Message-State: AJcUukd35PAjD+drfbER+1gJxeeKR1Su3nUNfZ111/kSqW5gLsc2V54a
        IiGDermSsbJe0cHRTGHXMrJeagpipqUCspoNtsK+
X-Google-Smtp-Source: ALg8bN5TO8KbUYpE+ToMrP6uD/35FowvjYRwBSTuh1PeOpScAx2RqknHzntkSER6eCfXGSWydvDjmVSNlaeCEiCuPi4=
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr12815034ljh.42.1547852302430;
 Fri, 18 Jan 2019 14:58:22 -0800 (PST)
MIME-Version: 1.0
References: <dc7ef993460ee145eb5cc897ba6e2d84db50bafc.1547826963.git.rgb@redhat.com>
In-Reply-To: <dc7ef993460ee145eb5cc897ba6e2d84db50bafc.1547826963.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Jan 2019 17:58:11 -0500
Message-ID: <CAHC9VhTmkxaFQ7OshYw22d77hVJU=5M446vyGTw_zLvw8tPdbg@mail.gmail.com>
Subject: Re: [PATCH ghak59 V4] audit: add syscall information to CONFIG_CHANGE records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Tie syscall information to all CONFIG_CHANGE calls since they are all a
> result of user actions.
>
> Exclude user records from syscall context:
> Since the function audit_log_common_recv_msg() is shared by a number of
> AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> syscall accompanied record type, special-case the AUDIT_USER_* range of
> messages so they remain standalone records.
>
> See: https://github.com/linux-audit/audit-kernel/issues/59
> See: https://github.com/linux-audit/audit-kernel/issues/50
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Changelog:
> v4:
> - rebase on v5.0-rc1
> - remove audit_log_config_change_alt() and call
>   audit_log_common_recv_msg() directly
> - remove audit_tree_log_remove_rule() change superceded by patch v3-3/4
>
> Passes audit-testsuite, no issues identified with ausearch-test.
>
>  kernel/audit.c          | 27 ++++++++++++++++++---------
>  kernel/audit_fsnotify.c |  2 +-
>  kernel/audit_watch.c    |  2 +-
>  kernel/auditfilter.c    |  2 +-
>  4 files changed, 21 insertions(+), 12 deletions(-)

Good timing, this hit my inbox just as I was making one last pass
before dinner.  Looks good to me, merged into audit/next.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index d412fb4ae6d5..ca55ccb46b76 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -396,7 +396,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>         struct audit_buffer *ab;
>         int rc = 0;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return rc;
>         audit_log_format(ab, "op=set %s=%u old=%u ", function_name, new, old);
> @@ -1053,7 +1053,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
>         return err;
>  }
>
> -static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +static void audit_log_common_recv_msg(struct audit_context *context,
> +                                       struct audit_buffer **ab, u16 msg_type)
>  {
>         uid_t uid = from_kuid(&init_user_ns, current_uid());
>         pid_t pid = task_tgid_nr(current);
> @@ -1063,7 +1064,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>                 return;
>         }
>
> -       *ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
> +       *ab = audit_log_start(context, GFP_KERNEL, msg_type);
>         if (unlikely(!*ab))
>                 return;
>         audit_log_format(*ab, "pid=%d uid=%u ", pid, uid);
> @@ -1071,6 +1072,11 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>         audit_log_task_context(*ab);
>  }
>
> +static inline void audit_log_user_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +{
> +       audit_log_common_recv_msg(NULL, ab, msg_type);
> +}
> +
>  int is_audit_feature_set(int i)
>  {
>         return af.features & AUDIT_FEATURE_TO_MASK(i);
> @@ -1338,7 +1344,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 if (err)
>                                         break;
>                         }
> -                       audit_log_common_recv_msg(&ab, msg_type);
> +                       audit_log_user_recv_msg(&ab, msg_type);
>                         if (msg_type != AUDIT_USER_TTY)
>                                 audit_log_format(ab, " msg='%.*s'",
>                                                  AUDIT_MESSAGE_TEXT_MAX,
> @@ -1361,7 +1367,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 if (nlmsg_len(nlh) < sizeof(struct audit_rule_data))
>                         return -EINVAL;
>                 if (audit_enabled == AUDIT_LOCKED) {
> -                       audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +                       audit_log_common_recv_msg(audit_context(), &ab,
> +                                                 AUDIT_CONFIG_CHANGE);
>                         audit_log_format(ab, " op=%s audit_enabled=%d res=0",
>                                          msg_type == AUDIT_ADD_RULE ?
>                                                 "add_rule" : "remove_rule",
> @@ -1376,7 +1383,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 break;
>         case AUDIT_TRIM:
>                 audit_trim_trees();
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(audit_context(), &ab,
> +                                         AUDIT_CONFIG_CHANGE);
>                 audit_log_format(ab, " op=trim res=1");
>                 audit_log_end(ab);
>                 break;
> @@ -1406,8 +1414,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 /* OK, here comes... */
>                 err = audit_tag_tree(old, new);
>
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> -
> +               audit_log_common_recv_msg(audit_context(), &ab,
> +                                         AUDIT_CONFIG_CHANGE);
>                 audit_log_format(ab, " op=make_equiv old=");
>                 audit_log_untrustedstring(ab, old);
>                 audit_log_format(ab, " new=");
> @@ -1474,7 +1482,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                 old.enabled = t & AUDIT_TTY_ENABLE;
>                 old.log_passwd = !!(t & AUDIT_TTY_LOG_PASSWD);
>
> -               audit_log_common_recv_msg(&ab, AUDIT_CONFIG_CHANGE);
> +               audit_log_common_recv_msg(audit_context(), &ab,
> +                                         AUDIT_CONFIG_CHANGE);
>                 audit_log_format(ab, " op=tty_set old-enabled=%d new-enabled=%d"
>                                  " old-log_passwd=%d new-log_passwd=%d res=%d",
>                                  old.enabled, s.enabled, old.log_passwd,
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index cf4512a33675..37ae95cfb7f4 100644
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
>         audit_log_session_info(ab);
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 20ef9ba134b0..e8d1adeb2223 100644
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
>         audit_log_session_info(ab);
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index bf309f2592c4..26a80a9d43a9 100644
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
