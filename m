Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47968214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrBUHON0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfBDQDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:03:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40309 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfBDQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:03:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so119622plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q3pvE3XcaaskQri/CTEnINYvixmlLLzqI7M1l4ZwfGM=;
        b=VrBUHON0ZSP1G9+g99coAseZNTR4BQC8ipA//y9KYaxm9rioWUXBXZGnnV3XUvLded
         JWRoxRQNkKkLbjpvt5HStfdbXFRh35ay0PRZ/w4Q0YyThthEKRzmlGvH2P/2XdK9mwhG
         cbslbRc296BgvjnS5uFVXzGARhiXQN3NM9yoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3pvE3XcaaskQri/CTEnINYvixmlLLzqI7M1l4ZwfGM=;
        b=mgVX3hlsc6srrLQqzW0ZdLmsJy+si4NJbo7GBW//Nz8pkTckS/BsoZlExv0Id/b4gJ
         3ZWEVDwyA3pKgVGzsYBQqt0Yhqn8YyOLKZhrN+i+L5l7GF7WRCB+K7vlW70Mc+0AIcFF
         tSA0QEVIU+g7FODH8tXX7igrIRmaEE2JXCO1OB26JrYPJsQc1pCcRBogj/cyMA/okYF0
         m04EK0SVpN+W9K1rI4ERiF5UsHRRZcvQlYB5bCQ7Qnt8i9+BLUxURzECQaYWIQrK7SDc
         Mc1X8k9IZzUd2rteOBbW1sKv8P0XIj8ZKP2SPGV2wkpzLDv3cbV0IkW+WXxJw6OrFFtE
         /D3g==
X-Gm-Message-State: AHQUAubOvveXdcR8izsox5GO1jvGImZj1GvZSdeUUn6d9rgnsbKIqVMJ
        fKQr+AifJ62E5MdGSgawwOgTPA==
X-Google-Smtp-Source: AHgI3IYR/wBDLSSzqoFx9FHCuhVdG6ijUQy8aFa0KImmQhHN901R7WLmiAMPgRNkuQQrT5Cpc0PANw==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr37805plb.323.1549296220729;
        Mon, 04 Feb 2019 08:03:40 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b5sm660136pfc.150.2019.02.04.08.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 08:03:39 -0800 (PST)
Date:   Mon, 4 Feb 2019 08:03:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
Message-ID: <20190204160337.GG2387@tuxbook-pro>
References: <20190125232954.26166-1-bjorn.andersson@linaro.org>
 <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
 <20190129224652.GB11349@centauri.lan>
 <20190204104347.GD23441@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204104347.GD23441@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Feb 02:43 PST 2019, Mark Brown wrote:

> On Tue, Jan 29, 2019 at 11:46:52PM +0100, Niklas Cassel wrote:
> 
> > Adding Mark Brown on CC.
> 
> It really helps if you ask a specific question when doing something like
> this rather than just have a big quoted mail - it makes it much easier
> to find what's relevant rather than trying to find things, especially
> when they're buried behind several layers of quoting.
> 
> > On Tue, Jan 29, 2019 at 10:58:47PM +0100, Jorge Ramirez wrote:
> > > On 1/26/19 00:29, Bjorn Andersson wrote:
> 
> > > the question is, should this property contain only hardware achievable
> > > values? or should drivers only request hardware achievable values? the
> > > way the constrains are implemented it has to be one of the two (I think
> > > the former would be more intuitive - ie if the dts
> > > regulator-min-microvolt is a valid value)
> 
> Drivers should not be coded with a specific regulator or board in mind
> and should just request whatever they need.  This will then be matched
> with whatever the board is actually able to deliver.  Similarly there is
> no requirement that machine constraints be written with specific
> reference to what the physical regulator on the board is able to do, for
> example the constraints will come from electrical engineering
> restrictions like the specifications of the parts connected to the
> regulator rather than from what the regulator can actually do so people
> should feel free to just write down the actual physical constraint and
> let the regulator API ensure that the constraint is met.

We have a regulator that is described as 1.05V in the schematics for the
board we're working on and we have the USB block wanting 1.05V on one of
its pins.  But the particular regulator works in steps of 8mV, and the
adjacent steps are 1.048V and 1.056V.

A) If we describe the min-microvolt = max-microvolt = 1.05V then the
regulator frameworks adjusts the min value to 1.056V, per the steps, and
fail as min > max.

B) The USB driver that we inherited was written to request min/max of
1.05V/1.05V, so pointing this to a regulator with min/max of e.g.
1.05V/1.06V we're outside the adjusted range of 1.056V/1.06V.


So the question is, should the board dts be written with
min/max-microvolt adjusted to match the hardware steps? Or could the
regulator framework be made to round down to the previous valid step
instead of up?

Regards,
Bjorn
