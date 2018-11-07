Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FE5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C852085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C852085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbeKHBFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:05:17 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34337 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeKHBFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:05:17 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so7831288vsi.1;
        Wed, 07 Nov 2018 07:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFDoyXBbWPXoq4jdpmuCCfC9Z24EPUBl5vTbfphQXlY=;
        b=jIR/FE9lI9hgO+lsCrgFDv0u5/PhsuW60zN1Ml0C6ey+2lQ83g0RNrhpGrZlsmyQER
         RJxcQabmpVgFbcfVzMRfUtcxwuNOh5svVJIPKo81wASPsVRis/UY4RADKI7grp6lfm4y
         y9zaYtXYJ2/bB+3khjjnf1nKj10duWR1S3yY6dlx5JQiEMkEzGCNPQUiFZzccMItqVBf
         p/aKVEBO37xIe/XD3eCqa5fPrUfdGUHCAM931Cdl4Nzjjzo1/+fUvIhG0d+VGHtyh2nv
         ZxeiAbLK30UxAFw9xBS9frubX3GarPnJCuTHZFjnWBDyIu8sw7jxCOMOmFf9m94UjR4w
         tEqg==
X-Gm-Message-State: AGRZ1gK1vU1nF+e2NCp5J9g2FT8A+RrJP6gUH8ixsYI7H/ciwCb16iak
        E7y9JIRXv5j39EiU47N9eDtDu66qbyDyyzgGM3eB6mAl
X-Google-Smtp-Source: AJdET5fsEWPKyt19SONIzJGJnXqaIrSv1h5kj38Qg66H567KVkGhfXpyAdkxeAmCz5hIqoCrVsKL6ER/UBZhUqJ+eNE=
X-Received: by 2002:a67:d119:: with SMTP id u25mr255775vsi.63.1541604864655;
 Wed, 07 Nov 2018 07:34:24 -0800 (PST)
MIME-Version: 1.0
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com> <20181029134100.GD28520@bombadil.infradead.org>
 <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
In-Reply-To: <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Nov 2018 16:34:12 +0100
Message-ID: <CAMuHMdUO5_-TsGiu3otuLqNtLNgdnw=1QdKjTzPmSxHp9QotxQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, pgaj@cadence.com,
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        swboyd@chromium.org, joao.pinto@synopsys.com,
        luis.oliveira@synopsys.com, manuel.abreu@synopsys.com,
        gustavo.pimentel@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Wed, Nov 7, 2018 at 4:15 PM vitor <vitor.soares@synopsys.com> wrote:
> On 29/10/18 13:41, Matthew Wilcox wrote:
> > On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
> >> +config DW_I3C_MASTER
> >> +    tristate "Synospsys DesignWare I3C master driver"
> >> +    depends on I3C
> >> +    depends on !(ALPHA || PARISC)
> > why?
>
> Please check this email thread: https://lkml.org/lkml/2018/10/8/393

Hence this deserves a comment, so we know when/what to do to drop the
dependency:

    depends on  !(ALPHA || PARISC) # needs {read,write}sl()

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
