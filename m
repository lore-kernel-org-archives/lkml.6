Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB0BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D429B2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJZDD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:03:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33727 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJZDD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:03:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id g25so330893otl.0;
        Thu, 25 Oct 2018 11:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cbAsnv1AyMNVii+EEFGeMzHngWxMm3A6iMUt2ujqc+E=;
        b=AC9TrrVDQmo+viaqkWPNrE40ITFlR8pLGYYyC/diGJKJy1a+hNpW8K6PC+Q4Ir91Ot
         o37rKUG8pyLzW0eUaHNOu4Zn7X0EiaaRnyfav2d0N6P4gxf/vtpyNGJ9phKrc9sDc/Fc
         K34TIdGbUbCf4OQ+NRImhETCDljaGdbt8U9+V5JZ9wgg82QVvHHwuPJtx0LcRiGnMF21
         WTuRg+V+q5Kfca+F0qdD9zyHVIbv9g8ryZ3hNwSBwRZrJMLfqabm4m7UVstwAZDbHros
         DSGIb6XSYr325o09xsQPUSHnmbI0u9Y0dx+eY5TIIFfoFtZNEctasu88uOIdItsAN7sI
         UopA==
X-Gm-Message-State: AGRZ1gJ8bYNTiiTFJp03cL0chvjGatzluqwm1LH2gSujgNNLE8IB7tL9
        QsK3jdozgwTzW/3yUWZhKA==
X-Google-Smtp-Source: AJdET5frMn8BgzFM3CSLJxtfSoWrUNVGmnpzoPaf9hDRQni4t3sO8RBRrxem1DzZ10Dzwar73hAKtA==
X-Received: by 2002:a9d:6254:: with SMTP id i20mr201985otk.249.1540492205476;
        Thu, 25 Oct 2018 11:30:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y29sm252311oty.8.2018.10.25.11.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:30:04 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:30:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Message-ID: <20181025183003.GA12672@bogus>
References: <20181018073327.64942-1-icenowy@aosc.io>
 <1886367.eljNk7jKYl@avalon>
 <c68f0da9607805e1f6673a9a16a7dcfff4d8fe91.camel@aosc.io>
 <2778638.na8ndVNUfi@avalon>
 <f71d442412f31828c466e3483e9d42f5e96ddc1d.camel@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f71d442412f31828c466e3483e9d42f5e96ddc1d.camel@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 08:40:11PM +0800, Icenowy Zheng wrote:
> 在 2018-10-18四的 14:23 +0300，Laurent Pinchart写道：
> > Hi Icenowy,
> > 
> > On Thursday, 18 October 2018 13:00:05 EEST Icenowy Zheng wrote:
> > > 在 2018-10-18四的 11:53 +0300，Laurent Pinchart写道：
> > > > On Thursday, 18 October 2018 10:33:22 EEST Icenowy Zheng wrote:
> > > > > The ANX6345 is an ultra-low power DisplayPort/eDP transmitter
> > > > > designed
> > > > > for portable devices.
> > > > > 
> > > > > Add a binding document for it.
> > > > > 
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > ---
> > > > > 
> > > > >  .../bindings/display/bridge/anx6345.txt       | 39
> > > > > +++++++++++++++++++
> > > > > 
> > > > >  1 file changed, 39 insertions(+)
> > > > >  create mode 100644
> > > > > 
> > > > > Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > new
> > > > > file
> > > > > mode 100644
> > > > > index 000000000000..0689d4eb5f65
> > > > > --- /dev/null
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> > > > > @@ -0,0 +1,39 @@
> > > > > +Analogix ANX6345 eDP Transmitter
> > > > > +--------------------------------
> > > > > +
> > > > > +The ANX6345 is an ultra-low power Full-HD eDP transmitter
> > > > > designed
> > > > > for
> > > > > +portable devices.
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > + - compatible		: "analogix,anx6345"
> > > > > + - reg			: I2C address of the device
> > > > > + - reset-gpios		: Which GPIO to use for reset
> > > > > +
> > > > > +Optional properties:
> > > > > +
> > > > > + - dvdd12-supply	: Regulator for 1.2V digital core
> > > > > power.
> > > > > + - dvdd25-supply	: Regulator for 2.5V digital core
> > > > > power.
> > > > 
> > > > Shouldn't these to supplies be mandatory ?
> > > 
> > > Yes they should.
> > > 
> > > > > + - panel-supply		: Regulator for the power of
> > > > > the panel.
> > > > 
> > > > Shouldn't the panel supply for specified in the DT node of the
> > > > panel
> > > > ?
> > > 
> > > However, eDP panel can be probed, may vary on the same device, and
> > > we
> > > don't have a generic binding for it...
> > 
> > Shouldn't we fix that ? :-)
> 
> Maybe we should create a connector binding instead of a panel binding?

There's not any such thing as a standard eDP connector, is there? 
Otherwise, that's just creating a generic panel binding in disguise. 
Maybe if eDP interface is standardized enough in terms of power control, 
control lines, EDID at least sometimes present, etc., then we could have 
some sort of generic eDP panel/connector binding.

Rob
