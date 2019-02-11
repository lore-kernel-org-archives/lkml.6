Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AB72146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549876983;
	bh=9epsIt/A6F2QzjGryeFi0IsxIUNvrjE56LUM6dfUSgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eJz5IfG5AJZKzdFS+WO52XKUjS1FgSlBuaY2kNQ/UtHVPLhXGcv3Fzxw/bbwnVapw
	 SrW2ADxu2DeyAdShqlj6vgRg8Wxni9/mh6UY4NwnLrFXih7WVNdRy3ZCQn1O6blo0+
	 QWagkrr7r33yiH3aMxIs2sbZJSDkta0c1XQ0YfaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBKJXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:23:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45218 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:23:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so8065693ljd.12;
        Mon, 11 Feb 2019 01:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57cf3Lc6S+hV34hW4qWkEqcWBtCzdKYSCNE88tgbwFY=;
        b=aGf4dqiB592acHKI4k60laEPg015DvDO8LCtydrzzk0D8XusznPOLnFyuGl/9nGvQX
         F9O0YHfVSVQ1Ac9iNHeZQwsNQc5yDpRU7PwjcJ7qOVSJiNNui7nVSC4xJokq+/+232ut
         wGOub++djSlvox+tipPWcmk30VJaV1ZwsVgFS7jDZIqf3nRvXVvsIY7ip+mpqK2DcV3n
         JNYT6J8JXFNiCf/9nYAL8Jq7ZayMLeBmESjvf8yZX7WS1TLTgoUwcVj5Ouujdx+G4VUW
         V3MRhdh01BgK7AEyDhxZNWahaXnnRnT7aANJ/Ev/UrWAJQ1SJIS4BebtfS4supS4aTO/
         aq7w==
X-Gm-Message-State: AHQUAubNiGP4bDLZuyLxQ4GJayJucCRTdCILdCsGiyvzXvQ8GnJn3zaY
        65QFXZbUuEYte9zdmFeEc/k=
X-Google-Smtp-Source: AHgI3IZD1jEIfdMVWIhhGklrrMIe+2SC7DYFGzpUnfPu5MYxGNfkzXRHYwnnblKbLxcOwTdZ1dZ3RA==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr2988166ljr.45.1549876978579;
        Mon, 11 Feb 2019 01:22:58 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a21sm1034696lfk.61.2019.02.11.01.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 01:22:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gt7nf-00058B-Ak; Mon, 11 Feb 2019 10:22:51 +0100
Date:   Mon, 11 Feb 2019 10:22:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190211092251.GV4686@localhost>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
 <20190130155016.GA26536@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130155016.GA26536@bogus>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> > Add binding for Mediatek-based GNSS receivers.
> > 
> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> > ---
> > 
> > v3:
> > Removed the I2C and SPI interfaces references.
> > Removed the "mediatek,mt3339" compatible line.
> > Added the optional propertied (reset, fix)
> > Added the pin names for the optional properties.
> > 
> > v2:
> > Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> > Moved current-speed as an optional propertie.
> > Removed the status line in the example.
> > Added "mediatek,mt3339" compatible.
> > 
> >  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > new file mode 100644
> > index 000000000000..00650d81c5c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> > @@ -0,0 +1,37 @@
> > +Mediatek-based GNSS Receiver DT binding
> > +
> > +Mediatek chipsets are used in GNSS-receiver modules produced by several
> > +vendors and can use an UART interface.

s/an/a/

> > +
> > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> > +properties.
> > +
> > +Required properties:
> > +
> > +- compatible	: Must be
> > +
> > +			"globaltop,pa6h"
> > +
> > +- vcc-supply	: Main voltage regulator (pin name: VCC)
> > +
> > +Optional properties:
> > +
> > +- gtop,reset-gpios	: GPIO used to reset the device
> > +  			  (pin name: RESET, NRESET)
> 
> reset-gpios is the standard name.
> 
> > +- gtop,fix-gpios	: GPIO used to determine device position fix state
> > +			  (pin name: FIX, 3D_FIX)

I'm thinking we might need a standard name for fix-gpios as well. This
isn't a feature that is globaltop (or mediatek) specific, and other
manufacturers provide similar functionality through pins named UI_FIX,
or even LCKIND (lock indicator).

The pin is typically used to drive an indicator LED AFAIU, but the
characteristics of the signal varies from device to device (fw to fw),
for example, pulse when no lock and low otherwise, or pulse when a 2d or
3d-fix is acquired, etc.

I'm not sure how useful the pulsing would be for software, but someone
might find a use for it in some form.

Rob, is this something we want to keep in the binding, and if so, how
about using a generic name such as "gnss-fix-gpios"?

Johan
