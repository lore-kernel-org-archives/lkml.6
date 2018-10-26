Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC96C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760A920848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760A920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeJZInk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:43:40 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43864 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeJZInk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:43:40 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 2A8F6BFCA1;
        Fri, 26 Oct 2018 00:08:49 +0000 (UTC)
Date:   Fri, 26 Oct 2018 08:08:43 +0800
In-Reply-To: <20181025183003.GA12672@bogus>
References: <20181018073327.64942-1-icenowy@aosc.io> <1886367.eljNk7jKYl@avalon> <c68f0da9607805e1f6673a9a16a7dcfff4d8fe91.camel@aosc.io> <2778638.na8ndVNUfi@avalon> <f71d442412f31828c466e3483e9d42f5e96ddc1d.camel@aosc.io> <20181025183003.GA12672@bogus>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
To:     linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
CC:     devicetree@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-sunxi@googlegroups.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <3E73AB92-AFD7-4DA6-AF42-725B894DE114@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年10月26日 GMT+08:00 上午2:30:03, Rob Herring <robh@kernel.org> 写到:
>On Thu, Oct 18, 2018 at 08:40:11PM +0800, Icenowy Zheng wrote:
>> 在 2018-10-18四的 14:23 +0300，Laurent Pinchart写道：
>> > Hi Icenowy,
>> > 
>> > On Thursday, 18 October 2018 13:00:05 EEST Icenowy Zheng wrote:
>> > > 在 2018-10-18四的 11:53 +0300，Laurent Pinchart写道：
>> > > > On Thursday, 18 October 2018 10:33:22 EEST Icenowy Zheng wrote:
>> > > > > The ANX6345 is an ultra-low power DisplayPort/eDP transmitter
>> > > > > designed
>> > > > > for portable devices.
>> > > > > 
>> > > > > Add a binding document for it.
>> > > > > 
>> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > > > > ---
>> > > > > 
>> > > > >  .../bindings/display/bridge/anx6345.txt       | 39
>> > > > > +++++++++++++++++++
>> > > > > 
>> > > > >  1 file changed, 39 insertions(+)
>> > > > >  create mode 100644
>> > > > > 
>> > > > > Documentation/devicetree/bindings/display/bridge/anx6345.txt
>> > > > > 
>> > > > > diff --git
>> > > > >
>a/Documentation/devicetree/bindings/display/bridge/anx6345.txt
>> > > > >
>b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
>> > > > > new
>> > > > > file
>> > > > > mode 100644
>> > > > > index 000000000000..0689d4eb5f65
>> > > > > --- /dev/null
>> > > > > +++
>> > > > >
>b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
>> > > > > @@ -0,0 +1,39 @@
>> > > > > +Analogix ANX6345 eDP Transmitter
>> > > > > +--------------------------------
>> > > > > +
>> > > > > +The ANX6345 is an ultra-low power Full-HD eDP transmitter
>> > > > > designed
>> > > > > for
>> > > > > +portable devices.
>> > > > > +
>> > > > > +Required properties:
>> > > > > +
>> > > > > + - compatible		: "analogix,anx6345"
>> > > > > + - reg			: I2C address of the device
>> > > > > + - reset-gpios		: Which GPIO to use for reset
>> > > > > +
>> > > > > +Optional properties:
>> > > > > +
>> > > > > + - dvdd12-supply	: Regulator for 1.2V digital core
>> > > > > power.
>> > > > > + - dvdd25-supply	: Regulator for 2.5V digital core
>> > > > > power.
>> > > > 
>> > > > Shouldn't these to supplies be mandatory ?
>> > > 
>> > > Yes they should.
>> > > 
>> > > > > + - panel-supply		: Regulator for the power of
>> > > > > the panel.
>> > > > 
>> > > > Shouldn't the panel supply for specified in the DT node of the
>> > > > panel
>> > > > ?
>> > > 
>> > > However, eDP panel can be probed, may vary on the same device,
>and
>> > > we
>> > > don't have a generic binding for it...
>> > 
>> > Shouldn't we fix that ? :-)
>> 
>> Maybe we should create a connector binding instead of a panel
>binding?
>
>There's not any such thing as a standard eDP connector, is there? 
>Otherwise, that's just creating a generic panel binding in disguise. 
>Maybe if eDP interface is standardized enough in terms of power
>control, 
>control lines, EDID at least sometimes present, etc., then we could

eDP has the same display signal set with DP, including AUX which
carries DPCD and EDID (if present).

But I don't know whether other lines are standardized, including power, backlight, etc.

>have 
>some sort of generic eDP panel/connector binding.
>
>Rob
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
