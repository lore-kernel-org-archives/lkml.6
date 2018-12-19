Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608B620989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMudr+Xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbeLSR3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:29:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44455 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbeLSR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:29:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so23064563qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RNtDut7EYbVTVQhZQO3P6kZg1nlexwHjsIZa/oiPjXQ=;
        b=QMudr+Xdt4I+t9rvwzdK+md8p6wLT+zp6FB92F0c+CdFTUesvleld0cuHg2Gf74v39
         sVJm062l/58JAB3On+dc/PG7BILRVJCAkPc8Bxc0oFS1n5f5nnKc+LbPXCTPM9CGFnex
         Uj5WJOPzJXjdxcdN+zX6oBHsolYNTsCsVfdcGsU5rK+CDuAKc0QIid4nAueYQSfCluT0
         WKIsTo6+Hc/4nL702Dd6nl2M5NK5J9e+OfKCdWGwm8w/J/XXXx/z2Z5OsO/DKM1M8n7X
         RA9sOwCO7/b1UW3TjD3L2kRsTB2vqafwnk+2ESsonBRq+IZN4nqxSVmykKNDrRv27jAF
         o9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNtDut7EYbVTVQhZQO3P6kZg1nlexwHjsIZa/oiPjXQ=;
        b=TFrp4FeckhyR/uc4pjqfPcOAv3lW9b9lCUf/oQz2ziEOKGKe6ckr2+Ofi8rfy31chB
         OVXbB7DiAVse/413oZy5SwKbPhZgqJEsSuNjB12qfG9DqjyI7zhOu/E/vxD6F0J1wsij
         3nIShy70aNiQ66merQ1q8obVXJ6/RodlYAehYg+ekc6NWUz4faDYFerMp7XvLhnipquq
         FootyiFPwGk4i4k8Gww547W5kh0HkyIlSOg27PY0Bxlkhe9oZcQ4fzpXjcdNYNh5WRmC
         Rb6iv9Wms6HYqSL1BDJAnHfZQWcJONxdkjYGF/zEkew2VQvFQdE9TJQFtVKOq0z0MOd6
         ho1w==
X-Gm-Message-State: AA+aEWZWShWaXhZVwndY/s0RWkG1aEUJrme5JMuY90RNDqQWHRLQ5DtJ
        3QrLz6iRazuJbFUF2v8i1F2O6MEq3I0=
X-Google-Smtp-Source: AFSGD/UEnRxepLBhKKDVTNW2I0YBdsXpqq/7Eo//Eq+yWulNoVRKFL0CfTEkzpAgO4oWrpHOy9mdiw==
X-Received: by 2002:ac8:7181:: with SMTP id w1mr22889946qto.271.1545240588248;
        Wed, 19 Dec 2018 09:29:48 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n92sm1820470qtd.85.2018.12.19.09.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:29:47 -0800 (PST)
Date:   Wed, 19 Dec 2018 15:29:43 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/7] drm: i915: Delete base.id prints
Message-ID: <20181219172943.yvccbanfeod3hcoj@smtp.gmail.com>
References: <20181218133821.sykwt6wdeo7uf6o7@smtp.gmail.com>
 <20181219131254.GR21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219131254.GR21184@phenom.ffwll.local>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Daniel Vetter wrote:
> On Tue, Dec 18, 2018 at 11:38:21AM -0200, Shayenne Moura wrote:
> > This patch removes base.id prints from drm_display_mode                         
> > objects in i915 files. It removes dependency from drm_mode_object.
> > 
> > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> 
> Again I think better to switch to DRM_MODE_FMT/ARG.
> -Daniel
> 

This one has a different print style. Is it okay to change to DRM_MODE_FMT?

Best,
Shayenne
> > ---
> >  drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> > index 7f455bca528e..61dd7bb3fa85 100644
> > --- a/drivers/gpu/drm/i915/i915_debugfs.c
> > +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> > @@ -2948,8 +2948,8 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
> >  	for (i = 0; i < tabs; i++)
> >  		seq_putc(m, '\t');
> >  
> > -	seq_printf(m, "id %d:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> > -		   mode->base.id, mode->name,
> > +	seq_printf(m, "name:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> > +		   mode->name,
> >  		   mode->vrefresh, mode->clock,
> >  		   mode->hdisplay, mode->hsync_start,
> >  		   mode->hsync_end, mode->htotal,
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
