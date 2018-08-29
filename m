Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8820120658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8820120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeH3B1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:27:12 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:41383 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeH3B1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:27:12 -0400
Received: by mail-qt0-f180.google.com with SMTP id t39-v6so7525449qtc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 14:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=B5uqRUhVnXSRJ4DszGLcxAojQi1JXw4Oz1rUijCBEf4=;
        b=PI753DWTgSbBuAestO/8ddcTmTxIEGGlcefAMf63DRlQahifhvge/NP42hfewSZvcA
         p+7g3Ikce7lsUL8+RBtcb8tfEUARyMagO3CAVRK2IhMs/iA/56GoJ7GvStEI5xOlhhMv
         E2n2RNvEdQ14Nlc9e0EnQBsPDxiF7fPRAKa8E6WzbNY1j7NTXSaiAt8zDEuTRDdKpRM4
         /HutOwHs69uIhmOcQsaXc/kY5Qabdk2Eqz6X1vkz3haTYPyApVcCxSqxNERlN4r2JBOu
         i0GP8CRMsuW5mNhZzlu+JOzjsl6xe9kdNvYI7ZpnlbhVfn42q/35E7VCBFVUAirPZwDp
         kBcw==
X-Gm-Message-State: APzg51Bi6zeiuk/VHRLfSu+eWGFK8fUT4pbfYZU32FjGyIoZzC7eqIqU
        y9mnlCDIImNCArruaVloejl6NA==
X-Google-Smtp-Source: ANB0VdbgFEyNSN3+b0xl2clhK7ms1+7dLWpUttyhRdJOXamMd9lQOe5eO1/7Pg+kN+vROx0dT/LHuw==
X-Received: by 2002:a0c:b616:: with SMTP id f22-v6mr8610862qve.184.1535578105180;
        Wed, 29 Aug 2018 14:28:25 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id j129-v6sm2784842qke.56.2018.08.29.14.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 14:28:24 -0700 (PDT)
Message-ID: <ea3c8d6fd7fed44911fe55f04d785922fb2a2483.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v4] drm/i915: Re-apply "Perform link quality
 check, unconditionally during long pulse"
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jan-Marek Glogowski <glogow@fbihome.de>, stable@vger.kernel.org
Date:   Wed, 29 Aug 2018 17:28:23 -0400
In-Reply-To: <20180829212235.GL6418@intel.com>
References: <20180825191035.3945-1-lyude@redhat.com>
         <871sak5hdu.fsf@intel.com>
         <c87f70879c87b0d29880e32f6632c4c7acd337bb.camel@redhat.com>
         <20180829212235.GL6418@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 14:22 -0700, Rodrigo Vivi wrote:
