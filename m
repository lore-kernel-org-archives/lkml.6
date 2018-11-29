Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFD420673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/OJBTsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFD420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeK3Bsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:40 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44701 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbeK3Bsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:39 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so1728055iod.11;
        Thu, 29 Nov 2018 06:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eckJcny/cf4nXZGjStsczvp2JABAZxmB/lGr4Kk07JQ=;
        b=B/OJBTsKwFZNqvpEx8lBddJ1QBRak4GJQYK7YPSTr3EMd3Iofuncvvf0FQa+B4D4P5
         pi0FXK2494XFQCJg7sp08t/pBwrqkpeDL9WOGRJOrVy6vEsUQKOuJuZYIAMlBgqJF9AX
         4tTu45k8tvJWmOcs6nNwK4We5UHDnQo57itkoCxrQSsLfklDq6dUt2aDrAnPMt4ZiEw0
         2InFZjkqMGR8ujqlPBOdp9SqMsd4TzW3vwxdGAxckYMYyVuf4N3UQfMV4C4UF+rq8d94
         b1SUbhNqTQsz8Ts4aETk0+6208BV4kZ7AE/Cd3koMDTa83gjsoK3/1nNbpqBOq3hdUeZ
         W1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eckJcny/cf4nXZGjStsczvp2JABAZxmB/lGr4Kk07JQ=;
        b=jYb4JlK7sPGZYlCTSozylzGoEC2Kejl9xlLdPmhdDM1twgNJ43PsNGXTiVqlnrZObY
         vmTeUU2xGzAxuLmrJ4nfteP5cNq6bzdLAMdLbAZ53jcGlFUsVoGdGEWYipFgnbWNNgfq
         5RnTpZlGIYODYC9cygp90zSzX5fR00C5DkqXwJLwu+bAQVVxVFPFsPz7uHNVuoBH6SGQ
         hx+cOZxtgiiVH6ZgrsSzlq+Qbc6IcWKxZfViBplf+U1kyI0UD1rEkHTP1XIVC9qxE7oL
         Yy2YuQwQBlDnj5WIUS9Py1gaWyEh/rpXnNSyHQnfu+62OguACDWRnFCSC6c6bt51rkBO
         tgng==
X-Gm-Message-State: AA+aEWY1POzdqC84hscEnuWemS3iv7rXdrce4mxg0JiJzTapbU3N+3Tn
        +2BOYx9pI0BEYrK90/3YtUZhmyudY0Vcy4+ShQc=
X-Google-Smtp-Source: AFSGD/XNUmolr03t0de3GHU16ddBj7IpJgnMnPMw1j3dPNE2uuy9RQH7ZTYnd2IYoK6wsDt+ocBmYHMXQv805zqZR5k=
X-Received: by 2002:a6b:fc05:: with SMTP id r5mr1405591ioh.129.1543502583051;
 Thu, 29 Nov 2018 06:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
In-Reply-To: <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Nov 2018 09:42:50 -0500
Message-ID: <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     hch@lst.de
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:25 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Thu, Nov 29, 2018 at 9:14 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Nov 29, 2018 at 07:33:15PM +0530, Vivek Gautam wrote:
> > > dma_map_sg() expects a DMA domain. However, the drm devices
> > > have been traditionally using unmanaged iommu domain which
> > > is non-dma type. Using dma mapping APIs with that domain is bad.
> > >
> > > Replace dma_map_sg() calls with dma_sync_sg_for_device{|cpu}()
> > > to do the cache maintenance.
> >
> > As I told you before:  hell no.  If you spent the slightest amount of
> > actually trying to understand what you are doing here you'd know this
> > can't work.  Just turn on dma debugging and this will blow up in your
> > face.
>
> you can tone it down..  we weren't the ones who created the dma/iommu
> mess, we are just trying to find a way to work around it
>
> > Either you use the DMA API properly, that is you use it to map and
> > to sync, or you don't use it at all.  Mix and match between iommu
> > APIs and DMA APIs is simply not possible.
>
> I'd *love* nothing more to not use the dma api.. but on arm there is
> no other way to do cache maint.

btw, one of us will try this w/ dma debugging enabled..

Maybe the thing we need to do is just implement a blacklist of
compatible strings for devices which should skip the automatic
iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
preventing us from enabling per-process pagetables for a5xx (where we
need to control the domain/context-bank that is allocated by the dma
api).

Like I've said before, I'm open to other suggestions.  But the
automagic behind-the-scenes dma+iommu hookup really screwed us, and we
need to find some sort of solution instead of downstream hacks.

BR,
-R
