Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbeA3PcM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:32:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:61264 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbeA3PcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:32:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,435,1511856000";
   d="scan'208";a="26655597"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v2] drm/edid: use true and false for boolean values
In-Reply-To: <20180130151946.GC5453@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180130100528.GA7154@training> <20180130150927.3fm5kotyp6vqugaf@art_vandelay> <20180130151946.GC5453@intel.com>
Date: Tue, 30 Jan 2018 17:31:59 +0200
Message-ID: <87607jwefk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> On Tue, Jan 30, 2018 at 10:09:27AM -0500, Sean Paul wrote:
>> On Tue, Jan 30, 2018 at 04:05:28AM -0600, Gustavo A. R. Silva wrote:
>> > Assign true or false to boolean variables instead of an integer value.
>> > 
>> > This issue was detected with the help of Coccinelle.
>> 
>> I suppose you could also fix up the other preferred assignment by adding !!
>> to the bitwise & operation.
>
> Assigning >1 to a bool is well defined. No need to clutter the code with
> !! imo.

Agreed.

BR,
Jani.

>
>> 
>> It's also helpful to post the spatch in the commit message so others can
>> replicate your result (this case is pretty trivial, so less important).
>> 
>> Sean
>> 
>> > 
>> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> > ---
>> > Changes in v2:
>> >  - Use true for boolean value in add_detailed_mode as suggested by Daniel
>> >    Vetter.
>> >  - Update subject.
>> > 
>> >  drivers/gpu/drm/drm_edid.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> > index ddd5379..b1cb262 100644
>> > --- a/drivers/gpu/drm/drm_edid.c
>> > +++ b/drivers/gpu/drm/drm_edid.c
>> > @@ -2767,7 +2767,7 @@ do_detailed_mode(struct detailed_timing *timing, void *c)
>> >  
>> >  		drm_mode_probed_add(closure->connector, newmode);
>> >  		closure->modes++;
>> > -		closure->preferred = 0;
>> > +		closure->preferred = false;
>> >  	}
>> >  }
>> >  
>> > @@ -2784,7 +2784,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
>> >  	struct detailed_mode_closure closure = {
>> >  		.connector = connector,
>> >  		.edid = edid,
>> > -		.preferred = 1,
>> > +		.preferred = true,
>> >  		.quirks = quirks,
>> >  	};
>> >  
>> > -- 
>> > 2.7.4
>> > 
>> 
>> -- 
>> Sean Paul, Software Engineer, Google / Chromium OS
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Technology Center
