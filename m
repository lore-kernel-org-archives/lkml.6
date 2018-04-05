Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeDEXzd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:55:33 -0400
Received: from mail-by2nam03on0042.outbound.protection.outlook.com ([104.47.42.42]:58272
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750835AbeDEXzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:55:31 -0400
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
Subject: RE: [RFC 3/3] drm: Add helper to validate damage during modeset_check
Thread-Topic: [RFC 3/3] drm: Add helper to validate damage during
 modeset_check
Thread-Index: AQHTzG/R+8rDCCfBbEuJL0AYZYU6cKPxzyyAgAEGd1A=
Date: Thu, 5 Apr 2018 23:55:29 +0000
Message-ID: <MWHPR05MB3117BE16BBCC51D394185510BABB0@MWHPR05MB3117.namprd05.prod.outlook.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-4-git-send-email-drawat@vmware.com>
 <20180405075929.GR3881@phenom.ffwll.local>
In-Reply-To: <20180405075929.GR3881@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=drawat@vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR05MB3312;7:nDnEWtzcUSKpN1ZDIpI3x6CdwoNl57bHJn9Tl5erJRfGBbi5C7LsC5fiCHnag4SVFMEZxk+jT1yBcYIjBgfhG7Z91f2QE16i1XbVIHjtjDOirqGue0hyvhF20XdjJ8CYehf6McmJaNMAQiiO8FcNWwxbQlYVqkDZ1gYOHA4ELXkj5tT5CiP/AMlAarhypciCr9vRNP1QAcUFGs8kUwA/em6iWmdv46A4Xy3kIeg1LCM+RBKyfaOqGDkWGyRnXLgk;20:j4rUpocHyGdXvdWfD922+9SaNC+KxKvROHMZeh190KifZlTJRiF2NqmXwnbqEGxv8/hNJ8Y4TsL1lRnSLK/FrCvS6bK6Ziowzc+0xhfKt+uS9Rsd0dq5ZyjseWM3HcLCPKDVTmO7hdeXzOg34NoxTe1zhSsF9oLHF13bqOkP1lk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a290e4ce-7e03-4cd6-5311-08d59b50b619
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR05MB3312;
x-ms-traffictypediagnostic: MWHPR05MB3312:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MWHPR05MB331245D748F8D8E44311279DBABB0@MWHPR05MB3312.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(10436049006162);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR05MB3312;BCL:0;PCL:0;RULEID:;SRVR:MWHPR05MB3312;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(39380400002)(366004)(346002)(189003)(199004)(8676002)(316002)(8936002)(5660300001)(54906003)(81166006)(7416002)(102836004)(86362001)(59450400001)(81156014)(229853002)(11346002)(446003)(6506007)(7696005)(99286004)(6916009)(476003)(575784001)(97736004)(76176011)(478600001)(74316002)(6436002)(106356001)(55016002)(15650500001)(6246003)(53936002)(68736007)(966005)(14454004)(2900100001)(2906002)(6306002)(3846002)(6116002)(26005)(305945005)(66066001)(105586002)(3280700002)(5250100002)(39060400002)(25786009)(3660700001)(9686003)(7736002)(4326008)(5890100001)(33656002)(486006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB3312;H:MWHPR05MB3117.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EeKI3IWX3V5DWGKQCRAIXsPsArdtO4yg6dVvPkC5NCz2hXA2HjEtU6SFFqcUKrlS0Iw7aQ59dqzNebQ8/iETWfTaH46dxwMlTnWUweRFXwYFO4Uo/6JrX9L/lFC/wiaMxetzsmT92ODp8DZkYjPKxdyzQWiTi8p6lretfbddIsnDfvOGy+ckxym9WUOAwwHxo+i5mevp9s4x3k8LXlDFsIwrrLfHT9pWWwEBH/ZN2aBnNQWHiZnZRhIro5uO6EFTWXyr0QrwYoQnygjE9vU+/fs4K3oCdfW0tj56DM0mifpcIn+MxLmR9UnUtcuOlQe5kjNc1KCr6MpAsa71tdiXowC838OqdDB0mXN2DKZ+Ag1RtEfwKZEn5S+A2yHq3hifgX1mmiecNLsHD8LmB211DLkWjN4e90OEptzh0Bb1VXU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a290e4ce-7e03-4cd6-5311-08d59b50b619
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 23:55:29.6754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3312
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35NteS3032706

> 
> On Wed, Apr 04, 2018 at 04:49:08PM -0700, Deepak Rawat wrote:
> > This patch adds a helper which should be called by driver which enable
> > damage (by calling drm_plane_enable_damage_clips) from atomic_check
> > hook. This helper for now set the damage to NULL for the planes on crtc
> > which need full modeset.
> >
> > The driver also need to check for other crtc properties which can
> > affect damage in atomic_check hook, like gamma, ctm, etc. Plane related
> > properties which affect damage can be handled in damage iterator.
> >
> > Signed-off-by: Deepak Rawat <drawat@vmware.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 47
> +++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_atomic_helper.h     |  2 ++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> b/drivers/gpu/drm/drm_atomic_helper.c
> > index 355b514..23f44ab 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -3987,3 +3987,50 @@ drm_atomic_helper_damage_iter_next(struct
> drm_atomic_helper_damage_iter *iter,
> >  	return true;
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
> > +
> > +/**
> > + * drm_atomic_helper_check_damage - validate state object for damage
> changes
> > + * @dev: DRM device
> > + * @state: the driver state object
> > + *
> > + * Check the state object if damage is required or not. In case damage is
> not
> > + * required e.g. need modeset, the damage blob is set to NULL.
> 
> Why is that needed?
> 
> I can imagine that drivers unconditionally upload everything for a
> modeset, and hence don't need special damage tracking. But for that it's
> imo better to have a clear_damage() helper.

Don't we need a generic helper which all drivers can use to see if anything
in drm_atomic_state will result in full update? My intention for calling that
function from atomic_check hook was because state access can
return -EDEADLK.

I think for now having drm_damage_helper_clear_damage helper and 
calling it from atomic_check seems better option. In future once I have
clear idea, a generic function can be done.


> 
> But even for modesets (e.g. resolution changes) I'd expect that virtual
> drivers don't want to upload unecessary amounts of data. Manual upload
> hw drivers probably need to upload everything, because the panel will have
> forgotten all the old data once power cycled.

AFAIK current vmwgfx will do full upload for resolution change.

> 
> And if you think this is really the right thing, then we need to rename
> the function to tell what it does, e.g.
> 
> drm_damage_helper_clear_damage_on_modeset()
> 
> drm_damage_helper because I think we should stuff this all into
> drm_damage_helper.c, see previous patch.
> 
> But I think a
> 
> drm_damage_helper_clear_damage(crtc_state)
> 
> which you can use in your crtc->atomic_check function like
> 
> crtc_atomic_check(state)
> {
> 	if (drm_atomic_crtc_needs_modeset(state))
> 		drm_damage_helper_clear_damage(state);
> }
> 
> is more flexible and useful for drivers. There might be other cases where
> clearing damage is the right thing to do. Also, there's the question of
> whether no damage clips == full damage or not, so maybe we should call
> this helper full_damage() instead.

In my opinion if via proper documentation it is conveyed that no damage
means full-update the clear_damage makes sense.

> -Daniel
> 
> > + *
> > + * NOTE: This helper is not called by core. Those driver which enable
> damage
> > + * using drm_plane_enable_damage_clips should call this from their
> @atomic_check
> > + * hook.
> > + */
> > +int drm_atomic_helper_check_damage(struct drm_device *dev,
> > +				   struct drm_atomic_state *state)
> > +{
> > +	struct drm_crtc *crtc;
> > +	struct drm_plane *plane;
> > +	struct drm_crtc_state *crtc_state;
> > +	unsigned plane_mask;
> > +	int i;
> > +
> > +	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> > +		if (!drm_atomic_crtc_needs_modeset(crtc_state))
> > +			continue;
> > +
> > +		plane_mask = crtc_state->plane_mask;
> > +		plane_mask |= crtc->state->plane_mask;
> > +
> > +		drm_for_each_plane_mask(plane, dev, plane_mask) {
> > +			struct drm_plane_state *plane_state =
> > +				drm_atomic_get_plane_state(state, plane);
> > +
> > +			if (IS_ERR(plane_state))
> > +				return PTR_ERR(plane_state);
> > +
> > +			if (plane_state->damage_clips) {
> > +				drm_property_blob_put(plane_state-
> >damage_clips);
> > +				plane_state->damage_clips = NULL;
> > +				plane_state->num_clips = 0;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(drm_atomic_helper_check_damage);
> > diff --git a/include/drm/drm_atomic_helper.h
> b/include/drm/drm_atomic_helper.h
> > index ebd4b66..b12335c 100644
> > --- a/include/drm/drm_atomic_helper.h
> > +++ b/include/drm/drm_atomic_helper.h
> > @@ -224,6 +224,8 @@ drm_atomic_helper_damage_iter_init(struct
> drm_atomic_helper_damage_iter *iter,
> >  bool
> >  drm_atomic_helper_damage_iter_next(struct
> drm_atomic_helper_damage_iter *iter,
> >  				   struct drm_rect *rect);
> > +int drm_atomic_helper_check_damage(struct drm_device *dev,
> > +				   struct drm_atomic_state *state);
> >
> >  /**
> >   * drm_atomic_crtc_for_each_plane - iterate over planes currently
> attached to CRTC
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
> cyZdStnd2NQpRu98lJP2iYGw&m=70sQYwsOsrWAPt1SdaK8gDC1Fr3KTUpJLw
> 008Coi8rY&s=wCKqHwASJhJBVWlirJDaofj0YDju_QHCPE4uZw8W3Mg&e=
