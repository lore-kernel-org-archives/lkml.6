Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D7ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3265B21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMU491ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3265B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeIUDYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:24:31 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55928 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbeIUDYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:24:30 -0400
Received: by mail-it1-f194.google.com with SMTP id d10-v6so56523itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg+vd5ggFSRvBp1nMxn8WnsMDdMW/WuDRawGX4bRb64=;
        b=CMU491cecrua94hYBC1oJl50GK+SchZvptcORr8XA3cjCM1fji485Wl3tL+KvebnjM
         N1pOyziM58hsWkAWZS4z8wxyTk1DdIo43a1XokIibPD2Fi8Rr1dwKwqH4n/apfrK/tX6
         Z22qTJdltEKlV0zIEMOqLhSUM/q/whkSc+PRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg+vd5ggFSRvBp1nMxn8WnsMDdMW/WuDRawGX4bRb64=;
        b=X5upCJY0u0XZ+OK6GgIWiTl3259q5q09nkKjq8asCbj0rU1eSxUmZyIUAImWijfZzU
         9KdplzPfuW04jSrVysJ3Gw55Fj/6Nbwx+evRaTHTFdvAzkUDRw0bflXREAkQ3JSb/ax0
         1QMX7YKrG1Zb/g0apyI8olaNtFp9mdeDZaIArVoLp9VHvdmqIL9V3Rpc5RzDus4s0WAJ
         FNrVuJ1tZcifAjX6e0VD6cpq9/rdFE0Tig56HUTHBV/pF/EAK4x71l3oXgnEaAtvIhp3
         tGP43pk0kyoSLLJ51p40t3nyOI7Pg6XQgph0myUa1/kOKiUZLOjQmnIF+XDfDUfCOgls
         Edwg==
X-Gm-Message-State: APzg51CqTnLOrYwenQPSodftoQMYoOBAYWscO04lZuAY68/z7qOiUEZK
        brG3gpSypwVPk48I6bU0L0k3K4RzXhauCNHA1jw+UUw4R68=
X-Google-Smtp-Source: ANB0VdYVaju2MILde8XiDVZ3Y4Ywjp9Hck54iuCB7EJPzxXUu5SAa6qhxP182TFkVlA9l8QqgFb4LZCmIMm58oQM11A=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr3865756itd.130.1537479538060;
 Thu, 20 Sep 2018 14:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 14:38:44 -0700
Message-ID: <CACRpkdZYpDJGzexRr7y4LO+hyJ92aEu_eRquK50iBWaaox5H5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] add support for VSC8584 and VSC8574
 Microsemi quad-port PHYs
To:     quentin.schulz@bootlin.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        allan.nielsen@microchip.com,
        Linux MIPS <linux-mips@linux-mips.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a drive-by comment this seems vaguely related to the Vitesse
DSA switch I merged in drivers/net/dsa/vitesse-vsc73xx.c
The VSC* product name handily gives away the origin in Vitesse's
product line.

The VSC73xx also have the 8051 CPU and internal RAM, but are
accessed (typically) over SPI, and AFAICT this thing is talking over
MDIO.

The Vitesse 73xx however also supports a WAN port and VLANs
which makes it significantly different, falling into switch class I
guess.

These VSC85*4's does have an SPI interface as well, according
to the data sheet but I assume your target boards don't even
connect it?

When it comes to 8051 code we have quite a lot of this in the kernel
these days, I suspect the 8051 snippets in this code could be
disassembled and put into linux-firmware in source form, but
that is maybe a bit overly ambitious. We have done that for a few
USB to serial controllers using the EzUSB 8051 though:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/keyspan_pda
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/usbdux

These can rebuild their firmware using the as31 assembler.
https://github.com/nitsky/as31

Yours,
Linus Walleij
