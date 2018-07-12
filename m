Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A52DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D0B20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf0eZyhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D0B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbeGLIQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:16:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36415 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeGLIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:16:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id b22-v6so11058255lfa.3;
        Thu, 12 Jul 2018 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zqpK3YHjwleJqx6PiBCC/89qvsqEXLCeMNu82nibIDk=;
        b=Rf0eZyhQXslhN6JEBUJJKqk+QcK2kB501C3r9E7Z7rqarRyZrlLa/2H24vSqBsgujB
         Skzaf7TG6G+0NDARuSXuH7zFbUTulBCviJT0OfNbHQMH1jcHv6rc4oGCeemTh0EFC+Sq
         3QK2VTHek4nL++wLc442WCm+68IK2SlPCs+JOLiaIsC6XG7SoVfKK+OK3iyAwBQR5fRe
         EtzPMI6TggR2p0gzDBg8mDVCA/ucxHXcmQWxFDokblDQp3H0vcK2W3RuzevxEFzaqB5Y
         3uH+BbDBZQfiD0huJ+42wMStj882qs6UvwKogpoJrDt2J/ZSoBb40WF9MgkJCHm/zHy2
         sZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zqpK3YHjwleJqx6PiBCC/89qvsqEXLCeMNu82nibIDk=;
        b=eboVBvO4LD+IvjFg6vBgvPKlygjVOrFeNsOjsFxqIbHozWOlwY1U5yTbWi7BaWdlLg
         moNB32BTwOIkpIhH3gl5uroFpX5pSvVsnIDiziCxtuSL0VeC/x9PvdimQ8wGKYdg6yzQ
         lAyGLcdpsR85YO7IjPYo2heB5UbFHL4Jrhb9Ury3HyDyz7Sb7EjE3pNGa1dr806X5rZg
         ZSpxjiibBg/+0/yvkep7sylEUyg9lfkt4MXs7y7oX+I2fAwRPeaAsQokKEds0IG5Xdbx
         1FcF3pbG3/NP3azrrfZ0GdK3rWm0bpde/6umUR1dtVE0DeDHQxVPi1/L4V2BPw/nvb+5
         EabA==
X-Gm-Message-State: AOUpUlG7pH5fcUWMTJzvb5I9I7FFFAgJbk+i8um3YgBhPlThaFMF5PiS
        X1qV6XJUj7A8eNg+qY0ZkxBWTY1Jr1pr6F8QIog=
X-Google-Smtp-Source: AAOMgpcIKW8JvFcBTfObUfsPzbXyFTNAOvCM5hxK9JEdABgJfEfdAf6ABHgch4RCHQ0In5okBN2qxrRywX0XZ8N33sg=
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr939664lff.11.1531382886917;
 Thu, 12 Jul 2018 01:08:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 01:08:05
 -0700 (PDT)
In-Reply-To: <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com> <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
 <20180711164120.3e32fb08@bbrezillon> <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
 <20180711191212.3855bb25@bbrezillon> <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 10:08:05 +0200
X-Google-Sender-Auth: r04NhL0R8-yZlON2DPxF_T_AKjc
Message-ID: <CAK8P3a2oMDw2zHzE5vFFHDqzKVKEzOga6v0ExdYVawnMtcdbrQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
To:     Peter Rosin <peda@axentia.se>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 6:41 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-07-11 19:12, Boris Brezillon wrote:
>> On Wed, 11 Jul 2018 17:39:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> That's exactly the sort of discussion I wanted to trigger. Maybe we
>> shouldn't care and expose this use case as if it was X different I3C
>> buses (with all devices present on the bus being exposed X times to the
>> system).
>
> For I2C, this multiple masters for one bus case was retrofitted in
> the i2c-demux-pinctrl driver. It's a huge kludge with a number of
> undesirable quirks. I don't know if the circumstances for adding
> this I2C driver also applies for I3C, but it might be an argument
> in favor of the proposed extra bus object...

From reading the documentation and git history on that driver,
it seems to be used only for static configuration, i.e. you use
one driver or the other, but don't flip between them at runtime,
right?

I'm guessing that even with i3c we may have to support something
like that, as a likely scenario might be that the i3c controller is
multiplexed with a traditional i2c controller and/or gpios, but you
would not be able to perform the i3c standard secondary master
transition with the latter two because they are (by definition) not
i3c compatible.

       Arnd
