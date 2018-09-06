Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D94FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AFE20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="auM8DQNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AFE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeIGBDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:03:07 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48634 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeIGBDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:03:06 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9B33D5C0840;
        Thu,  6 Sep 2018 22:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536265556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoWo7ocZy3OhtTKHZoy+DZARznPO7J5oz+g0gvUMo1A=;
        b=auM8DQNjnnhW/SKHfj5jaOa28QW2qS6SmIy9Dxgw3zzQ1ltS4RtRBwKViYgC65l1XWn/DQ
        u8j6AvH7/nWQ5mbU+2CCn2WAn1jal47rsvyk+nKEYDRV/ZTuUBk5n4WvFA33KtE1jNvGcL
        Pl+ag5XbUzmezkIFP8BMN5w2UQRhAK0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Sep 2018 13:25:56 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dave Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
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
In-Reply-To: <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
References: <20180905052113.21262-1-stefan@agner.ch>
 <4035252.QuWadVx7pr@avalon> <1569297.pdEFdpi3HS@avalon>
 <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
 <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
Message-ID: <b1cb586397a4cd444c33dd83d72fa544@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.2018 04:07, Linus Walleij wrote:
> On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
>> On 05.09.2018 00:44, Laurent Pinchart wrote:
> 
>> Good point! I actually really don't like that we use the same flags here
>> but from a different perspective. Especially since the flags defines
>> document things differently:
>>
>> /* drive data on pos. edge */
>> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
>> /* drive data on neg. edge */
>> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)
> 
> Maybe a stupid comment from my side, but can't we just change the
> documentation to match the usecases?
> 
> /* Trigger pixel data latch on positive edge */
> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> 
>> Using the opposite perspective would also need translation in crtc
>> drivers... So far no driver uses sampling_edge.
>>
>> I would prefer if we always use the meaning as documented by the flags.
>>
>> I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
>> DRM_BUS_FLAG_PIXDATA_NEGEDGE.
>>
>> Linus Walleij, you added sampling edge, any thoughts?
> 
> I just thought it was generally useful to have triggering edge encoded
> into the bridge as it makes it clear that this edge is something
> that is a delayed version of the driving edge which is subject to
> clock skew caused by the speed of electrons in silicon and
> copper and slew rate caused by parasitic capacitance.

Ok, I read a bit up on the history of bridge timing, especially:
https://www.spinics.net/lists/dri-devel/msg155618.html

IMHO, this got overengineered. For displays we do not need all that
setup/sample delay timing information, and much longer cables are in
use. So why is all that needed for bridges?

For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
clearly states:
Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.

So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
should be used, which makes the pl111 driver setting TIM2_IPC: 
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index.html

> DRM_BUS_FLAG_PIXDATA_POSEDGE is the right value for my use cases, but it 
> doesn't match how the ADV7123 operates. Using DRM_BUS_FLAG_PIXDATA_NEGEDGE 
> would match the hardware, but would break display for some modes, depending on 
> the display clock frequency as the internal 8.5ns output delay applied to a 
> falling clock edge would fall right into the 1.7ns setup + hold time window of 
> the ADV7123 around the rising edge. I can't test this right now as I don't 
> have local access to boards using the ADV7123, but from a quick calculation 
> that ignores the PCB transmission delay modes with frequencies between 57MHz 
> and 71MHz could break if the data was output on the falling edge of the clock.

If clocks vs. data signal are really that much off on R-Car DU, then
parallel displays must have the very same issue...

Are you sure that only the clock signal has an output delay? And that
this output delay is a fixed value, clock independent?

Typically, delays apply to all signals equally, and often are clock
frequency dependent...

Without really looking at the signals, I would not jump to conclusions
here! I am pretty sure that driving on negative edge works just as well.

--
Stefan

> 
> Yours,
> Linus Walleij
