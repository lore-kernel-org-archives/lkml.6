Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE528C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8451F2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="UY0MB+Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbeL1PnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:43:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51748 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732718AbeL1PnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:43:24 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so28809868ite.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 07:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jByY46wNFvE4E4rauyf9hkYWJfsbk11FBUlYHXn28d4=;
        b=UY0MB+CpsBZkEwKYdlIyeoUtQhxbA7gRPtwr4cQyt19Hwq9g6SX6VqsLo9lCbiP4aZ
         3dt1wH17fl+iF4k3qrXqPMYJb/CQdsmNcamg8d2ApqbKcJFHeHItqjrfffUQPdxJ3Odz
         2N6iKZrmM+5tLe+AXj0biZEBHEjzwDvCvZI5JoJjTXjwwf7ZpzrIeus3MfOLtIqi9rUl
         Na2OoDk6dj3BnIcBVW9e4LujA9imyLK6kfbvmuiJIrto603RTU89623TGiE8fT9woDII
         UUFjxhIu/X/kmIDF4msJRqrBNgKh8CnRU34OH2sbbgE4W4LgIzHPVRaGuNUp+zbG6lf0
         C4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jByY46wNFvE4E4rauyf9hkYWJfsbk11FBUlYHXn28d4=;
        b=fq2l7hmVqRsyeiQt+I+YX34rjmX3eAVdF/EGDoDHLP9cZEYeV1E+9UjeVoyvXMGbsW
         Cc6evVP09N71CjDgT2RX9zfDBrQwdXZhgaULViUDEssj82G8efpXgnqCu+WhvYTaNa+V
         V3aXlP6NafJSHUP1nJz8Mp7rnkGs5SvU+7Im9g71eAWR3uWRa000ueSzWC9DMzZWI8RF
         bzSoTd9FgRxJ9P/Dugy9miA86Y77vjrN6flWVHd/3P3ww+xDKsDyRXjjTx0cqCqkp8SF
         c3cOrRcdue1aSVddhKCfYA8lu4tkNkDgvYOvwU/NNxXuNw8zQZRMnN31uQY9ZyzhZN4t
         Y25g==
X-Gm-Message-State: AA+aEWae0bD+DItZtkU6+4A8CUI67FgX3haj0xd1EYTqCw8Y2wq56rUj
        KtmAx+7HccKjzfIfWVJrng9nAA==
X-Google-Smtp-Source: AFSGD/V4ZKvW86qBczs2oX2LerHoE1te6rX1BUiOAFJ2nQjOqzoCmEGsFSCi8EXHjGyxFQ4XqubXIw==
X-Received: by 2002:a24:c8d7:: with SMTP id w206mr18528163itf.56.1546011803431;
        Fri, 28 Dec 2018 07:43:23 -0800 (PST)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id y5sm17954494itb.42.2018.12.28.07.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 07:43:22 -0800 (PST)
Date:   Fri, 28 Dec 2018 10:43:16 -0500
From:   Alexander Aring <aring@mojatatu.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     Xue Liu <liuxuenetmail@gmail.com>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Message-ID: <20181228154316.2x2tyfzidnb4emqo@x220t>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
 <20181224153205.ycr2zdrjbyklulfh@x220t>
 <57bead63-bc4e-4dfe-57a9-9875600f5e37@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57bead63-bc4e-4dfe-57a9-9875600f5e37@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 05:57:53AM +0100, Andreas Färber wrote:
