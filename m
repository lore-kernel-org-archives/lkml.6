Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53213C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1120C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FQJIqJDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD1120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJAWeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:34:09 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52004 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeJAWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:34:08 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 521CF6F8;
        Mon,  1 Oct 2018 17:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538409339;
        bh=eWJSvPjO1YBzy4kGEdn1C+UBQS+hFM6od4YgSYdrrGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQJIqJDQgp9XejDgYkhqOXkUfrqGa2HUzaci5yUtDAs7Y9OV3opRyA/92LOmd9JgZ
         m/jX8d+znsRswiCazhlXFNYK85HyQGgreO1PG+n66iE9qBz8A0X7EdjWwJdRVhGl23
         oHf92SFm4kj8RTtsfHQSkF/zm8AaVNkyMmPq7Qso=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/7] [media] ad5820: DT new optional field enable-gpios
Date:   Mon, 01 Oct 2018 18:55:56 +0300
Message-ID: <1740213.b4QuNDOMfZ@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAL_JsqJ32c3FXrUmCO0N16GcrUJ53tj5rp3VvV0s5H1NybwqKQ@mail.gmail.com>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com> <CAPybu_0+F-o03qfg6u3RjgCJaeqzEoma4Niz-H9=0bSHJo+9jg@mail.gmail.com> <CAL_JsqJ32c3FXrUmCO0N16GcrUJ53tj5rp3VvV0s5H1NybwqKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Monday, 1 October 2018 18:01:42 EEST Rob Herring wrote:
> On Mon, Oct 1, 2018 at 7:40 AM Ricardo Ribalda Delgado wrote:
> > On Mon, Oct 1, 2018 at 2:36 PM Rob Herring wrote:
> >> On Mon, Oct 1, 2018 at 3:20 AM Ricardo Ribalda Delgado wrote:
> >>> On Thu, Sep 27, 2018 at 8:23 PM Rob Herring wrote:
> >>>> On Thu, Sep 20, 2018 at 10:47:47PM +0200, Ricardo Ribalda Delgado 
wrote:
> >>>>> Document new enable-gpio field. It can be used to disable the part
> >>>>> enable-gpios without turning down its regulator.
> >>>>> 
> >>>>> Cc: devicetree@vger.kernel.org
> >>>>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> >>>>> Acked-by: Pavel Machek <pavel@ucw.cz>
> >>>>> ---
> >>>>> 
> >>>>>  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 7
> >>>>>  +++++++
> >>>>>  1 file changed, 7 insertions(+)
> >>>>> 
> >>>>> diff --git
> >>>>> a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> >>>>> b/Documentation/devicetree/bindings/media/i2c/ad5820.txt index
> >>>>> 5940ca11c021..9ccd96d3d5f0 100644
> >>>>> --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> >>>>> +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> >>>>> 
> >>>>> @@ -8,6 +8,12 @@ Required Properties:
> >>>>>    - VANA-supply: supply of voltage for VANA pin
> >>>>> 
> >>>>> +Optional properties:
> >>>>> +
> >>>>> +   - enable-gpios : GPIO spec for the XSHUTDOWN pin. Note that
> >>>>> the polarity of +the enable GPIO is the opposite of the XSHUTDOWN
> >>>>> pin (asserting the enable +GPIO deasserts the XSHUTDOWN signal
> >>>>> and vice versa).
> >>>> 
> >>>> shutdown-gpios is also standard and seems like it would make more
> >>>> sense here. Yes, it is a bit redundant to have both, but things just
> >>>> evolved that way and we don't want to totally abandon the hardware
> >>>> names (just all the variants).
> >>> 
> >>> Sorry to insist
> >>> 
> >>> The pin is called xshutdown, not shutdown and is inverse logic,
> >>> Wouldnt it make more sense to use the name enable-gpios?
> >> 
> >> Inverse of what? shutdown-gpios is the inverse of enable-gpios. By
> >> using shutdown-gpios you can just get rid of "Note that the polarity
> >> of the enable GPIO is the opposite of the XSHUTDOWN pin (asserting the
> >> enable GPIO deasserts the XSHUTDOWN signal and vice versa)."
> > 
> > The pin is called XSHUTDOWN
> > 
> > 0V means shutdown
> > 
> > 3.3V means enable
> > 
> > This is why I think is more clear to use enable as name in the device
> > tree.
> 
> Neither enable-gpios nor shutdown-gpios have a defined polarity. The
> polarity is part of the flags cell in the specifier.

To be precise, the polarity is the relationship between the logical level (low 
or high) *on the GPIO side* and the logical state (asserted or deasserted) of 
the signal *on the device side*. This is important in order to take all 
components on the signal path into account, such as inverters on the board. 
The polarity does tell what level to output on the GPIO in order to achieve a 
given effect.

The polarity, however, doesn't dictate what effect is expected. This is 
defined by the DT bindings (together with the documentation of the device). 
For instance an enable-gpios property in DT implies that an asserted logical 
state will enable the device. The GPIO polarity flags thus take into account a 
possible inverter at the device input (as in the difference between the ENABLE 
and nENABLE signals), but stops there.

In this case, we have an XSHUTDOWN pin that will shut the device down when 
driven to 0V. If we call the related DT property shutdown, its logical level 
will be the inverse of XSHUTDOWN: the signal will need to be driven low to 
assert the shutdown effect. The GPIO flags will thus need to take this into 
account, and documenting it in DT could be useful to avoid errors.

On the other hand, if we call the related DT property enable its logical level 
will the the same as XSHUTDOWN: the signal will need to be driven high to 
assert the enable effect.

On the driver side we would have to deassert shutdown or assert enable to 
enable the device.

I don't mind which option is selected, as long as the DT bindings are clear 
(without any inverter in the signal path beside the one inside the ad5820, the 
polarity would need to be high for the enable case and low for the shutdown 
case).

-- 
Regards,

Laurent Pinchart



