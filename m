Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1932CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ADC20578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjuxFtY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfAOBDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:03:07 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34711 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOBDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:03:06 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so680315vsi.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5Mn0H2GmTAtAKZeaYpB0QFNGy2tuSWnsbYLaeOZCD8=;
        b=hjuxFtY9bS1qDuIQpvvyF0dIfHxf5RQS211DF9clP205V/bDHvYaHraYw/8bMriR8E
         EBXjuXNbi/5UPpPhp9lo75QA6okX+LVCgVMwBuFfOLTvF3GQtECoDSQwqJkRMwAOzwNl
         eCentY9YB/+Zep+zSRlYXsI30Ie9MSLpAFW6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5Mn0H2GmTAtAKZeaYpB0QFNGy2tuSWnsbYLaeOZCD8=;
        b=SAZ9j3tbnjhwM+AEToZuPXsVEeUxt4iOrsTYE4z1n1gAZK0EKc9jieoEu4VMDcAmjZ
         mLaNqsq+Q3P2lCw4ejn70+nvYzIzys82akvaIJ5cFJos+iFJeHMy/ebLrswspTrvAATz
         h6azRJtB64USwP+Y2BkKKLSj7NFmQGsSdQayplW6nPKApi5xwvDss5blkwJSTzPhDf/5
         Sp1Mytix7isyvFnBlQ0gORa62SjfEVCSStpA4UrvKQwHhXvnLzGDLtWxRbXHPwkEdtpm
         UlHWRa46VjQCSbZcq4ha7CGusnm8IDqzBSj/iFxxU8F6Ugx7pKP7+Fqu3f1UUbLfjvXk
         NAug==
X-Gm-Message-State: AJcUukeZRa5beLSpTNDPcM8/AusbH5QtuYuu+vrarNP1dmfsO6FPtSTY
        DlY/70jddVgVJdlBtKuxXRZqkZXfVZc=
X-Google-Smtp-Source: ALg8bN5ENpeXzSVP2pX39f/Jvf99/13v3tAl4XyrdIXgCbOBXbhS2nkpsBvXaXSdmhJpAQrud0XkeQ==
X-Received: by 2002:a67:4c51:: with SMTP id z78mr465630vsa.99.1547514185202;
        Mon, 14 Jan 2019 17:03:05 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id w65sm4100649vsc.16.2019.01.14.17.03.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:03:04 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id x64so657329vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:03:03 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr601519vsl.66.1547514183309;
 Mon, 14 Jan 2019 17:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu>
In-Reply-To: <20190112152844.26550-1-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:02:51 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLGkPqA+ZY7aFizpsRj9VvOhUSfixWcLLVHXwsAo3PQyA@mail.gmail.com>
Message-ID: <CAGXu5jLGkPqA+ZY7aFizpsRj9VvOhUSfixWcLLVHXwsAo3PQyA@mail.gmail.com>
Subject: Re: [PATCH 1/8] lkdtm: change snprintf to scnprintf for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
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

(I didn't find a 0/8 cover letter, so I'm replying here...)

Many of these fixes are just robustness updates (e.g. the lkdtm case
below is not current a problem: the size of the static array getting
displayed is less than PAGE_SIZE). It might be worth noting which are
actually problems (and include the appropriate Cc: and Fixes: lines).

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

Are these changes going into someone's single tree, or are they
intended for individual maintainers to pick up?

Acked-by: Kees Cook <keescook@chromium.org>

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
