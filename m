Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0085C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB024443
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n6fZAziY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJVvnzAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EB024443
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeGBStO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:49:14 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38532 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeGBStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:49:12 -0400
Received: by mail-yb0-f195.google.com with SMTP id i9-v6so1860313ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=j6X9iMYS8KjJrMdo5EclT36D0jsHAsEql0Ir6ZqnGEw=;
        b=n6fZAziYaNpsP8ebKNkRHcbg2LSSkyRbqQdsbrRIa+RQXq0AAR9sCgg5wjJbbbYdla
         oT4X7I9o+nSN4xq0AT79+wujVu/4oCwU1GWOuj7j4rSQ6Jq6PJ2MWoJPsR4VAoNJkm7V
         3nk8VaT9CgHQZiOAKJDZ1wAPVTznz2fhiWknv19ZMg/ZeglXnG/VXTIK4XzgHD3ccVX5
         CK0M/IrpW9hv1yp2XzIpSWdkC1gXgwnm1mtchjkEg/6Hv2Spz1OccmZMW0nhT0GuT7is
         YdUL2qvMYQPu8eJeGuf96MnVlcQFzpa3tYtdYVYO8NMHYC3pIQDlFQULDjJ92zYYYljG
         cy4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=j6X9iMYS8KjJrMdo5EclT36D0jsHAsEql0Ir6ZqnGEw=;
        b=cJVvnzAoOv7/OgSCz3Ms/8M/uS72WX9l5ZKcJ8N27QMzDDcUYvCpnUQp8LPGZrOAnt
         dwbm7rwhl4iGrggFv8UM3HRn5FafE7G/WlBr48Px+nmUVMwEfwf8v0LhIb2X5LuMqP30
         qPpxzcV3gVdGTuZHBwUDc/DZQ760/17WvrHRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=j6X9iMYS8KjJrMdo5EclT36D0jsHAsEql0Ir6ZqnGEw=;
        b=blHIcGoI/DXuvy6eVe75o38t4uvOy0qrsRlQC9iVBbz/ILCqS4EdGdt+guoN5eAskQ
         b1jzvS1EWDmkuBOTYMeLhjVazlTQ/9xMdbY3ZOQpd452RvwrGSDoHV52/Z2dHdlXa1GQ
         F/yYh5O6dO5e+7DnVc7e8QC8GuAMuLoOhG5LgXw2681G8K7l2JEix2UxmKOvLqQgtN7a
         jrCRJBSoWfqPSsQyhSMnY8dN/ngbIl+0jv7G0KWqZwKl0M/USjzTrjJpf6gYAdz1zwJB
         osJy2OwBCJcSO1PEEc/PYSjZripLYtCqtgcjAHzkJOeuEzzdxUF9UOBkhtKglxThHK3o
         Bbkg==
X-Gm-Message-State: APt69E3XazwJ9j6X41Cb9ceT2J53dkOc18ORt0haDylWKXG1a8eWoxQD
        QCN6CJeIrQgar1N9gzBX94k54e4CWoe6U+ZaG/0aHg==
X-Google-Smtp-Source: ADUXVKKHq5UZcYmy+Y3RMJ/LuA+ll6yKCGNS0Zsw1JaZAa9Bd8hD/AzxaqUJF912hBXulHk/PrxHjJbukHXosfJMhX0=
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr13186357ybj.343.1530556879229;
 Mon, 02 Jul 2018 11:41:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 11:41:18 -0700 (PDT)
In-Reply-To: <bb09a8b9-f984-6dd4-b07b-3ecaf200862e@infradead.org>
References: <bb09a8b9-f984-6dd4-b07b-3ecaf200862e@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 11:41:18 -0700
X-Google-Sender-Auth: b6ZdMLsCyDjmGECV8mofKjBWiWI
Message-ID: <CAGXu5jL-GUwgL7XLJS6=9BFuidbCAcUpDKgJV8dq41zd3yvA7A@mail.gmail.com>
Subject: Re: [PATCH] sysctl: fix typos in comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 11:22 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix a few typos/spellos in kernel/sysctl.c.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/sysctl.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- lnx-418-rc2.orig/kernel/sysctl.c
> +++ lnx-418-rc2/kernel/sysctl.c
> @@ -222,7 +222,7 @@ static int proc_dopipe_max_size(struct c
>                 void __user *buffer, size_t *lenp, loff_t *ppos);
>
>  #ifdef CONFIG_MAGIC_SYSRQ
> -/* Note: sysrq code uses it's own private copy */
> +/* Note: sysrq code uses its own private copy */
>  static int __sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
>
>  static int sysrq_sysctl_handler(struct ctl_table *table, int write,
> @@ -1973,13 +1973,13 @@ static void warn_sysctl_write(struct ctl
>  }
>
>  /**
> - * proc_first_pos_non_zero_ignore - check if firs position is allowed
> + * proc_first_pos_non_zero_ignore - check if first position is allowed
>   * @ppos: file position
>   * @table: the sysctl table
>   *
>   * Returns true if the first position is non-zero and the sysctl_writes_strict
>   * mode indicates this is not allowed for numeric input types. String proc
> - * hadlers can ignore the return value.
> + * handlers can ignore the return value.
>   */
>  static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
>                                            struct ctl_table *table)
>



-- 
Kees Cook
Pixel Security
