Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94207C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F44B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874040;
	bh=H90f+1PhDcCYsStTRPNxDGgXMm86z7WU9jb3gXdQZ14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uqkXD+SkVH8EhZEuqPp5I1drIIlHFpdGqkRdTzVu7cVA0a9Svo5wRAn0SFkrDGSwy
	 kkV6VRELE5oTCDHjaROwd4s1Byxa16inZ62QT8s858kudoTo06lvGa80HM6c+HVD2W
	 7CqFMr2CmvN05TGRFQj7/OsAxd7NrZOWeCX8Wp0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfBKId6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:33:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35731 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfBKId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:33:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id v7so2754902lfd.2;
        Mon, 11 Feb 2019 00:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXRBrZfleR9tkrKooKw/mjJvBRgchmBHV3mJTc0H0Cg=;
        b=F0WvOmHXzx98JXr/+E2txJQsFQ4BcjOnP/rSwjkp8qpJ2neyVQwxqJGHy2FkWnq8O7
         kDzUANcx8YYtrxjt1b6dv0Q2Wy/LaPBZudrSmo7Tg+3x5/2Q6RoXUx3Ods/vu2C7qKMl
         XtWwJzm0tx8gm6apdlbhzH1rsX1QK20MDWZOIWUcsQs8a4ENr2648HsE38JVI31AKYQu
         SxMw76CwBYO1CQrQGfh82IU2YuM0vqpBVaXw0DXcwx1+UmliX2gYjs8UOpum+RmnkQ83
         sp/u9C1aRGwKIGrFSrjndFNUAV9gUF4dVUX2qIsY0VycdeZRJUZicJJpjy+w39EEI1Ee
         eTXw==
X-Gm-Message-State: AHQUAuaJAnM18ShBnSX1lsGJ7TyQn3fwQFo5vH4NHbYpX+rO6Fsrad71
        0I/BqZV6lJKAPHzmy6NITk8=
X-Google-Smtp-Source: AHgI3IaNzz58l1AYM1ozG1ZRxrZUYIsaYnBjmzsNy8Hca5hFmaq3Y8kJKEr03zDF3SLJc4PJJE5ejQ==
X-Received: by 2002:a19:ee13:: with SMTP id g19mr10611671lfb.72.1549874036291;
        Mon, 11 Feb 2019 00:33:56 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z6sm2138830lfa.87.2019.02.11.00.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:33:55 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gt72D-0004pO-Rw; Mon, 11 Feb 2019 09:33:49 +0100
Date:   Mon, 11 Feb 2019 09:33:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190211083349.GU4686@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost>
 <867eeo7pjm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867eeo7pjm.fsf@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:46:53PM +0100, Loys Ollivier wrote:
> 
> On Fri 25 Jan 2019 at 09:07, Johan Hovold wrote:
> 
> > On Thu, Jan 17, 2019 at 05:54:32PM +0100, Loys Ollivier wrote:
> >> Add binding for Mediatek-based GNSS receivers.
> >> 
> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >> ---
> >> 
> >> v2:
> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> >> Moved current-speed as an optional propertie.
> >> Removed the status line in the example.
> >> Added "mediatek,mt3339" compatible.

> >> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> >> @@ -0,0 +1,39 @@
> >> +Mediatek-based GNSS Receiver DT binding
> >> +
> >> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> >> +vendors and can use UART, SPI or I2C interfaces.
> >> +
> >> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> >> +properties.
> >> +
> >> +Required properties:
> >> +
> >> +- compatible	: Must be one of
> >> +
> >> +			"globaltop,pa6h"
> >> +			"mediatek,mt3339"
> >
> > I'm not sure it makes sense to add the GPS chip itself as it cannot be
> > used stand-alone AFAIU, and either not way would require a lot more
> > resources to be defined than what you add to this binding.
> 
> OK, I find it a bit confusing to have Mediatek bindings but no
> compatible Mediatek SoCs.
> But it is true that it can't be used stand-alone. I will remove this
> reference and also remove it from the mtk.c driver code from this patch
> serie.

> >> +Required properties (I2C):
> >> +- reg		: I2C slave address
> >> +
> >> +Required properties (SPI):
> >> +- reg		: SPI chip select address
> >
> > While the mt3339 appears to support these interfaces, the globaltop one
> > does not.
> >
> > Have you looked around for a small sample of mt3339-based receivers, to
> > see whether anyone actually provides these?
> 
> Again I'm confused by the fact that it is the Mediatek bindings.
> Hence why I have added it and why it was not present in the v1 that was
> only for Globaltop.

This is no different from the sirfstar driver for receivers based on
those chipsets but manufactured by various other vendors.

> I find it odd mentionning the chipset but not all its interfaces.
> I will remove these sections and only list supported interfaces (i.e.
> UART). Other interfaces can be added afterward if one finds a board that
> provides them.

Right, but please do look around for other receivers using this chipset
so that we can make the binding generic enough to cover those as well
(e.g. by choosing representative resource names).

Johan
