Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4667FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1399D21924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GmILv1N+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfBQQuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:50:32 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:46755 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfBQQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:50:31 -0500
Received: by mail-vk1-f196.google.com with SMTP id j68so3315564vke.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLO3Ll9hFeedSc+RlwtOBhq1eEkh3OZEywMgtNexPrU=;
        b=GmILv1N+jqflO9QgDOJXnPzvTpx1Z4yHyoz0KWHahV1dvcmWmwPA9tmmgWjIM08QD0
         j/Lwu4KNaOtuiNxUwWJRC9sF4af142gDHgdppMHYB/+cTFixXHLX99aUj1vvhOLv6Bcn
         7ia9HKHVDmOGJOdSiz16zSll9uhFI1Vz1zdb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLO3Ll9hFeedSc+RlwtOBhq1eEkh3OZEywMgtNexPrU=;
        b=J7NDCURLlpVXzANybpX3KomS0R1CLQiqIKZJbHJpt+Fh/EJ6TBkjuhXfu4qhi1w4nO
         0vhwk1z5OWzGUenFI/1f6T+EAi/1bFJn0lR0/t/XJlHz9myel8sBR7vNhu7uSc4pmEYq
         Sv8pesQgRqgOkL59Ueu5pnDoi91bbJ3eU5U6fpmhW6AZzhE6c3v1EzGESPXEqfAvOdrH
         Zhe2DUcBQ1CWnsFipLq34+wx9ysEVr7U84KXHg9LXGEDUW/QHZPX8ZRrTSKnggfqXohW
         gC0jWCZxcz9Y7bq/eib2mXMmGP0FnHe44fE/cGryHmSgSqiJQaWXcxOMzLWfVhmAHq2g
         4spQ==
X-Gm-Message-State: AHQUAuaUDGNLoyHpVaVNVSv+2juU9lLrK4wIneAB9UmhXYJopyb9a4fe
        mwxIxVYY5QlTbIRqHGjOOrosnEHQ/w0=
X-Google-Smtp-Source: AHgI3IYXC4A1Zdfrw179BBltyDlasJO4fpw2EB5t87bvSxjeMXP2f8Pdzt7mdfy8zGLnbFj1QYu8bg==
X-Received: by 2002:a1f:7f10:: with SMTP id o16mr113679vki.31.1550422230048;
        Sun, 17 Feb 2019 08:50:30 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id d67sm12258210vkd.45.2019.02.17.08.50.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 08:50:29 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id t13so8312469vsk.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 08:50:28 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr2927113vsq.48.1550422228315;
 Sun, 17 Feb 2019 08:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20190216140008.28671-1-bhe@redhat.com> <20190216140008.28671-4-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-4-bhe@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 08:50:15 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLVYC8QZ9xo_=JxODQAPVTJMvnWwUb+aZKO-X-Luz+S0w@mail.gmail.com>
Message-ID: <CAGXu5jLVYC8QZ9xo_=JxODQAPVTJMvnWwUb+aZKO-X-Luz+S0w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm: Add build time sanity check for struct page size
To:     Baoquan He <bhe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Garnier <thgarnie@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 6:02 AM Baoquan He <bhe@redhat.com> wrote:
>
> Size of struct page might be larger than 64 bytes if debug options
> enabled, or fields added for debugging intentionally. Yet an upper
> limit need be added at build time to trigger an alert in case the
> size is too big to boot up system, warning people to check if it's
> be done on purpose in advance.
>
> Here 1/4 of PAGE_SIZE is chosen since system must have been insane
> with this value. For those systems with PAGE_SIZE larger than 4KB,
> 1KB is simply taken.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 35fdde041f5c..eb6c8e22333b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -67,6 +67,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/nmi.h>
>  #include <linux/psi.h>
> +#include <linux/sizes.h>
>
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -7084,6 +7085,7 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
>         unsigned long start_pfn, end_pfn;
>         int i, nid;
>
> +       BUILD_BUG_ON(sizeof(struct page) > min_t(size_t, SZ_1K, PAGE_SIZE));

Are there systems with PAGE_SIZE < 1K? Maybe this should just be a
direct SZ_1K check?
(Also, perhaps this should use the new static_assert where struct page
is defined?)

-Kees

>         /* Record where the zone boundaries are */
>         memset(arch_zone_lowest_possible_pfn, 0,
>                                 sizeof(arch_zone_lowest_possible_pfn));
> --
> 2.17.2
>


-- 
Kees Cook
