Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF6FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BAE2196F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fiqwgcAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfBQRah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:30:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37563 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBQRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:30:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id r10-v6so12358458ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsIlCPevGTkpmWXFe23QGHRV1UfkcaWJRUrDhlzkeE4=;
        b=fiqwgcAIWNgDCqfteOTca2L/UXt0mYyswsxhLpyeGzy5Y3kKwNbmEZZFxA5b1OWBRN
         ZeaIwGKeQW+k1tEcr3MfSGB7qz+pqxT6sN+zgYvgg+7MuakypMAPpRAc++K6HS+f109k
         LZbnmAjpDUtstCOteUprhsB3qzfDhYUuGe/mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsIlCPevGTkpmWXFe23QGHRV1UfkcaWJRUrDhlzkeE4=;
        b=ptGJxBtQIStRD9lr42SD1n0+pST7+tpqG3XLlJdkgBUTrjGYfvE0eV6ybycxiZxX60
         RZZOkJeNHfu+RpPlpaHf5y8odfdw8IbcYAVimqXkkjEmgblwf7wZMV5YQiMbdae3uaKK
         IEQ/AClmA8KKQ8Ou3drQhjpPsMEtnEdeNJoQLy6Hl2qyh4qZ+EokdD1eTaRkIDx8aZ7w
         FPvq/+LIAwklPFpreBiGhjz0kpokmRP/mksK4KjmqkNVh3a/f+I3J+YWyLbVyBeODRqs
         49Rv/kJbV5VbLJxFArMVYPBq91GQbWuuBTMZ2RKs7T4pyysJlmDeeKtsAb+mYV7GOCl0
         uhgA==
X-Gm-Message-State: AHQUAubtUS39Lo9fPEsc2I65gjCaB88P5nwjZHwUxbq71P7Npv92Imqg
        4nhIYhWpK7H7ocPZH+HPlekHjKgor6o=
X-Google-Smtp-Source: AHgI3Ib10CMBoFOI8UahFFXfa2xhz0Mkup7iVDZQFJn+kvbN66R5nZ/A+LKNw6m2ewLw+Imu2sudAQ==
X-Received: by 2002:a2e:5cc4:: with SMTP id q187-v6mr10246170ljb.69.1550424634592;
        Sun, 17 Feb 2019 09:30:34 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n20sm3079940lfh.53.2019.02.17.09.30.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 09:30:33 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id j13-v6so12374946ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:30:33 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr10491446lji.2.1550424633262;
 Sun, 17 Feb 2019 09:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20190217090903.GA17600@beast>
In-Reply-To: <20190217090903.GA17600@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Feb 2019 09:30:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiA00pLq_3DautqfL=Dn9r4Nmjgw+M2ABt-RfCX38xh6g@mail.gmail.com>
Message-ID: <CAHk-=wiA00pLq_3DautqfL=Dn9r4Nmjgw+M2ABt-RfCX38xh6g@mail.gmail.com>
Subject: Re: [PATCH v4] exec: load_script: Do not exec truncated interpreter path
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 1:09 AM Kees Cook <keescook@chromium.org> wrote:
>
> +static inline char *next_spacetab(char *first, const char *last)
> +{
> +       for (; first <= last; first++)
> +               if (spacetab(*first))
> +                       return first;
> +       return NULL;
> +}

I think this should be "next_terminator()" and also stop at NUL.

You do check for the NUL case here:

> +               if (!next_spacetab(cp, buf_end) && *buf_end)
> +                       return -ENOEXEC;

but it means that if there's no space ot tab and it's a short file,
you pointlessly walk to the end. No?

                   Linus
