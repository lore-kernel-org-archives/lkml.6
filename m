Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05844C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81022087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547917037;
	bh=3gxBaH2bE68Yfp+/oibOe9+ZC9R4mkaIaW55U9uYlT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hhqaonsO9SE0pseVhv6tFaM2deRFuLLsZWwBo4aoXkRkR2ou9BY+Jewwr3yph29wA
	 VPEnyvPTS0LJAxfwU2rcMH2xyXKzCMW58C6Bfs1pD1VaOuO+m+KvgIcPzsYDedWKoZ
	 ctwJPzQMhckEKXhHyM8v/nFF33hpeTDuXnqkmGlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfASQ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfASQ5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:57:15 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D162084F;
        Sat, 19 Jan 2019 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547917034;
        bh=3gxBaH2bE68Yfp+/oibOe9+ZC9R4mkaIaW55U9uYlT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uP7kLrpd0OlwbcUuSZ/kW5hEZ714LQxe8Zrbi9Kg5D2KChwNQQA4UqMgtZqJ/x/OG
         eMkCDi5BbOp31llRv2d02P2dUcb1mrcnDvcm5otZWHET2wRP13HAXPyXBlsSxUGz85
         QUlqMcc6v+3Hxp4mNjBo5ZdDmiKwK/M9uzjI+wB8=
Date:   Sat, 19 Jan 2019 16:57:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     sebastien bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for
 bme680
Message-ID: <20190119165709.5045a18b@archlinux>
In-Reply-To: <4768d945-61aa-a8ab-3e41-68b4f861cc69@gmail.com>
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
        <20190111205359.14158-2-sebastien.bourdelin@gmail.com>
        <20190112182837.4cc42743@archlinux>
        <4768d945-61aa-a8ab-3e41-68b4f861cc69@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 15:17:10 -0500
sebastien bourdelin <sebastien.bourdelin@gmail.com> wrote:

> On 1/12/19 1:28 PM, Jonathan Cameron wrote:
> > On Fri, 11 Jan 2019 15:53:59 -0500
> > Sebastien Bourdelin <sebastien.bourdelin@gmail.com> wrote:
> >  
> >> BME680 is a pressure/temperature/humidity/voc sensor.
> >>
> >> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>  
> > Hmm. We could add the VDD and VDIO regulators perhaps.
> > Driver assumes they are on currently but we'll get a board where control
> > is needed sooner or later.  I'm not that fussed about this though.  
> 
> If that's fine with you, i prefer to leave it as it is right now as i 
> don't feel
> 
> confident enough to correctly explain it in the Documentation.
> 
> But if you have more input, you are more then welcome!
Given we aren't planning to do more than turn them on and that'll work
fine with stub regulators (so they can effectively be optional for ever),
there is no particular need to put them in now if you prefer not to.

Jonathan

> 
> > Jonathan
> >  
> >> ---
> >>   .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> >> new file mode 100644
> >> index 000000000000..885a1b918340
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
> >> @@ -0,0 +1,11 @@
> >> +Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
> >> +
> >> +Required properties:
> >> +- compatible: must be "bosch,bme680"
> >> +
> >> +Example:
> >> +
> >> +bme680@77 {
> >> +          compatible = "bosch,bme680";
> >> +          reg = <0x77>;
> >> +};  

