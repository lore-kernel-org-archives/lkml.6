Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeDIIdY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:33:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56134 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeDIIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:33:22 -0400
X-Google-Smtp-Source: AIpwx4/4DGC9JA1Qp0Z1fBkrFPZJNxpkR3LuG6RruCgVHiXW7Z29M+ly6TLO1TdC0xx9o9fu97u2kQ==
Date: Mon, 9 Apr 2018 10:33:17 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Deepak Singh Rawat <drawat@vmware.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com"
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Message-ID: <20180409083317.GM31310@phenom.ffwll.local>
Mail-Followup-To: Deepak Singh Rawat <drawat@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "lukasz.spintzyk@displaylink.com" <lukasz.spintzyk@displaylink.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
 <20180405073525.GP3881@phenom.ffwll.local>
 <MWHPR05MB3117649FFA7D68D00E99AA89BABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR05MB3117649FFA7D68D00E99AA89BABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 11:07:19PM +0000, Deepak Singh Rawat wrote:
> > 
> > On Wed, Apr 04, 2018 at 04:49:06PM -0700, Deepak Rawat wrote:
> > > From: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> > >
> > > Optional plane property to mark damaged regions on the plane in
> > > framebuffer coordinates of the framebuffer attached to the plane.
> > >
> > > The layout of blob data is simply an array of drm_mode_rect with
> > maximum
> > > array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike plane src
> > > coordinates, damage clips are not in 16.16 fixed point.
> > >
> > > Damage clips are a hint to kernel as which area of framebuffer has
> > > changed since last page-flip. This should be helpful for some drivers
> > > especially for virtual devices where each framebuffer change needs to
> > > be transmitted over network, usb, etc.
> > >
> > > Driver which are interested in enabling DAMAGE_CLIPS property for a
> > > plane should enable this property using drm_plane_enable_damage_clips.
> > >
> > > Signed-off-by: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> > > Signed-off-by: Deepak Rawat <drawat@vmware.com>
> > 
> > The property uapi section is missing, see:
> > 
> > https://urldefense.proofpoint.com/v2/url?u=https-
> > 3A__dri.freedesktop.org_docs_drm_gpu_drm-2Dkms.html-23plane-
> > 2Dcomposition-
> > 2Dproperties&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=zOOG28inJK0762
> > SxAf-
> > cyZdStnd2NQpRu98lJP2iYGw&m=ELAUsNTjD0ICwUEDFjPW4jsmy2A5AkhS5Q
> > z_3vlEC9Q&s=nH-HNXPczoJQMj1iwHiGfrhXz4-00b0M8-3kirjm-EY&e=
> > 
> > Plane composition feels like the best place to put this. Please use that
> > section to tie all the various bits together, including the helpers you're
> > adding in the following patches for drivers to use.
> > 
> > Bunch of nitpicks below, but overall I'm agreeing now with just going with
> > fb coordinate damage rects.
> > 
> > Like you say, the thing needed here now is userspace + driver actually
> > implementing this. I'd also say the compat helper to map the legacy
> > fb->dirty to this new atomic way of doing things should be included here
> > (gives us a lot more testing for these new paths).
> > 
> > Icing on the cake would be an igt to make sure kernel rejects invalid clip
> > rects correctly.
> > 
> > > ---
> > >  drivers/gpu/drm/drm_atomic.c        | 42
> > +++++++++++++++++++++++++++++++++++++
> > >  drivers/gpu/drm/drm_atomic_helper.c |  4 ++++
> > >  drivers/gpu/drm/drm_mode_config.c   |  5 +++++
> > >  drivers/gpu/drm/drm_plane.c         | 12 +++++++++++
> > >  include/drm/drm_mode_config.h       | 15 +++++++++++++
> > >  include/drm/drm_plane.h             | 16 ++++++++++++++
> > >  include/uapi/drm/drm_mode.h         | 15 +++++++++++++
> > >  7 files changed, 109 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic.c
> > b/drivers/gpu/drm/drm_atomic.c
> > > index 7d25c42..9226d24 100644
> > > --- a/drivers/gpu/drm/drm_atomic.c
> > > +++ b/drivers/gpu/drm/drm_atomic.c
> > > @@ -669,6 +669,40 @@ static void drm_atomic_crtc_print_state(struct
> > drm_printer *p,
> > >  }
> > >
> > >  /**
> > > + * drm_atomic_set_damage_for_plane - sets the damage clips property
> > to plane
> > > + * @state: plane state
> > > + * @blob: damage clips in framebuffer coordinates
> > > + *
> > > + * Returns:
> > > + *
> > > + * Zero on success, error code on failure.
> > > + */
> > > +static int drm_atomic_set_damage_for_plane(struct drm_plane_state
> > *state,
> > > +					   struct drm_property_blob *blob)
> > > +{
> > > +	if (blob == state->damage_clips)
> > > +		return 0;
> > > +
> > > +	drm_property_blob_put(state->damage_clips);
> > > +	state->damage_clips = NULL;
> > > +
> > > +	if (blob) {
> > > +		uint32_t count = blob->length/sizeof(struct drm_rect);
> > > +
> > > +		if (count > DRM_MODE_FB_DIRTY_MAX_CLIPS)
> > > +			return -EINVAL;
> > > +
> > > +		state->damage_clips = drm_property_blob_get(blob);
> > > +		state->num_clips = count;
> > > +	} else {
> > > +		state->damage_clips = NULL;
> > > +		state->num_clips = 0;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > >   * drm_atomic_get_plane_state - get plane state
> > >   * @state: global atomic state object
> > >   * @plane: plane to get state object for
> > > @@ -793,6 +827,12 @@ static int drm_atomic_plane_set_property(struct
> > drm_plane *plane,
> > >  		state->color_encoding = val;
> > >  	} else if (property == plane->color_range_property) {
> > >  		state->color_range = val;
> > > +	} else if (property == config->prop_damage_clips) {
> > > +		struct drm_property_blob *blob =
> > > +			drm_property_lookup_blob(dev, val);
> > > +		int ret = drm_atomic_set_damage_for_plane(state, blob);
> > 
> > There's already a helper with size-checking built-in, see
> > drm_atomic_replace_property_blob_from_id(). Wrt computing num_clips
> > I'd
> > just provide a little inline helper that does the
> > blob->length/sizeof(drm_rect) conversion (it's just a shift, so fast).
> > 
> > > +		drm_property_blob_put(blob);
> > > +		return ret;
> > >  	} else if (plane->funcs->atomic_set_property) {
> > >  		return plane->funcs->atomic_set_property(plane, state,
> > >  				property, val);
> > > @@ -856,6 +896,8 @@ drm_atomic_plane_get_property(struct drm_plane
> > *plane,
> > >  		*val = state->color_encoding;
> > >  	} else if (property == plane->color_range_property) {
> > >  		*val = state->color_range;
> > > +	} else if (property == config->prop_damage_clips) {
> > > +		*val = (state->damage_clips) ? state->damage_clips->base.id
> > : 0;
> > >  	} else if (plane->funcs->atomic_get_property) {
> > >  		return plane->funcs->atomic_get_property(plane, state,
> > property, val);
> > >  	} else {
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> > b/drivers/gpu/drm/drm_atomic_helper.c
> > > index c356545..55b44e3 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -3506,6 +3506,8 @@ void
> > __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
> > >
> > >  	state->fence = NULL;
> > >  	state->commit = NULL;
> > > +	state->damage_clips = NULL;
> > > +	state->num_clips = 0;
> > >  }
> > >  EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
> > >
> > > @@ -3550,6 +3552,8 @@ void
> > __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
> > >
> > >  	if (state->commit)
> > >  		drm_crtc_commit_put(state->commit);
> > > +
> > > +	drm_property_blob_put(state->damage_clips);
> > >  }
> > >  EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
> > >
> > > diff --git a/drivers/gpu/drm/drm_mode_config.c
> > b/drivers/gpu/drm/drm_mode_config.c
> > > index e5c6533..e93b127 100644
> > > --- a/drivers/gpu/drm/drm_mode_config.c
> > > +++ b/drivers/gpu/drm/drm_mode_config.c
> > > @@ -293,6 +293,11 @@ static int
> > drm_mode_create_standard_properties(struct drm_device *dev)
> > >  		return -ENOMEM;
> > >  	dev->mode_config.prop_crtc_id = prop;
> > >
> > > +	prop = drm_property_create(dev, DRM_MODE_PROP_BLOB,
> > "DAMAGE_CLIPS", 0);
> > 
> > Bit a bikeshed, but since the coordinates are in fb pixels, not plane
> > pixels, I'd call this "FB_DAMAGE_CLIPS".
> > 
> > > +	if (!prop)
> > > +		return -ENOMEM;
> > > +	dev->mode_config.prop_damage_clips = prop;
> > > +
> > >  	prop = drm_property_create_bool(dev,
> > DRM_MODE_PROP_ATOMIC,
> > >  			"ACTIVE");
> > >  	if (!prop)
> > > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> > > index 6d2a6e4..071221b 100644
> > > --- a/drivers/gpu/drm/drm_plane.c
> > > +++ b/drivers/gpu/drm/drm_plane.c
> > > @@ -1101,3 +1101,15 @@ int drm_mode_page_flip_ioctl(struct
> > drm_device *dev,
> > >
> > >  	return ret;
> > >  }
> > > +
> > > +/**
> > > + * drm_plane_enable_damage_clips - enable damage clips property
> > > + * @plane: plane on which this property to enable.
> > > + */
> > > +void drm_plane_enable_damage_clips(struct drm_plane *plane)
> > > +{
> > > +	struct drm_device *dev = plane->dev;
> > > +	struct drm_mode_config *config = &dev->mode_config;
> > > +
> > > +	drm_object_attach_property(&plane->base, config-
> > >prop_damage_clips, 0);
> > > +}
> > > diff --git a/include/drm/drm_mode_config.h
> > b/include/drm/drm_mode_config.h
> > > index 7569f22..d8767da 100644
> > > --- a/include/drm/drm_mode_config.h
> > > +++ b/include/drm/drm_mode_config.h
> > > @@ -628,6 +628,21 @@ struct drm_mode_config {
> > >  	 */
> > >  	struct drm_property *prop_crtc_id;
> > >  	/**
> > > +	 * @prop_damage_clips: Optional plane property to mark damaged
> > regions
> > > +	 * on the plane in framebuffer coordinates of the framebuffer
> > attached
> > > +	 * to the plane.
> > 
> > Why should we make this optional? Looks like just another thing drivers
> > might screw up, since we have multiple callbacks and things to set up for
> > proper dirty tracking.
> 
> Thanks Daniel for the review.
> 
> I think not all compositor will be interested in sending damage, that was the
> reason to make this optional. Also when damage is not set that means
> user-space need full update just like eglSwapBuffersWithDamageKHR.
> 
> I will add better documentation.

I think if we also handle this case in the helper that'd be even better:
In the case of no damage, the helper/core code could automatically supply
a damage rect for the entire buffer. That way drivers don't have to handle
this case specially.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
