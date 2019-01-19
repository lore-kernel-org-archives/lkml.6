Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10855C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AC52087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547919867;
	bh=TM35aWnH5m8UtndAVmOGbGnPUwbzCNoxZUtWLpUhstI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fW7o8esMXWSwSSmLuPZkb/jtzXR1EQ/cvZJR9dFfLZZ+jV8Gk8pAd7xuecR5/w+g9
	 tQAt7O9gbLouYdlS/F+4NaoNik7lJJ9nFibeShsVvbYBijhNeSUN0Z0EOngnjJyr0U
	 dPiaHhOD5oFPmYrW6QRN2bOLpy8JVGCSPJbUxIWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfASRoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbfASRoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:44:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E9D2084F;
        Sat, 19 Jan 2019 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547919864;
        bh=TM35aWnH5m8UtndAVmOGbGnPUwbzCNoxZUtWLpUhstI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pXGykSWYvUkn1McjbodDAjjZ/gQc7yMwc3Og6TARvpKkuFv762UXr+k/BZEK045aA
         sYMQgStQMqFxgZrSe9gDA6Tj0QovDq6NEkDhj4nZxmBo7Ti4O5fxCtOtJOlEmNDF+v
         FRDQnNU4lmNxp1llVmrRSP5knDz0r+6ZKqvr4Icc=
Date:   Sat, 19 Jan 2019 17:44:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de
Subject: Re: [PATCH v3 1/2] iio: chemical: bme680: Add device-tree support
Message-ID: <20190119174418.32cb9a3f@archlinux>
In-Reply-To: <20190115184713.GC10186@himanshu-Vostro-3559>
References: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
        <20190115184713.GC10186@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 00:17:13 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Mon, Jan 14, 2019 at 03:19:13PM -0500, Sebastien Bourdelin wrote:
> > This commit allow the driver to work with device-tree.
> > 
> > Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> > ---  
> 
> 	Acked-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it and see if we missed anything.

Thanks,

Jonathan
> 
> Thanks!
> 
> > v2 -> v3:
> >   - remove of_match_ptr: Suggested by Jonathan Cameron <jic23@kernel.org>
> >   - minor style fixup
> >   - rebase on master
> > v1 -> v2:
> >   - add missing of.h header in bme680_spi.c
> > ---
> >  drivers/iio/chemical/bme680_i2c.c | 7 +++++++
> >  drivers/iio/chemical/bme680_spi.c | 8 ++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> > index 06d4be539d2e..b2f805b6b36a 100644
> > --- a/drivers/iio/chemical/bme680_i2c.c
> > +++ b/drivers/iio/chemical/bme680_i2c.c
> > @@ -70,10 +70,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> >  
> > +static const struct of_device_id bme680_of_i2c_match[] = {
> > +	{ .compatible = "bosch,bme680", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
> > +
> >  static struct i2c_driver bme680_i2c_driver = {
> >  	.driver = {
> >  		.name			= "bme680_i2c",
> >  		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
> > +		.of_match_table		= bme680_of_i2c_match,
> >  	},
> >  	.probe = bme680_i2c_probe,
> >  	.id_table = bme680_i2c_id,
> > diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> > index c9fb05e8d0b9..d0b7bdd3f066 100644
> > --- a/drivers/iio/chemical/bme680_spi.c
> > +++ b/drivers/iio/chemical/bme680_spi.c
> > @@ -6,6 +6,7 @@
> >   */
> >  #include <linux/acpi.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  #include <linux/regmap.h>
> >  #include <linux/spi/spi.h>
> >  
> > @@ -110,10 +111,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> >  
> > +static const struct of_device_id bme680_of_spi_match[] = {
> > +	{ .compatible = "bosch,bme680", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
> > +
> >  static struct spi_driver bme680_spi_driver = {
> >  	.driver = {
> >  		.name			= "bme680_spi",
> >  		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
> > +		.of_match_table		= bme680_of_spi_match,
> >  	},
> >  	.probe = bme680_spi_probe,
> >  	.id_table = bme680_spi_id,
> > -- 
> > 2.20.1
> >   
> 

