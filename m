Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E153C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A4127A28
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KnEZUpxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A4127A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967325AbeF1WLu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:11:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39657 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966704AbeF1WLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:11:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id t7-v6so5710473ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58qtdp4UqF31JOEv4yzW8gtTlX6/Iitkr8ZN+3mTlyA=;
        b=KnEZUpxg8QPe2yiJsvTJP6KTbkBWH9K1YDS12MgSg4/pTXGc+19y5TYQPpGKduXpcl
         Y1sBuSKLMI3OuVI0XeZI8jz4ibCWiVok57ZFNH40SNO6d0MiSk89kGqjxDG5Wad/aJov
         p9XEBf+7LAB1QiIZml4sLleSeiTKzOEdEAZKuhGEuwNLXJwJMgR/htun2+MpxsesNrwF
         kuXmeugDPq38M3G2bR3nTYMNgwnpWIVbaFmXUwzgOLbSZNGeBDfCf0xbtbBbEuARnPYp
         s1E8BoEIyihvC5OkWwFsKGZfIvYUEMjtC+Ac4KQ+D934nXnjeY70kNgNNWmEBIk6X5EW
         2rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58qtdp4UqF31JOEv4yzW8gtTlX6/Iitkr8ZN+3mTlyA=;
        b=jVPRI55tvaLlLWDuxz4NlguNyaoPB0E6D3ktXNhIpi6NeK9r5gB7acFFV1n8n/OBdi
         2qtFgT7LyT2jokmucE3rxh8kJypJ+6YESsRXVVn2skmdnuh6arlrDlIW7oDmNw/xr8zJ
         VurzzE12OcCRXxFRkMKpVn+mIIgC4QJg/Hru9Cks14jM47PZScS+rVDlFs4Z5wlbA1st
         NU1MDbCXRN4R7S/c5saASXrGr2yYITGwjROP59OoR7Xtr9VwlAzMDarOGjvZlF7/lLma
         O/QN2PPXlu950z2TUl9QBsTdXsok/+TpDIjwKsotNxRhGSPlEeV4oPoIE+8zpUlhKxbd
         YDXQ==
X-Gm-Message-State: APt69E3yJRD0m9tXv/8InDlkfmsTc24RLLL2l4CtEUzGfw/gfNj4YfRp
        GlfrfLLPvOaI6fGM916JTC8kc17EYwBDGdk2EltKZHk=
X-Google-Smtp-Source: AAOMgpdtP0nL+9aFocUQdIjdOC8KrzotozvEWh2cqgWOqa/kPpFno7b/fB2Rnvfa7ZehMRNWxLy/ATJIxfqsZN6gamo=
X-Received: by 2002:a2e:18b:: with SMTP id f11-v6mr8153964lji.83.1530223907734;
 Thu, 28 Jun 2018 15:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <907e32319825bb6336a662f4f6f6d173f56f3226.1529003588.git.rgb@redhat.com>
In-Reply-To: <907e32319825bb6336a662f4f6f6d173f56f3226.1529003588.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 18:11:36 -0400
Message-ID: <CAHC9VhSKcxHScr-ZNQU3iVrqhU4CDKW7tpn3e+NBKAAmnpRP4g@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 3/6] audit: exclude user records from
 syscall context
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
> Since the function audit_log_common_recv_msg() is shared by a number of
> AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> syscall accompanied record type, special-case the AUDIT_USER_* range of
> messages so they remain standalone records.
>
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

I think this is fine, but see my previous comment about combining 2/6
and 3/6 as a safety measure.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index e469234..c8c2efc 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1057,7 +1057,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
>         return err;
>  }
>
> -static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +static void __audit_log_common_recv_msg(struct audit_context *context,
> +                                       struct audit_buffer **ab, u16 msg_type)
>  {
>         uid_t uid = from_kuid(&init_user_ns, current_uid());
>         pid_t pid = task_tgid_nr(current);
> @@ -1067,7 +1068,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>                 return;
>         }
>
> -       *ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
> +       *ab = audit_log_start(context, GFP_KERNEL, msg_type);
>         if (unlikely(!*ab))
>                 return;
>         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> @@ -1075,6 +1076,11 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>         audit_log_task_context(*ab);
>  }
>
> +static inline void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +{
> +       __audit_log_common_recv_msg(audit_context(), ab, msg_type);
> +}
> +
>  int is_audit_feature_set(int i)
>  {
>         return af.features & AUDIT_FEATURE_TO_MASK(i);
> @@ -1341,7 +1347,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 if (err)
>                                         break;
>                         }
> -                       audit_log_common_recv_msg(&ab, msg_type);
> +                       __audit_log_common_recv_msg(NULL, &ab, msg_type);
>                         if (msg_type != AUDIT_USER_TTY)
>                                 audit_log_format(ab, " msg='%.*s'",
>                                                  AUDIT_MESSAGE_TEXT_MAX,
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
