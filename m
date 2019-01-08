Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72607C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD942087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E896vM7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfAHH06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:26:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43549 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfAHH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:26:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so2506973lji.10;
        Mon, 07 Jan 2019 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gLpA0X7yaYbuHIfOxugIz/l3iMw2+1bYQhVKtFDqIxU=;
        b=E896vM7pY61a2h80BmWHA9tVL5MwIsoZqAWJ++lCQHC16ZJZzB9ShpfyXxkN9rc4bu
         9Ma36YWRN+E1f+QLzUCcTXAHiDzS9L5oWCQhL4NrcOuUJ3Ldr5ZI+dxf1tgBbjaes4De
         cW7V9ch5nQnRAlLwYtnWzvczmeYchnA9hywnOytW54OF3EFjjOtHFNW+ai9WXL7DczPR
         Pdzd3eANcV6MkhfEk+BU4D7u4/Xf4GK/d/uEr3qlhUvqitHkvpysiIx1MsIj1zd9folP
         LRehWehCyNPEvqCKaigAVC2y/trrqYdL1NEKJ0/0hbbCApHRaGbB7ZJYt2EAB5dMIINx
         d1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gLpA0X7yaYbuHIfOxugIz/l3iMw2+1bYQhVKtFDqIxU=;
        b=UfW4sPwuZfZrWAu3N3SpYVi5S/R+wzsMw8uZL0vcbBb4kXElLjJUl2qrEYQZeQ0UYl
         Fas1H7MHN+6MYhcg1TQZJZJRw5S0XZqYOcV6LaaBso+7x9AvnAG5pAbJ4uXirq8ZbUXm
         2vq0WlM+Hklq278nKMHN5vWn9STScM66JeQL82n7KBY+QKBB6TqNmrVkmU84vSVOGqnj
         N0g0glwDsQVnXv9jD9ABU51mc4qSUCFLxaRJYsngCJMPCzDw5rNDo0/HHHrKD0zjePI5
         ELusivvif83Ifemiza4HPtcg7Ir6oYVg5xecwc+Q3Ml1H+wpxlijNRdQo0gFqXFnV2Pw
         8IpA==
X-Gm-Message-State: AJcUukeL+AtAIXN9J48Y4cHtJh7jLNp8mKgo68zyqzPQ9HoAAZAy9k42
        eCDlKwZmKvywOdt0ioudXoE=
X-Google-Smtp-Source: ALg8bN45M3tUBHDAuCWw8w3MzjkjDlwuEz1/uN0yrsDs5ulk9cbOjYcFKzaNkVG9I+7o37Mlay4gVg==
X-Received: by 2002:a2e:a0d3:: with SMTP id f19-v6mr388971ljm.48.1546932414343;
        Mon, 07 Jan 2019 23:26:54 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id d2sm13233155lfg.16.2019.01.07.23.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 23:26:53 -0800 (PST)
Message-ID: <36f682cf61b353441ff41cf651650f7117247052.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] drm/fb-helper: Bring back workaround for bugs of
 SDL 1.2
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        stable@vger.kernel.org
Date:   Tue, 08 Jan 2019 12:26:52 +0500
In-Reply-To: <20190107100842.GZ21184@phenom.ffwll.local>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
         <20181227231308.16904-2-mironov.ivan@gmail.com>
         <20181228121549.GU9058@dvetter-linux.ger.corp.intel.com>
         <e4754c8dab11b1f8b61a7fb2aae690b979cc7209.camel@gmail.com>
         <20190107100842.GZ21184@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 11:08 +0100, Daniel Vetter wrote:
> > > > @@ -1654,6 +1712,40 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> > > >  		return -EINVAL;
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * Workaround for SDL 1.2, which is known to be setting all pixel format
> > > > +	 * fields values to zero in some cases. We treat this situation as a
> > > > +	 * kind of "use some reasonable autodetected values".
> > > > +	 */
> > > > +	if (!var->red.offset     && !var->green.offset    &&
> > > > +	    !var->blue.offset    && !var->transp.offset   &&
> > > > +	    !var->red.length     && !var->green.length    &&
> > > > +	    !var->blue.length    && !var->transp.length   &&
> > > > +	    !var->red.msb_right  && !var->green.msb_right &&
> > > > +	    !var->blue.msb_right && !var->transp.msb_right) {
> > > > +		u8 depth;
> > > > +
> > > > +		/*
> > > > +		 * There is no way to guess the right value for depth when
> > > > +		 * bpp is 16 or 32. So we just restore the behaviour previously
> > > > +		 * introduced here by commit . In fact, this was
> > > > +		 * implemented even earlier in various device drivers.
> > > > +		 */
> > > > +		switch (var->bits_per_pixel) {
> > > > +		case 16:
> > > > +			depth = 15;
> > > > +			break;
> > > > +		case 32:
> > > > +			depth = 24;
> > > > +			break;
> > > > +		default:
> > > > +			depth = var->bits_per_pixel;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		drm_fb_helper_fill_pixel_fmt(var, depth);
> > > 
> > > Please use fb->format->depth here instead of guessing.
> > > -Daniel
> > 
> > I do not think that this is the right way.
> > 
> > Without guessing, if SDL1 makes a request with bits_per_pixel == 16
> > (for example) and current fb->format->depth == 24, ioctl() will succeed
> > while actual pixel format will remain the same. As a result, SDL1 will
> > display garbage because of invalid pixel format.
> > 
> > Or am I missing something here?
> 
> This is supposed to be the case where SDL didn't set any of this stuff.
> Guess is definitely not what we want to do, we should use the actual
> depth, which is stored in fb->format->depth. Older code did guess, but we
> fixed that, and shouldn't reintroduce that guess game.
> -Daniel
> 

Done. See the v2 patch series.

