Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64882C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDCD20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vkZEzOyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfANW7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:59:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46424 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfANW7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:59:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id y14so518680lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5DVVvlBscBC6EIYomzKqD7HcRhB/c47Kegc7+dnBU8=;
        b=vkZEzOyrN8qgZ2yRg0AdBzIuYJtOjCrFShNySQmgBpmaBOvtge30S823E1Ow7UgxGR
         ucWxHUWlXb6qp/cn7gZ6U7VAIFnGnFdutA86R0TQRUqW9SHAPQbMC5B81hYLxsOGbCrO
         FqdRYro6xYiQRSsbCa7dHHInAIlhttYISUtwAv18TrPCp6IPUxscdZhamlFBUDy7iw4C
         LIie4gXfyX/SYigtSrjjk8ntoqCF3U+v49trffVUR2KFdvwCGs17z3aunpQImVLfWtS5
         IrGAj+403/0n1qBOvDbs9szYYYrj9kby/ETMNbXwKOU04GmYRtfpiwrXFLVX834f56eu
         Q94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5DVVvlBscBC6EIYomzKqD7HcRhB/c47Kegc7+dnBU8=;
        b=ZfXqPs+itcBU4rDGB0tbwUfwk33Uxxd8ePmwYWps+y/S0RUw1Q/5wjbqVa4MGrBHlz
         NFa5qNFANkVNRGiiaQWwKGKeTLLN1y2lcoQ9S3BxWqBOIMxroxlr8lrPa/aYy8tUmK2M
         1S5pBwHvQLExG3VyhSVC00MC6NbH2ZKtW/L8DhPcgLmctdpqLZCmRsK4uvu6WwW5huQk
         C1WjGdi7am2yUmBX8pANqkLSHj6VMB2/QGpq84VPvvAkB9KrboxoykhPPjpktno/jRdu
         DP16DQNnmMYUuJlPdQzjlvQhHljlB9QQBDUl6gMENA2dEtWnkojI8eqpJ7h3r46w5jnG
         Vitg==
X-Gm-Message-State: AJcUukdWMHj9d8jpeT9xzRQi//qigCKmPdrAvQN3TsNv9SNzh/jUzeNw
        gHUxpbX9oPTi/YEgXX7j99Fhiplk5obAfi7m3RXc
X-Google-Smtp-Source: ALg8bN6DAOMSBNiwxutsSIzxSfCmR090nBRh7M8jdODuXjAQg16qQSwf4xqvnlv3R2pZO8uVn2Hqnw67vE0FGvjFXy4=
X-Received: by 2002:a19:f115:: with SMTP id p21mr576681lfh.20.1547506749653;
 Mon, 14 Jan 2019 14:59:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
In-Reply-To: <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Jan 2019 17:58:58 -0500
Message-ID: <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
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

On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
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
>  kernel/audit.c          | 27 +++++++++++++++++++--------
>  kernel/audit_fsnotify.c |  2 +-
>  kernel/audit_tree.c     |  2 +-
>  kernel/audit_watch.c    |  2 +-
>  kernel/auditfilter.c    |  2 +-
>  5 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 0e8026423fbd..a321fea94cc6 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1072,6 +1073,16 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
>         audit_log_task_context(*ab);
>  }
>
> +static inline void audit_log_user_recv_msg(struct audit_buffer **ab, u16 msg_type)
> +{
> +       audit_log_common_recv_msg(NULL, ab, msg_type);
> +}

This makes sense because this is used by "user" records ...

> +static inline void audit_log_config_change_alt(struct audit_buffer **ab)
> +{
> +       audit_log_common_recv_msg(audit_context(), ab, AUDIT_CONFIG_CHANGE);
> +}

... and I don't believe this makes sense because there is no real
logical grouping with the callers like there is for
audit_log_user_recv_msg().

-- 
paul moore
www.paul-moore.com
