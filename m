Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A6DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4EC21741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pYJ+p1mG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4EC21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeHNIZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:25:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48962 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbeHNIZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:25:26 -0400
Received: from avalon.localnet (h-17-125.A137.corp.bahnhof.se [94.254.17.125])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 85105CE;
        Tue, 14 Aug 2018 07:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534225188;
        bh=eJYtQlJ+nPBtkRtsJmvlsaRsuTsuqaFaQKEGqfXTcwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYJ+p1mG3prTr48p9nrbJAi18/J1Brh4xb6UaJ9WQn0BQ+0YVSq6YATCTZnh8BvAP
         422U1YNXLcbNmR1+AH80Q4JxbvDBbJwH4NYWcZmBdzH0bn2O69mL3YPTSi/WyfaKNf
         LqyPytt8uEc7eoJRZmOpUKSMMUBpgJLWljihBdhA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: media: adv748x: Document re-mappable addresses
Date:   Tue, 14 Aug 2018 08:40:37 +0300
Message-ID: <2887621.fdKYYZGugR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAL_JsqJQNtRNq+b3sJ4eEse1pzWy3F-WgbDF7=t-TrvFx6WcUQ@mail.gmail.com>
References: <20180809192944.7371-1-kieran.bingham@ideasonboard.com> <dedade62-91ed-2c92-dac7-fe4a8f9d9452@ideasonboard.com> <CAL_JsqJQNtRNq+b3sJ4eEse1pzWy3F-WgbDF7=t-TrvFx6WcUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tuesday, 14 August 2018 01:48:05 EEST Rob Herring wrote:
> On Mon, Aug 13, 2018 at 1:17 PM Kieran Bingham wrote:
> > On 13/08/18 18:45, Rob Herring wrote:
> > > On Thu, Aug 09, 2018 at 08:29:44PM +0100, Kieran Bingham wrote:
> > >> The ADV748x supports configurable slave addresses for its I2C pages.
> > >> Document the page names, and provide an example for setting each of the
> > >> pages explicitly.
> > > 
> > > It would be good to say why you need this.
> > 
> > In fact - I should probably have added a fixes tag here, which would
> > have added more context:
> > 
> > Fixes: 67537fe960e5 ("media: i2c: adv748x: Add support for
> > i2c_new_secondary_device")
> 
> That doesn't really explain things from a DT perspective.
> 
> > Should I repost with this fixes tag?
> > Or can it be collected with the RB tag?
> 
> I'll leave that to Hans.
> 
> > > The only use I can think of
> > > is if there are other devices on the bus and you need to make sure the
> > > addresses don't conflict.
> > 
> > Yes, precisely. This driver has 'slave pages' which are created and
> > mapped by the driver. The device has default addresses which are used by
> > the driver - but it's very easy for these to conflict with other devices
> > on the same I2C bus.
> > 
> > Because the mappings are simply a software construct, we have a means to
> > specify the desired mappings through DT at the board level - which
> > allows the boards to ensure that conflicts do not appear.
> > 
> > > Arguably, that information could be figured out without this in DT.
> > 
> > How so ?
> > 
> > Scanning the bus is error prone, and dependant upon driver state (and
> > presence), and we have no means currently of requesting 'free/unused'
> > addresses from the I2C core framework.
> 
> True. But assuming all devices are in DT, then you just need to scan
> the child nodes of the bus and get a map of the used addresses. Though
> if you had 2 or more devices like this, then you'd need to maintain
> s/w allocated addresses too. It could all be maintained with a bitmap
> which you initialize with addresses in DT.

We've discussed this topic with Wolfram before, and unfortunately the base 
assumption of assuming all devices are in DT often doesn't hold :-( For all 
kind of reasons vendors often don't provide a full description of I2C buses, 
especially when slave devices don't need to be accessed from Linux. Sometimes 
they lack DT bindings for some I2C slaves that are not essential and still 
want to provide a partial but functional DT. Sometimes devices are hooked up 
to an I2C bus for debugging purposes only and end up never being used, so 
nobody bothers describing them. Sometimes an I2C slave has multiple slave 
addresses which DT writes are not aware of. Those are just a few examples.

One alternative would be to add a DT property to the I2C master node to list 
the known to be free addresses. I'm not sure that's better though. We should 
also keep in mind that some I2C slaves could have restrictions on which 
secondary addresses can be used, so we would need to pass constraints to the 
I2C address allocator, which would quickly become a mess.

-- 
Regards,

Laurent Pinchart



