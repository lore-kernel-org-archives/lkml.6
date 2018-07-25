Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3597AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD44720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbsWsOHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD44720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeGYO6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:58:48 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38664 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbeGYO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:58:47 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so13966054oie.5;
        Wed, 25 Jul 2018 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rlRgA2HAAItKHMV4Sp4q9L0nNx7KkyVsqEWQx1KRZso=;
        b=SbsWsOHeliEGtParIs4plZ6F3R+NPeC7kgUMoDb15XBbhlYvCmoFM3oDh0f59mYP3L
         T52Ruwd7G5kTeorOH/lpjiOaXsBGWrQ+hBzAreYEOnCMzO0G3hhlCc8aBAqDCh93HvpS
         3Wtx74ZCXMwTkO5PsAUxZENxwixpCLWCTxWidWocM5m8ojxqtEDxroTvK9mqTjQUZcBC
         43EqZQTquyQxhHmv5RGTP1dgDT622cXUBI4znesxUHgFFM4oeIyZOprlkxm7stbO4FcC
         ckEOuN3Y1VE4lKGlTlW4d3ZY4g4SDSwJ2l8MoXfLlKkJ8bYUtEc+K6fYo5HwSeFopuwU
         S5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rlRgA2HAAItKHMV4Sp4q9L0nNx7KkyVsqEWQx1KRZso=;
        b=Cvj+yExXxLCIJbRKijAIqGWY22EXuxb2JqmFUlB9zchvBLsQX5QNsMWUXEohZ0tZ8b
         mge4BbpGXM2Jqjtkqa7rbFEbCMgJ+zmZWzBhRCKIMaaqmzFaD8bLP3rz36FWQXILXq/m
         7/GUywLXQE7/4FFmXkm3EVdg1U/DASEO9XUK/BijDFI5Y4Q2cF5wwNDM5tYP9LPh8VmH
         js6Ry64W4UJ+6NTJnTpvlr6OXkOx/TPdowpp3m/l9r4nTOthIvca1ecXKkpSuw2CPKXB
         FQHryHzB34VJUFFNzAtk2EWBACPUyDJB8OHUIgS/rR0KxWFujBWt9C1P/vKbFr2IL4iP
         pdLw==
X-Gm-Message-State: AOUpUlEwfwRR+6wxBKEqUVmjXQjE/mb3BLrPetW5PQKDIDfb97DQze7R
        IAhl9zfRBw+kNkMcgsIr00Pn8Bh4JBuf9yAPpUZRJZKo
X-Google-Smtp-Source: AAOMgpdfqFdwsfzlUN4zbE5Y9hGBBNL72S4NS1ylXJ11XY1jwfDmOjTYdhADQpvs40PL4JOzCdruvlMBhY5AAxWRNBU=
X-Received: by 2002:aca:dec6:: with SMTP id v189-v6mr3593322oig.98.1532526421556;
 Wed, 25 Jul 2018 06:47:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 06:46:41 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1807241652550.1311-100000@iolanthe.rowland.org>
References: <CAJs94EahjbkJRWKR=2QeD=tOMR=kznwXbQgTbKvSuTg4jBk1ew@mail.gmail.com>
 <Pine.LNX.4.44L0.1807241652550.1311-100000@iolanthe.rowland.org>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Wed, 25 Jul 2018 16:46:41 +0300
X-Google-Sender-Auth: oCCfMCKZjliHDF_3-YDSk64rACY
Message-ID: <CAJs94EZpJgDg0j8sVgOd56OY53mv7VxSODbhtR5MsZnFUoJA+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Tomasz Figa <tfiga@chromium.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-24 23:55 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
> On Tue, 24 Jul 2018, Matwey V. Kornilov wrote:
>
>> 2018-07-23 21:57 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
>> > On Mon, 23 Jul 2018, Matwey V. Kornilov wrote:
>> >
>> >> I've tried to strategies:
>> >>
>> >> 1) Use dma_unmap and dma_map inside the handler (I suppose this is
>> >> similar to how USB core does when there is no URB_NO_TRANSFER_DMA_MAP)
>> >
>> > Yes.
>> >
>> >> 2) Use sync_cpu and sync_device inside the handler (and dma_map only
>> >> once at memory allocation)
>> >>
>> >> It is interesting that dma_unmap/dma_map pair leads to the lower
>> >> overhead (+1us) than sync_cpu/sync_device (+2us) at x86_64 platform.
>> >> At armv7l platform using dma_unmap/dma_map  leads to ~50 usec in the
>> >> handler, and sync_cpu/sync_device - ~65 usec.
>> >>
>> >> However, I am not sure is it mandatory to call
>> >> dma_sync_single_for_device for FROM_DEVICE direction?
>> >
>> > According to Documentation/DMA-API-HOWTO.txt, the CPU should not write
>> > to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is
>> > not needed.
>>
>> Well, I measured the following at armv7l. The handler execution time
>> (URB_NO_TRANSFER_DMA_MAP is used for all cases):
>>
>> 1) coherent DMA: ~3000 usec (pwc is not functional)
>> 2) explicit dma_unmap and dma_map in the handler: ~52 usec
>> 3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~56 usec
>>
>> So, I suppose that unfortunately Tomasz suggestion doesn't work. There
>> is no performance improvement when dma_sync_single is used.
>>
>> At x86_64 the following happens:
>>
>> 1) coherent DMA: ~2 usec
>> 2) explicit dma_unmap and dma_map in the handler: ~3.5 usec
>> 3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~4 usec
>>
>> So, whats to do next? Personally, I think that DMA streaming API
>> introduces not so great overhead.
>> Does anybody happy with turning to streaming DMA or I'll introduce
>> module-level switch as Ezequiel suggested?
>
> How about using the dma_unmap and dma_map calls in the USB core?  If
> they add the same overhead as putting them in the handler, I think it
> would be acceptable for x86_64.

Sure, that is the simplest way to implement streaming API.

>
> It certainly is odd that the dma_sync_single APIs take longer than
> simply mapping and unmapping.

Well. I am surprised too. Probably, it is related to that only 9560
bytes are used for each URB. It is only three memory pages.

>
> Alan Stern
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
