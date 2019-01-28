Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91F4214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRolODtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1L6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:58:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44108 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfA1L6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:58:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so7870823pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5y+OwHy8ExdG4LYMZEjHHJUF2SaskHXsVe2GWcV06zk=;
        b=qRolODtYN1zJsGDVt3HOz6l8wrc6GUAlMzXQnL3tq1xgr67ZhdtLbF728uoKIRgkZR
         UTxKYqJWP0r/ELVFtWDU7NKjE6wdAlQZ2AlbkPo+GEWmOUSU+v7ehGLKgiZxJJc9N+j8
         s7R9Fswa5tCpJxSt1NyhLP+L3Sir0USfrbXVSN9Si9lwvsg2hWh6d9FaC7V71I2+2k+0
         rvB/bQLWXgMzXCnwTbfPS9VFyM/WdT6X+zED5eBEclvKiHluGYbJos1oaYQQLbO+KXVa
         xOQAbPHB1ra/dQi01B0U83r4H77lCd2E191gwmr+Tpoxy/Xjg6T6K0ublkOplFG52EEJ
         x+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5y+OwHy8ExdG4LYMZEjHHJUF2SaskHXsVe2GWcV06zk=;
        b=RZ9WK7bo8jQwBs6m1ZQyQ7Y/bQirkgKsv0wTksCvD5loqARMM5aaUU1EZm0VjxVihT
         +s+tVVsBjzonY2BONI8V/Ojpd/hrOWWB2YRXMwDQt238IRhyZgOn+e0x8QDmdf5NDboF
         QQJaZHASE0PJ6sy+lJCAmyMvmQ3faiHiQU2BsOhu+AA+xRN6qR9b5TA4tJW3CEA8UFon
         ECFW3XrwrcfL/OsPtnsl4tMEuXQKH6rbJcOXk1wiqBgWMHrJYTbUk4m0Z6y1ivSiO3bF
         wo6x2Swtu50vNBFqR50NnOl0ANxQXmJbPCpX8KApMqN88m2nIkl3+VZ+/NsUzVZ1uGvc
         h4AA==
X-Gm-Message-State: AJcUukfj8q2QlT1mzSx1uofRL3/Q8bqdni5uKOkcQMFkqFlO3LCMmJlA
        X+WUVwTSpXUja+cw/hqA1C5s+x8sjsYqZv2vKTgCwKEw
X-Google-Smtp-Source: ALg8bN4xDB0Uunb4gcRy/OS9OBPiAg4ka1u7aWN8LBwC77ktBv3gyOd36Vw+hsHQT0w9svWN2P0f0IY/LEzayM61UeI=
X-Received: by 2002:a62:5793:: with SMTP id i19mr21763806pfj.49.1548676711010;
 Mon, 28 Jan 2019 03:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20190128113619.19025-1-bp@alien8.de>
In-Reply-To: <20190128113619.19025-1-bp@alien8.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 13:58:19 +0200
Message-ID: <CAHp75VdVFGoJxGzszoGXZ0h-bteDwYA+FbWob0soZPPPQbJFSA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Andy and Darren as arch/x86/platform/ reviewers
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 1:36 PM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> ... so that they can get CCed on platform patches.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: x86@kernel.org
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cef2104d5f2c..825cad5e01e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16652,6 +16652,15 @@ S:     Maintained
>  F:     drivers/platform/x86/
>  F:     drivers/platform/olpc/
>
> +X86 PLATFORM DRIVERS - ARCH
> +R:     Darren Hart <dvhart@infradead.org>
> +R:     Andy Shevchenko <andy@infradead.org>
> +L:     platform-driver-x86@vger.kernel.org
> +L:     x86@kernel.org
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> +S:     Maintained
> +F:     arch/x86/platform
> +
>  X86 VDSO
>  M:     Andy Lutomirski <luto@kernel.org>
>  L:     linux-kernel@vger.kernel.org
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
