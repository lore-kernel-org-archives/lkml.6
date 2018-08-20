Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B6AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5A92170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBbOvdTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5A92170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeHTXmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:42:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37906 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHTXmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:42:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so7327043pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+ZAQzVfVhWeLceyKWn+FK+VYYwausDp5pofcIxzenc=;
        b=bBbOvdTKxeRm20RfobfEHZyzp+3MTkk4yyKUaXM4P0EvrAJ/q6GtuV/lja2iy4kQin
         hXE4giAH7oOFd/AYMiKN/mMh5ovO41gNSFl/xk2XvY+Wb63i/YbBXWfskbWyQ18pAKug
         +O1MisPzUKDDLkAQH+85AYPpI+gHgJVCZGP9uyyRB1fOIYDG36ou6RY5VwQQZOsEl6wq
         EArjjQ5aK0ZJCnIstxzkQ8ITfc+EqCzbbCotY91PSEXLfyDnTSlVOhIlJasQgMWIv9U3
         foaDtYAl0C9Mzk3EiYjtN+Vi586XZFTsp4Vg+DA1BrelA4px5t9Cw5C6gpMLh30pY0HO
         7DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+ZAQzVfVhWeLceyKWn+FK+VYYwausDp5pofcIxzenc=;
        b=hGT2eF+I/Q8HvHOZYcqp7H7MfPJvBjmjfN6thgNIbinWsPH7/rU/5TDKxXljgP2K2u
         7PCLC6OLMtyptSN6ixnIGsxMZJrXc8llP+rWTPAAzxLwaWaNPCSjFOFWkdLI2KbAeIOX
         70ZAXG+5FHACbR4TpDw+hlcX4U+cj7hWP5Dupl5V/gTW8EwKWQhtTbPDoRWME5h6SR7i
         r9jBqm91bFp2zQKH+0pEvx10G9ec7SW4fje4EZypRnKO8FpLHNxerXeWCP2jx3l84Dch
         mncicj0o8bjnVByMyCo/E6jWAKSf3DGuR0vkkYSmWoMMY0pCs1alZik2excWMX1J0ko4
         82YQ==
X-Gm-Message-State: AOUpUlGq2olQuTQT35a9HO4keuCTR/Fj9AdY3tmJ5jcWuGfm4jYDchao
        u4EHDrF61Iz9Gpi8AR4b/Fcu4hczkVL25bVv5iJb+fBdTx+hcw==
X-Google-Smtp-Source: AA+uWPxIQKC1fD4/GS3B9eOEDeHHBnT6YKIYdZrX/UG+F1LIWhdyhet4889Z6NzO2K/E1f+NzQeVjjrCZ8mkqOSzgBc=
X-Received: by 2002:a63:190e:: with SMTP id z14-v6mr8188048pgl.302.1534796739959;
 Mon, 20 Aug 2018 13:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
In-Reply-To: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Aug 2018 13:25:28 -0700
Message-ID: <CAKwvOdmaABwZhZ0YCPBhuiq+hMrSF=Ad_sOD04d8+ab5QLLXhA@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     joe@perches.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, efault@gmx.de,
        Guenter Roeck <linux@roeck-us.net>, riel@surriel.com,
        Kees Cook <keescook@chromium.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 1:15 PM Joe Perches <joe@perches.com> wrote:
>
> Various architectures fail to build properly with older versions
> of the gcc compiler.

Just curious if certain arch's require older versions of gcc?  Surely
that's not the case, but hopefully this patch wont surprise anyone.

It might be worthwhile to see where else in the kernel has
/gcc\s+[0-9]/g as I'm sure there's other old-gcc workarounds that can
go too (in follow up patches).

Thanks for sending.  This helps us ship newer compiler features for
which older compiler support is difficult/impossible.
-- 
Thanks,
~Nick Desaulniers
