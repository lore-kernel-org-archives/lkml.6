Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F056CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAA2208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG+tPFwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAA2208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeGMF2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 01:28:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52136 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeGMF2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 01:28:36 -0400
Received: by mail-it0-f65.google.com with SMTP id h2-v6so8149898itj.1;
        Thu, 12 Jul 2018 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sXdgquaFxlbIg3+9FuaNNO2t9xj7Slm776nPBvg9fI=;
        b=eG+tPFwzAXkw374PuV/YRzZcJZQnf2BadilGqEhWZETElAsHnupphPDCBlRLCCUB1b
         DLESiziW2M49QhLxT7E6IdFQe0EWWeCvKganWRBBxjw5qi5+qBXMZ6gh+HApL+kfMMN6
         9TL8HKGrmDSYWiqCtDfwdUeSHQCPx/cqFg2t05FzbLPliLrMPLNa3KulpeyeeQJ7M6ak
         G13GpRfX/xHCwXSSfK0ooZcaKmgYYXlyxIB9Zxg5uw6n7pVYnwmsks3tVe4BMX51Ci8M
         KrH/hSrld4UzRBlR/6LSUBP1vZTgQe+a7RS6FhqqoPj37TFSJIvivvK6Q14LdGkUkKVv
         Wn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sXdgquaFxlbIg3+9FuaNNO2t9xj7Slm776nPBvg9fI=;
        b=rWaQqqB3PxwuQ8ioSxfntSQMsxqDMsi0qNr9K0R7IsYaCXDsBTuTgW5e9GiNikAW6G
         2M/zUCoJINYY6cV08f6410YjZisZTao35tTrhd/lM6hWubgtGlQ8JPM8XwNJ3iBpP5Xf
         M/8lu6xT7feCI1Y2x4mARVClYw7Q06ntoCVcLe8fP/KYvdqy+Yp4wYhZKqPu9zjI3fTl
         EkDKCbmKNspl0giJCz/JyZsa9ttYvGLNANRsNeF7AqHQbUw2WsJEPGo8GYoWLaUzDltA
         f3iU/RzxnkqOffhUotqhU+NBpkW4ZGIwvhJkd4LO54fqokKIOUTqqSgiQMfjlhmfLYwi
         twFQ==
X-Gm-Message-State: AOUpUlGghMdcqVNgkkDz6a4sdaizFi6FnLZzkbkjkBAVI2HlyrzHL9Xv
        NP04/h+UP2SyTIC6V7UrIp11CUuqIIRkGv/mZJ0kCcxc
X-Google-Smtp-Source: AAOMgpdZawiUycbKwzIrU3m0NDWDLMmlXcZc1aJVTI8Z+FrJseM54qbuomkAkUV89wVzgTw/Jg/7v4ErE84N8U1TB1E=
X-Received: by 2002:a24:7b97:: with SMTP id q145-v6mr3583777itc.79.1531458939894;
 Thu, 12 Jul 2018 22:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
 <20180712023337.30112-2-andrew.smirnov@gmail.com> <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 12 Jul 2018 22:15:28 -0700
Message-ID: <CAHQ1cqEXBfs1B6Jr1NvUY6WoyX9oG=0haJpiTLVH7t-37ht10Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 6:37 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Wed, Jul 11, 2018 at 11:33 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > +       pinctrl_switch: switchgrp {
> > +               fsl,pins = <
> > +                       MX51_PAD_AUD3_BB_CK__GPIO4_20           0xc5
>
> The i.MX51 Reference Manual states that 0xa5 is the default reset
> value for the register IOMUXC_SW_PAD_CTL_PAD_AUD3_BB_CK.
>
> By reading your commit log I had the impression you wanted to provide
> the default value explicitly.
>
> Please clarify.

I wanted to avoid relying on defaults be it register reset values or
settings that bootloader left us with. Default value of 0xa5 works,
but, given how the pin is IRQ_TYPE_LEVEL_HIGH, I though it would be
better to configure it to have a pulldown. Do you want me to add that
to commit log?

Thanks,
Andrey Smirnov
