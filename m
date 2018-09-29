Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D2EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A83F2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiofYwnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A83F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeI2RyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbeI2RyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:54:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0B02064A;
        Sat, 29 Sep 2018 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538220366;
        bh=+zD75+TSyktm+DqCHtiewxuGGEWD0/B4TRifVAIbcbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IiofYwnTwRIe+0ZNHWlyqKlvIIoHCsawiE5qMkU+tiObz7nzHq0MWTUjyD2iE7p9w
         lSlarHzfz8fIzv4WPUtUeh9wn6OlL7T3VURmtxXHaPCT75tGE2QukN0WKl5j26k+//
         DXcKJopGeMb8cfUNtdndczeGcDhoh7Fg79t/D7wo=
Date:   Sat, 29 Sep 2018 12:26:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     ryang <decatf@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add device tree
 binding documentation
Message-ID: <20180929122602.66dde03d@archlinux>
In-Reply-To: <20180927193137.GA14849@bogus>
References: <20180922210539.6670-1-decatf@gmail.com>
        <20180927193137.GA14849@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 14:31:37 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, Sep 22, 2018 at 05:05:38PM -0400, ryang wrote:
> > Document device tree bindings for ROHM BH1750 ambient light sensor driver.
> > 
> > Signed-off-by: ryang <decatf@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> > new file mode 100644
> > index 000000000000..468350cc7af6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> > @@ -0,0 +1,18 @@
> > +ROHM BH1750 - ALS, Ambient light sensor
> > +
> > +Required properties:
> > +
> > +- compatible: Must be one of:
> > +    "rohm,bh1710"
> > +    "rohm,bh1715"
> > +    "rohm,bh1721"
> > +    "rohm,bh1750"
> > +    "rohm,bh1751"
> > +- reg: the I2C address of the sensor
> > +
> > +Example:
> > +
> > +bh1750@23 {  
> 
> light-sensor@23
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Fixed up.  Thanks Rob.

Jonathan

> 
> > +	compatible = "rohm,bh1750";
> > +	reg = <0x23>;
> > +};
> > -- 
> > 2.17.1
> >   

