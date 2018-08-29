Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3D8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC54020652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0zIZOjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC54020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeH2WNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:13:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36159 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeH2WNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:13:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id v26-v6so5143794ljj.3;
        Wed, 29 Aug 2018 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCazvnBEpnm0Gyw6GCjF0KHSnNzsP+NrH/ddpIW4/7M=;
        b=U0zIZOjse7NTlkw8aL1Xf79IgHi5J6GzaD7VdAcm5GcPzTlIfhqyAPHBu6dGbRAnKd
         3oZrCFUXOn27H5zbcjg3e4vxdQEP9GQ2IQ5QbrgUiYYSOgFuFI9sKoQUSa5u45NqE4Q9
         CpcWfQ/Zycm3FXRug6ou3jUZAvvjXqDGdGPU7d/zgDgBJRgCRrbllyZWzvL+MXDteDeG
         f1JPhJOVcBAYf5fHUGBmZwhrbac62d1ZJJW613XeO2uvZaXGkrhq83yVVlNzqUfbr0oz
         1RssNhfaCVr6z6O5wzyHWfaFo1QFdPvlRsFsUzwfWXmd0ao+6cS3FbrdfO5dUWkNFHGe
         64Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCazvnBEpnm0Gyw6GCjF0KHSnNzsP+NrH/ddpIW4/7M=;
        b=jG0AsTcaJvg2xjgGIMGR6kleJl2+ppRl+myZXqUQtahDs7NpG5yGKXO2Bl4ljVf4/Y
         8kr66+m5c1QVy1fmxY8RthGSu8O7/9vRFx7m1Xsk9ALzrVDQVR3iJsLY3zO1phzcNDTq
         48wMCaegU8HmENHWmTFXA4ofJA0u7iEyy0hn+PH4lndbXJ1moPtVTPWRTxXGxb8C187w
         Uz6e6+y40cW/WfTc3b6/K8ujYSHma1vgFEBmxqTZCRSBQWz+mb3Q0YLxVoQg9NzM1UFW
         ivXiMTUh8LDiXC2koE5R9GYQXkKV2XZ9HYDe/7h0LE7oukdVeX500InXRjXO9E86C18/
         x6Ug==
X-Gm-Message-State: APzg51Dqf2NNVzVBZ0kNMpsTFYICALcFaAWrue5g459YVSBZwgJI7yc3
        QF1us+AnCaeveqH7w6FK0no=
X-Google-Smtp-Source: ANB0VdYjHmuSri0MpxQ5WAvP8Nkj7cnPlw8jEXXy1dbEnl0A06ypglmgF1MmXL/s1/shdOzE2FEudg==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr4896917ljk.42.1535566506354;
        Wed, 29 Aug 2018 11:15:06 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id n3-v6sm799786lji.96.2018.08.29.11.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 11:15:05 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>, kishon@ti.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC RFT PATCH 0/4] gpiolib: speed up GPIO array processing
Date:   Wed, 29 Aug 2018 20:16:20 +0200
Message-ID: <1595423.PPW7Q1vFt0@z50>
In-Reply-To: <CACRpkdbgY6VNP-K-c5ErQtmO7E83D6c=49TN5siF8VTNh_66Jg@mail.gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-1-jmkrzyszt@gmail.com> <CACRpkdbgY6VNP-K-c5ErQtmO7E83D6c=49TN5siF8VTNh_66Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wednesday, August 29, 2018 11:06:21 AM CEST Linus Walleij wrote:
> On Tue, Aug 21, 2018 at 1:42 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> 
wrote:
> 
> > This series is a follow up of the former "mtd: rawnand: ams-delta: Use
> > gpio-omap accessors for data I/O" which already contained some changes
> > to gpiolib.  Those previous attempts were commented by Borris Brezillon
> > who suggested using GPIO API modified to accept bitmaps, and by Linus
> > Walleij who suggested still more great ideas for further immprovement
> > of the proposed API changes - thanks!
> >
> > The goal is to boost performans of get/set array functions while
> > processing GPIO arrays which represent pins of a signle chip in
> > hardware order.  If resulting performance is close to PIO, GPIO API
> > can be used for data I/O without much loss of speed.
> 
> Hands down, this is a very pretty patch set. I'm a big fan already.
> 
> This is mainly because it fulfills the requirement for libraries
> to be narrow and deep, which is what we want.
> This refers to John Ousterhouts software design philosophy,
> here is a great lecture if you haven't seen it already:
> https://www.youtube.com/watch?v=bmSAYlu0NcY
> 
> Let's get this into v1 and get some testing and merge it for v4.20
> ASAP

Please hold on for a while, I'm going to resubmit soon, with the comment from 
Peter Rosin on i2c-mux-gpio addressed and the error discovered by Miguel Ojeda 
in hd44780 fixed.

Thanks,
Janusz

> so we get some proper testing before the v4.20 merge
> window. It would be excellent if some of the current users of
> the array API could provide tested-by's or at least ACKs.
> 
> For example ts-nbus.c must be a big benefactor.
> 
> Yours,
> Linus Walleij
> 




