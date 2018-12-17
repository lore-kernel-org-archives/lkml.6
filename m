Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B612133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeLQOEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:04:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56864 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbeLQOEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:04:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19F8EA78;
        Mon, 17 Dec 2018 06:04:35 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8FF3F59C;
        Mon, 17 Dec 2018 06:04:34 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 1E0856802BC; Mon, 17 Dec 2018 14:04:33 +0000 (GMT)
Date:   Mon, 17 Dec 2018 14:04:33 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>
Subject: Re: [RFC AFBC 06/12] drm/arm/malidp:- Added support for new YUV
 formats for DP500, DP550 and DP650
Message-ID: <20181217140433.GA988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-7-git-send-email-ayan.halder@arm.com>
 <20181204165746.GN988@e110455-lin.cambridge.arm.com>
 <20181214141222.GC19564@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214141222.GC19564@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 02:12:23PM +0000, Ayan Halder wrote:
> On Tue, Dec 04, 2018 at 04:57:46PM +0000, Liviu Dudau wrote:
> 
> Hi Liviu,
> > On Mon, Dec 03, 2018 at 11:32:00AM +0000, Ayan Halder wrote:
> > > We have added some new formats to be supported on DP500/DP550/DP650.
> > 
> > Make a bit more descriptive commit message here, please!
> >
> I will keep the following commit message :-
> 
> ""We have added support for some AFBC only pixel formats like :-
> DRM_FORMAT_YUV420_8BIT (single plane YUV 420 8 bit format)
> DRM_FORMAT_VUY888 (single plane YUV 444 8 bit format)
> DRM_FORMAT_VUY101010 (single plane YUV 444 10 bit format)
> DRM_FORMAT_YUV420_10BIT (single plane YUV 420 10 bit format)
> 
> Generally, these formats are supported by our hardware using the same hw-ids as
> the equivalent multi plane pixel formats.
> 
> Also we have added support for XYUV 444 8 and 10 bit formats.""
> 
> Let me know if this looks fine.

Yes, LGTM.

Best regards,
Liviu

> 
> Thanks,
> Ayan Kumar halder
> > > 
> > > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > > 
> > > Depends on :- https://patchwork.kernel.org/patch/10460063/
> > 
> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > 
> > Best regards,
> > Liviu
> > 
> > > ---
> > >  drivers/gpu/drm/arm/malidp_hw.c | 22 +++++++++++++++++++++-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> > > index 55d379b..25ac5890 100644
> > > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > > @@ -49,6 +49,12 @@ static const struct malidp_format_id malidp500_de_formats[] = {
> > >  	{ DRM_FORMAT_YUYV, DE_VIDEO1, 13 },
> > >  	{ DRM_FORMAT_NV12, DE_VIDEO1 | SE_MEMWRITE, 14 },
> > >  	{ DRM_FORMAT_YUV420, DE_VIDEO1, 15 },
> > > +	{ DRM_FORMAT_XYUV8888, DE_VIDEO1, 16 },
> > > +	/* These are supported with AFBC only */
> > > +	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1, 14 },
> > > +	{ DRM_FORMAT_VUY888, DE_VIDEO1, 16 },
> > > +	{ DRM_FORMAT_VUY101010, DE_VIDEO1, 17 },
> > > +	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1, 18 }
> > >  };
> > >  
> > >  #define MALIDP_ID(__group, __format) \
> > > @@ -74,11 +80,25 @@ static const struct malidp_format_id malidp500_de_formats[] = {
> > >  	{ DRM_FORMAT_ABGR1555, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 1) }, \
> > >  	{ DRM_FORMAT_RGB565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 2) }, \
> > >  	{ DRM_FORMAT_BGR565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 3) }, \
> > > +	/* This is only supported with linear modifier */	\
> > > +	{ DRM_FORMAT_XYUV8888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) },\
> > > +	/* This is only supported with AFBC modifier */		\
> > > +	{ DRM_FORMAT_VUY888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) }, \
> > >  	{ DRM_FORMAT_YUYV, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 2) },	\
> > > +	/* This is only supported with linear modifier */ \
> > >  	{ DRM_FORMAT_UYVY, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 3) },	\
> > >  	{ DRM_FORMAT_NV12, DE_VIDEO1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(5, 6) },	\
> > > +	/* This is only supported with AFBC modifier */ \
> > > +	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 6) }, \
> > >  	{ DRM_FORMAT_YUV420, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 7) }, \
> > > -	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}
> > > +	/* This is only supported with linear modifier */ \
> > > +	{ DRM_FORMAT_XVYU2101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
> > > +	/* This is only supported with AFBC modifier */ \
> > > +	{ DRM_FORMAT_VUY101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
> > > +	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}, \
> > > +	/* This is only supported with AFBC modifier */ \
> > > +	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}, \
> > > +	{ DRM_FORMAT_P010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}
> > >  
> > >  static const struct malidp_format_id malidp550_de_formats[] = {
> > >  	MALIDP_COMMON_FORMATS,
> > > -- 
> > > 2.7.4
> > > 
> > 
> > -- 
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ??\_(???)_/??
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
