Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A271C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B65222D6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A11XKqcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfBNA1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:27:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34319 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfBNA1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:27:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so2090486plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMnhjtqVdgPByvYYJJCyKk7KktNyY4yGIyHkhdv1Ego=;
        b=A11XKqcFo9JTB+aFSaL/DgcHLfl2LOj4ZBNO5OvcDFJr5StoLjT/z9pdRp1l1CVHrV
         IosQcHhDGwA7ScUxVsB2wfAjAiE4hRNwTa84AqaL+j8FFuVC9NvNTfjuCSAMlMH52RfL
         5xuiD4Sab8kDTVkwx9P4+8ebN4dmWs/ZII6BWiHXaaGP2H99Abjt3A8sMx06WsBjDvdI
         zQHBDs1lU5o1XWpNUwuYL9BrkZpdKk7pgCFVeN+iI8nLJDP7n3+/ztaeLZMcyUp7o8PF
         0lrg/QlOLS7GMibEXFocwWTBQbPMXYr+Riznm9AW8AISXOdn1ch+6b5VQTKwVhRt9yXQ
         BslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMnhjtqVdgPByvYYJJCyKk7KktNyY4yGIyHkhdv1Ego=;
        b=lPhYKZfVVaSBHy/IRcZZoC/6U57wTWUwrfjSZ0ov1mRvQROtYSs4q8aboENGLcuFZi
         KUkYqx/Z19hS7YmTtZr0ldvha+oOueIfjgJylZAh27abElX47EnpCSg6zUw/HNRb5mc9
         mUunMyaZejgQFP1s9VaVcJPNTGNfATGWABMnOOcUBxbRFz75jQk3Q8CwQnHbRRBnCxM5
         L74ncDHe1qkUm2E217ZXxD5iZjAY805lXdDygifBzRwq5WrcAwFs8Lo0A5C0vzNyUzZ+
         UJwn0XO2Nj2hHm0p0kYNqBJ4Q+HRoyJqe7Qzk0yB1DE6lykxCVh6e0braOUMgIY+aQi5
         nr2w==
X-Gm-Message-State: AHQUAua5SGH5e2horkWlgIBaPM2Yq4enjskINuEzQNncfRRK0Y9BLfti
        U7heKzWGw6B/1gjJzz0YnshhSjr4thvYEr0gsxzVpg==
X-Google-Smtp-Source: AHgI3IbYhBZZTUaRoFQmz74HXKjqlvRInirhBE9dP3FgmdmkPFbfB1XUwZIpVL9JhPO7DFOgaK/qlXy8SH/KpEzuK7o=
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr1041683pla.246.1550104039964;
 Wed, 13 Feb 2019 16:27:19 -0800 (PST)
MIME-Version: 1.0
References: <bf858f26ef32eb7bd24c665755b3aee4bc58d0e4.1550103861.git.andreyknvl@google.com>
In-Reply-To: <bf858f26ef32eb7bd24c665755b3aee4bc58d0e4.1550103861.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Feb 2019 01:27:09 +0100
Message-ID: <CAAeHK+z=ft93RNx7rvq1QFr3kiOFVzBVACEFN4fL8nbEVOEXKA@mail.gmail.com>
Subject: Re: [PATCH] kasan, slub: fix more conflicts with CONFIG_SLAB_FREELIST_HARDENED
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:25 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
> Normally, this doesn't cause any issues, as both set_freepointer()
> and get_freepointer() are called with a pointer with the same tag.
> However, there are some issues with CONFIG_SLUB_DEBUG code. For
> example, when __free_slub() iterates over objects in a cache, it
> passes untagged pointers to check_object(). check_object() in turns
> calls get_freepointer() with an untagged pointer, which causes the
> freepointer to be restored incorrectly.
>
> Add kasan_reset_tag to freelist_ptr(). Also add a detailed comment.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reported-by: Qian Cai <cai@lca.pw>

> ---
>  mm/slub.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 80da3a40b74d..c80e6699357c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -249,7 +249,18 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
>                                  unsigned long ptr_addr)
>  {
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> -       return (void *)((unsigned long)ptr ^ s->random ^ ptr_addr);
> +       /*
> +        * When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
> +        * Normally, this doesn't cause any issues, as both set_freepointer()
> +        * and get_freepointer() are called with a pointer with the same tag.
> +        * However, there are some issues with CONFIG_SLUB_DEBUG code. For
> +        * example, when __free_slub() iterates over objects in a cache, it
> +        * passes untagged pointers to check_object(). check_object() in turns
> +        * calls get_freepointer() with an untagged pointer, which causes the
> +        * freepointer to be restored incorrectly.
> +        */
> +       return (void *)((unsigned long)ptr ^ s->random ^
> +                       (unsigned long)kasan_reset_tag((void *)ptr_addr));
>  #else
>         return ptr;
>  #endif
> --
> 2.20.1.791.gb4d0f1c61a-goog
>
