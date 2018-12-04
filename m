Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62024C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0DE20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0DE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeLDTKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:10:18 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35630 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:10:18 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so10529819vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6/7wHXurqaGj/r7xd81EwmlpqX7AnvegbNypZr5kCg=;
        b=uf/3mZNvh4i3BSxr5A3OyUghYzKM/NtldNyXfIcbSfOBqOQgDjIgBLpQMrt8eSkGsZ
         BChbamyinLySXzzwIztxVreoTR42BQcFJnoyG6pbi8o5C7wzZbf1aKxvjYYKj6kdGVZQ
         o/0yiP8m/JLyFe2sfuJ1GZpH3UYDsKvYHZnEVJ0GEoPSegCC9nCVV3F4ydsDsGsJU5w2
         rGX7sATJjJ7O7RkQVbSNTqWrCK+f46W/gQbR5jqdCluTyrBuO23xhmZ1u/VrF2+DQpB4
         8pKJPP6LDl7R3c8DKw7jnTTqxekEtJrDyHZs6aoScKhDfugc5xYYZK2/1sm0kGr9YFLi
         13LA==
X-Gm-Message-State: AA+aEWbZ5wv5xk3Y+46JCu1QP5g4AuHcVAuonCbhvPhFV8ggWdLRbIiP
        wn48Wfi4uGIOJ/0zW+ZP7c3jXnwWTYqFGkU04CxIeg==
X-Google-Smtp-Source: AFSGD/XteH1tPmLCJCGi97IqrNFP/GAIe4bayT4cICl6wJt1tilDC58KJVdd15ciNdUZM90GkSkVHwd4bGh915dakhU=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr9576970vsm.152.1543950613733;
 Tue, 04 Dec 2018 11:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20181204131456.23579-1-geert@linux-m68k.org>
In-Reply-To: <20181204131456.23579-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Dec 2018 20:10:00 +0100
Message-ID: <CAMuHMdVJQvFzZLcWn7AWSo-wMbmpHW7XTo6ccP-isdjE8mGrwg@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix crash in free_all_bootmem()
To:     Andreas Schwab <schwab@linux-m68k.org>, rppt@linux.ibm.com,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 2:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> When running the kernel in Fast RAM on Atari:
>
>     Ignoring memory chunk at 0x0:0xe00000 before the first chunk
>     ...

> ---
> The Amiga part is untested.

Oops, not even compile-tested...

/me hides in a brown paper bag...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
