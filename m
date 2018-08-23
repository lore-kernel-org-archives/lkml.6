Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF93C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8554C2064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="flNx3/iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8554C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeHWLex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:34:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34527 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeHWLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:25:51 -0400
Received: by mail-io0-f193.google.com with SMTP id c22-v6so3612982iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHC1KL9cbor5hZKnz9N8gSAgr8N6N+wolekmx9rzvUk=;
        b=flNx3/iJg9wqc3iDY5m79JV6n0m1+qhbi1eeEpGo+MeuUnhfZVb01nbBxv0DjI5IL7
         5jaBVJaa730hO8O3n6B/oC2K2jAlc7Knj2L7D1UvVQQvbj7123NI2Pru7G/FJAYHCURP
         ewx2QYJaM2WgqCI10Ky6Enu01rfYin3UpjdGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHC1KL9cbor5hZKnz9N8gSAgr8N6N+wolekmx9rzvUk=;
        b=fB2hFVAkhy7MqL1h6mKyXHJDa/vjUytMBndFig8vQqQnjcXJWYBK7d7td30YRmIQAU
         Y+x3eOD/P2E4N9QmrvaXaGhC5oSiGBs9quAXsCagcv7Aze5gsPggpxiqAVWavZRTEjfz
         Gk/lqqn/qVHz2MfLzh0vmTqqhuPtUHU4FR/VPxNRBPBNe9ksbYlU8auD4ahi6Pcr4FKB
         IWFeDhY610h5XRVfqeOtbFUTWwBLbhLgbavASJ2A7y9lOF8KJ9EDCWth/KNzhNnhCh6Z
         /km83hLcM+Ez3WPWqFcDbnCAYx+6CYbGAMqU7gL0pbbqe8J1decRwab6VEDf+evfpBeq
         711Q==
X-Gm-Message-State: AOUpUlFOrh8cKnBBh3v+Hy+qCXshKV1GZp2VR9mPZdTeinMNeouBzfVR
        SjseOmh90iwjVer2lko4POlID4NU2MeE9Cg7xYaxnw==
X-Google-Smtp-Source: AA+uWPziplUEYaaBbj5mIxQgO0rU5vSsvtaM75LTnUBiVmfzKRtuOO49wJ7OKWokA/bRk7tK7Mu5f9T+3JPDKaEud6o=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr29543802iog.175.1535011049623;
 Thu, 23 Aug 2018 00:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180816200648.90458-1-swboyd@chromium.org> <20180816200648.90458-2-swboyd@chromium.org>
 <CAD=FV=Uk9XgP+6_4x685E0yM4kS+0HkEFtML+N-nkR6DzFfchQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Uk9XgP+6_4x685E0yM4kS+0HkEFtML+N-nkR6DzFfchQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Aug 2018 09:57:18 +0200
Message-ID: <CACRpkdZJ6Xa6Ge8iCkRSUek3S=LFGt710KQxotovZYgGf4qoXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pinctrl: msm: Really mask level interrupts to
 prevent latching
To:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:49 PM Doug Anderson <dianders@chromium.org> wrote:
> On Thu, Aug 16, 2018 at 1:06 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> > The interrupt controller hardware in this pin controller has two status
> > enable bits. The first "normal" status enable bit enables or disables
> > the summary interrupt line being raised when a gpio interrupt triggers
> > and the "raw" status enable bit allows or prevents the hardware from
> > latching an interrupt into the status register for a gpio interrupt.
> > Currently we just toggle the "normal" status enable bit in the mask and
> > unmask ops so that the summary irq interrupt going to the CPU's
> > interrupt controller doesn't trigger for the masked gpio interrupt.
> >
> > For a level triggered interrupt, the flow would be as follows: the pin
> > controller sees the interrupt, latches the status into the status
> > register, raises the summary irq to the CPU, summary irq handler runs
> > and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
> > interrupt, the interrupt handler runs, and finally unmask the interrupt.
> > When the interrupt handler completes, we expect that the interrupt line
> > level will go back to the deasserted state so the genirq code can unmask
> > the interrupt without it triggering again.
> >
> > If we only mask the interrupt by clearing the "normal" status enable bit
> > then we'll ack the interrupt but it will continue to show up as pending
> > in the status register because the raw status bit is enabled, the
> > hardware hasn't deasserted the line, and thus the asserted state latches
> > into the status register again. When the hardware deasserts the
> > interrupt the pin controller still thinks there is a pending unserviced
> > level interrupt because it latched it earlier. This behavior causes
> > software to see an extra interrupt for level type interrupts each time
> > the interrupt is handled.
> >
> > Let's fix this by clearing the raw status enable bit for level type
> > interrupts so that the hardware stops latching the status of the
> > interrupt after we ack it. We don't do this for edge type interrupts
> > because it seems that toggling the raw status enable bit for edge type
> > interrupts causes spurious edge interrupts.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> NOTE: IMO we should land this fix even if we continue to have debate
> on patch #2 and #3 since this fixes a definite problem.

OK makes sense, I guess I'll queue this for fixes
once v4.19-rc1 is out.

Would be nice to also get Bjorn's buy-in on it!

Yours,
Linus Walleij
