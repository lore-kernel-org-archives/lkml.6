Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADFC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8A62087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VBlinL9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8IIP0OJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfAGKNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:13:00 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41043 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725550AbfAGKNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:13:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 598731431;
        Mon,  7 Jan 2019 05:12:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 07 Jan 2019 05:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=bUr2uSJslzFSQjpLPjUpt/KLbov
        Iy3XFjirj3IH6TzI=; b=VBlinL9RFieXN8sK11N9ePEnuw4EKVh16UggoN3h9iV
        rmaY9yEdWmdCynWMIAMJ13+IFeor23dsLGbG4us0AGQIef1cib+f9DZc+6qZiQNQ
        QYXwxyDgV8CicGKomLS1Sq4/xX22b3tCm6IVqlucJj0NAUNOEM8L64Z+t2+O1ToU
        Hk21ZAxTfF5w/3eVEul1J1Hs2WcNiVszAFJ18DyEZ+XQv1kWc5vDnG9N1EU1ycV+
        rJ70v2MQOI77dHPEMaxUTtybCrWzqhMLXNwj4qvJ9Spc22mB1qSvZqcEynrxaBbj
        MgmDeyzF7ifoiHGsfKmSYqlZ+Cw+NZ0nciWptGi9TsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bUr2uS
        JslzFSQjpLPjUpt/KLbovIy3XFjirj3IH6TzI=; b=n8IIP0OJXrRp5YWeOcNFW1
        4JpqnyGfCIsnHiwQZaWkB92itUpIeJYPYuzDJD6gSGz7K30PsO4aD2+KfgLmnwBY
        euFRXnHU1mMacW81c/ghe4zfZ//VheBKm8/3rjQv+m+4MqZPKbShR4ik6O080XBB
        Hei6QE+WxUr73jrv4u9W+8zQscLoGhjCS6eTypBKrHgLQLcBtP6nVAs0V2qTUf7r
        ovAdDmHcbV6K+2mzKpWOgr0tG6SB4qMf1f9df6aqGWqgsMWsm4lEzqXgwaopyTs7
        JMf20sB2w9ouNGwNUiQNPVPeQq8VPuHCBIrjkd8qeNXlgFTHGCDAI/ob8lNI9hRg
        ==
X-ME-Sender: <xms:KCYzXPOkDA7eFqFmOvNKQy7Z4yPdJtUBWC7MqmJ0uDkBvosEyidI3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudculddtuddrgedtkedrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuffhomhgrihhnpehsohhurhgtvg
    hfohhrghgvrdhnvghtnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehm
    rghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptd
X-ME-Proxy: <xmx:KSYzXOOCvcKYAdHZur-XprvKiZqMauMVv2JlfWaFbPUcvdc7vmM-Tw>
    <xmx:KSYzXJSZN3P2tWKcedPZr-YNS4jdWk88Wi8zVehk4QgwnBkO8zEg5Q>
    <xmx:KSYzXIBlFv6kiAjkQgFyNm4kLcnumpNZKkLzPHQToyU3gG13YBDNfw>
    <xmx:KSYzXCUXkOpG2lb8m_05uiUg9Gomck9t2UBLAuzd7GzOt0l2JXtlqw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 836CAE4662;
        Mon,  7 Jan 2019 05:12:56 -0500 (EST)
Date:   Mon, 7 Jan 2019 11:12:55 +0100
From:   Greg KH <greg@kroah.com>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        saahriktu <mail@saahriktu.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH v1 2/2] drm/fb-helper: Ignore the value of
 fb_var_screeninfo.pixclock
Message-ID: <20190107101255.GA2364@kroah.com>
References: <20181227231308.16904-1-mironov.ivan@gmail.com>
 <20181227231308.16904-3-mironov.ivan@gmail.com>
 <20181228120652.GR9058@dvetter-linux.ger.corp.intel.com>
 <b9f21efe2fe2d0a71ad6672fbe9155df52ac5e02.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f21efe2fe2d0a71ad6672fbe9155df52ac5e02.camel@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 09:21:21PM +0500, Ivan Mironov wrote:
> On Fri, 2018-12-28 at 13:06 +0100, Daniel Vetter wrote:
> > On Fri, Dec 28, 2018 at 04:13:08AM +0500, Ivan Mironov wrote:
> > > Strict requirement of pixclock to be zero breaks support of SDL 1.2
> > > which contains hardcoded table of supported video modes with non-zero
> > > pixclock values[1].
> > > 
> > > To better understand which pixclock values are considered valid and how
> > > driver should handle these values, I briefly examined few existing fbdev
> > > drivers and documentation in Documentation/fb/. And it looks like there
> > > are no strict rules on that and actual behaviour varies:
> > > 
> > > 	* some drivers treat (pixclock == 0) as "use defaults" (uvesafb.c);
> > > 	* some treat (pixclock == 0) as invalid value which leads to
> > > 	  -EINVAL (clps711x-fb.c);
> > > 	* some pass converted pixclock value to hardware (uvesafb.c);
> > > 	* some are trying to find nearest value from predefined table
> > >           (vga16fb.c, video_gx.c).
> > > 
> > > Given this, I believe that it should be safe to just ignore this value if
> > > changing is not supported. It seems that any portable fbdev application
> > > which was not written only for one specific device working under one
> > > specific kernel version should not rely on any particular behaviour of
> > > pixclock anyway.
> > > 
> > > However, while enabling SDL1 applications to work out of the box when
> > > there is no /etc/fb.modes with valid settings, this change affects the
> > > video mode choosing logic in SDL. Depending on current screen
> > > resolution, contents of /etc/fb.modes and resolution requested by
> > > application, this may lead to user-visible difference (not always):
> > > image will be displayed in a right way, but it will be aligned to the
> > > left instead of center. There is no "right behaviour" here as well, as
> > > emulated fbdev, opposing to old fbdev drivers, simply ignores any
> > > requsts of video mode changes with resolutions smaller than current.
> > > 
> > > Feel free to NAK this patch if you think that it causes breakage of
> > > user-space =).
> > 
> > It's a regression, we don't nack regression fixes :-)
> > 
> > > The easiest way to reproduce this problem is to install sdl-sopwith[2],
> > > remove /etc/fb.modes file if it exists, and then try to run sopwith
> > > from console without X. At least in Fedora 29, sopwith may be simply
> > > installed from standard repositories.
> > > 
> > > [1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
> > > [2] http://sdl-sopwith.sourceforge.net/
> > > 
> > > Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> > 
> > I thought this is also a regression fix, so also needs Fixes: and cc:
> > stable?
> > -Daniel
> 
> This particular patch fixes a bug that existed for 10 years unnoticed.
> Are "Fixes:" and "Cc: stable" really required?

If you want it backported into a stable kernel release, then yes, they
are needed :)

thanks,

greg k-h
