Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDEXHX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:07:23 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:6560
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750786AbeDEXHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:07:21 -0400
From: Deepak Singh Rawat <drawat@vmware.com>
To: Daniel Vetter <daniel@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
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
Subject: RE: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Thread-Topic: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Thread-Index: AQHTzG/LKmgpUVY09ESOpEZ7duU7PKPxyHKAgAEAxkA=
Date: Thu, 5 Apr 2018 23:07:19 +0000
Message-ID: <MWHPR05MB3117649FFA7D68D00E99AA89BABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
 <20180405073525.GP3881@phenom.ffwll.local>
In-Reply-To: <20180405073525.GP3881@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR05MB2863;7:appQOUdpcjUxC0Bx+nbrw0t1pwTWDFuKq/amodTX4LvivA/1g3TwhY1pAgPLklU/7O7AqKXJnTgPLtBJZPTtTDU1E1ZRK4iwgPiwiSrb1JD14vlQomsU0iYWXCdjLLaNWoApoKpri9Cr6vQDPyGHoE9XQap7Kfp42P4j/hvOxZnfOJzGLaBwz+HyXLWyFJyYwlHulrNDyhqCi24f4FCw0ROftLgymnySLcWVivAHSDijFx7cQAPsc2Ql9F+gzCts;20:Dmdae6Jo3ogAWdxVuwrzeg/ZYZlSOPfHgVzVE9bTLwEeE9ClZ94Q3gdDb6WbBaT3UQ17Gr4QE1Yo83qGQgHGxe2RlXJGzqHKB9yg4ohwcwqiKxudD+fLLj8EzRWc6E3WgZA/LziM1Q9ki5ScYuXrX39ef47skV8SXOvUqwfkjp8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9d645880-d2f9-4522-f0f8-08d59b49fb93
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR05MB2863;
x-ms-traffictypediagnostic: MWHPR05MB2863:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com;
x-microsoft-antispam-prvs: <MWHPR05MB2863AA47DAC111CF5EA2A325BABB0@MWHPR05MB2863.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(10436049006162);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR05MB2863;BCL:0;PCL:0;RULEID:;SRVR:MWHPR05MB2863;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(199004)(189003)(33656002)(6116002)(81166006)(2900100001)(81156014)(3846002)(6436002)(7416002)(8936002)(6916009)(5660300001)(8676002)(97736004)(105586002)(7736002)(229853002)(6306002)(3660700001)(74316002)(305945005)(2906002)(966005)(39060400002)(55016002)(53936002)(26005)(575784001)(86362001)(7696005)(76176011)(6246003)(3280700002)(9686003)(68736007)(99286004)(478600001)(106356001)(66066001)(5250100002)(6506007)(102836004)(5890100001)(25786009)(486006)(54906003)(446003)(316002)(59450400001)(4326008)(476003)(186003)(14454004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB2863;H:MWHPR05MB3117.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: t0z0tCWoTaTejuMlnFa3ptpSyy2RoXHkY4714DCJwmdW4mxZeqT35tupI4kU1iTxzp4KjpfvVowfBaUbUTRtNc1b67AqHqaFpGjA9uOL+OrLJPZcPQAqMVFKkYHPu7z8b0PAau7NzcFXRL/C6bpZaBi0UgG+vv7Ao3U3KzVMGmz3omnmH8PjT9S4aQDz3kFUrkWIq8ygUcQEVMqGE1YR21VOyWN7ykIXfmvsAnN2ma7ht9+EFc+6eynv3oZsNq2uhF4xlfPJ6DJvfwpJs9N6xZHmouYkMZwpTaBz2AnU0RJBZPG/0j8/88uZAs3QbUxUNpgsXibhkvIgflR1HEj9HZg4f2nH2uCfd0SprG81tfG06N6kSXdJBhp8qZjaUEzluV82fauS1rzIMsVOQoqjBF+gd1fwAmETHiHUFUpmjtw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d645880-d2f9-4522-f0f8-08d59b49fb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 23:07:19.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB2863
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35N7SBI029244

> 
> On Wed, Apr 04, 2018 at 04:49:06PM -0700, Deepak Rawat wrote:
> > From: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> >
> > Optional plane property to mark damaged regions on the plane in
> > framebuffer coordinates of the framebuffer attached to the plane.
> >
> > The layout of blob data is simply an array of drm_mode_rect with
> maximum
> > array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike plane src
> > coordinates, damage clips are not in 16.16 fixed point.
> >
> > Damage clips are a hint to kernel as which area of framebuffer has
> > changed since last page-flip. This should be helpful for some drivers
> > especially for virtual devices where each framebuffer change needs to
> > be transmitted over network, usb, etc.
> >
> > Driver which are interested in enabling DAMAGE_CLIPS property for a
> > plane should enable this property using drm_plane_enable_damage_clips.
> >
> > Signed-off-by: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
> > Signed-off-by: Deepak Rawat <drawat@vmware.com>
> 
> The property uapi section is missing, see:
> 
> https://urldefense.proofpoint.com/v2/url?u=https-
> 3A__dri.freedesktop.org_docs_drm_gpu_drm-2Dkms.html-23plane-
> 2Dcomposition-
> 2Dproperties&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=zOOG28inJK0762
> SxAf-
> cyZdStnd2NQpRu98lJP2iYGw&m=ELAUsNTjD0ICwUEDFjPW4jsmy2A5AkhS5Q
> z_3vlEC9Q&s=nH-HNXPczoJQMj1iwHiGfrhXz4-00b0M8-3kirjm-EY&e=
> 
> Plane composition feels like the best place to put this. Please use that
> section to tie all the various bits together, including the helpers you're
> adding in the following patches for drivers to use.
> 
> Bunch of nitpicks below, but overall I'm agreeing now with just going with
> fb coordinate damage rects.
> 
> Like you say, the thing needed here now is userspace + driver actually
> implementing this. I'd also say the compat helper to map the legacy
> fb->dirty to this new atomic way of doing things should be included here
> (gives us a lot more testing for these new paths).
> 
> Icing on the cake would be an igt to make sure kernel rejects invalid clip
> rects correctly.
> 
> > ---
> >  drivers/gpu/drm/drm_atomic.c        | 42
> +++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/drm_atomic_helper.c |  4 ++++
> >  drivers/gpu/drm/drm_mode_config.c   |  5 +++++
> >  drivers/gpu/drm/drm_plane.c         | 12 +++++++++++
> >  include/drm/drm_mode_config.h       | 15 +++++++++++++
> >  include/drm/drm_plane.h             | 16 ++++++++++++++
> >  include/uapi/drm/drm_mode.h         | 15 +++++++++++++
> >  7 files changed, 109 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic.c
> b/drivers/gpu/drm/drm_atomic.c
> > index 7d25c42..9226d24 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -669,6 +669,40 @@ static void drm_atomic_crtc_print_state(struct
> drm_printer *p,
> >  }
> >
> >  /**
> > + * drm_atomic_set_damage_for_plane - sets the damage clips property
> to plane
> > + * @state: plane state
> > + * @blob: damage clips in framebuffer coordinates
> > + *
> > + * Returns:
> > + *
> > + * Zero on success, error code on failure.
> > + */
> > +static int drm_atomic_set_damage_for_plane(struct drm_plane_state
> *state,
> > +					   struct drm_property_blob *blob)
> > +{
> > +	if (blob == state->damage_clips)
> > +		return 0;
> > +
> > +	drm_property_blob_put(state->damage_clips);
> > +	state->damage_clips = NULL;
> > +
> > +	if (blob) {
> > +		uint32_t count = blob->length/sizeof(struct drm_rect);
> > +
> > +		if (count > DRM_MODE_FB_DIRTY_MAX_CLIPS)
> > +			return -EINVAL;
> > +
> > +		state->damage_clips = drm_property_blob_get(blob);
> > +		state->num_clips = count;
> > +	} else {
> > +		state->damage_clips = NULL;
> > +		state->num_clips = 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> >   * drm_atomic_get_plane_state - get plane state
> >   * @state: global atomic state object
> >   * @plane: plane to get state object for
> > @@ -793,6 +827,12 @@ static int drm_atomic_plane_set_property(struct
> drm_plane *plane,
> >  		state->color_encoding = val;
> >  	} else if (property == plane->color_range_property) {
> >  		state->color_range = val;
> > +	} else if (property == config->prop_damage_clips) {
> > +		struct drm_property_blob *blob =
> > +			drm_property_lookup_blob(dev, val);
> > +		int ret = drm_atomic_set_damage_for_plane(state, blob);
> 
> There's already a helper with size-checking built-in, see
> drm_atomic_replace_property_blob_from_id(). Wrt computing num_clips
> I'd
> just provide a little inline helper that does the
> blob->length/sizeof(drm_rect) conversion (it's just a shift, so fast).
> 
> > +		drm_property_blob_put(blob);
> > +		return ret;
> >  	} else if (plane->funcs->atomic_set_property) {
> >  		return plane->funcs->atomic_set_property(plane, state,
> >  				property, val);
> > @@ -856,6 +896,8 @@ drm_atomic_plane_get_property(struct drm_plane
> *plane,
> >  		*val = state->color_encoding;
> >  	} else if (property == plane->color_range_property) {
> >  		*val = state->color_range;
> > +	} else if (property == config->prop_damage_clips) {
> > +		*val = (state->damage_clips) ? state->damage_clips->base.id
> : 0;
> >  	} else if (plane->funcs->atomic_get_property) {
> >  		return plane->funcs->atomic_get_property(plane, state,
> property, val);
> >  	} else {
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> b/drivers/gpu/drm/drm_atomic_helper.c
> > index c356545..55b44e3 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -3506,6 +3506,8 @@ void
> __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
> >
> >  	state->fence = NULL;
> >  	state->commit = NULL;
> > +	state->damage_clips = NULL;
> > +	state->num_clips = 0;
> >  }
> >  EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
> >
> > @@ -3550,6 +3552,8 @@ void
> __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
> >
> >  	if (state->commit)
> >  		drm_crtc_commit_put(state->commit);
> > +
> > +	drm_property_blob_put(state->damage_clips);
> >  }
> >  EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
> >
> > diff --git a/drivers/gpu/drm/drm_mode_config.c
> b/drivers/gpu/drm/drm_mode_config.c
> > index e5c6533..e93b127 100644
> > --- a/drivers/gpu/drm/drm_mode_config.c
> > +++ b/drivers/gpu/drm/drm_mode_config.c
> > @@ -293,6 +293,11 @@ static int
> drm_mode_create_standard_properties(struct drm_device *dev)
> >  		return -ENOMEM;
> >  	dev->mode_config.prop_crtc_id = prop;
> >
> > +	prop = drm_property_create(dev, DRM_MODE_PROP_BLOB,
> "DAMAGE_CLIPS", 0);
> 
> Bit a bikeshed, but since the coordinates are in fb pixels, not plane
> pixels, I'd call this "FB_DAMAGE_CLIPS".
> 
> > +	if (!prop)
> > +		return -ENOMEM;
> > +	dev->mode_config.prop_damage_clips = prop;
> > +
> >  	prop = drm_property_create_bool(dev,
> DRM_MODE_PROP_ATOMIC,
> >  			"ACTIVE");
> >  	if (!prop)
> > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> > index 6d2a6e4..071221b 100644
> > --- a/drivers/gpu/drm/drm_plane.c
> > +++ b/drivers/gpu/drm/drm_plane.c
> > @@ -1101,3 +1101,15 @@ int drm_mode_page_flip_ioctl(struct
> drm_device *dev,
> >
> >  	return ret;
> >  }
> > +
> > +/**
> > + * drm_plane_enable_damage_clips - enable damage clips property
> > + * @plane: plane on which this property to enable.
> > + */
> > +void drm_plane_enable_damage_clips(struct drm_plane *plane)
> > +{
> > +	struct drm_device *dev = plane->dev;
> > +	struct drm_mode_config *config = &dev->mode_config;
> > +
> > +	drm_object_attach_property(&plane->base, config-
> >prop_damage_clips, 0);
> > +}
> > diff --git a/include/drm/drm_mode_config.h
> b/include/drm/drm_mode_config.h
> > index 7569f22..d8767da 100644
> > --- a/include/drm/drm_mode_config.h
> > +++ b/include/drm/drm_mode_config.h
> > @@ -628,6 +628,21 @@ struct drm_mode_config {
> >  	 */
> >  	struct drm_property *prop_crtc_id;
> >  	/**
> > +	 * @prop_damage_clips: Optional plane property to mark damaged
> regions
> > +	 * on the plane in framebuffer coordinates of the framebuffer
> attached
> > +	 * to the plane.
> 
> Why should we make this optional? Looks like just another thing drivers
> might screw up, since we have multiple callbacks and things to set up for
> proper dirty tracking.

Thanks Daniel for the review.

I think not all compositor will be interested in sending damage, that was the
reason to make this optional. Also when damage is not set that means
user-space need full update just like eglSwapBuffersWithDamageKHR.

I will add better documentation.

> 
> One option I'm seeing is that if this is set, and it's an atomic driver,
> then we just directly call into the default atomic fb->dirty
> implementation. That way there's only 1 thing drivers need to do to set up
> dirty rect tracking, and they'll get all of it.
> 
> > +	 *
> > +	 * The layout of blob data is simply an array of drm_mode_rect with
> > +	 * maximum array size limited by
> DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike
> > +	 * plane src coordinates, damage clips are not in 16.16 fixed point.
> 
> I honestly have no idea where this limit is from. Worth keeping? I can
> easily imagine that userspace could trip over this - it's fairly high, but
> not unlimited.

DRM_MODE_FB_DIRTY_MAX_CLIPS was used to just have an upper limit
and its already exposed to user-space. IMHO there has to be an upper limit
to avoid unnecessary overflow ?

> 
> > +	 *
> > +	 * Damage clips are a hint to kernel as which area of framebuffer has
> > +	 * changed since last page-flip. This should be helpful
> > +	 * for some drivers especially for virtual devices where each
> > +	 * framebuffer change needs to be transmitted over network, usb,
> etc.
> 
> I'd also clarify that userspace still must render the entire screen, i.e.
> make it more clear that it's really just a hint and not mandatory to only
> scan out the damaged parts.

Yes will work on better documentation.

> 
> > +	 */
> > +	struct drm_property *prop_damage_clips;
> > +	/**
> >  	 * @prop_active: Default atomic CRTC property to control the active
> >  	 * state, which is the simplified implementation for DPMS in atomic
> >  	 * drivers.
> > diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> > index f7bf4a4..9f24548 100644
> > --- a/include/drm/drm_plane.h
> > +++ b/include/drm/drm_plane.h
> > @@ -146,6 +146,21 @@ struct drm_plane_state {
> >  	 */
> >  	struct drm_crtc_commit *commit;
> >
> > +	/*
> > +	 * @damage_clips
> > +	 *
> > +	 * blob property with damage as array of drm_rect in framebuffer
> 
> &drm_rect gives you a nice hyperlink in the generated docs.
> 
> > +	 * coodinates.
> > +	 */
> > +	struct drm_property_blob *damage_clips;
> > +
> > +	/*
> > +	 * @num_clips
> > +	 *
> > +	 * Number of drm_rect in @damage_clips.
> > +	 */
> > +	uint32_t num_clips;
> > +
> >  	struct drm_atomic_state *state;
> >  };
> >
> > @@ -611,6 +626,7 @@ int drm_plane_init(struct drm_device *dev,
> >  		   const uint32_t *formats, unsigned int format_count,
> >  		   bool is_primary);
> >  void drm_plane_cleanup(struct drm_plane *plane);
> > +void drm_plane_enable_damage_clips(struct drm_plane *plane);
> >
> >  /**
> >   * drm_plane_index - find the index of a registered plane
> > diff --git a/include/uapi/drm/drm_mode.h
> b/include/uapi/drm/drm_mode.h
> > index 50bcf42..0ad0d5b 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -873,6 +873,21 @@ struct drm_mode_revoke_lease {
> >  	__u32 lessee_id;
> >  };
> >
> > +/**
> > + * struct drm_mode_rect - two dimensional rectangle drm_rect exported
> to
> > + * user-space.
> > + * @x1: horizontal starting coordinate (inclusive)
> > + * @y1: vertical starting coordinate (inclusive)
> > + * @x2: horizontal ending coordinate (exclusive)
> > + * @y2: vertical ending coordinate (exclusive)
> > + */
> > +struct drm_mode_rect {
> > +	__s32 x1;
> > +	__s32 y1;
> > +	__s32 x2;
> > +	__s32 y2;
> 
> Why signed? Negative damage rects on an fb don't make sense to me. Also,
> please specify what this is exactly (to avoid confusion with the 16.16
> fixed point src rects), and maybe mention in the commit message why we're
> not using drm_clip_rect (going to proper uapi types and 32bit makes sense
> to me).
> 
> Cheers, Daniel
> > +};
> > +
> >  #if defined(__cplusplus)
> >  }
> >  #endif
> > --
> > 2.7.4
> >
> 
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> https://urldefense.proofpoint.com/v2/url?u=http-
> 3A__blog.ffwll.ch&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=zOOG28inJK
> 0762SxAf-
> cyZdStnd2NQpRu98lJP2iYGw&m=ELAUsNTjD0ICwUEDFjPW4jsmy2A5AkhS5Q
> z_3vlEC9Q&s=kLx5XCTMRYRoecNhwwwN2XItT4Rt0ib12-UP5VB4XLI&e=
