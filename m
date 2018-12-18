Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B1EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B40E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="VdYwOgta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeLRPeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:34:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46717 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:34:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so15987070otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRcpSDgKBunETK4jngTuaWDbCUphXpYDKqI0rFAN6ng=;
        b=VdYwOgtalgTEQ412UEhrLyvhKiVp6UVMMgPk8ZbrsIhWs81CVJNDe/jBg10x4iiDl4
         s5W8atvzTPFAj0GI+0DVkFs/HcaxSI4tUfkXiXSvsUQjVGfsxl/U/irbEjLLApwWBU4s
         ApjWDPNgSKTpaDroEbAy9MvFXwMvgcT3qK6sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRcpSDgKBunETK4jngTuaWDbCUphXpYDKqI0rFAN6ng=;
        b=ikwm/+bJbXyNQ2ClTroi4UgU/Nx7HpBAVXtbRHs0n/9vzwp5r/ARo/YbDjeu1KrXdf
         7wTvKLKGvyAI6/RgEyuvKmA/7W0baf1RBx/t8QYWFAH9JvYXrxu2R26bF8jtIqAHkwhb
         lY0/wHW3vsaYKc93Y2Mj+kFfbubTLExi9HfkmYvNim8W/RxfjPIW5Q7/vljQCWsclHib
         +P15RgDlgem4eeETgTPCxWyNV/K74ESoMR4BOtfU+X8GAlbGN8p3iIEHd0MIvQam0dEE
         UG4tX6Dawyu2m8+ckGGXp2awEZlMXyH+l3vNPYxD6ueSNCUPrY+OEOOErZbzCgcYKlzK
         4ihQ==
X-Gm-Message-State: AA+aEWYOzqO4abdce5PSFjwCSfwSICFyeyJPTetXhE9FOQE9ZVtmdJjS
        pty/p+FPoPi40mlV25jWojmC/xKgX9sRFg==
X-Google-Smtp-Source: AFSGD/X1ZaBbAtRSRcue6upxYcAZ03oF50eqGi/FBN3KocEvtl+S6KydK6CdwRkG4HlqfrN2CQchMQ==
X-Received: by 2002:a9d:5550:: with SMTP id h16mr11847836oti.140.1545147254801;
        Tue, 18 Dec 2018 07:34:14 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id 75sm4626777otc.67.2018.12.18.07.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:34:13 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id j21so2249788oii.8;
        Tue, 18 Dec 2018 07:34:13 -0800 (PST)
X-Received: by 2002:aca:e401:: with SMTP id b1mr7717991oih.231.1545147253134;
 Tue, 18 Dec 2018 07:34:13 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw> <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com> <20181218142756.GA2031@nanopsycho>
In-Reply-To: <20181218142756.GA2031@nanopsycho>
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date:   Tue, 18 Dec 2018 23:34:19 +0800
X-Gmail-Original-Message-ID: <CAC=mGzifRScmq6VOtWE1QSJUUrOEG81gF2C8eiYYRnmBRUbWCw@mail.gmail.com>
Message-ID: <CAC=mGzifRScmq6VOtWE1QSJUUrOEG81gF2C8eiYYRnmBRUbWCw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Tue, Dec 18, 2018 at 03:27:09PM CET, starnight@g.ncu.edu.tw wrote:
> >> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> >> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
> >> >
> >> >This patch implements part of Class A end-devices SoftMAC defined in
> >> >LoRaWAN(TM) Specification Ver. 1.0.2:
> >> >1. End-device receive slot timing
> >> >2. Only single channel and single data rate for now
> >> >3. Unconfirmed data up/down message types
> >> >
> >> >On the other side, it defines the basic interface and operation
> >> >functions for compatible LoRa device drivers.
> >> >
> >> >Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> >> >---
> >> >V2:
> >> >- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
> >> >  LoRaWAN Soft MAC modules
> >> >- Modify for Big/Little-Endian
> >> >- Use SPDX license identifiers
> >> >
> >> >V3:
> >> >- Remove the decoration word - inline of the functions
> >> >- Order local variables from longest to shortest line in the functions
> >> >- Change the calling mac_cb function to lrw_get_mac_cb macro
> >> >
> >> >V4:
> >> >- Fix the delay period between RX window#1 and window#2
> >> >- Fix by coding style report from scripts/checkpatch.pl
> >> >
> >> >V5:
> >> >- Initial rx_skb_list when it is allocated with LoRa hardware
> >> >- Check the sk_buff's data length before access it
> >> >- Deal FPort field and decrypt payload in lrw_parse_frame function
> >> >- Drop the recieved frame if parse failed
> >> >- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
> >> >
> >> > net/maclorawan/Kconfig  |  14 +
> >> > net/maclorawan/Makefile |   2 +
> >> > net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
> >> > net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
> >> > 4 files changed, 1177 insertions(+)
> >> > create mode 100644 net/maclorawan/Kconfig
> >> > create mode 100644 net/maclorawan/Makefile
> >> > create mode 100644 net/maclorawan/mac.c
> >> > create mode 100644 net/maclorawan/main.c
> >>
> >>
> >> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> >> you add headers for "API" and here you implement functions. That is just
> >> weird. Does it mean you can have other implementations?
> >
> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
> >This part is soft-MAC as Andreas mentioned
> >http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html
>
> Okay, that does not answer my concern about header file in one patch and
> the actual implementation of functions in another one.

Just for clarification:
- Patch "net: lorawan: Add LoRaWAN socket module" is for lorawan module
- Patch "net: lorawan: Add LoRaWAN API declaration for LoRa devices"
containes the header file "include/linux/lora/lorawan.h" which will be
included by LoRa device drivers or other kernel modules.
- Patches "net: maclorawan: Add maclorawan module declaration", "net:
maclorawan: Implement the crypto of maclorawan module" and "net:
maclorawan: Implement maclorawan class module" are for maclorawan
module.

Question 1:
Should I marge "net: maclorawan: Add maclorawan module declaration",
"net: maclorawan: Implement the crypto of maclorawan module" and "net:
maclorawan: Implement maclorawan class module" into a single patch
named "net: maclorawan: Add maclorawan as the soft-MAC module"?

Then:
For example, after a LoRa device driver includes the header
"linux/lora/lorawan.h", the device driver will call "lrw_alloc_hw()"
and pass with a "struct lrw_operations" type of variable's pointer.
It gets a type of "struct lrw_hw *" pointer.  Then, it will call
"lrw_register_hw()" to register the device.  The device driver
implements the callback functions for the "struct lrw_operations" type
of variable by it self before calls "lrw_alloc_hw()".

Question 2:
Should the patch "net: lorawan: Add LoRaWAN API declaration for LoRa
devices" also be merged into "net: maclorawan: Add maclorawan as the
soft-MAC module" or "net: maclorawan: Implement maclorawan class
module"?  Or, just leave it as a single patch?
