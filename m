Return-Path: <mchehab+samsung@kernel.org>
X-Google-Smtp-Source: AB8JxZoWQ19uJKGlJ/JEO7liWanYWq4oPtnszWustsaDE40AcUZzPlBp6wCxS5cAXxdFkfUdBSpt
ARC-Seal: i=1; a=rsa-sha256; t=1525462215; cv=none;
        d=google.com; s=arc-20160816;
        b=QkK7WzFOM7wbYDLcI/KkEodmxFEmrUPDg34HJyZTGRvYv5HM0tEUIOHzKh2xsqL/Dn
         42nL6nXL9omDvAUp5DrwOXrpkOfloh6caRDB8Cqi7tE9Nm1tNVv+toPxcO6g9+It9Gdv
         sYtCH6qtNINSNFChx3nWxyVlTQix+OQM4WSFYmEaV772U3+j7ReIVpGDhe729xdXIwgd
         aL20dam15Wvar7f4FcZf5K8CuioTM92UBu3AjilxOUiP5Gtz4F/9AIhNEAQRPGYp31Qi
         38idCkVFAzbu36BTTkQNIAcnMMWkpjbJm3LJIew6ZTjiUblKWmUql+j0xcZffyDjsxdp
         hOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ASiNS8+ski53a9iizi+xH5C9sJSnIzN1aiV6HlPnJnA=;
        b=XSgnslH90A3Ho8LAeZsffo044GsRb7rl6GdB1Z5xvnUaY/6QO3LBhOi8Jf5LOWxQoa
         QB3wxuUznYfXvL1o+4J8XoyvebVkPTymkuaQnwQerKwcC0bRs3jSH6lANmlAuqsvZ4fq
         zVczxDBNo7sCC7qC1dBQk9zI+1KWKddoKpDYWQY+wFFkA+AWgauLMvEMtCeeCd9E5UyN
         ARnDF9V5j2G6mHvxS/+zuPNVubrbckQ47LxiMD19FRQYBC2ObBjogmOqFfZ8LnaYPvm/
         aJ0USyHe9sBDcIvs1wxbqQDgGzkis4GkhPN6z4wI1Pjwm8HZK2/ctZ4z/Fmok8fzcboQ
         D7jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tw5zRaWq;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=tw5zRaWq;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 16:29:32 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack
 <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Bartlomiej
 Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, Vinod
 Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Ezequiel Garcia
 <ezequiel.garcia@free-electrons.com>, Boris Brezillon
 <boris.brezillon@free-electrons.com>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek
 Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille
 Pitchen <cyrille.pitchen@wedev4u.fr>, Nicolas Pitre <nico@fluxnic.net>,
 Samuel Ortiz <samuel@sortiz.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Petr Cvek
 <petr.cvek@tul.cz>, Sakari Ailus <sakari.ailus@iki.fi>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Pravin Shedge
 <pravin.shedge4linux@gmail.com>, Flavio Ceolin <flavio.ceolin@intel.com>,
 Robert Jarzmik <robert.jarzmik@renault.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Niklas
 =?UTF-8?B?U8O2ZGVybHVuZA==?=        
 <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 04/15] media: pxa_camera: remove the dmaengine compat
 need
Message-ID: <20180504162932.52a020cc@vento.lan>
In-Reply-To: <89f3e97c-08a4-33b6-8fd3-0c1b4dea2065@xs4all.nl>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
	<20180402142656.26815-5-robert.jarzmik@free.fr>
	<89f3e97c-08a4-33b6-8fd3-0c1b4dea2065@xs4all.nl>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644928520099498?=
X-GMAIL-MSGID: =?utf-8?q?1599563068746834222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Sun, 22 Apr 2018 13:06:12 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> On 04/02/2018 04:26 PM, Robert Jarzmik wrote:
> > From: Robert Jarzmik <robert.jarzmik@renault.com>
> > 
> > As the pxa architecture switched towards the dmaengine slave map, the
> > old compatibility mechanism to acquire the dma requestor line number and
> > priority are not needed anymore.
> > 
> > This patch simplifies the dma resource acquisition, using the more
> > generic function dma_request_slave_channel().
> > 
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>  
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

I'm assuming that you'll be applying it together with other PXA patches.
So:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Regards,
Mauro
> 
> Regards,
> 
> 	Hans
> 
> > ---
> >  drivers/media/platform/pxa_camera.c | 22 +++-------------------
> >  1 file changed, 3 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
> > index c71a00736541..4c82d1880753 100644
> > --- a/drivers/media/platform/pxa_camera.c
> > +++ b/drivers/media/platform/pxa_camera.c
> > @@ -2357,8 +2357,6 @@ static int pxa_camera_probe(struct platform_device *pdev)
> >  		.src_maxburst = 8,
> >  		.direction = DMA_DEV_TO_MEM,
> >  	};
> > -	dma_cap_mask_t mask;
> > -	struct pxad_param params;
> >  	char clk_name[V4L2_CLK_NAME_SIZE];
> >  	int irq;
> >  	int err = 0, i;
> > @@ -2432,34 +2430,20 @@ static int pxa_camera_probe(struct platform_device *pdev)
> >  	pcdev->base = base;
> >  
> >  	/* request dma */
> > -	dma_cap_zero(mask);
> > -	dma_cap_set(DMA_SLAVE, mask);
> > -	dma_cap_set(DMA_PRIVATE, mask);
> > -
> > -	params.prio = 0;
> > -	params.drcmr = 68;
> > -	pcdev->dma_chans[0] =
> > -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> > -						 &params, &pdev->dev, "CI_Y");
> > +	pcdev->dma_chans[0] = dma_request_slave_channel(&pdev->dev, "CI_Y");
> >  	if (!pcdev->dma_chans[0]) {
> >  		dev_err(&pdev->dev, "Can't request DMA for Y\n");
> >  		return -ENODEV;
> >  	}
> >  
> > -	params.drcmr = 69;
> > -	pcdev->dma_chans[1] =
> > -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> > -						 &params, &pdev->dev, "CI_U");
> > +	pcdev->dma_chans[1] = dma_request_slave_channel(&pdev->dev, "CI_U");
> >  	if (!pcdev->dma_chans[1]) {
> >  		dev_err(&pdev->dev, "Can't request DMA for Y\n");
> >  		err = -ENODEV;
> >  		goto exit_free_dma_y;
> >  	}
> >  
> > -	params.drcmr = 70;
> > -	pcdev->dma_chans[2] =
> > -		dma_request_slave_channel_compat(mask, pxad_filter_fn,
> > -						 &params, &pdev->dev, "CI_V");
> > +	pcdev->dma_chans[2] = dma_request_slave_channel(&pdev->dev, "CI_V");
> >  	if (!pcdev->dma_chans[2]) {
> >  		dev_err(&pdev->dev, "Can't request DMA for V\n");
> >  		err = -ENODEV;
> >   
> 



Thanks,
Mauro
