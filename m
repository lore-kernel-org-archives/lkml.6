Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA0EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 22:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830322084D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 22:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HkkR94uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBXWm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 17:42:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33793 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBXWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 17:42:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so5793233lje.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 14:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgFykbtzivybWAdu4ba3qU6vVxgXdDX5Rkw4zI5WnEA=;
        b=HkkR94uvhLQUL0o2rNxFIB7T/hzUQ/bv4NUuEZZNfGKcLeVaft2ngf71Ic94IjPZBj
         zRQaKJm0a1ja4R592THaKkbrWYLvJvIf4Jlcka1gj4CA0UQudsI/1ZTLX1nlW+okVsfn
         eH4heU1IrMdPgHMOnIR6WbWdX/HcNaZwjievQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgFykbtzivybWAdu4ba3qU6vVxgXdDX5Rkw4zI5WnEA=;
        b=LlA0/V3nCQs2vt5I1FGUThv/cKcWIwnXRZmoW11g1+bCq0p7/uL54KIYdCMODuHSHP
         NOa/pF1dhc2AYO043q2rDQ9Qcxv0YGQorLNO8l0Q2cqtTKQHUgQHvRRVeQvuo04ydxTn
         e7Vm2ikbGgNabTPUvS/s2BVul6xGCMgfFe7pu2W/PHm3sSYwWaOP3mpAtcgUrjrexIrR
         CUXOdV47ifyUQZ9ck0IgS8I7D7TwaI4KT+5GgMl2zsVMIDcrnhppqkegJPTFEd9AY/7K
         qkLT02jUZCaYy1U9UVqtMECeI4cvpgJJ1p53t/Sb2omCz/xs23jgIgwOCmbGC4KqKwaa
         XTmw==
X-Gm-Message-State: AHQUAubED+qGDnM8ZJymp+QB/RnSPPJivQyfRFgdiLO7HGLfFhU9lBqx
        es0NFaf/qPkK2UBIjEHE1rbhIMyL5Ig=
X-Google-Smtp-Source: AHgI3IYkyk5AhkzU4C3FJIx2PPHQX/UxrYxVIIwJZbiKjmyYNsxDa2rXxP3Mj7UXhrrPlolk162wuw==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr8029729lji.83.1551048173787;
        Sun, 24 Feb 2019 14:42:53 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f141sm2286654lfe.64.2019.02.24.14.42.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 14:42:52 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id n15so5445430lfe.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 14:42:52 -0800 (PST)
X-Received: by 2002:a19:3f44:: with SMTP id m65mr4456979lfa.136.1551048171891;
 Sun, 24 Feb 2019 14:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com> <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
In-Reply-To: <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Feb 2019 14:42:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
Message-ID: <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
To:     Alex Gagniuc <Alex_Gagniuc@dellteam.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mr.nuke.me@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 12:37 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> Dell r740xd to name one. r640 is even worse -- they probably didn't give
> me one because I'd have too much stuff to complain about.
>
> On the above machines, firmware-first (FFS) tries to guess when there's
> a SURPRISE!!! removal of a PCIe card and supress any errors reported to
> the OS. When the OS keeps firing IO over the dead link, FFS doesn't know
> if it can safely supress the error. It reports is via NMI, and
> drivers/acpi/apei/ghes.c panics whenever that happens.

Can we just fix that ghes driver?

It's not useful to panic just for random reasons. I realize that some
of the RAS people have the mindset that "hey, I don't know what's
wrong, so I'd better kill the machine than continue", but that's
bogus.

What happens if we just fix that part?

> As I see it, there's a more fundamental problem. As long as we accept
> platforms where firmware does some things first (FFS), we have much less
> control over what happens. The best we can do is wishy-washy fixes like
> this one.

Oh, I agree that platforms with random firmware things are horrid. But
we've been able to handle them just fine before, without making every
single possible hotplug pci driver have nasty problems and
workarounds.

I suspect we'd be much better off having the ghes driver just not panic.

What is the actual ghes error? Is it the "unknown, just panic" case,
or something else?

               Linus
