Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD0C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DC720842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQP/8ori"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbfBMA5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:57:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34936 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfBMA5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:57:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so1188580otm.2;
        Tue, 12 Feb 2019 16:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZqLbps8Eicn9bK00mPyp+DBSxWASkWXhIst/2wZu/A=;
        b=dQP/8orizVz3eshrenK/ZouNE/69Wr1hLGemLd1VoxCG/KLXBHtKEYl5466gXm8l1v
         ThIamJ4vVZs7wVAThJAq8eM0xa1FQUhBJtnFNzku+N3Y0uwet4nBztgW8L1mrFaECvI1
         IevrfxlAc03hDh1dsiCF/Xz2QSZn2p773nupHuoDQ1YJWwX/dVOQexC1mCvQe1UTXdOL
         WMwRgqFdYr8JZREc/i99TxE5CG2z5DtcXpse5e9VDPy2oqiKml5077LTRHSURrZYb0+i
         V+icdebCCm0M2G27SNjKre+K5THKSqunoAFJR5JmR2GzlpWN1x533KkrBQxAs8gwCVUm
         4y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZqLbps8Eicn9bK00mPyp+DBSxWASkWXhIst/2wZu/A=;
        b=bimKax3LxcBX1+wMsvRnvObWypcFIzU+d35zL4h/XASh0M57N/61eO5QIiSJLjNygv
         MkNhbU2TLUCZRMMlyQnCZtTL8IXoY/OFguVxrPNB2L44pp3kiWGDrbO0WlUob2nscb0u
         xTIdCaEzuGUkqXRXfP9DYQnG+00LUEhm256rtryOOgFpvmAr3HNq1KSVnm3hWcs4ogaL
         xoUOBZ/kYRo4Az7zHsUfSSkxMHxuEyTkjf/zISmXw41ZOzPEYtVMqdr9qKUXRnYvcASq
         LlG2gaBkVQEVLhDUgvYCOh/fjqjY1QDSR0xuXYspRrKjBy9G77ioJkJAjVq4ZB2pRC6A
         h5kg==
X-Gm-Message-State: AHQUAuaMQc7cRy3GJ1u6vRYqwVglzHlJRmrWsBm60XlAqWHvV7CfBl5H
        vzq4fE+G+53KbC3UZZurjSaKjQYo1OZGmzrv+sI=
X-Google-Smtp-Source: AHgI3IZ2ZWFHnUGl7nnxlmnyXkKsp0GTwym5V5KYNGiGc4gKmGBlHQhyLsthXo170+wBUY9bLuGxLBbDuxllQO/qZ7Y=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr7170940otp.225.1550019455764;
 Tue, 12 Feb 2019 16:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20190107132226.16216-1-stefan@agner.ch> <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
 <1549916056.3075.102.camel@impinj.com> <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
 <1549923727.3075.103.camel@impinj.com> <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
 <1550016436.3075.127.camel@impinj.com>
In-Reply-To: <1550016436.3075.127.camel@impinj.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Feb 2019 22:57:23 -0200
Message-ID: <CAOMZO5Ctp_p=j1G1DCaPxsyjWTK8dtKR9Ov59XGxYdiqE+1c2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:07 PM Trent Piepho <tpiepho@impinj.com> wrote:

> Tried SDMA firmware 4.2.  Still broken.  No apparent change.
>
> Get 4 cycle pause after each byte.
>
> And crash while/after using DMA.  Clearly some sort of memory
> corruption going on.  Fortunately, it's very reliable that using DMA
> almost immediately causes a problem and this is easy to reproduce.  I
> think that indicates it's either clobbers a lot of RAM, or consistently
> manages to hit a very important location for kernel memory allocators.
>
> I've got an idea of where that might be happening that I'm looking
> into.

Ok, thanks for investigating this issue.

>
> I think it's reasonable to add the dma attributes, but put a check in
> the spi-imx driver to disable DMA on imx7d at least.

Something like this?
http://dark-code.bulix.org/urfoh8-580174
