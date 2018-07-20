Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ED7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DA5206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkHRZxAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DA5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeGTUFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:05:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40069 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbeGTUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:05:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id h4-v6so11233512qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K5aKN1twt3OsHprz478h6YmMek7/P6D1hjsb8sftGjg=;
        b=fkHRZxAJwWg+oFBuCC7yQyngrM6nNSwq8paCYPH2BMONgp5GvyxJB0iQaJicqPmykC
         fakcb/UR8dwwf0/bG/HYwYGx6Ei39O8iRnXF5md0JQ/ZB9QhQa5W8roDCdLdfjuaNA4C
         FMrz5T5FA9SzlD9c4mAtX2GDB++ePi46VgRxcC5MS9s82QpkjsecrRWhv+/FXQTsbhCp
         W7plJdbSNWoOa1ran80fO97EuIS5IyLDGA4mVFzBLks8l4NbuM7UiH6N658kbbBHaqCU
         g76LAnLstoDfSDlqiToiVggy8B3xnNGj+Bn+CEvsw9oVU0ZfZnMYiDXTspAezwFV0PZ4
         kjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K5aKN1twt3OsHprz478h6YmMek7/P6D1hjsb8sftGjg=;
        b=uN9hHXjRfrJ4eFFPUZxHtoANrswpi1S/Q2ibCv7ptUdos8cjwHgMsfLokosITe0O6N
         6+qFP+MnzBVRYd4QOOnMGerRECbDGdQo2hyFZ8k2SP2n6OkFDG4P6H11AqiEqCn4JUpb
         XnYMtF+SjK4Wm38k/knDHbE3ugS9hPmhFkC8so4A/woM0qIHD+jNzjmWkPBwI7MlKcAb
         LzZhZeX6g1rdJ7N+btYbR4e4ey71wb4N7NhxUI/ql0CBUb7fG+7LWkaMb1XV5ngVSz/4
         SA3Eqnce7rduv68rL0BQjWCDGwfTusnvn1Ll/LS8X402EosB3JFSS/Ry7LR7ft7l8TMI
         4lIg==
X-Gm-Message-State: AOUpUlFI4a2F+DtZyquOkDMVKFqcjdJKvk5SRf+aHRpsM/DFwBlcCfdb
        vy1MIw00oylcFjJAy+fOgl2afrQy4VaOd932Dqo=
X-Google-Smtp-Source: AAOMgpf/zCiC9/MpF5fUT/ktNBpGNkZtVYFxYK5XHbXEz/G7+DI+q+rW84sw6ak/juPkmU2L4RDpjWNfie350QVa0u4=
X-Received: by 2002:ac8:8f0:: with SMTP id y45-v6mr3267317qth.408.1532114165886;
 Fri, 20 Jul 2018 12:16:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3fc6:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 12:16:05
 -0700 (PDT)
In-Reply-To: <20180626184422.24974-1-malat@debian.org>
References: <20180625171513.31845-1-malat@debian.org> <20180626184422.24974-1-malat@debian.org>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Fri, 20 Jul 2018 12:16:05 -0700
Message-ID: <CA+8MBbLB5JTdcgS3yJRR12doMgEiofD8NNXedyYyj4c7AcDnMg@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memblock: add missing include <linux/bootmem.h>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:44 AM, Mathieu Malaterre <malat@debian.org> wrote:
> Because Makefile already does:
>
>   obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o
>
> The #ifdef has been simplified from:
>
>   #if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
>
> to simply:
>
>   #if defined(CONFIG_NO_BOOTMEM)

Is this sitting in a queue somewhere ready to go to Linus?

I don't see it upstream yet.

>
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v3: Add missing reference to commit 6cc22dc08a24
> v2: Simplify #ifdef
>
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 03d48d8835ba..611a970ac902 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -20,6 +20,7 @@
>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>
> +#include <linux/bootmem.h>
>
>  #include <asm/sections.h>
>  #include <linux/io.h>
> @@ -1224,6 +1225,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
>         return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
>  }
>
> +#if defined(CONFIG_NO_BOOTMEM)
>  /**
>   * memblock_virt_alloc_internal - allocate boot memory block
>   * @size: size of memory block to be allocated in bytes
> @@ -1431,6 +1433,7 @@ void * __init memblock_virt_alloc_try_nid(
>               (u64)max_addr);
>         return NULL;
>  }
> +#endif
>
>  /**
>   * __memblock_free_early - free boot memory block
> --
> 2.11.0
>
