Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC27C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59EE20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jTzjRASm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59EE20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755381AbeFRQuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:50:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37758 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755119AbeFRQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:50:34 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so15472452oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zceNZnGkDjzzhptHZsGNVcVvwAsWQKK9OlqOY+WU1Kc=;
        b=jTzjRASmQZGfwe/UlzI4P6jffO7l9YagsSSQaG9HmZsnQ7iuYxxLacn6bZKwvy7Y0b
         VbMZg7NFc+zOwhTzP/O5gwazYh2GzVyPyt/Wjnqa5mCHr8R2J74OZdE0LZk0Km3ZY9RK
         LiSakcOYrqrQbsvyj6QFz1JCmbfSbh6cMyuR1sNIEGLflecBpwa+RtyhxvSKjKvYjb7a
         zHFavldvUHsffhz3iOWo9vnwYpI4kWuNCnFE4PNC1qLtwXkL7w6QPp415vxSbwjHGuXf
         vSqhOVR4qan4vmkQraxK5FrAjbeygyV4vsHsQzbFNNBP9zlMSd7NTTIM5xWXFqEZdLx1
         3Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zceNZnGkDjzzhptHZsGNVcVvwAsWQKK9OlqOY+WU1Kc=;
        b=V0d3cGje1fFUnAvwAaETExLwzrh/8UQvBzcv6HWGLg1+0noppAvrAv49vetpSWjuLx
         LcwgveS2v8XVdVVOAz7RmzENuMVVesGV3y1RZenOSRDqYji2XCq7xRjV57xvpyExBsuV
         qcrNpoA87a63QUMWOr42U4mGkSpIvCJm7M57KBk86DFAT93NG7AYBTgwjbUaQMyw3iXr
         63ADa09Drq/ltc+QYgx3ltBXUHiVeRANoF7CaPCw59nC1MFC+2W5A7N6JNo4QhQci3uT
         dxstQqWT2GH4y45xJoj5f5nig/hSWWc2RbTeEtDIfZrVOfFpZu1UONnIzIDPsSfCAfir
         rz2w==
X-Gm-Message-State: APt69E208vnrKLQB5b/FewJIAu7cJMGUUWQbM0tpPEEi3h2ECnK1BITH
        HM+9JmCQTN1xVBcYKEhdeKKRtrqrC6Xw0GKH3pYwpQ==
X-Google-Smtp-Source: ADUXVKJUeJeX0D7aDsSW/8Ap4N61Rtea6sNLt7/6Rj0fhuu9lYeFoY3M33AattyDl1VWdXVaTlAcNukjqAQsOq4Iwq4=
X-Received: by 2002:aca:ab15:: with SMTP id u21-v6mr7703426oie.272.1529340633488;
 Mon, 18 Jun 2018 09:50:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 09:50:33
 -0700 (PDT)
In-Reply-To: <20180618132712.4b4eddc9@canb.auug.org.au>
References: <20180618132712.4b4eddc9@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Jun 2018 09:50:33 -0700
Message-ID: <CAPcyv4idNE8ErxNm5bb3rG4jUeZU9HJRmO03omMJxSN-8FYN+w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the xarray tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 8:27 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the xarray tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> In file included from arch/powerpc/include/asm/bug.h:128:0,
>                  from include/linux/bug.h:5,
>                  from arch/powerpc/include/asm/cmpxchg.h:9,
>                  from arch/powerpc/include/asm/atomic.h:11,
>                  from include/linux/atomic.h:5,
>                  from fs/dax.c:17:
> fs/dax.c: In function 'dax_lock_page':
> fs/dax.c:392:21: error: implicit declaration of function 'radix_tree_exceptional_entry'; did you mean 'radix_tree_exception'? [-Werror=implicit-function-declaration]
>        WARN_ON_ONCE(!radix_tree_exceptional_entry(entry))) {
>                      ^
> include/asm-generic/bug.h:69:25: note: in definition of macro 'WARN_ON_ONCE'
>   int __ret_warn_on = !!(condition);   \
>                          ^~~~~~~~~
> fs/dax.c:395:15: error: implicit declaration of function 'slot_locked'; did you mean 'iget_locked'? [-Werror=implicit-function-declaration]
>    } else if (!slot_locked(mapping, slot)) {
>                ^~~~~~~~~~~
>                iget_locked
> fs/dax.c:396:4: error: implicit declaration of function 'lock_slot'; did you mean 'local_set'? [-Werror=implicit-function-declaration]
>     lock_slot(mapping, slot);
>     ^~~~~~~~~
>     local_set
> fs/dax.c:402:28: error: passing argument 1 of 'dax_entry_waitqueue' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    wq = dax_entry_waitqueue(mapping, index, entry, &ewait.key);
>                             ^~~~~~~
> fs/dax.c:152:27: note: expected 'struct xa_state *' but argument is of type 'struct address_space *'
>  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
>                            ^~~~~~~~~~~~~~~~~~~
> fs/dax.c:402:37: warning: passing argument 2 of 'dax_entry_waitqueue' makes pointer from integer without a cast [-Wint-conversion]
>    wq = dax_entry_waitqueue(mapping, index, entry, &ewait.key);
>                                      ^~~~~
> fs/dax.c:152:27: note: expected 'void *' but argument is of type 'long unsigned int'
>  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
>                            ^~~~~~~~~~~~~~~~~~~
> fs/dax.c:402:8: error: too many arguments to function 'dax_entry_waitqueue'
>    wq = dax_entry_waitqueue(mapping, index, entry, &ewait.key);
>         ^~~~~~~~~~~~~~~~~~~
> fs/dax.c:152:27: note: declared here
>  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
>                            ^~~~~~~~~~~~~~~~~~~
> fs/dax.c: In function 'dax_unlock_page':
> fs/dax.c:424:2: error: implicit declaration of function 'dax_unlock_mapping_entry'; did you mean 'dax_delete_mapping_entry'? [-Werror=implicit-function-declaration]
>   dax_unlock_mapping_entry(mapping, page->index);
>   ^~~~~~~~~~~~~~~~~~~~~~~~
>   dax_delete_mapping_entry
>
> Caused by commits in the xarray tree interacting with commit
>
>   9b3d53936caa ("filesystem-dax: Introduce dax_lock_page()")
>
> from the nvdimm tree.
>
> Willy thanks for the heads up about this.
>
> I have applied the following merge fix patch (taken from the diff between
> the -next tree at this point and the xarray-20180615 branch from the
> xarray tree) for today.

I was hoping that dax_lock_page() and the memory_failure() handling
could go in before the xarray rework. This helps -stable and distros
that need to backport this error handling support. Willy, would you be
amenable to rebasing on top of the next rev of the
dax+memory_failure() work?

Apologies for the thrash.
