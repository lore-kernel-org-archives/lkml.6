Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755735AbeCHJxX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:53:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53173 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755717AbeCHJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:53:19 -0500
X-Google-Smtp-Source: AG47ELsemGnLR5VK9+x0SsHIT+ss5mvny4RRVGPfnzhhVkuIsTJpY4+d0L++Qxyd/di6gP1iwnaBOA==
Date: Thu, 8 Mar 2018 09:53:15 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180308095315.mpcmx2ob6yhsnrm6@dell>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308094652.qg4atjw5c3hayaz3@earth.universe>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018, Sebastian Reichel wrote:
> On Wed, Mar 07, 2018 at 04:32:11PM +0000, Lee Jones wrote:
> > On Fri, 23 Feb 2018, Sebastian Reichel wrote:
> > > +static const struct mfd_cell cpcap_mfd_devices[] = {
> 
> [...]
> 
> > > +	}, {
> > > +		.name          = "cpcap-led",
> > > +		.id            = 4,
> > > +		.of_compatible = "motorola,cpcap-led-cp",
> > > +	}, {
> > > +		.name          = "cpcap-codec",
> > > +	}
> > > +};
> > 
> > With none of the entries containing platform_data /me wonders why you
> > can't still use devm_of_platform_populate()?
> 
> Because devm_of_platform_populate works with compatible properties and
> cpcap-codec does not have one after I removed it for Mark.

Sorry, I missed that conversation.  Why was it removed?

> > >  static int cpcap_probe(struct spi_device *spi)
> > >  {
> > >  	const struct of_device_id *match;
> > > @@ -260,7 +308,8 @@ static int cpcap_probe(struct spi_device *spi)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	return devm_of_platform_populate(&cpcap->spi->dev);
> > > +	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
> > > +				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
> > >  }
> > >  
> > >  static struct spi_driver cpcap_driver = {
> > 



-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
