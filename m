Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578A7C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C82E20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C82E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeKIUQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:16:30 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38509 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbeKIUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:16:30 -0500
Received: by mail-vk1-f196.google.com with SMTP id w72so293621vkd.5;
        Fri, 09 Nov 2018 02:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8vW0xAUgfKUdbaaEaMujTTe8aswgIr8la1V/zBzx/E=;
        b=Udn5FiLe9rXFFDDBzZWjEz2tshpZqh9Y05GpmVF0CGqWZUZWDFE3OzSvT/6C4/C5zJ
         o7WaDxfSfsZ+kaTPXH0a4yGYnqu54UHyzJuju2xb9xfDkyy9gfoex0qLmf30Rzg+nchD
         BEltPR5ieDUrt3Cea4TRhFcqNI+iHz/l8dVAqGSiwofjN8QvvH4Wz3niztA9xUVpS2Fa
         H+VUmUbrTMpT16AUaMGe+1vUdvGJcOcqocMV/qmsMcm/F6yAcCUQ+3SyGEUC5mt0ypy0
         Nw3NGtuhdrZxvMlvvG0WTCH9wm01u/qhkjY8sv/YoqFyeKHfUCEJGvKp3BY3ShLFDlpB
         6CDg==
X-Gm-Message-State: AGRZ1gIVfV0xlci+U0SHdAWCVY5pGktGKDgVMY93D4yfFZ0tBpJBA1q3
        4wsd9IW7c3b74TRtk4Iju5T5NWMOQZQ9E+KUT6g=
X-Google-Smtp-Source: AJdET5e6mFEc4wIVAgOVzzhlNpQFZwdfLu3SA4+UMTyfODOI72OzxWWGbWGmr3TlFy15bgTsG+2/DTB+12jvgC+8Z2w=
X-Received: by 2002:a1f:1881:: with SMTP id 123mr363263vky.40.1541759789855;
 Fri, 09 Nov 2018 02:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20181106183609.207702-1-sboyd@kernel.org> <20181106183609.207702-2-sboyd@kernel.org>
 <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com> <154169993998.88331.10494065577891939152@swboyd.mtv.corp.google.com>
 <0f2bb386-ba92-544c-e980-c95309944b22@gmail.com>
In-Reply-To: <0f2bb386-ba92-544c-e980-c95309944b22@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Nov 2018 11:36:17 +0100
Message-ID: <CAMuHMdWm2P8fa6d9vLhYtWHBe0uNPj9jfyL1rtmdLixPEi1rUg@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, ryder.lee@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Fri, Nov 9, 2018 at 11:29 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 08/11/2018 18:58, Stephen Boyd wrote:
> > Quoting Matthias Brugger (2018-11-08 00:29:46)
> >> On 06/11/2018 19:36, Stephen Boyd wrote:
> >>> +int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
> >>> +{
> >>> +     int (*probe_func)(struct platform_device *pdev);
> >>> +
> >>> +     probe_func = of_device_get_match_data(&pdev->dev);
> >>
> >> Shouldn't we check if probe_func is not NULL?
> >
> > Is the oops from the NULL pointer deref insufficient?
>
> Do you think we should crash the machine if someone uses the call wrongly? Or
> should we provide the possibility to error out on the caller side?

I believe that would be a bug in the driver, to be discovered ASAP.
So yes, please do crash ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
