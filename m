Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF98C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2A8217BB
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgJHwsdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2A8217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeHEKhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 06:37:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46267 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHEKhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 06:37:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so16992795oie.13;
        Sun, 05 Aug 2018 01:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qsP+s47x++DYY+iN3K+Nt/+lBilgOjxgZUWGiMMFKhs=;
        b=CgJHwsdbWIWLZTAgPa/0BJvi1nhjobB91O2fk9knapTbXcNYnqcJRdt1ft9IyOYvfI
         zjA7nAQYwDcv7bx9nY5Lr/WI8qecA5UoBalyWi9UYcIkJvkJp3C7Lhf7V9AzAY9EmIPu
         T0HDrs8CkKfpALicUFs3igRXGpAtbtt7kdu8EzNsi6AzmiXs/I71QDr5sqjZDYqGdcZM
         NkSOcS+QOjyIdMw5dxdFj54sNzHPeP1HmPxxvnyUUOz/MUrIvSIdPpTZwdNzrGEp6bs1
         U8JpSafC1/0el0dsey3p8V5sYuxK9JSvb7qMbzGVSf1wm1TXgE4mTFDap3TNqnswDtdR
         785Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qsP+s47x++DYY+iN3K+Nt/+lBilgOjxgZUWGiMMFKhs=;
        b=n73QH0sXjg9wir+DcGUUNsKEtBBwY23Y/77SBumdfZrS/RIL/aJZEA6Lrj9ZTYUeRx
         02F8TmX+p9Pj71O2QVfw2JKws1znFr3993hAh9b8BjPVH6i/68fMVkng+a8ahAe6Bf6N
         OUujkMvQprIL6ZGGnXthVNelCyO8gCzkTskj5r9WCcvwKpWbY/u/xbxzaq/EgwHo8wfy
         o5GrecsyYJAOMpnMLcHlB/iUiGWUROKFA0HKEjBbOjr8jLBtWSiKoakRf5w78f0QsxgI
         pJxIGTmTq90pGr5U3twav09sbSlConZfsw3VeDsm2obtCITf7rxjzqzCiXS5TV8nd2np
         wxWQ==
X-Gm-Message-State: AOUpUlF4uIpwJw3xSqt6PdnNapZ0s2rFCRsNhkDyY1cWgTPo7qw+iUMO
        g8i4cE+e0NMPGUVXvEwjHjB0nNb6aE/Q2AjkQEw=
X-Google-Smtp-Source: AAOMgpdubfm2+XMj8EkDbvoA6bQbofK+R+Zgv5x0Q2CWYD/fbnxas4jB2AWA202XxvF/AkyGn/tk+lobMDd2kYeJSRo=
X-Received: by 2002:aca:f401:: with SMTP id s1-v6mr10786906oih.269.1533458038799;
 Sun, 05 Aug 2018 01:33:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 01:33:38 -0700 (PDT)
In-Reply-To: <20180805074946.GA14119@infradead.org>
References: <CAJs94EZA=o5=4frPhXs3vnr4x-__gSZ2ximvTyugLoaD6KLcUg@mail.gmail.com>
 <Pine.LNX.4.44L0.1808041045060.25853-100000@netrider.rowland.org> <20180805074946.GA14119@infradead.org>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Sun, 5 Aug 2018 11:33:38 +0300
X-Google-Sender-Auth: lgbxPGvEkrmWgv7FhhY07-uxNyM
Message-ID: <CAJs94Eb_Mzxk6a+_b8ZnutdkBjrk5=UWg0F1X0-iRZK1do5uLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: usb: pwc: Don't use coherent DMA buffers for
 ISO transfer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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

2018-08-05 10:49 GMT+03:00 Christoph Hellwig <hch@infradead.org>:
> On Sat, Aug 04, 2018 at 10:46:35AM -0400, Alan Stern wrote:
>> > 2) dma_unmap and dma_map in the handler:
>> > 2A) dma_unmap_single call: 28.8 +- 1.5 usec
>> > 2B) memcpy and the rest: 58 +- 6 usec
>> > 2C) dma_map_single call: 22 +- 2 usec
>> > Total: 110 +- 7 usec
>> >
>> > 3) dma_sync_single_for_cpu
>> > 3A) dma_sync_single_for_cpu call: 29.4 +- 1.7 usec
>> > 3B) memcpy and the rest: 59 +- 6 usec
>> > 3C) noop (trace events overhead): 5 +- 2 usec
>> > Total: 93 +- 7 usec
>> >
>> > So, now we see that 2A and 3A (as well as 2B and 3B) agree good within
>> > error ranges.
>>
>> Taken together, those measurements look like a pretty good argument for
>> always using dma_sync_single_for_cpu in the driver.  Provided results
>> on other platforms aren't too far out of line with these results.
>
> Logically speaking on no-mmio no-swiotlb platforms dma_sync_single_for_cpu
> and dma_unmap should always be identical.  With the migration towards
> everyone using dma-direct and dma-noncoherent this is actually going to
> be enforced, and I plan to move that enforcement to common code in the
> next merge window or two.
>

I think that Alan means that using dma_sync_single_for_cpu() we save
time required for subsequent dma_map() call (which is required when we
do dma_unmap()).

So, does everybody happy with dma_sync_single_for_cpu() for now? If
so, then I'll prepare new version of the patch series.

-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
