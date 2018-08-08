Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C7C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFB7219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOYUcDj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFB7219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeHHPFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:05:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34927 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHHPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:05:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so1628225ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhdrX9PR8GVAnqLUDLvt0in01K6XB1e91ZBu9UJo7Cg=;
        b=XOYUcDj+vZIvF/5e8xgbzyEi3053eLsXlb/VaCJuIMV1Et82tHgKRvEHWnQYgQU9Pq
         fThdEh4yOMIExsR59cwyVqVr/QJonRdfokERiiw2J1C93I0Z0m/f3kxND+KzLzIp5seP
         QhxUh8nZma+SoN/AsLoAp5r2dohNbKlhe/DhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhdrX9PR8GVAnqLUDLvt0in01K6XB1e91ZBu9UJo7Cg=;
        b=KB3tcnHWI+KXxsv2jAM3CLEScFELo1C8JwR18HkmwxzCuUcA+pHyXyhr/THG2Qriq/
         YFiC/4nxARbMpRxO1UYyUvv8IPiUsRog4X3SvGerVrntNLpZhfKyuYOmhK+yVDG3TPbl
         zGJiv10e96fKRqammFizDi1dz0S1ENRt7Z4U3hUkTCKJAp8aG4Lb7ZmFMhuZjlq04IYd
         QdGGpypYNJ8oQA6xHEyqk8QptX5CuYs7WVNtmWcHoynAZABAICd+17oGYLHzkazmo1e8
         tFk7VmdNI4y04UIZXwnAk4Eze1yFqqiJGB+8ifIq26ok0yWJ1RgyinWf5UwFbqoZa/Qu
         wg4Q==
X-Gm-Message-State: AOUpUlEkpgDVWNX/0cGasMxS7qxdzRUCn79w4elpErQbI9I60YxR/Cf3
        AqfeENQkjXhF89D9jKfQOmkNw7O1UmvviOc+P31ZHA==
X-Google-Smtp-Source: AA+uWPwekWTdaBZv+P38X97TeTiIZeK963TS2MQNJ5xMPb2unghcBeAyhKiPG2cytvK4FRsNRIVRdb9L330kCfXLZEk=
X-Received: by 2002:a2e:4d51:: with SMTP id a78-v6mr1934184ljb.106.1533732329073;
 Wed, 08 Aug 2018 05:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180627103408.33003-1-keiichiw@chromium.org> <11886963.8nkeRH3xvi@avalon>
 <CAAFQd5CM63BQ1oxmrhZuxTVj7pc=6XUJKa-cJ3gFBHxiF3HPfQ@mail.gmail.com> <3411643.50e8mdYzJX@avalon>
In-Reply-To: <3411643.50e8mdYzJX@avalon>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Wed, 8 Aug 2018 21:45:17 +0900
Message-ID: <CAD90VcbpeVatm33h2QwGnq_him5KkL1b6n8j0D_RyUyRi3osaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before processing
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        kieran.bingham@ideasonboard.com,
        Douglas Anderson <dianders@chromium.org>,
        stern@rowland.harvard.edu, ezequiel@collabora.com,
        matwey@sai.msu.ru
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent, Kieran, Tomasz,

Thank you for reviews and suggestions.
I want to do additional measurements for improving the performance.

Let me clarify my understanding:
Currently, if the platform doesn't support coherent-DMA (e.g. ARM),
urb_buffer is allocated by usb_alloc_coherent with
URB_NO_TRANSFER_DMA_MAP flag instead of using kmalloc.
This is because we want to avoid frequent DMA mappings, which are
generally expensive.
However, memories allocated in this way are not cached.

So, we wonder if using usb_alloc_coherent is really fast.
In other words, we want to know which is better:
"No DMA mapping/Uncached memory" v.s. "Frequent DMA mapping/Cached memory".

For this purpose, I'm planning to measure performance on ARM
Chromebooks in the following conditions:
1. Current implementation with Kieran's patches
2. 1. + my patch
3. Use kmalloc instead

1 and 2 are the same conditions I reported in the first mail on this thread.
For condition 3, I only have to add "#define CONFIG_DMA_NONCOHERENT"
at the beginning of uvc_video.c.

Does this plan sound reasonable?

Best regards,
Keiichi
On Wed, Aug 8, 2018 at 5:42 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Tomasz,
>
> On Wednesday, 8 August 2018 07:08:59 EEST Tomasz Figa wrote:
> > On Tue, Jul 31, 2018 at 1:00 AM Laurent Pinchart wrote:
> > > On Wednesday, 27 June 2018 13:34:08 EEST Keiichi Watanabe wrote:
> > >> On some platforms with non-coherent DMA (e.g. ARM), USB drivers use
> > >> uncached memory allocation methods. In such situations, it sometimes
> > >> takes a long time to access URB buffers.  This can be a cause of video
> > >> flickering problems if a resolution is high and a USB controller has
> > >> a very tight time limit. (e.g. dwc2) To avoid this problem, we copy
> > >> header data from (uncached) URB buffer into (cached) local buffer.
> > >>
> > >> This change should make the elapsed time of the interrupt handler
> > >> shorter on platforms with non-coherent DMA. We measured the elapsed
> > >> time of each callback of uvc_video_complete without/with this patch
> > >> while capturing Full HD video in
> > >> https://webrtc.github.io/samples/src/content/getusermedia/resolution/.
> > >> I tested it on the top of Kieran Bingham's Asynchronous UVC series
> > >> https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html.
> > >> The test device was Jerry Chromebook (RK3288) with Logitech Brio 4K.
> > >> I collected data for 5 seconds. (There were around 480 callbacks in
> > >> this case.) The following result shows that this patch makes
> > >> uvc_video_complete about 2x faster.
> > >>
> > >>            | average | median  | min     | max     | standard deviation
> > >> w/o caching| 45319ns | 40250ns | 33834ns | 142625ns| 16611ns
> > >> w/  caching| 20620ns | 19250ns | 12250ns | 56583ns | 6285ns
> > >>
> > >> In addition, we confirmed that this patch doesn't make it worse on
> > >> coherent DMA architecture by performing the same measurements on a
> > >> Broadwell Chromebox with the same camera.
> > >>
> > >>            | average | median  | min     | max     | standard deviation
> > >> w/o caching| 21026ns | 21424ns | 12263ns | 23956ns | 1932ns
> > >> w/  caching| 20728ns | 20398ns |  8922ns | 45120ns | 3368ns
> > >
> > > This is very interesting, and it seems related to https://
> > > patchwork.kernel.org/patch/10468937/. You might have seen that discussion
> > > as you got CC'ed at some point.
> > >
> > > I wonder whether performances couldn't be further improved by allocating
> > > the URB buffers cached, as that would speed up the memcpy() as well. Have
> > > you tested that by any chance ?
> >
> > We haven't measure it, but the issue being solved here was indeed
> > significantly reduced by using cached URB buffers, even without
> > Kieran's async series. After we discovered the latter, we just
> > backported it and decided to further tweak the last remaining bit, to
> > avoid playing too much with the DMA API in code used in production on
> > several different platforms (including both ARM and x86).
> >
> > If you think we could change the driver to use cached buffers instead
> > (as the pwc driver mentioned in another thread), I wouldn't have
> > anything against it obviously.
>
> I think there's a chance that performances could be further improved.
> Furthermore, it would lean to simpler code as we wouldn't need to deal with
> caching headers manually. I would however like to see numbers before making a
> decision.
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
