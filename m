Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A44C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731192148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfA2Ka7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:30:59 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50153 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2Ka7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:30:59 -0500
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2B44720008;
        Tue, 29 Jan 2019 10:30:54 +0000 (UTC)
Message-ID: <12e21befacf68861ddf34020838ff7a6e6e078ad.camel@hadess.net>
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
From:   Bastien Nocera <hadess@hadess.net>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Tue, 29 Jan 2019 11:30:53 +0100
In-Reply-To: <20190129091651.GA8497@bogon.m.sigxcpu.org>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
         <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
         <20190129091651.GA8497@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 10:16 +0100, Guido Günther wrote:
> Hi,
> On Mon, Jan 28, 2019 at 07:24:33PM +0100, Bastien Nocera wrote:
> > On Mon, 2019-01-28 at 18:03 +0100, Guido Günther wrote:
> > > From what I've seen in vendor trees it's fine to treat this as
> > > gt1x¹.
> > > 
> > > [1]: 
> > > https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drivers/input/touchscreen/mediatek/GT5688
> > 
> > Can you please point to the exact line of code that makes you say
> > that?
> > I'm not saying it's not compatible, but it's not the same driver
> > that
> > the current goodix.c was based on, or even goodix.c.
> > 
> > Can you please elaborate?
> 
> I basically looked at the registers uses for the config update:
> 
> https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/touchscreen/mediatek/GT5688/include/gt1x_tpd_common.h#L152
> https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/touchscreen/mediatek/GT5688/gt1x_generic.c#L430

I'm not sure that's good enough to say that the touchscreen models are
compatible.

> That and the fact that the driver is doing it's job well made me
> believe
> that's good for base support.

If you've tested it, that's better. Can you please add a reference to
the device that you've tested this on in the commit message?

>  Things like hotknot, gesture wakeup and
> proximity sensor will need additional work.
> 
> > Finding that data in the specs would also be fine:
> > https://github.com/hadess/gt9xx/tree/master/specifications
> 
> https://github.com/hadess/gt9xx/pull/3

Merged that, thanks

Cheers