> On Mon, Aug 27, 2018 at 01:39:02PM -0400, Lyude Paul wrote:
> > On Mon, 2018-08-27 at 11:43 +0300, Jani Nikula wrote:
> > > On Sat, 25 Aug 2018, Lyude Paul <lyude@redhat.com> wrote:
> > > > From: Jan-Marek Glogowski <glogow@fbihome.de>
> > > > 
> > > > This re-applies the workaround for "some DP sinks, [which] are a
> > > > little nuts" from commit 1a36147bb939 ("drm/i915: Perform link
> > > > quality check unconditionally during long pulse").
> > > > It makes the secondary AOC E2460P monitor connected via DP to an
> > > > acer Veriton N4640G usable again.
> > > > 
> > > > This hunk was dropped in commit c85d200e8321 ("drm/i915: Move SST
> > > > DP link retraining into the ->post_hotplug() hook")
> > > > 
> > > > Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the
> > > > ->post_hotplug() hook")
> > > > [Cleaned up commit message, added stable cc]
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > > Resending this to update patchwork; will push in a little bit
> > > 
> > > Is there a bugzilla? Reference to a list discussion? Something with a
> > > dmesg where someone can actually verify this is the right fix?
> > 
> > This patch has actually been on the list for a while now-I have had mdnavare
> > take a look at it as well (they said it looked fine with the only change
> > being
> > in regards to the comment), and it'd been on the list for a while already.
> > 
> > > 
> > > IMO needs an ack from Ville too. He should be in Cc: in the first place
> > > as the author of the regressing commit.
> > > 
> > > 'dim fixes c85d200e8321' gives you the output:
> > 
> > aaah-I had thought it was just for generating the Fixes line, I will be more
> > careful about that in the future
> 
> Hi Lyude,
> 
> I understand that this patch was a while on the mailing list and no
> proper attention, but besides the commit message information that
> dim is generating I have a feeling now that this patch wasn't quite
> ready yet and shouldn't be rushed in like it was.
> 
> Since you modified few versions ideally it would be good to have extra eyes
> and the mandatory "Reviewed-by" there.
> 
> Also it is a good idea to give few days for different timezones to
> comment out (after the re-sping I mean)
> 
> And finally based on the discussions it seems that there is still
> some work to get done or a different way to handle this other
> this back and forth of reapply-revert-reapply...
> 
> I just noticed it when preparing drm-intel-fixes pull request.
> 
> Since I'm not 100% confident this patch should be here I'm removing it
> from this week's pull request.
> 
> But probably adding it next week if Jani and Ville give and ack
> or indication that it is right or at least he best we could do now.
   I understand! Sorry about all of the trouble, I will be much more careful in
   the future
> 
> thanks,
> Rodrigo.
> 
> 
> > > 
> > > Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the
> > > ->post_hotplug() hook")
> > > Cc: Manasi Navare <manasi.d.navare@intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: <stable@vger.kernel.org> # v4.17+
> > > 
> > > BR,
> > > Jani.
> > > 
> > > > 
> > > >  drivers/gpu/drm/i915/intel_dp.c | 33 +++++++++++++++++++--------------
> > > >  1 file changed, 19 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > > > b/drivers/gpu/drm/i915/intel_dp.c
> > > > index b3f6f04c3c7d..db8515171270 100644
> > > > --- a/drivers/gpu/drm/i915/intel_dp.c
> > > > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > > > @@ -4333,18 +4333,6 @@ intel_dp_needs_link_retrain(struct intel_dp
> > > > *intel_dp)
> > > >  	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
> > > >  }
> > > >  
> > > > -/*
> > > > - * If display is now connected check links status,
> > > > - * there has been known issues of link loss triggering
> > > > - * long pulse.
> > > > - *
> > > > - * Some sinks (eg. ASUS PB287Q) seem to perform some
> > > > - * weird HPD ping pong during modesets. So we can apparently
> > > > - * end up with HPD going low during a modeset, and then
> > > > - * going back up soon after. And once that happens we must
> > > > - * retrain the link to get a picture. That's in case no
> > > > - * userspace component reacted to intermittent HPD dip.
> > > > - */
> > > >  int intel_dp_retrain_link(struct intel_encoder *encoder,
> > > >  			  struct drm_modeset_acquire_ctx *ctx)
> > > >  {
> > > > @@ -5031,7 +5019,8 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
> > > >  }
> > > >  
> > > >  static int
> > > > -intel_dp_long_pulse(struct intel_connector *connector)
> > > > +intel_dp_long_pulse(struct intel_connector *connector,
> > > > +		    struct drm_modeset_acquire_ctx *ctx)
> > > >  {
> > > >  	struct drm_i915_private *dev_priv = to_i915(connector-
> > > > >base.dev);
> > > >  	struct intel_dp *intel_dp = intel_attached_dp(&connector->base);
> > > > @@ -5090,6 +5079,22 @@ intel_dp_long_pulse(struct intel_connector
> > > > *connector)
> > > >  		 */
> > > >  		status = connector_status_disconnected;
> > > >  		goto out;
> > > > +	} else {
> > > > +		/*
> > > > +		 * If display is now connected check links status,
> > > > +		 * there has been known issues of link loss triggering
> > > > +		 * long pulse.
> > > > +		 *
> > > > +		 * Some sinks (eg. ASUS PB287Q) seem to perform some
> > > > +		 * weird HPD ping pong during modesets. So we can
> > > > apparently
> > > > +		 * end up with HPD going low during a modeset, and then
> > > > +		 * going back up soon after. And once that happens we
> > > > must
> > > > +		 * retrain the link to get a picture. That's in case no
> > > > +		 * userspace component reacted to intermittent HPD dip.
> > > > +		 */
> > > > +		struct intel_encoder *encoder =
> > > > &dp_to_dig_port(intel_dp)-
> > > > > base;
> > > > 
> > > > +
> > > > +		intel_dp_retrain_link(encoder, ctx);
> > > >  	}
> > > >  
> > > >  	/*
> > > > @@ -5151,7 +5156,7 @@ intel_dp_detect(struct drm_connector *connector,
> > > >  				return ret;
> > > >  		}
> > > >  
> > > > -		status = intel_dp_long_pulse(intel_dp-
> > > > >attached_connector);
> > > > +		status = intel_dp_long_pulse(intel_dp-
> > > > >attached_connector,
> > > > ctx);
> > > >  	}
> > > >  
> > > >  	intel_dp->detect_done = false;
> > > 
> > > 
> > 
> > -- 
> > Cheers,
> > 	Lyude Paul
> > 
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx

