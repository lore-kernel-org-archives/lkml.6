Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D2CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4394F217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah3S27jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4394F217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeHDKF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 06:05:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40274 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 06:05:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so13883855oie.7;
        Sat, 04 Aug 2018 01:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/XT79+YaXF4bnqRXVByuEWWbO6TtkLHaQ65WwoEWUE0=;
        b=ah3S27jkrR3HS4aUuERSR/Dl72eJy1dFzf27HFcvVTlLddhyQng8sDP681KUuhKSDq
         NYG4wcASEWoUOm9wMYv5l/nIc1Kw1eh6v4ILCiwEAUVp5jvOQ804w5J0i1yfHvevmg5g
         IF2DvoSBx+4Pi78tyCLCbXA+YOl8llTcUMtZBjrPiDUERa9RJhMn/WfXG5rseCrTL+9x
         Ku4T2iJxm3V4I+MqNqRxJmbsC+ciQT8ogFPt6IT76VW/AxDTuhR7PhiHnO1MN/THlyd2
         bzcTvSGT0AstqQZbCiPi/8obL2OPw4XMh2fJ3zcl822E7UOEho3MoNsOFioB4/dDu9L6
         wjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/XT79+YaXF4bnqRXVByuEWWbO6TtkLHaQ65WwoEWUE0=;
        b=Usr+oVxOxhBBF8Ajoaz3PpR/vaPXQC5UWgP4wMM5TnMX/TPeOAFXXXQ9phVe1US9yA
         wbAFDqo5yOpXCmHjsEva71SMNHW8afssDNEF5yWUF4YU/7VGP02pfh68vXodFp5Obic8
         1zxioVWpW/cSDgmLtWkp9OUD7buZ8Hm70M+urYrfGUv7tsFyQ4EVzTU56U3z7i5CS105
         iFU17abhkrw11NpMp12wJ03QgXTJ9pmX1+j7xdhK0p8QrUWGiheyCVUBpHHMhN0oVRAy
         l22Yd/whiUnjBT82I5zAmCPBtZ0n9tjCFS51SYPnGVm/BqKWlh/DDYMfPNwX7nig8upB
         Lutw==
X-Gm-Message-State: AOUpUlECuLEb9Fr2dn6+Eezhe1AzEXncJs8+ZorYJwRoPjL9x2quoygs
        SzWbGG7+1GPesMXB/UhAeHclAfW9cBxh1umZwbJSVZDRaWM=
X-Google-Smtp-Source: AAOMgpcxUwR/QAtHE0+je/MPgYnaTTknmR2vmATOQEC7omMbDpsaPBmfwMwHBesjTSGnlI0I/KnG7ORQWQY+JjHg1Cg=
X-Received: by 2002:aca:578b:: with SMTP id l133-v6mr6959476oib.329.1533369971113;
 Sat, 04 Aug 2018 01:06:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 01:05:50 -0700 (PDT)
In-Reply-To: <CAAFQd5AKJrCAAFiis-YjKFULPb1zqboPVSgT8Uepg-C561fgeg@mail.gmail.com>
References: <CAJs94EahjbkJRWKR=2QeD=tOMR=kznwXbQgTbKvSuTg4jBk1ew@mail.gmail.com>
 <Pine.LNX.4.44L0.1807241652550.1311-100000@iolanthe.rowland.org>
 <CAJs94EZpJgDg0j8sVgOd56OY53mv7VxSODbhtR5MsZnFUoJA+g@mail.gmail.com> <CAAFQd5AKJrCAAFiis-YjKFULPb1zqboPVSgT8Uepg-C561fgeg@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Sat, 4 Aug 2018 11:05:50 +0300
X-Google-Sender-Auth: cv6_B7fG9tK0kUIMNbjEoTKk6aU
Message-ID: <CAJs94EYAEoTM+B79TBTy934FVqOrruv962ZnymO3N6YbfccYLw@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-30 7:14 GMT+03:00 Tomasz Figa <tfiga@chromium.org>:
> On Wed, Jul 25, 2018 at 10:47 PM Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>>
>> 2018-07-24 23:55 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
>> > On Tue, 24 Jul 2018, Matwey V. Kornilov wrote:
>> >
>> >> 2018-07-23 21:57 GMT+03:00 Alan Stern <stern@rowland.harvard.edu>:
>> >> > On Mon, 23 Jul 2018, Matwey V. Kornilov wrote:
>> >> >
>> >> >> I've tried to strategies:
>> >> >>
>> >> >> 1) Use dma_unmap and dma_map inside the handler (I suppose this is
>> >> >> similar to how USB core does when there is no URB_NO_TRANSFER_DMA_MAP)
>> >> >
>> >> > Yes.
>> >> >
>> >> >> 2) Use sync_cpu and sync_device inside the handler (and dma_map only
>> >> >> once at memory allocation)
>> >> >>
>> >> >> It is interesting that dma_unmap/dma_map pair leads to the lower
>> >> >> overhead (+1us) than sync_cpu/sync_device (+2us) at x86_64 platform.
>> >> >> At armv7l platform using dma_unmap/dma_map  leads to ~50 usec in the
>> >> >> handler, and sync_cpu/sync_device - ~65 usec.
>> >> >>
>> >> >> However, I am not sure is it mandatory to call
>> >> >> dma_sync_single_for_device for FROM_DEVICE direction?
>> >> >
>> >> > According to Documentation/DMA-API-HOWTO.txt, the CPU should not write
>> >> > to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() is
>> >> > not needed.
>> >>
>> >> Well, I measured the following at armv7l. The handler execution time
>> >> (URB_NO_TRANSFER_DMA_MAP is used for all cases):
>> >>
>> >> 1) coherent DMA: ~3000 usec (pwc is not functional)
>> >> 2) explicit dma_unmap and dma_map in the handler: ~52 usec
>> >> 3) explicit dma_sync_single_for_cpu (no dma_sync_single_for_device): ~56 usec
>
> That's very strange because on ARM dma_unmap_single() does exactly the
> same thing as dma_sync_single_for_cpu():
>
> arm_dma_map_page()
> https://elixir.bootlin.com/linux/v4.18-rc7/source/arch/arm/mm/dma-mapping.c#L129
> arm_dma_unmap_page()
> https://elixir.bootlin.com/linux/v4.18-rc7/source/arch/arm/mm/dma-mapping.c#L159
>
> arm_dma_sync_single_for_cpu()
> https://elixir.bootlin.com/linux/v4.18-rc7/source/arch/arm/mm/dma-mapping.c#L167
>
> Could you post the code you used for testing of cases 2) and 3)?

I remeasured the timings (see my other mail).
The code you asked is here:
https://github.com/matwey/linux/tree/pwc_dma_v3 but I am going to
rebase this branch.

>
> Best regards,
> Tomasz
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
