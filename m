Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeA3Qb6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:31:58 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54440 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeA3Qb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:31:57 -0500
X-Google-Smtp-Source: AH8x224UYll/qj6mdsmPWDBlSVPTH95JcwjbEmWekdk0JDwPGs+R3yYnG9iHIefy17G3M3wG7F6+1Q==
Date: Tue, 30 Jan 2018 17:31:53 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Sean Paul <seanpaul@chromium.org>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v2] drm/edid: use true and false for boolean values
Message-ID: <20180130163153.GT25930@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <seanpaul@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20180130100528.GA7154@training>
 <20180130150927.3fm5kotyp6vqugaf@art_vandelay>
 <20180130151946.GC5453@intel.com>
 <20180130160244.p24of44jgib3botq@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180130160244.p24of44jgib3botq@art_vandelay>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:02:44AM -0500, Sean Paul wrote:
> On Tue, Jan 30, 2018 at 05:19:46PM +0200, Ville Syrjälä wrote:
> > On Tue, Jan 30, 2018 at 10:09:27AM -0500, Sean Paul wrote:
> > > On Tue, Jan 30, 2018 at 04:05:28AM -0600, Gustavo A. R. Silva wrote:
> > > > Assign true or false to boolean variables instead of an integer value.
> > > > 
> > > > This issue was detected with the help of Coccinelle.
> > > 
> > > I suppose you could also fix up the other preferred assignment by adding !!
> > > to the bitwise & operation.
> > 
> > Assigning >1 to a bool is well defined. No need to clutter the code with
> > !! imo.
> 
> There are examples of both in the file already. I don't have strong feelings
> either way.

Yeah, I applied this one for now, we can do more color choice discussions
with follow ups :-)

Thanks for the patch.
-Daniel

> 
> Sea
> 
> > 
> > > 
> > > It's also helpful to post the spatch in the commit message so others can
> > > replicate your result (this case is pretty trivial, so less important).
> > > 
> > > Sean
> > > 
> > > > 
> > > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > > ---
> > > > Changes in v2:
> > > >  - Use true for boolean value in add_detailed_mode as suggested by Daniel
> > > >    Vetter.
> > > >  - Update subject.
> > > > 
> > > >  drivers/gpu/drm/drm_edid.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > > > index ddd5379..b1cb262 100644
> > > > --- a/drivers/gpu/drm/drm_edid.c
> > > > +++ b/drivers/gpu/drm/drm_edid.c
> > > > @@ -2767,7 +2767,7 @@ do_detailed_mode(struct detailed_timing *timing, void *c)
> > > >  
> > > >  		drm_mode_probed_add(closure->connector, newmode);
> > > >  		closure->modes++;
> > > > -		closure->preferred = 0;
> > > > +		closure->preferred = false;
> > > >  	}
> > > >  }
> > > >  
> > > > @@ -2784,7 +2784,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
> > > >  	struct detailed_mode_closure closure = {
> > > >  		.connector = connector,
> > > >  		.edid = edid,
> > > > -		.preferred = 1,
> > > > +		.preferred = true,
> > > >  		.quirks = quirks,
> > > >  	};
> > > >  
> > > > -- 
> > > > 2.7.4
> > > > 
> > > 
> > > -- 
> > > Sean Paul, Software Engineer, Google / Chromium OS
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > -- 
> > Ville Syrjälä
> > Intel OTC
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