> Hi Alexander and Xue Liu,
> 
> Am 24.12.18 um 16:32 schrieb Alexander Aring:
> > On Tue, Dec 18, 2018 at 02:50:58PM +0100, Xue Liu wrote:
> >> On Mon, 17 Dec 2018 at 15:19, Andreas Färber <afaerber@suse.de> wrote:
> >>> Am 17.12.18 um 09:50 schrieb Xue Liu:
> >>>> I have a question about the architecture of your module. AFAIK LoRaWAN
> >>>> is already the MAC Layer above the LoRa technology. Why do you want to
> >>>> make a new layer called "maclorawan" ?
> >>>
> >>> I had asked Jian-Hong to separate between his soft-MAC implementation
> >>> and the common bits needed to drive hard-MAC implementations found on
> >>> several of the hardware modules made available to me.
> >>>
> >> As a reference Linux 802.11 uses cfg80211 to talk with hard-MAC devices.
> >> We may also use the name “cfglora” for hard-MAC implementation.
> > 
> > There exists also a cfg802154. :-)
> > 
> > Note that cfg80211 is also for providing a backwardscompatibility to the
> > wireless ioctl() interface.
> > 
> > In theory it's simple:
> > 
> > netlink API -> SoftMAC (macFOOBAR layer) -> cfgFOOBAR implementation -> driver layer
> >             \-> HardMAC (driver layer) -> cfgFOOBAR implementation
> 
> So how does cfgFOOBAR relate to nlFOOBAR now? Given that we were told to
> use netlink and pointed to some nl802whatever, I am confused about two
> people now calling for cfg. We have an nllora stubbed in linux-lora.git,
> and I was expecting to see an nllorawan¹ either in this series or on

Why there is a different between two lora technologies? This sounds you
driving into two lora subsystems without one userspace api to access them,
this getting worse.

> top. If you're suggesting to rename them technology-neutral, then please

I am sorry, I actually meant that... People tell me that I can't explain
things all the time.

> say so clearly - otherwise it sounds to me like you didn't actually look
> at the staged code yet or didn't read our previous discussions and lead
> our contributors to reinvent things we already have...
> 

As example for 802.15.4:

nl802154 (which is one netlink interface for doesn't matter what
kind 802.15.4 device is behind) -> callback structure of cfg802154 which
goes to a somehow 802.15.4 device as SoftMAC layer or HardMAC driver.

> We really need to complete the layers from the ground up before we get
> lost in more nice-to-have upper layers: For LoRaWAN that means we need
> to have TX and RX working for LoRa _and_ FSK. sx1276 still has lots of
> hardcoded stuff from my own testing that needs to hook into nllora, and
> FSK exists only as ETH_P_FSK constant so far, with no concept for
> switching modes yet (which as mentioned in my presentation¹ needs to go
> via sleep mode, losing most register settings) nor any netlink support.
> Not all drivers need to be at the same implementation level, of course,
> but we need at least one that's far enough to validate such patches.
> 

Your register behaviour sounds for me like a feature for regmap. Or
either a feature to handle in your subsystem.

> And seeing that I just found a major bug in sx1276 driver's TX path,
> apparently no one apart from me is testing that driver - sx128x and
> sx1301 were not yet complete enough to transmit, and due to the open
> socket address/protocol discussions none can receive yet, so as Jiri
> hinted, this LoRaWAN soft-MAC patch series can't have been
> runtime-tested against any staged driver at all!  => [RFC lora-next v5 6/6]
> 

aha. When I started working on ieee802154 many times I thought nobody
had really tested it. That's somehow the process of upstream
programming, it's growing over the time. The first implementation is
always somehow crappy, but people working on it and get experience over
the time, you cannot have perfect code.

> Therefore I thought in our case some hard-MAC may be easier to validate
> LoRaWAN sockets (patch 1/6), to avoid a dependency on completing the MAC
> implementation first. For example, iM880, RF1276TS and 32001353 are pure
> LoRaWAN modules without raw LoRa support. (Whereas many others support
> both and I'm still looking for input on how to best deal with that -
> currently exposing them as LoRa devices for maximal flexibility.)
> 

So that means you ignore SoftMAC because HardMAC is easier? We actually
go the opposite way to say SoftMAC introduce the most infrastructure and
then say that we will bind HardMAC to it.

Of course binding a socket interface to a datapath is easy.

- Alex
