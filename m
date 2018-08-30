Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F54C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C0C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C0C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH3Vk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:40:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43943 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeH3Vk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:40:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id 130-v6so20734qkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=t86HlEw9xnSZNQgbwp9+A7YLrbb5xQLEzHG0nFS1OVo=;
        b=bBLSHg40Ukwl6uBA6v8p85IiVeLHc4gIilIz4IP54cFDtN4BJDzqCBLOd0Cat7/VeQ
         PG7jpKJxln3Cj8UWJdWxHIB/ZuLbb1HuTUqHgk4opQ6L0mZc935kcpccqcKsrzRFa9DY
         7tzt399StUddsYTLFHuIFPzvdATzNmfSAkHY8K0nBgrnIUrCmTwvTAy9a6tnJIAw2n0D
         Hw6WF6Z0/6PFHRhCnMMRUHbFqNbI+w7kPp2MKy8eneiqL8JRP18T9YE6feNGWMPFUUbK
         tfLgtUDqJcxnoLTVghDPvi6zNvFCG3qQZGttxZGMmpXtrlFkJoRB4UBVmzwPOo6hSBM1
         4wuQ==
X-Gm-Message-State: APzg51DQ7AyK23hl4h0ZWEPZ975nl178/zSUIPG7sQYaG3EaMzlvqAWO
        3ofdyF25BGyuWYnQL/7D+BKgpWLYba4=
X-Google-Smtp-Source: ANB0VdYqXGUUTYjHJ6YDr0d1hsxERDB4rlTLi+xeO2DqOLBymWkuJen2pQBzM+dPtBalc9ryOU8ybQ==
X-Received: by 2002:a37:a811:: with SMTP id r17-v6mr12486528qke.81.1535650662728;
        Thu, 30 Aug 2018 10:37:42 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id x8-v6sm4373825qka.24.2018.08.30.10.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 10:37:42 -0700 (PDT)
Message-ID: <1070321d947fe290294ab3e838233227590a672c.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: Fix nouveau_connector_ddc_detect()
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 30 Aug 2018 13:37:41 -0400
In-Reply-To: <20180830173603.GP5565@intel.com>
References: <20180830171628.23999-1-lyude@redhat.com>
         <20180830173603.GP5565@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 20:36 +0300, Ville Syrjälä wrote:
