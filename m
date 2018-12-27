Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1367AC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5508218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCQIZDnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbeL0X1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:27:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41345 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbeL0X1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:27:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so17399441ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 15:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VDPXz+5zNRY2wgICSSR+KSlpUkOB9nTArrp7HkbEpU0=;
        b=bCQIZDnxVwZ2l42JX+rAmBk1TZAHLYd5KUDfhn2UStWPrTghno2ZJ1plYqank43dyk
         HmZZt2+Uezbd3797CJ6qw8J8aoUXhy1tclQav5bFwl2IbfDuM9xYp4+OMXAVvTYB7kMw
         N9KkI5rYOktCYwOhNpaiRSzuV0Rajk9z8Ds+VRdabm/zsrsYpy11+lr3bUqOmcy7H7Fy
         9yG5vLyOT+CdDuoE0T/m/faQGt6wlwTwILXnb6Vw8RS3Q8mp4z6OjLFgZ4l0m9zjRMGF
         4/nBQp7WrMPXRaB9B7jh/MHdqjVuKGBIX+GxCyAXNd95S9mAI9miyzkYbxOZQrgf+VAQ
         P/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VDPXz+5zNRY2wgICSSR+KSlpUkOB9nTArrp7HkbEpU0=;
        b=K1QG+xTpb4xCTF/JHe471ArFbRtsJv16BrdiXtuwjLbhZdRP9oY60AvqF5aKFpb1VD
         wrltDTHZMemjdcM10YSFoo0KMiU+Y86dAsEUdEv+z3EhNwYCwxcw1vxSn7o+jZrzh2q+
         q3FQ20jy8VpdJjsUFQRMj7VdOPkAJvQMX8lLItsdZ/Lnayo9G5cy/C+ApJgRaHcWpiwd
         yttuLZMzxeq0g/yI6IoVvsjOjT9XeZFMLOWC6wmDj0UItrjB5gyZtHtkqCO3FDhsjudR
         DXGUh8ggTFfeQEIG9W6U9rrPJBTYsM95VSGR3lTMkytI/DhGTPOJh4s3rscgCJO7hQTS
         w+Uw==
X-Gm-Message-State: AJcUukf4+pDDtpvCGSNGSuz4xqhbzZnBaa+cy4vBoT85dGxpSg0WAmd+
        l7ub3N+Drdg7cbK4UmMxF0E=
X-Google-Smtp-Source: ALg8bN5QpG/2zYJwpWGXiUT+UhXkRDMYmfuJAF7+zI7/GQfIhklZdPMB6fOFZKtEatyhQMK+rdproA==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr11643422ljk.55.1545953218043;
        Thu, 27 Dec 2018 15:26:58 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id a11sm7706080lff.68.2018.12.27.15.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 15:26:57 -0800 (PST)
Message-ID: <00547df7d87c7fe6d8c842d5b29a0cd6809cdf5d.camel@gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/fb-helper: Bring back workaround for bugs
 of SDL 1.2
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date:   Fri, 28 Dec 2018 04:26:56 +0500
In-Reply-To: <20181227120046.GC9058@dvetter-linux.ger.corp.intel.com>
References: <20181226121124.1632-1-mironov.ivan@gmail.com>
         <20181226121124.1632-2-mironov.ivan@gmail.com>
         <20181227120046.GC9058@dvetter-linux.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-27 at 13:00 +0100, Daniel Vetter wrote: 
> > +	/*
> > +	 * Workaround for SDL 1.2, which is known to be setting all pixel format
> > +	 * fields values to zero in some cases. We treat this situation as a
> > +	 * kind of "use some reasonable autodetected values".
> > +	 */
> > +	if (!var->red.offset     && !var->green.offset    &&
> > +	    !var->blue.offset    && !var->transp.offset   &&
> > +	    !var->red.length     && !var->green.length    &&
> > +	    !var->blue.length    && !var->transp.length   &&
> > +	    !var->red.msb_right  && !var->green.msb_right &&
> > +	    !var->blue.msb_right && !var->transp.msb_right) {
> > +		u8 depth;
> > +
> > +		/*
> > +		 * There is no way to guess the right value for depth when
> > +		 * bpp is 16 or 32. So we just restore the behaviour previously
> > +		 * introduced here by commit 785b93ef8c309. In fact, this was
> > +		 * implemented even earlier in various device drivers.
> > +		 */
> > +		switch (var->bits_per_pixel) {
> > +		case 16:
> > +			depth = 15;
> > +			break;
> > +		case 32:
> > +			depth = 24;
> > +			break;
> > +		default:
> > +			depth = var->bits_per_pixel;
> > +			break;
> > +		}
> 
> The guesswork here looks fishy. We should still have the drm-side format,
> and should use that.

This existed for a very long time until problematic commit was applied.
And there is a clear evidence that it was actually used by
applications.

> Otherwise the patches look good I think, but they
> need a Fixes: tag and cc: stable so backporters know what to do with
> these.
> 

I added "cc: stable" into the regression fix. Also added more info into
the commit messages. See the PATCH v1 in the mailing list.

Thanks.



