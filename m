Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D592ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B67D20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jThluhYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B67D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbeGTAwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:52:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34791 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGTAwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:52:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so9659943wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5MQzsHmNh5kfhaOk5Qv6cnWUOb+Ja3EzRzykl/IwUg=;
        b=jThluhYUI+qXL2RGRrOHBPOpTCWj7YPr3VNSHv+agc3yaD7JsxP6yWCTYu2CofEq+s
         53do1PdHdTTlWu+CI1k8GVQuNIIYYVq9yC0BydTfQevrAMxbfa8T5+gVCJC7eA7K6mLR
         cVFPoJACZlhUSpNdgzKnTfZ8PIq82rn9mK3bn6U2FypWKg+iB71fhZ7f5iMfFVpN9TM9
         gAPUVnFymh3IvgTp9+St/hjj1nMH4yC+cHtl/vNIFsjyy4TgzTpcsUhPzDQlmBVuVrVM
         ArWDOJgzeNtdNZmDgIn+gIgVYKqZqDtD2OZGffU8now+fa8BRtB5JJLSjpA0RYJqobbq
         rUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5MQzsHmNh5kfhaOk5Qv6cnWUOb+Ja3EzRzykl/IwUg=;
        b=MdSQkOBQeIvnhgR1aLsR0x1XRjBI55Z6FwlyK6WmXrhrUgF6gC+nl0uGedXLi+swgC
         IBjN01f1e4iX5lNzMgANBuZGXp3UDThvTOimJGfnTcAq2Cq1XKBURskmoImmJRstF6Qb
         6uvZlyIWGLeBiFRyJxBROI5S9INbfDZoOqDgt2cRrdLLDLiEig73vUIH3XLG4zlPiUhn
         bjwfIAZBZvFVtGlsJbG/RfkaFrp1VFvs0MLsaJUGhKllkg/03PQ0bYXpCnjNbr7Yjvpq
         qaVCIotJBEw4yl+FfYL3SmKdCIo9sXMrozX2wIhTFmgJAcI5UKZ/0Xmp814gw+7KMKAm
         YA3Q==
X-Gm-Message-State: AOUpUlGpIlCuwmCxCaqnXEkgyTANO8kMjbUmL2CaINbPdBChA7yxQRE0
        iNjI+kbRMolV7yKTqsgByN1LBgXEkqwzSU7RYigemQ==
X-Google-Smtp-Source: AAOMgpdY/uyxfwcBB0H+p9nVRGJFWmbvH8IqHh28nnd9nXwAU2xVLYHuIfj2cGO1p7NaLM+krxmaMb4aCFN8jlJ4hyA=
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr9239709wrm.2.1532045227257;
 Thu, 19 Jul 2018 17:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180614200956.GB7137@avx2> <15003.1529008242@warthog.procyon.org.uk>
 <20180617215732.GA24688@avx2>
In-Reply-To: <20180617215732.GA24688@avx2>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Jul 2018 17:06:55 -0700
Message-ID: <CALvZod7HXbR1hQ-cZ1=n8as7wBkNMC6T0TbRhpgXNTKviJxgCg@mail.gmail.com>
Subject: Re: [PATCH] proc: fixup PDE allocation bloat
To:     adobriyan@gmail.com
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 2:57 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> commit 24074a35c5c975c94cd9691ae962855333aac47f
> ("proc: Make inline name size calculation automatic")
> started to put PDE allocations into kmalloc-256 which is unnecessary as
> ~40 character names are very rare.
>
> Put allocation back into kmalloc-192 cache for 64-bit non-debug builds.
>
> Put BUILD_BUG_ON to know when PDE size is gotten out of control.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  fs/proc/inode.c    |    6 ++++--
>  fs/proc/internal.h |   17 +++++++----------
>  2 files changed, 11 insertions(+), 12 deletions(-)
>
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -105,8 +105,10 @@ void __init proc_init_kmemcache(void)
>                 kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
>                                   SLAB_ACCOUNT|SLAB_PANIC, NULL);
>         proc_dir_entry_cache = kmem_cache_create_usercopy(
> -               "proc_dir_entry", SIZEOF_PDE_SLOT, 0, SLAB_PANIC,
> -               OFFSETOF_PDE_NAME, SIZEOF_PDE_INLINE_NAME, NULL);
> +               "proc_dir_entry", SIZEOF_PDE, 0, SLAB_PANIC,

Hi Alexey, can you comment if proc_dir_entry_cache should or shouldn't
have SLAB_ACCOUNT flag?

Shakeel
