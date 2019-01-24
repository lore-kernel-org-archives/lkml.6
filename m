Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C950C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E31218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMtBVCwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfAXJ27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:28:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53637 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAXJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:28:58 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so3898405ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOgiQRbEc2ZGqRBKfFg3466MI00NsQxMby/czhlkrn8=;
        b=MMtBVCwoX7nPmat/Zu3fE2gyRB686DtszfASBsWsXelgf4qP/4lsF5RHThNfDZ2PGF
         FJFoVf3loh8VmbUbY2RSyR1yt3lJO1DfKOxDWwhGbWiWvFkdJO6VccXXj6cFXBeysLnZ
         CbU513EbflTpqigfkgAMUXrgb+ENJG7JykNcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOgiQRbEc2ZGqRBKfFg3466MI00NsQxMby/czhlkrn8=;
        b=i0Z9KQ6f93dbYkAfXZRkUEZyUEesmz2upA/bTiX8AEl24bkuT2KUonoYdWhpFDO5RM
         ZH+RFpwTN0gInR/I6NoJ1onOo5i4RYRHVa+owEL0D+IqtEtuTiYDE9hQG6Su68m3f5RY
         nVOz9wtVEF/cCwZLUQrma1ymETdfz9+uzRiNgkEjxBZ+jxniaNGlKDw1+8ckAsuiRhhk
         7+3vQZeCpd2xhwjevt0HIcyZDjQn/45bIwj1ltr2c6HIDHgzw1MriBnsnQ7SLy7reh9K
         xexqkIPHOeer0XFW7AooygUgodfm3zotii0QnUQ8PCip8svgK1Tew1SU2+ICd0bWNSEN
         2HoQ==
X-Gm-Message-State: AJcUukd0VrGnw9TUbQgkAO/S99iCnK3kikRyeTqdBODgthLJhiOdnlbg
        mkRHBtRXma4mGv7NKy/PtWxzHhJfALQ2uTvIe/ybKPee7Wo=
X-Google-Smtp-Source: ALg8bN4JgLY/gFm1maSc+bETsFLPr/UaeNA5zos+EvnXWXoWHcBplWfV4NYk6BxLzUsPHoa/pw9yrVnfZefdjBf+mPA=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr1058463ith.158.1548322137295;
 Thu, 24 Jan 2019 01:28:57 -0800 (PST)
MIME-Version: 1.0
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org> <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org> <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org> <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
In-Reply-To: <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 24 Jan 2019 10:28:45 +0100
Message-ID: <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 10:25, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 24.01.19 um 10:13 schrieb Christoph Hellwig:
> > On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
> >> But my concern is that it seems likely that non-cache coherent
> >> implementations are relying on this hack as well. There must be a
> >> reason that this hack is only disabled for PowerPC platforms if they
> >> are cache coherent, for instance, and I suspect that that reason is
> >> that the hack is the only thing ensuring that the CPU mapping
> >> attributes match the device ones used for these buffers (the vmap()ed
> >> ones), whereas the rings and other consistent data structures are
> >> using the DMA API as intended, and thus getting uncached attributes in
> >> the correct way.
> > Dave, who added that commit is on Cc together with just about everyone
> > involved in the review chain.  Based on the previous explanation
> > that idea what we might want an uncached mapping for some non-coherent
> > architectures for this to work at all makes sense, but then again
> > the way to create those mappings is entirely architecture specific,
> > and also need a cache flushing before creating the mapping to work
> > properly.  So my working theory is that this code never properly
> > worked on architectures without DMA coherent for PCIe at all, but
> > I'd love to be corrected by concrete examples including an explanation
> > of how it actually ends up working.
>
> Cache coherency is mandatory for modern GPU operation.
>
> Otherwise you can't implement a bunch of the requirements of the
> userspace APIs.
>
> In other words the applications doesn't inform the driver that the GPU
> or the CPU is accessing data, it just does it and assumes that it works.
>

Wonderful!

In that case, do you have any objections to the patch proposed by
Christoph above?
