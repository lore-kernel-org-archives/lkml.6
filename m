Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FD0C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED78621776
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="NPpiU691"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED78621776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanguardiasur.com.ar
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeHHSuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:50:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38832 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHSuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:50:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so1261816plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9m4EzFrK4o7iKi+yVMqTnAXeSoP5rWcrhp2zGMzxHQ=;
        b=NPpiU691Vs6iBhcToq3ZnpjTAgzXLr3y4Jn7nvjQbAJ0aDfjm1hM6cbywXGTbxdTY8
         Aqeqah9pWX3kYfjBnjKbBIsNuye49REYFpX1o7F4hGUn4xdixiGknYV6Q+F/P94aKFyO
         33ERTcGXZIf7VU5jWP4nIy8gPnptqWElgW66mlgjJXCcf8aRkPt1YNLRdwzg1fgj8zxY
         MXH1i0aW4q5bK4O6vy7xAmdhNeUPrPd8XnqGgTCqOcc7xTxtmSFb4kQsyLjA1mT/VJfe
         nfTbsF/VRzuPH3r+1KbO627ZN5/SQUlH7ULcexJlDpmpXmJtfIGsb/JE8FmlZdeLwRSJ
         LlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9m4EzFrK4o7iKi+yVMqTnAXeSoP5rWcrhp2zGMzxHQ=;
        b=Mojcnc3TE6Qe2k84xwfMEUr++pTVrEx4aKAIxA3kvHOxiCHvbsx1dUhzCFlzCTx88G
         AYzik/Xenk77J5FVSmTisTOs1oQzc7OC6ofc6/sDKijagB4KGcmqpJDyHyU8AzaWQU33
         0+WXELKzL7nUmaYArAYI9Xj+xjvlzdhzmDSk//thO4m8S3H0GUjZdLtEQ5g106/euXHs
         28m/t71K8zl7j0oJbTl5T2BjjK6Al9Bm7fgkK9AbnYKP/aYoujQUNw/WgAIpvTSavQbz
         Q3iW3DkcZ88PTWHJNotWaG0B41WN1zwlrnQT6uXCNRdjTCAOXxHK0X6EYdO9dCX9qsPY
         oQ/A==
X-Gm-Message-State: AOUpUlF/4IXqUoNsybSzM7iTBSxtSANguPufyDFhfguqjPpu2SgIhvaK
        kJTaghVxtq0MsFv/ZCNjWER3h7kS6eMexowe1CDIZQ==
X-Google-Smtp-Source: AA+uWPwlhSXnr7oTwLSvJiK5dg8GT5MCQQP+bVmuaLBl57g3/McLr/ppf9+6w5laK78ORg32EYov2Iak8b08sXbh57I=
X-Received: by 2002:a17:902:8482:: with SMTP id c2-v6mr3275801plo.45.1533745796807;
 Wed, 08 Aug 2018 09:29:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:5d02:0:0:0:0 with HTTP; Wed, 8 Aug 2018 09:29:56
 -0700 (PDT)
In-Reply-To: <1959555.Z0pJAWgXVZ@avalon>
References: <Pine.LNX.4.44L0.1808081015110.1466-100000@iolanthe.rowland.org> <1959555.Z0pJAWgXVZ@avalon>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 8 Aug 2018 13:29:56 -0300
Message-ID: <CAAEAJfASOfP5tMuiBtufVbH91MNHgeTqpbmyc42igSnEKMxO1Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before processing
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        kieran.bingham@ideasonboard.com,
        Douglas Anderson <dianders@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, matwey@sai.msu.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 August 2018 at 13:22, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hello,
>
> On Wednesday, 8 August 2018 17:20:21 EEST Alan Stern wrote:
>> On Wed, 8 Aug 2018, Keiichi Watanabe wrote:
>> > Hi Laurent, Kieran, Tomasz,
>> >
>> > Thank you for reviews and suggestions.
>> > I want to do additional measurements for improving the performance.
>> >
>> > Let me clarify my understanding:
>> > Currently, if the platform doesn't support coherent-DMA (e.g. ARM),
>> > urb_buffer is allocated by usb_alloc_coherent with
>> > URB_NO_TRANSFER_DMA_MAP flag instead of using kmalloc.
>>
>> Not exactly.  You are mixing up allocation with mapping.  The speed of
>> the allocation doesn't matter; all that matters is whether the memory
>> is cached and when it gets mapped/unmapped.
>>
>> > This is because we want to avoid frequent DMA mappings, which are
>> > generally expensive. However, memories allocated in this way are not
>> > cached.
>> >
>> > So, we wonder if using usb_alloc_coherent is really fast.
>> > In other words, we want to know which is better:
>> > "No DMA mapping/Uncached memory" v.s. "Frequent DMA mapping/Cached
>> > memory".
>
> The second option should also be split in two:
>
> - cached memory with DMA mapping/unmapping around each transfer
> - cached memory with DMA mapping/unmapping at allocation/free time, and D=
MA
> sync around each transfer
>

I agree with this, the second one should be better.

I still wonder if there is anyway we can create a helper for this,
as I am under the impression most USB video4linux drivers
will want to implement the same.

> The second option should in theory lead to at least slightly better
> performances, but tests with the pwc driver have reported contradictory
> results. I'd like to know whether that's also the case with the uvcvideo
> driver, and if so, why.
>

I believe that is no longer the case. Matwey measured again and the results
are what we expected: a single mapping, and sync in the interrupt handler
is a little bit faster. See https://lkml.org/lkml/2018/8/4/44

2) dma_unmap and dma_map in the handler:
2A) dma_unmap_single call: 28.8 +- 1.5 usec
2B) memcpy and the rest: 58 +- 6 usec
2C) dma_map_single call: 22 +- 2 usec
Total: 110 +- 7 usec

3) dma_sync_single_for_cpu
3A) dma_sync_single_for_cpu call: 29.4 +- 1.7 usec
3B) memcpy and the rest: 59 +- 6 usec
3C) noop (trace events overhead): 5 +- 2 usec
Total: 93 +- 7 usec

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
