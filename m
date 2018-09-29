Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B9BC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04C02084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8gxdOy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04C02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeI2Rui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeI2Rui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:50:38 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07792064A;
        Sat, 29 Sep 2018 11:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538220153;
        bh=C6eeGdQOdS87lf11YCEh5uxjLJD/0MFJBKxgkvx3jsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r8gxdOy+BmmX2tDP4XyaUG2D8G7s8aCYs33dLrfYr9Ryy19d8qxC2Ke+W1mnBgdRG
         vmd78wWvsQekccDAEBKcG1M9F/xnw58ZDTI/7nn+fZ8oJjyotMKYYdALuOKv71Fejj
         0oOgw5SDF10kLtzS/UpKJwviiV0x80tvhc4IunRw=
Date:   Sat, 29 Sep 2018 12:22:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180929122228.54c0b5dc@archlinux>
In-Reply-To: <20180926003402.GA6020@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
        <5baa1b01.1c69fb81.f0d8f.30c6@mx.google.com>
        <20180926003402.GA6020@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 08:34:02 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Mon, Sep 24, 2018 at 03:23:52PM -0700, Rob Herring wrote:
> > On Thu, Sep 20, 2018 at 09:13:40PM +0800, Song Qiang wrote:  
> > > PNI RM3100 magnetometer is a high resolution, large signal immunity
> > > magnetometer, composed of 3 single sensors and a processing chip.
> > > PNI is currently not in the vendors list, so this is also adding it.
> > >   
> 
> ...
> 
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > index 41f0b97eb933..5bf3395fe9ae 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > @@ -288,6 +288,7 @@ pine64	Pine64
> > >  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> > >  plathome	Plat'Home Co., Ltd.
> > >  plda	PLDA
> > > +pni     PNI  
> > 
> > PNI doesn't stand for something?
> >   
> 
> Hi Rob,
> 
> PNI should be 'PNI Sensor Corporation'. I saw that PLDA above mine and
> thought I should write down its abbreviation, which apparently is wrong.

To answer more directly.  If PNI itself stands for anything the company
is deliberately making it non obvious!  I had a good search to try and
find out and got nowhere...

> 
> yours,
> Song Qiang
> 
> > >  portwell	Portwell Inc.
> > >  poslab	Poslab Technology Co., Ltd.
> > >  powervr	PowerVR (deprecated, use img)  
> >   

