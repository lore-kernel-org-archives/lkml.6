Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3113BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A2C21019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MHhWc47+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfBYAnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 19:43:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBYAnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 19:43:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id u21so5586478lfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFrUlEOjued1wJA3N6kxyWg2OjZbJC/Aci0z7O3+QUU=;
        b=MHhWc47+xQz3aAQAD/8/6cvlgHxztPBQ9lwiLHZKZwvNCTVVrK16qxlD7Hxfcw5jeC
         KLgNFCT7CRhc1zj2Fp9am96Hfu99aUiRwvhYd+utNx+XHYH9W7W5p5dHiQ6SHqOBj20G
         Go/N3YcvB3Cfn2qDsDiq5Cz6UvDpykcRL2+Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFrUlEOjued1wJA3N6kxyWg2OjZbJC/Aci0z7O3+QUU=;
        b=q0FLDLQ3BrU45yC93fLcLUpBZ2slgBq1AElGf9VbSsbinSxsgtxP8DahRYFMo3n0ty
         SDnh3zBBtfyxrczTT+wd938kH6GbLmspWo9FceZ9XcWsVuFu7BkrQBNKEjsmahorzo4T
         GI7WXD2SwOSHmFpPyCDV5gNz4gPuTE+BlAwAkGffK0Z75SEdAjxNhplkkoLsrerx3gST
         hNt9g7AcxcxjxGlEjyP0LJBowf84JVn6Xx6FoaYwZz2zjPPt6ePgPx7a7s15EsGXRjyA
         KlLXTiKVsAFPY3u+UYZ+i2MAMkkWhYDK0k0jcIayrytnKsshzUVY6sXP2y7gAdOZe/Of
         7M7Q==
X-Gm-Message-State: AHQUAuYwneVlq3a2QCx3EL8udLSr0DtISk+rCxN+nw4mmD5ZeuIGoWVE
        HSYDKm2NZSYsPSG52lzPa68x3z+3z/I=
X-Google-Smtp-Source: AHgI3IZslREJRZr/CMifP2RWzp0QXiHaMEvRF/4G22RbC5p9JpN0/MTioLGbSvZlPoT1oGehZDySTg==
X-Received: by 2002:ac2:50c5:: with SMTP id h5mr9277030lfm.13.1551055424261;
        Sun, 24 Feb 2019 16:43:44 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id g24sm157854lja.75.2019.02.24.16.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 16:43:43 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id q12so5583574lfm.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 16:43:42 -0800 (PST)
X-Received: by 2002:a19:3f44:: with SMTP id m65mr4614142lfa.136.1551055422540;
 Sun, 24 Feb 2019 16:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com> <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
In-Reply-To: <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Feb 2019 16:43:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSN1cPoOigEAcyBOjOFeKGL9kX3xvKgZ8SYqQQd2stQQ@mail.gmail.com>
Message-ID: <CAHk-=whSN1cPoOigEAcyBOjOFeKGL9kX3xvKgZ8SYqQQd2stQQ@mail.gmail.com>
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

On Sun, Feb 24, 2019 at 3:27 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> >
> > It's not useful to panic just for random reasons. I realize that some
> > of the RAS people have the mindset that "hey, I don't know what's
> > wrong, so I'd better kill the machine than continue", but that's
> > bogus.
>
> That's the first thing I tried, but Borislav didn't like it. And he's
> right in the strictest sense of the ACPI spec: a fatal GHES error must
> result in a machine reboot [1].
>
> > What happens if we just fix that part?
>
> On rx740xd, on a NVMe hotplug bay, the upstream port stops sending
> hotplug interrupts. We could fix that with a quirk by clearing a
> proprietary bit in the switch. However, FFS won't re-arm itself to
> receive any further errors, so we'd never get notified in case there is
> a genuine error.

But this is not a genuine fatal error.

When spec and reality collide, the spec is just so much toilet paper.

In fact, the spec is worth _less_ than toilet paper, because at least
toilet paper is useful for wiping your butt clean. The spec? Not so
much.

> Keith Busch of Intel at some point suggested remapping all MMIO
> resources of a dead PCIe device to a read-only page that returns all
> F's. Neither of us were too sure how to do that, or how to handle the
> problem of in-flight DMA, which wouldn't hit the page tables.

I agree that that would be a really cute and smart way to fix things,
but no, right now I don't think we have any kind of infrastructure in
place to do something like that.

> > What is the actual ghes error? Is it the "unknown, just panic" case,
> > or something else?
>
> More like "fatal error, just panic". It looks like this (from a serial
> console):
>
> [   57.680494] {1}[Hardware Error]: Hardware error from APEI Generic
> Hardware Error Source: 1
> [   57.680495] {1}[Hardware Error]: event severity: fatal

Ok, so the ghes information is actively wrong, and tries to kill the
machine when it shouldn't be killed.

I seriously think that the correct thing is to fix the problem at the
*source* - ie the ghes driver. That's the only driver that should care
about "this platform is broken and sends invalid fatal errors".

So instead of adding hacks to the nvme driver, I think the hacks
should be in the ghes driver. Possibly just a black-list of "this
platform is known broken, don't even enable the ghes driver for it".
Or possibly a bit more fine-grained in the sense that it knows that
"ok, this particular kind of error is due to a hotplug event, the
driver will handle it without help from us, so ignore it".

                 Linus