> On Thu, Aug 30, 2018 at 01:16:28PM -0400, Lyude Paul wrote:
> > It looks like that when we moved over to using
> > drm_connector_for_each_possible_encoder() in nouveau, that one rather
> > important part of this function got dropped by accident:
> > 
> > 	/*          Right   v   here */
> > 	for (i = 0; nv_encoder = NULL, i < DRM_CONNECTOR_MAX_ENCODER; i++) {
> > 		int id = connector->encoder_ids[i];
> > 		if (id == 0)
> > 			break;
> > 
> > Since it's rather difficult to notice: the conditional in this loop is
> > actually:
> > 
> > 	nv_encoder = NULL, i < DRM_CONNECTOR_MAX_ENCODER
> > 
> > Meaning that all early breaks result in nv_encoder keeping it's value,
> > otherwise nv_encoder = NULL. Ugh.
> > 
> > Since this got dropped, nouveau_connector_ddc_detect() now returns an
> > encoder for every single connector, regardless of whether or not it's
> > detected:
> > 
> >     [ 1780.056185] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for
> > DP-2
> > 
> > So: fix this to ensure we only return an encoder if we actually found
> > one, and clean up the rest of the function while we're at it since it's
> > nearly impossible to read properly.
> > 
> > Changes since v1:
> > - Don't skip ddc probing for LVDS if we can't switch DDC through
> >   vga-switcheroo, just do the DDC probing without calling
> >   vga_switcheroo_lock_ddc() - skeggsb
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Fixes: ddba766dd07e ("drm/nouveau: Use
> > drm_connector_for_each_possible_encoder()")
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_connector.c | 49 ++++++++++++---------
> >  1 file changed, 28 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > index 71c3bd8ff9f8..461111aaedc4 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > @@ -414,9 +414,10 @@ nouveau_connector_ddc_detect(struct drm_connector
> > *connector)
> >  	struct nouveau_connector *nv_connector = nouveau_connector(connector);
> >  	struct nouveau_drm *drm = nouveau_drm(dev);
> >  	struct nvkm_gpio *gpio = nvxx_gpio(&drm->client.device);
> > -	struct nouveau_encoder *nv_encoder = NULL;
> > +	struct nouveau_encoder *nv_encoder = NULL, *found = NULL;
> >  	struct drm_encoder *encoder;
> > -	int i, panel = -ENODEV;
> > +	int i, ret, panel = -ENODEV;
> > +	bool switcheroo_ddc = false;
> >  
> >  	/* eDP panels need powering on by us (if the VBIOS doesn't default it
> >  	 * to on) before doing any AUX channel transactions.  LVDS panel power
> > @@ -433,37 +434,43 @@ nouveau_connector_ddc_detect(struct drm_connector
> > *connector)
> >  	drm_connector_for_each_possible_encoder(connector, encoder, i) {
> >  		nv_encoder = nouveau_encoder(encoder);
> >  
> > -		if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
> > -			int ret = nouveau_dp_detect(nv_encoder);
> > +		switch (nv_encoder->dcb->type) {
> > +		case DCB_OUTPUT_DP:
> > +			ret = nouveau_dp_detect(nv_encoder);
> >  			if (ret == NOUVEAU_DP_MST)
> >  				return NULL;
> > -			if (ret == NOUVEAU_DP_SST)
> > -				break;
> > -		} else
> > -		if ((vga_switcheroo_handler_flags() &
> > -		     VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
> > -		    nv_encoder->dcb->type == DCB_OUTPUT_LVDS &&
> > -		    nv_encoder->i2c) {
> > -			int ret;
> > -			vga_switcheroo_lock_ddc(dev->pdev);
> > -			ret = nvkm_probe_i2c(nv_encoder->i2c, 0x50);
> > -			vga_switcheroo_unlock_ddc(dev->pdev);
> > -			if (ret)
> > +			else if (ret == NOUVEAU_DP_SST)
> > +				found = nv_encoder;
> > +
> > +			break;
> > +		case DCB_OUTPUT_LVDS:
> > +			switcheroo_ddc = !!(vga_switcheroo_handler_flags() &
> > +					    VGA_SWITCHEROO_CAN_SWITCH_DDC);
> > +		/* fall-through */
> > +		default:
> > +			if (!nv_encoder->i2c)
> >  				break;
> > -		} else
> > -		if (nv_encoder->i2c) {
> > +
> > +			if (switcheroo_ddc)
> > +				vga_switcheroo_lock_ddc(dev->pdev);
> >  			if (nvkm_probe_i2c(nv_encoder->i2c, 0x50))
> > -				break;
> > +				found = nv_encoder;
> > +			if (switcheroo_ddc)
> > +				vga_switcheroo_unlock_ddc(dev->pdev);
> > +
> > +			break;
> >  		}
> > +		if (found)
> > +			break;
> 
> The diff is rather messy due to the change to a switch, but after staring
> at it for a while it does look correct to me.
> 
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> and sorry for the mess.
No problem! Honestly, if I was the one who made those changes I expect I would
have broken this same bit of code as well :P

> 
> >  	}
> >  
> >  	/* eDP panel not detected, restore panel power GPIO to previous
> >  	 * state to avoid confusing the SOR for other output types.
> >  	 */
> > -	if (!nv_encoder && panel == 0)
> > +	if (!found && panel == 0)
> >  		nvkm_gpio_set(gpio, 0, DCB_GPIO_PANEL_POWER, 0xff, panel);
> >  
> > -	return nv_encoder;
> > +	return found;
> >  }
> >  
> >  static struct nouveau_encoder *
> > -- 
> > 2.17.1
> 
> 

