Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3EBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BD6206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVPuTtR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391706AbfAKOyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:54:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46625 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390609AbfAKOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so13110076ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiz7Wr5zV9F15CaqgmTVT3cwFrrlab1AeDN8mYEG4jo=;
        b=WVPuTtR/ndViS6PFHzXI9F1Drm5p2L4SAy8RtXsWyB+IcFpKeV/f1qWP9JMP82GGw5
         RPW+cQWj5JQxdsJ+3HbaYZUgmZl7C7N4Qt4NLFQX+oriYnlFY5bvDNiu9AQ3wCMeBlGW
         h9n68eEY8zgkvZdiWaHvAaKNV2MWJcZxjXxTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiz7Wr5zV9F15CaqgmTVT3cwFrrlab1AeDN8mYEG4jo=;
        b=c0+tqL6SzdkZyScdSrYMHy7Gv5oHagGsF2Kj/ksqmXz11fwn4u0rHoJL//XDry6lZ7
         slFsNEJYKiv5Df1noBZDC5xfr/TxfYtvmWEA3lP+aFZeqpUTrsFL7w4k8rBBxKJxFnzm
         KQKPRpwYx2y5Dmk0Uopa8arEZS4iBEtCSZA6N2+qDImjk3RFm0+x+DsPRSIZGOfUCIIe
         sFx2Z7Y+mMUEo4FJNiyK1iha+sjzxcmGi6BYRCmtSlwa/GYGdcTIUwFnQRDI3lkTRdzv
         +7tj03QvKwt+dFNfOqiF0sNfk1rz07uRJIuB+XjEDmRzAkXIdsZQbFpsdAnknat2sLcS
         RLcg==
X-Gm-Message-State: AJcUukfK+f7nCmDmxo7hQ+56yWFVZyvodykW/lq0J2o5/feuI64VYSOv
        oygHg60LOipVAUvMmlxGMFZabzDiGu4Z51JIVK+NUg==
X-Google-Smtp-Source: ALg8bN7eohjr6xkd+13r3SWcDb/8yGYqS1LG43RZFSuqfWoXCaXwLMfVkvAytlhCZ8ADpSaOyOAkaJZwRmsxv0jMZvY=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr8758978ljc.97.1547217438950;
 Fri, 11 Jan 2019 06:37:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1502103715.git.michal.simek@xilinx.com> <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com> <20190107164210.3ecf37e8@windsurf>
 <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com> <20190111135413.73dad0b2@windsurf>
In-Reply-To: <20190111135413.73dad0b2@windsurf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 15:37:07 +0100
Message-ID: <CACRpkdZVfH_LYQov5mkMvp6BWjkVsisawWuE1PMp0b8dW5Qc=g@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Borsodi Petr <Petr.Borsodi@i.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 1:54 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> On Fri, 11 Jan 2019 10:54:20 +0100, Linus Walleij wrote:
>
> > My stance is that the driver is responsible of enabling and managing
> > runtime PM for its hardware block(s).
> >
> > Runtime PM in the core should only be added if the core needs to
> > be aware about it, such as is the case when e.g. a block device
> > needs to drain its write buffer before going to runtime sleep.
> >
> > I fail so see why the GPIO core need to be aware about this.
>
> In this very same thread at
> https://www.spinics.net/lists/arm-kernel/msg600515.html, you kind of
> proposed to handle this in the core in fact :-) Though indeed you said
> that the core could provide helpers.

Yeah allright, I have never been good with consistency but what I guess
I would mean to say (today) is that the driver needs to be in the driver
seat (heh) and opting in to any runtime PM support.

This is in contrast with "midlayer" where all drivers are forced to behave
"as if" they had runtime PM (i.e. calls are done to the runtime PM helpers
even if the device doesn't really activate runtime PM).

Yours,
Linus Walleij
