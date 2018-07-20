Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54638ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0833220673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnrWIY2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0833220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeGTJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:39:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43090 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeGTJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:39:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id m12-v6so1277654lfc.10;
        Fri, 20 Jul 2018 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fVn/Xg5mb+rYScFixn59lm+lv54Hm+61z/aHP+S63UU=;
        b=PnrWIY2Snte5fog4Z7OGaMy6uE7TPgrODyfuXOdgUnAFjyQvE8R8TOuXazLBwdZbgy
         NBB4G7YMzdulcl3HFVtClV5ZTwxHD1GQNW7rGbABpia40RXxIwfOAsPJ2Vyx84GXPLZW
         V2M50IGit44kp3psWleSFAcBq/DhqN5rfwramcxkfjRY0Ss06RIsSkL/iYgTbm1jWQw/
         fBn5kdN72E9DxzA/JdQs0kjqcjUNjCSL1II8s4LsNwI2MJLmn8kA4LWQ/QevgqbGi+oY
         o/hC0kTel/6/pZJK4HbnAp6KjhoZkQPz2GcO+QgoB7z+Y45UnX/2ZkeAy0MBDlFdccrG
         tepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fVn/Xg5mb+rYScFixn59lm+lv54Hm+61z/aHP+S63UU=;
        b=KSYkZKKu8TnAUnHJoc1McONqAOXjDqfNFHegQw3jU6I1VK9hzLlXIC3nI2U41Uknpx
         j9KaMqEA05SVF0DJ3rFUw4Ixzk4+KH1Cpq1Z8g8bGvbGcLuOZHKEFKOPlCsSjKiPm2SP
         TX3LPF1qJ28Nnq30fpGwF0lei4vE6rAkSSP6Qn46vm8BTmdWUlpJW+wxcn3hbAh7Dhlz
         rezhPOXXxCKWs0vZRXjXeS4+jgZyHz0eCKM25JpK+1gHxqiKargvAwM/xiPOW5QtKfs3
         7mNFy6ralqRSV5okh7u493IRnVgamCAefnWY1l0MIUGbdiXT9K+aGt3lthMP6xkVtzDZ
         5t5w==
X-Gm-Message-State: AOUpUlFlF2iRnHv5D/Yo+aeUbGu3IITKiAdfsyZy+yYhsuMCLrEbnZO0
        khh57Li+0tmvKW8Wb5w7l7SxEL/M4rTkKSdIDwo=
X-Google-Smtp-Source: AAOMgpd9WKXERcKfb9fbK+/rQZOyfUPBa/iib5u4UiYEGUeuf8Hpc2esH2kQvXqDdr9iRQMYRxlXiAniy48bhrmLNFI=
X-Received: by 2002:a19:5c06:: with SMTP id q6-v6mr871534lfb.6.1532076748084;
 Fri, 20 Jul 2018 01:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 01:52:27
 -0700 (PDT)
In-Reply-To: <20180719152930.3715-1-boris.brezillon@bootlin.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Jul 2018 10:52:27 +0200
X-Google-Sender-Auth: FN7o8MaSf4dMOgQOjtJDZ8cVdSM
Message-ID: <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
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
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 5:29 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure if we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   now, just in case we need it some day.
>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.
>
>   Discussion around the bus/master/dev representation is still ongoing,
>   with Arnd opting for a simple approach where
>   * the bus is implicitly represented by the master device
>   * the master is not represented as a device under the I3C bus
>   * only remote I3C devices are exposed and possibly duplicated if
>     several masters controlling the same bus are exposed to the same
>     Linux instance
>   and Peter preferring the representation where the bus is a separate
>   object. IIRC, Wolfram was in favor of the "bus is a separate object"
>   too.
>
>   If possible, I'd like to close this discussion soon, no matter which
>   solution is chosen.
...
> Missing features in this preliminary version:
...
> - no support for multi-master and the associated concepts (mastership
>   handover, support for secondary masters, ...)

Let's try to come to a conclusion to this discussion, this is the main
show-stopper for inclusion that I see, as changing the fundamental
design would be hard to do once we do it one way or the other,
and the structure is exposed to user space.

Peter and Wolfram, could you explain what scenario you can see that
would require handing over ownership of a device from one i3c master
to another i3c master when both are controlled by the same Linux
instance?

To me this seems like a rather odd scenario, and supporting it
properly requires significant complexity once we try to support the
dynamic handover of the bus between two of our own masters.

It seems more likely to me that we could deal with this case by
requiring either that each bus is controlled by at most one master
device in Linux, or at least that when we have two masters on
the same bus that they each control a non-overlapping set of
slave devices. Either way we'd be able to represent the structure
as a normal tree in the firmware (DT or ACPI) as well as in
sysfs.

       Arnd
