Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EA4206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWVEATBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EA4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeLEHP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:15:58 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41437 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeLEHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:15:57 -0500
Received: by mail-yb1-f194.google.com with SMTP id t13-v6so7988653ybb.8;
        Tue, 04 Dec 2018 23:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXxsXfTfG3CNAnc19/0DDN7ewLtniV7F2zCpd9uIs8Y=;
        b=GWVEATBtB3SraO8+PJXPKZ54N+JbUguSEDH8O3z8++/wdfOyNttc9i9wGr6X1GuDK+
         zfrNiMhU8YPe/mBXThZKwZqi6s8yEgIP3yHbPCR8tCpUxpqxmDpj66yf34xiyCLlSC7u
         eTbCqFmJIt18T+w+MPKGAcgwww8mdJCOr92q6xrD+7MScn2OeSSgmDSZUTjAc26eLgCc
         NK6i8BVnzf2gntfZmmyHuqJ3MwHlcmGKUFYBAwFOV34dPj/0n5sLX9uEQqx+aPgtjUSj
         3WGmeJlt+sTVePlSRjTyZAvwSrV3+06id/dAFpvtpT4JOYXpQTFzhbOEs+4xQZLCf/Qk
         IjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXxsXfTfG3CNAnc19/0DDN7ewLtniV7F2zCpd9uIs8Y=;
        b=RWa73XSXJYVHvlWwc0u4vUPtDgUpc4EJxuwrdeiWBmIPZj/KlnT0TKScxoUAdku2Va
         0Lq88Zg1iFXv8ZwUEl2bt6ayvIjeS0xeI4Cyz09rbec1EKRWaZyQzqIYjfmz8Ny8M0co
         5WfmnKKndvuHdieTeI3Jei02NT8rT2mkVaPChpw6zAQe3Ypgii55qRMRjBLoBAaKFZfD
         G0kyzPyf2mMTNpwfGM3yyjmw5IUbP63cVUE5fNELBQu6plZhYl5tX3gE4KCqwDgDuAWj
         i9P/Iu0BxuBvaQ4eNeQygTuJ3a/miR6aXUQAW94ya7urZj6zLTqqcopLvXBRUCCZ+9uo
         9FMA==
X-Gm-Message-State: AA+aEWZCrRF/eds6ZSZzO0dG4fODLby7y3t+wBl5e4wGtsoRXTsDB9dc
        ce+QBE5g8uhFZoF+MmoDrsESE3iV0D0jX7MiQFMeUSYD
X-Google-Smtp-Source: AFSGD/Uy/3WzJoyDn7Bj0kJO8pGEfYKFyu/KkvkQM74dS80JYX/rzrWRo8ssZlUo+qSoqB0e2fyGD+7LEDnCvdvV+U8=
X-Received: by 2002:a25:b002:: with SMTP id q2-v6mr23367985ybf.397.1543994156675;
 Tue, 04 Dec 2018 23:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20181204234446.GA4676@beast>
In-Reply-To: <20181204234446.GA4676@beast>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 Dec 2018 09:15:44 +0200
Message-ID: <CAOQ4uxg3jaQWpRNxSRuT2VRvAcQTNkBLVr3GPtX3ekQPE7k-Dg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Make sure to check event_len when copying
To:     keescook@chromium.org
Cc:     Jan Kara <jack@suse.cz>, xypron.glpk@gmx.de,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> As a precaution, make sure we check event_len when copying to userspace.
> Based on old feedback: https://lkml.kernel.org/r/542D9FE5.3010009@gmx.de
>

This precaution serves the new fanotify_event_info_fid format well:
https://marc.info/?l=linux-fsdevel&m=154375073318106&w=2
but also conflicts with my series.

I can weave your patch into my series and add a similar sanity check in
copy_fid_to_user() or if Jan applies your patch and has more comments
on my v4 series, I'll rebase on top of that.

Thanks,
Amir.

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/notify/fanotify/fanotify_user.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index e03be5071362..d9484a0ac6b3 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -206,7 +206,7 @@ static int process_access_response(struct fsnotify_group *group,
>
>  static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                                   struct fsnotify_event *event,
> -                                 char __user *buf)
> +                                 char __user *buf, size_t count)
>  {
>         struct fanotify_event_metadata fanotify_event_metadata;
>         struct file *f;
> @@ -220,6 +220,12 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>
>         fd = fanotify_event_metadata.fd;
>         ret = -EFAULT;
> +       /*
> +        * Sanity check copy size in case get_one_event() and
> +        * fill_event_metadata() event_len sizes ever get out of sync.
> +        */
> +       if (WARN_ON_ONCE(fanotify_event_metadata.event_len > count))
> +               goto out_close_fd;
>         if (copy_to_user(buf, &fanotify_event_metadata,
>                          fanotify_event_metadata.event_len))
>                 goto out_close_fd;
> @@ -295,7 +301,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>                         continue;
>                 }
>
> -               ret = copy_event_to_user(group, kevent, buf);
> +               ret = copy_event_to_user(group, kevent, buf, count);
>                 if (unlikely(ret == -EOPENSTALE)) {
>                         /*
>                          * We cannot report events with stale fd so drop it.
> --
> 2.17.1
>
>
> --
> Kees Cook
