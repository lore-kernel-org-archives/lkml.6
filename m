Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0242084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMrabFM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0242084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeGTMKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:10:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37844 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeGTMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:10:45 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so20696993oib.4;
        Fri, 20 Jul 2018 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hmlFjRSN1lLYAfCp5SbzCipavaP2bWtK0CDJjVLo+ws=;
        b=JMrabFM2mEDXOEuZJp8APUNjY+ec+aggS/3ATem0sFLRFOe97GF1xlvaHCan7B+IQF
         rRJaEJmIzoIJRcoxrSZqcLXIOjASm3ZJHbsSqYz/bJYFFomcuyGAyve8YJJlRsFMuWvq
         cJY+D5ZgLnnaNDKEc0NNgNDBHNyteVDAiA7bpdK7Y7ccPy6gfW6D7/4J0ZS/E446fv7m
         PPuxddVdl1wB5/ITF2vLBz5ABwZZv9o9oYcODZM3ZhxbJD2nQvEV8w1HcmKsrQx1dWzn
         cIeAp5j9bP4EYI+A0WuiORmPAT87BOlEtV8EkS+FO570oO49tZ0qNRZtZyNHMpEchIQp
         Vnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hmlFjRSN1lLYAfCp5SbzCipavaP2bWtK0CDJjVLo+ws=;
        b=A7gEbFPHs63ZRAVKctLipfV93OaIQkwEQUuas/QYWOSpvUVkqNayM/SOwV6tUo1pEJ
         6RG8Bc5p1BAhYmakwOQF/W/yjaGlum4jfZMvEChidDsHoSwZcgx6uKyy5AevGrm18PsD
         9aBtKLzTDAk3wXI4DZvHSdb31DS4gUNFfp8pQSGPnva7Gk4F99ZkCe6FwA39lKkZNqpV
         RKlaEwx90Ri+Y0ev2Hs0KGo1Dklavr7bwdJCrIBs39S/YvnPjZriotzcO0h2Ua0vgG5H
         aqxehSzUqEYjEDUlrK4wNrFpqEFcd8TUNMcaiDYIIwvlHdTHHwNSbQxpZ6G71Je9Ruka
         UWJw==
X-Gm-Message-State: AOUpUlFrMnG4fhzVjsxh0uM7zKH/ivCtReM4OwYBbcZ6VJf/kSvw6c10
        ovYyempymH+KXL6/O8cHchcNVsNJTBOc77jBw44=
X-Google-Smtp-Source: AAOMgpf/dfrwdYNzwh4CAW49ljNdE57vz0Vxg53HTfrGFCYMi2g/0mfm7/0dv9tHEfwF1Ye9VRL0TZoh7PBVGgtS7/Q=
X-Received: by 2002:aca:c514:: with SMTP id v20-v6mr1761880oif.153.1532085777885;
 Fri, 20 Jul 2018 04:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 04:22:37 -0700 (PDT)
In-Reply-To: <CAAFQd5D4YHOkMhyTmpPzpp9aPNoZtJMHgU1xmvb4PoPRaOFrbg@mail.gmail.com>
References: <eb2b495fe7e8bbeaf3f9e2814be4923583482852.camel@collabora.com>
 <Pine.LNX.4.44L0.1807171643120.1344-100000@iolanthe.rowland.org> <CAAFQd5D4YHOkMhyTmpPzpp9aPNoZtJMHgU1xmvb4PoPRaOFrbg@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Fri, 20 Jul 2018 14:22:37 +0300
X-Google-Sender-Auth: N6q0ZUIu0WDLVQZr7kd_CO47FKw
Message-ID: <CAJs94EY4x7GWuT1tF4cPquLRDFR060CuZAxS75nhOf0deYbG2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 13:55 GMT+03:00 Tomasz Figa <tfiga@chromium.org>:
> On Wed, Jul 18, 2018 at 5:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> On Tue, 17 Jul 2018, Ezequiel Garcia wrote:
>>
>> > Hi Matwey,
>> >
>> > First of all, sorry for the delay.
>> >
>> > Adding Alan and Hans. Guys, do you have any feedback here?
>>
>> ...
>>
>> > > > So, what is the benefit of using consistent
>> > > > for these URBs, as opposed to streaming?
>> > >
>> > > I don't know, I think there is no real benefit and all we see is a
>> > > consequence of copy-pasta when some webcam drivers were inspired by
>> > > others and development priparily was going at x86 platforms.
>> >
>> > You are probably right about the copy-pasta.
>> >
>> > >  It would
>> > > be great if somebody corrected me here. DMA Coherence is quite strong
>> > > property and I cannot figure out how can it help when streaming video.
>> > > The CPU host always reads from the buffer and never writes to.
>> > > Hardware perepherial always writes to and never reads from. Moreover,
>> > > buffer access is mutually exclusive and separated in time by Interrupt
>> > > fireing and URB starting (when we reuse existing URB for new request).
>> > > Only single one memory barrier is really required here.
>> > >
>> >
>> > Yeah, and not setting URB_NO_TRANSFER_DMA_MAP makes the USB core
>> > create DMA mappings and use the streaming API. Which makes more
>> > sense in hardware without hardware coherency.
>>
>> As far as I know, the _only_ advantage to using coherent DMA in this
>> situation is that you then do not have to pay the overhead of
>> constantly setting up and tearing down the streaming mappings.  So it
>> depends very much on the platform: If coherent buffers are cached then
>> it's a slight win and otherwise it's a big lose.
>
> Isn't it about usb_alloc_coherent() being backed by DMA coherent API
> (dma_alloc_coherent/attrs()) and ending up allocating uncached (or
> write-combine) memory for devices with non-coherent DMAs? I'm not sure

Yes, this is what exactly happens at armv7l platforms.

> how this memory is used by this driver, but if it reads from it using
> CPU, uncached mapping might be significantly slower than cached
> mapping of memory allocated with kmalloc().
>
> Best regards,
> Tomasz
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
