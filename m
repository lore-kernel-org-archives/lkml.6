Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1535FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CE1213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNtyrsX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfB0Jpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:45:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42170 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0Jpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:45:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so7747517pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nU1pvTeBxjZYzI6/p0pwBDVfOXSIrni5hGMGrU+WiLI=;
        b=tNtyrsX3IjGr5fKO/ZZcYPioVVqgoStdfUrRcBhUPyzVLo8pQAI6iTQzN4d2m5VQjb
         C2zxdOP11Me0m7rGTjtRtvYgSy8Trz8FL53yjBUp73c7kE9GpKxOSL5KIVdg9HgABeGX
         7o7DE7FcWSfhY7S9s1+Usvvjn1fhFEKHdQdFqdieOysjDN5czqg3T0ij6+vkMfoLpeFU
         rlH4Yo0Qj346ZxVlOMJcU0ASgvHLIRAkiZ5dGBzWEGPmENjv4+iSMfHuOtnChOQNtam2
         tG4etv9c/E5APNsbmEHTdK4XRLOv3L99DB7RQCzRD7MxyIfe1QDH92sLay5Fwy4Tyo5R
         +0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nU1pvTeBxjZYzI6/p0pwBDVfOXSIrni5hGMGrU+WiLI=;
        b=sqIihWXvKDL0S6E4eE9hksvTOZ0hGproWyBQ7rn84703aDxcWqBJlntRrqQq4SoTu0
         1q9NFJ+4El88Unr+ASed8saUJtqYmiZk3OJ4LSi0HbIPUQi5dsJr5tekBuiRFI6j1Ocu
         xWw6Fke6IbQtOdcnVcTmEQzVgu+580Qde3L7LKwmGZcL3cVuyTGGFeUzl3imtDDRlTLn
         JV0qi6vOx5jLMQvfT6pmQk9ulN8K+kMS3El/yFqFmRSGG9i8WW/b9LCERsDFwFTgKteu
         29+lhQSjqULH5ZOODnNi5SykPDJd1V8axcyBo7dYEI0IJslfqEW7YG8fZfgSVFs19kDc
         UBUw==
X-Gm-Message-State: AHQUAuYv33XXQ7jdylXIFq+xykPykDF+Ws7s2EHRlpQVwWiUzGCJGpbI
        fh1zTijNu8hGUChESGoHunv4fD2Ob8yh/4CjkiE=
X-Google-Smtp-Source: AHgI3IZtZCPKSMPFAeRkDx/cRKS/me0Dy3OL2vsy1SzBSd35CEy86M4zfxZewX1IAPK8QBXCFLwP7vQybpZKU4ZdI/I=
X-Received: by 2002:a63:2907:: with SMTP id p7mr2084676pgp.161.1551260743601;
 Wed, 27 Feb 2019 01:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20190227085050.30000-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190227085050.30000-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Feb 2019 11:45:31 +0200
Message-ID: <CAHp75VfsLJq1ei5U-jkgFc-zj-T6KCdTy8+Je+GnjB=KN4BS5w@mail.gmail.com>
Subject: Re: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        bhole_prashant_q7@lab.ntt.co.jp, Kees Cook <keescook@chromium.org>,
        john.fastabend@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:51 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Sometimes the user needs to split each entry on the mapped scatter list
> due to DMA length constrains. This helper returns a number of entities
> assuming that each of them is not bigger than supplied maximum length.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hmm... Usually we don't accept generic API without users.
Do you have any use case in mind?

> Patch was sent in 2016 initially to the DMA engine sub-system.
> Link:
>   https://patchwork.kernel.org/patch/9389821/
> This was part of a larger series:
>   https://patchwork.kernel.org/project/linux-dmaengine/list/?q=sg_nents_for_dma&archive=both&series=&submitter=&delegate=&state=*
>
> I'm not sure if this is supposed to go into DMAEngine or lib/scatterlist.
> It doesn't look like lib/scatterlist is managed by DMAEngine, so (by using
> the `get_maintainers.pl` script) I'm sending this patch to this group of
> parties.

The problem the patch tried to solve is much deeper and correct
solution should be more generic, i.e.
each channel should provide a set of parameters, such as DMA segment
size, to the users (via DMA engine API) and users should prepare the
SG list according to the limits of the channel.
In that case we don't need to re-split/re-allocate given SG list at
all, which would simplify DMA slave drivers and their users.

We discussed this topic back in 2016 with Vinod on LPC, but seems it's
not critical to solve. My case is to improve DMA performance for 8250
UART.

-- 
With Best Regards,
Andy Shevchenko
