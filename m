Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11ECC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D18220855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ftzYL/BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D18220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIGXHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:07:53 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58816 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGXHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:07:53 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F22FC5C0817;
        Fri,  7 Sep 2018 20:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536344741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCYw0qFERSiTmGXNA53NbbF4OdBpBMrUjGJB4K1SDAQ=;
        b=ftzYL/BT7PkJnoyGVk3g0UqElcYWcKrj13F+drJuzh4J3+V5stlwh+NnfJZ4Q+3GH6LNmp
        PiTlF3JYxmXVOvQHNwJfUD5d8Gfuv0FOjJxstKgV1t9/Q1QguS7p+OEbgg7mXNaeFRccnc
        MZTXvYXjkjdmyek4t7YyO6mae/QssNo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Sep 2018 11:25:40 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        max.krummenacher@toradex.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
In-Reply-To: <CACRpkdaUuWUHZgT0b64hMNZm3oy=7rece3H0p5VVe4d8jpFRaw@mail.gmail.com>
References: <20180905052113.21262-1-stefan@agner.ch>
 <4035252.QuWadVx7pr@avalon> <1569297.pdEFdpi3HS@avalon>
 <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
 <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
 <b1cb586397a4cd444c33dd83d72fa544@agner.ch>
 <CACRpkdaUuWUHZgT0b64hMNZm3oy=7rece3H0p5VVe4d8jpFRaw@mail.gmail.com>
Message-ID: <3c048938d12a070c03f0cbdbc89c86e8@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2018 00:10, Linus Walleij wrote:
> On Thu, Sep 6, 2018 at 10:25 PM Stefan Agner <stefan@agner.ch> wrote:
> 
>> Ok, I read a bit up on the history of bridge timing, especially:
>> https://www.spinics.net/lists/dri-devel/msg155618.html
>>
>> IMHO, this got overengineered. For displays we do not need all that
>> setup/sample delay timing information, and much longer cables are in
>> use. So why is all that needed for bridges?
> 
> I also avoided the overhead of creating this abstraction initially.
> 
> But after doing it I have this Stockholm syndrome that I start
> liking what Laurent told me to do.
> 
>> For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
>> clearly states:
>> Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.
>>
>> So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
>> should be used, which makes the pl111 driver setting TIM2_IPC:
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index.html
> 
> That is easy to say, but if I just set that up in code, even with a good
> comment it is hard for the next reader to understand what is going
> on. The central question will be, why does PL111 need to do this
> but not R-Car though they are using the same bridge?

That is something I have experienced before. Depending on drive
strength, and I guess sampling delay etc, it might sample just late
enough that signals are stable and no issues are really visible on the
screen. In those cases different cabling, changes in drive strength, or
even production variations might suddenly show artefacts though... My
point being, just because it supposedly works, does not mean that it is
right.

I did introduce the bus flags a while ago:
https://patchwork.kernel.org/patch/8254801/
https://patchwork.kernel.org/patch/8254821/

And then had to debug quite some controller and display issues around
pixel clock polarity:
https://patchwork.kernel.org/patch/8117181/
https://patchwork.kernel.org/patch/9465485/

E.g. in that last case, the pixel clock polarity flags were interpreted
wrong on both controller and display side. Hence this worked fine for
the case already upstream, but it did not work in my case...

In the end, best thing is to look on the bus. Parallel display signals
are still rather slow, and usually rather easy to scope.

PL111 needs to do this because its standard setting is driving on rising
edge. However, most displays as well as that bridge sample data on
rising edge.

I guess R-Car DU drives on negative edge by default, but can't say for
sure without hardware/data sheet.

As far as I can tell the R-Car DU driver also does not use the
DRM_BUS_FLAG_PIXDATA_*EDGE flags currently.



> 
> So this elaborate model gives a better transfer of abstract concepts
> to whoever needs to touch that code next. The code is not just
> logic, but also our map of the world and the documentation of our
> problem space.
> 
> Donald Knuth has this idea about literate programming which even
> turns the documentation/implementation process around. We are
> not there, not even remotely, but IMO the more complex the problem.
> the more we need to convey our thinking, not just our solution.

Fully agree.

My argument here is, that the map of the world (code) and the problem
are not aligned.

--
Stefan
