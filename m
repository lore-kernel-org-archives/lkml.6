Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D903C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB642081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="R2e96RJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB642081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbeKFF7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:59:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34562 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeKFF7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:59:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so144381lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9I4jWjust/NkvaFTMD6L286kxaCL0+V+u/MtwUpZDA=;
        b=R2e96RJEKEKnpdBEpACZwEtOX6sTTX5Jr0oKotjlP45wut/xIS8q3sKbajOL0c4xFv
         wnnGLVtoodZj7nVDHEwB/5BgRmz0SAfsGhjj5sCmqA/pUiUXqQvcb4MKvF/8XJlLshld
         SEbm3lBt2oBs9OY565z0ZBoUwKFq3967BZOLWOC7O7h5HFY/HseT9wAX5be9t6nne3Zi
         AgIl3KesvV6Lqj1Axs+LEVRJkRh8FjHQNd4iYsxFOQZS334lDuDUWM2olPl/HwOMhFB0
         owXRrB6pq4QnBMDVUhWUlnbT5ghWYQRamD6WI+CC/2zNuOF1iIL2cPp4Yb0qM2CXNqHw
         7LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9I4jWjust/NkvaFTMD6L286kxaCL0+V+u/MtwUpZDA=;
        b=E/3G1ND3R1RouHbYOoMk1wxOg7PTWv6R/C0Eu5xoOu4gIbwSU189NGT6QZsfXxsyNa
         +j+70MPpeOy6VU+PDWUmZ0eBqD1/lEIkiKc8WFYe9F+K5zf99WKxzG4yFP9NYkd0qCAW
         9jRb+grPWXzJAxWs/kKhOgLCQJ+9WWjzFor8dBmRlc2sMopElvP+v4oeVCqFyQyYTYHm
         nzKvKRzLUk5HMl3Fkj8fnQJp38st93YVNdgHMQlqZbRW19M5WKsgqpqmscEsjI2mmggg
         pu1aUN1mx6vE+MY1eLqLNDVXzYD+2uZdrEu8zGFapLAz4thhQkjQ5CW7mjQ9KZWg4UkU
         28dw==
X-Gm-Message-State: AGRZ1gKcnM7RLCJCeV6ZqVU9fCIo5i5QyFfabGpV3pGK1Oh+FifyvHIi
        CDeOqKxDAhDS9daxgCEUQBLtjQ+miIZacWcU8ZTGfw==
X-Google-Smtp-Source: AJdET5dmje8ev2NEBQYH4R97ti5h9Z7aoK4xonEtea+7e6d15pU6FJDC5H/wgIpSRdWt2p1omXfQgceLbDBqpcuIQ3g=
X-Received: by 2002:a19:df41:: with SMTP id q1mr14084545lfj.25.1541450297937;
 Mon, 05 Nov 2018 12:38:17 -0800 (PST)
MIME-Version: 1.0
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic> <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic> <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic> <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
 <20181105194721.GB26868@zn.tnic>
In-Reply-To: <20181105194721.GB26868@zn.tnic>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 5 Nov 2018 12:38:05 -0800
Message-ID: <CAOesGMjsPWeRZEeBH37uLQFBKwAWNMh5yCvuKNYrOUDfRSSYog@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, manish.narani@xilinx.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 11:47 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi Olof,
>
> On Mon, Nov 05, 2018 at 06:51:26AM -0800, Olof Johansson wrote:
> > In general, for new functionality where needing both the driver change
> > and a DT change to enable it (or a driver change and a config change
> > to enable it), we have been merging the changes separately between
> > driver trees and arm-soc. I.e. things will be in place, but not
> > enabled, until both sides land. Main reason for doing so is to cut
> > down on arbitrary dependencies between the trees, since there can
> > sometimes end up being a lot of them.
>
> Well, makes sense too and it is the least problematic approach. :-)
>
> > Since DT should strive for being backwards compatible (i.e, a driver
> > change shouldn't require a DT change for the kernel to not regress
> > functionally), this has been working pretty well.
>
> Ok.
>
> > However, if there's some other reason to share a base between the two
> > trees, we can do that. For most cases we've found that it's not needed
> > though. So let us know what you prefer here.
>
> No, I just wanted to make sure drivers can still function when they go
> to linux-next. But I certainly can get on board with keeping drivers and
> DT changes separate as it requires no sync and the short period of time
> when they don't load in linux-next, is perfectly ok.

Ok, sounds good.

> So can I assume you guys are going to pick up:
>
> https://lkml.kernel.org/r/1538667328-9465-7-git-send-email-manish.narani@xilinx.com
> https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani@xilinx.com

Yeah, Michal should pick those up for his platform and send them in to
us (or let us know if he wants us to take them directly, but usually
they come in through platform maintainers sending us pull requests).

>
> ?
>
> I can then pick up the rest.
>
> And I'll be ignoring DT stuff sent to me from now on and concentrate on
> the EDAC drivers, assuming former will go through your tree.
>
> Sounds good?

Yeah, that's the way we've been trying to do for various subsystems
and it's been working pretty well. Of course, if there's need to
coordinate more closely for something in the future we'll be happy to
do so.


-Olof
