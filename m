Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6D320859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPbI2REp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389979AbfAOUrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:47:51 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35279 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfAOUrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:47:51 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so2537065vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fl69mbl3aeJV852DXL+mW58QS5k6Dpd7g/JVmja/bME=;
        b=OPbI2REp2JERIevczEz3WMraWBonXMUY16IK0bbb/yf8UT6t80Iodm+CLBLJ9gpA2U
         UK7kf+dLnE6GypVIUZbuffN+hOHm47TNl8OPoZvQt0TKINuxi//be1cM9O5G/nkBzoZj
         wcpmOOesNLDjhj+994/dl6yroeKS7pN4uHOZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fl69mbl3aeJV852DXL+mW58QS5k6Dpd7g/JVmja/bME=;
        b=YMpZW+saTZisAs6PxfkcmmKSZ6DfcyK/jKeK9ZhffmYapVeO3wB8DdPqz5Ma2Fz9XW
         Zl6IodLoZMnl7AAjPFTpC5b2eOHTFcLp3owonmZunCjarCW0nxC3lYiOOqhdl6yUW5fd
         n5Zm6LIrWWbicuMuW5F94XhcEOKjQyTFmspTOVuW/XTql1vPzMDpu7diGO4gF/ikaXfI
         uHsCGCERmkvpwwrfX6gGpoH3eE0DduBWd2X1whYULzDBjcxY0rllmEFNyfBgutGtVTUn
         6/Og+1l4lTm0VQbGY4kmmTYl+HjXsqVBHYJnDJMMGlvz3YDG+Fbm5G6hZ2C3txgX4RyC
         jHvA==
X-Gm-Message-State: AJcUukfz3hCFXvccSg0FKbT6DUPd7tBq39zFS/eUkjdo2n9+t6mLg9k0
        RWn/AIzyOirD93UsD36GB5NJyDEKMt8=
X-Google-Smtp-Source: ALg8bN73hWl2ff3P3MbHwLeAzY4V+FZlc4ZvEBmrXsNo7X9676rhwqzXO9QUQwgAcx4XQUNFyaTt7A==
X-Received: by 2002:a67:e89a:: with SMTP id x26mr2312183vsn.80.1547585269221;
        Tue, 15 Jan 2019 12:47:49 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id w65sm9133867vsc.16.2019.01.15.12.47.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 12:47:48 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id d21so1426397uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 12:47:47 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr333734uap.14.1547585267418;
 Tue, 15 Jan 2019 12:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu>
In-Reply-To: <20190112152844.26550-1-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 15 Jan 2019 12:47:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJvWC0=zym11noj7tOjkDFYvn+wNimwSjcmiWnrCoOVVA@mail.gmail.com>
Message-ID: <CAGXu5jJvWC0=zym11noj7tOjkDFYvn+wNimwSjcmiWnrCoOVVA@mail.gmail.com>
Subject: Re: [PATCH 1/8] lkdtm: change snprintf to scnprintf for possible overflow
To:     Greg KH <greg@kroah.com>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

It looks like these are going via individual trees. Greg, can you
please take this into your drivers-misc tree for lkdtm?

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

>
> ---
>  drivers/misc/lkdtm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 2837dc77478e..610aa3bfe630 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -347,9 +347,9 @@ static ssize_t lkdtm_debugfs_read(struct file *f, char __user *user_buf,
>         if (buf == NULL)
>                 return -ENOMEM;
>
> -       n = snprintf(buf, PAGE_SIZE, "Available crash types:\n");
> +       n = scnprintf(buf, PAGE_SIZE, "Available crash types:\n");
>         for (i = 0; i < ARRAY_SIZE(crashtypes); i++) {
> -               n += snprintf(buf + n, PAGE_SIZE - n, "%s\n",
> +               n += scnprintf(buf + n, PAGE_SIZE - n, "%s\n",
>                               crashtypes[i].name);
>         }
>         buf[n] = '\0';
> --
> 2.19.2
>


-- 
Kees Cook
