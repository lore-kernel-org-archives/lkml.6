Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D548C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386042081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDqKkVUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386042081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeLARw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:52:26 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46386 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLARw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:52:26 -0500
Received: by mail-yb1-f195.google.com with SMTP id x130-v6so3082121ybg.13;
        Fri, 30 Nov 2018 22:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJqXubT790RG2gv0vreC1tJ/s8pg7Do38WZfqD9flMo=;
        b=ZDqKkVUHG0ZH14jixCwFrhbBgXPENrIEhb0NZHsJRpLXO7+flp3vpJmmvso3rPmDy4
         Q/3yaffPIgHs11uCo5tmSXdyUQvRKY9ecxpgzjst86kqdumTqIIaU1/gZi8lGwDse3Og
         sMLae3vLJEq/mBTzWdIQJ+uMoTw0kPChcMLaQzI1WAzKALi9cT4Z/zNcUKK2fTsSM7yZ
         +8K0sV0M/FNCNHPCf07Q5FYk/hYl3navgw8B2ZCnE0Tl01zcy320/3XRUrgFFYfr3iwL
         vYl9j56KOs1xzgoPSdYBRoPAHimA9uWA85yl8Mkm9QM7wI38chMkfATkLzzIqG7OBG9u
         pcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJqXubT790RG2gv0vreC1tJ/s8pg7Do38WZfqD9flMo=;
        b=MiSCL+Pk3Fd0Q6GoObunUpP/FDqgYiQmW3H1Qf9yT2gWDXwitrS/zVg4+gwRr/z7AN
         nTJSdVVacw0sd8rmPXGPZgYDyEOWmzJPC3SVQyART7U+4VXzF+YK/voGTA4mARIT3XVe
         INrSqHDFXAZGCQcsUCSaSrXt8IkO2gFp4vxSeGGRaEOQn8YOa7meDIpSRQuEzktgCcxr
         c6k/HFA+4CBTSnQVlJ9+S3UJ50+UWA4me08VeoqCV6V2/iQCLKGwGuQf6ZC7Pc+72sjL
         32hEJRxQZyU64ThlwwWTPLzMmNm6qUWC44oM+ZJvFw2D1Uua41dablkEjhfixjilPn4Y
         33MA==
X-Gm-Message-State: AA+aEWYD1+YtAg2UDZn7jwR8s3u0kGKRS6vWPCCvQ7gFVpRBCec1BJ51
        ZNoieKHoycBam26MH+KsvrnFCOczM2IMnd4DVvNvVNIo
X-Google-Smtp-Source: AFSGD/Way6HT6Rb+TQG/yc5qfNP+iKfgORcBv0tdQwrjf+GnVtt/JdKUSrWdqHoxuLHvQ2bLNh/PcP7f/D29Q8dVecI=
X-Received: by 2002:a25:b002:: with SMTP id q2-v6mr8661271ybf.397.1543646436602;
 Fri, 30 Nov 2018 22:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-13-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181130192737.15053-13-jarkko.sakkinen@linux.intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Dec 2018 08:40:25 +0200
Message-ID: <CAOQ4uxiXqt+r64mtJUejzq6JTMcH-DYPsd609SdqWj5UOfZUjw@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] inotify: replace **** with a hug
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 9:27 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  fs/notify/inotify/inotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 105576daca4a..db0b3b6d6a58 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -446,7 +446,7 @@ static void inotify_remove_from_idr(struct fsnotify_group *group,
>         /*
>          * We found an mark in the idr at the right wd, but it's
>          * not the mark we were told to remove.  eparis seriously
> -        * fucked up somewhere.
> +        * hugged up somewhere.
>          */
>         if (unlikely(found_i_mark != i_mark)) {
>                 WARN_ONCE(1, "%s: i_mark=%p i_mark->wd=%d i_mark->group=%p "


LoL. doesn't shaming conflict with the CoC?
Just remove this sentence - it adds no valuable information.
While at it, please fix grammar "a mark".

BTW, maybe you want to teach checkpatch.pl to alert about this
sort of language...

$ ./scripts/checkpatch.pl ./0001-test.patch
WARNING: 'refered' may be misspelled - perhaps 'referred'?
#4:
Subject: [PATCH] fucked up refered to person

Thanks,
Amir.
