Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E4BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB84F2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547237085;
	bh=8HrNCJNiKwRhOIAF8zUg3WsP9UV5H9Cb9MN9ILHVXsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GBI5EL5rUCNTVZsA0LI8UyLDdACvHmg9jMf+zjJgZU16xqPU3FumzCYo15rYEso6f
	 qlrZs67nb/DSQ//gm7vY53N6JrqbDURWM1XaRRk/eignQUbMxVtG1V0Eapk6MkGlol
	 tz4ckLnesiKSZY8Mc1NlO3ahS9PRMtaNxmvD8LyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbfAKUEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732290AbfAKUEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:04:43 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9529021872;
        Fri, 11 Jan 2019 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547237082;
        bh=8HrNCJNiKwRhOIAF8zUg3WsP9UV5H9Cb9MN9ILHVXsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KEiv30N42JiryMcHTFeP1lEss7v/nY/2og9j1d31g9sa9Sr4hvQKj/zEe4NTs1fdM
         RE2V7EQSgk0AIVWPQFy30JiGgyP8kq3fL+GmtMgQ3k3i6XzTUXdUPERbTa+odKDKSI
         zgNuVlBT3JbOKkQ29VljyUZyUA2zAf7QrhNZ5UjM=
Received: by mail-qt1-f173.google.com with SMTP id d19so20177977qtq.9;
        Fri, 11 Jan 2019 12:04:42 -0800 (PST)
X-Gm-Message-State: AJcUukcFUnp98sNTXJrs4ltB32kzvH8vpE/s2RjOOC7A7czWsR4yO1uh
        NlQW70Pkl7vmnbQ59TMhIg89yDiMOfi5zbCJEA==
X-Google-Smtp-Source: ALg8bN5tzqCaDHDFZCV+p2dpTbBIAT8t3PKkHFQ43D+QHqHc1fB5c8VHzVObRmHp97CZFwhjxu+j/XsIcdQp4QxuWr0=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr15353917qvi.90.1547237081761;
 Fri, 11 Jan 2019 12:04:41 -0800 (PST)
MIME-Version: 1.0
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
 <1547141652-8660-3-git-send-email-john.stultz@linaro.org> <CAL_Jsq+2dYaCzLSr8n4W=ftSjgmKJaUqwQ4S7qv7ZAaR2A-5XQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+2dYaCzLSr8n4W=ftSjgmKJaUqwQ4S7qv7ZAaR2A-5XQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Jan 2019 14:04:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLm_tDakS10gch8K_3F+mHrzR3isw8Tm=D-R118D1sYQ@mail.gmail.com>
Message-ID: <CAL_JsqJLm_tDakS10gch8K_3F+mHrzR3isw8Tm=D-R118D1sYQ@mail.gmail.com>
Subject: Re: [PATCH 2/8 v3] Documentation: bindings: k3dma: Add binding for hisi-dma-avail-chan
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 1:58 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Jan 10, 2019 at 11:34 AM John Stultz <john.stultz@linaro.org> wrote:
> >
> > Some dma channels can be reserved for secure mode or other
> > hardware on the SoC, so provide a binding for a bitmask
> > listing the available channels for the kernel to use.
> >
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Tanglei Han <hantanglei@huawei.com>
> > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > Cc: Ryan Grachek <ryan@edited.us>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: dmaengine@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v3: Renamed to hisi-dma-avail-chan
> > ---
> >  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> > index 10a2f15..38825d4 100644
> > --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> > @@ -14,6 +14,9 @@ Required properties:
> >                 have specific request line
> >  - clocks: clock required
> >
> > +Optional properties:
> > +- hisi-dma-avail-chan: Bitmask of available physical channels
>
> Not quite right. Should be: hisilicon,dma-avail-chan

Actually, we already have the same case elsewhere with
'brcm,dma-channel-mask'. Maybe there are others. So make the property
common (i.e. documented in dma.txt) and called 'dma-channel-mask'.

Whether or not the dmaengine handles this or not is irrelevant to
whether the binding is common or not. I have no say over OS design
decisions.

Rob
