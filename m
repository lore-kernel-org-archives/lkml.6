Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3758934-1522961405-2-16014113643070885881
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-1', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522961404; b=SbqVybQ4PmXOYOaJkYY1fEQxiF0UH+Bs/gvc8R3IChRe9CvNyV
    mNfqAF8fM4+5WOTrwkPjya1PXQJ+h//HbO3S5gdojJAQLjco1T9wlUQM799rU0pV
    twzlWWOFPBZ10e66u4+BJhdmmeLTV+smMxZFKB8k5P2Y7ngqHdobfLIzqRIszFtU
    WctYjvWEPtJJFDuyYi5m5KuPl/1k9ycVcVgwDi0+Z1G3St9tFUzUinBCV19YQQ+n
    07phsy2pTUohOvVp2kTy+MHCLFy4pWC5UI7gpVErFNKqx2MC2p3OokBwnIWIBEcY
    BiOX6tZYixphn0omxgM6c47gt93SU6AJmBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522961404;
    bh=8iEx7hH3whAz9fQOUCOTut4Spjv6u3oiprCnhu1hFEk=; b=gaEA4lgJVWYi
    mzIh6qwX5+bC3ZqZNbXGrgKaEtTbJ/0eerpMphjZozMM7aanbs8AONvrbJDmuHfe
    Dxww9FU1b4x75NRw9Rk/QM3n5U3bRf0KPCexFOgV5nT7eWPaLjxgNgMOLq9PapKZ
    Dj+iSZkyedQ+/7+4bIKQwgnejkidWYVZXttCmsaVIBCwe/MOD6+4Y26CeymL3mu/
    r2S7c78I5RBZpZ4MLCW2fCRxFdaK1aPXY6xjqP0OWd4zfeFRTwAgh3rYQAgTWgPM
    DA6lDYRLZ8OU9SChIHZd1AKyxiXBr3U6P7Vdi8VeF9gJrgQ9eWCki9d2ut0VITTk
    IuQq5XnhLA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fOf2x/jI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fOf2x/jI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG699Fuyl2JleOGySZcp/7ooSbxdb2L6MVwUzywcaUQm/vji3CU26MKjsN3U3bzGZjttTpPCPeiKiURMqEaYQ1JHK28IzGvs/O1UU50o1VudQn9s4uWj
    2YrtknSRnM16B4mQFZnNfUT4uUOMLV0DTPRpO74y7bM1bzLt8Rcfgp44ezlBDuHSrnjqABaMj3RYriiWawSk9F9g3NwIA5+TeOIBJrIlGedYDEfqvx10oOzM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=NTfZxkeiJG3UAG_HXy8A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDEUuB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 16:50:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42789 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDEUuA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 16:50:00 -0400
X-Google-Smtp-Source: AIpwx4+oZyJ0XE27EakYP5Qbu3CzceOv7YC84+V0nuIrb/Pr/F8IStjh7f537FXl5il0e49oSw3vwQ==
Message-ID: <1522961397.4019.0.camel@redhat.com>
Subject: Re: [PATCH v2] drm/i915/dp: Send DPCD ON for MST before phy_up
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>, Laura Abbott <labbott@redhat.com>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 16:49:57 -0400
In-Reply-To: <20180405203601.23242-1-lyude@redhat.com>
References: <20180405203601.23242-1-lyude@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Actually - ignore this patch, I'm going to do a v3 because i just noticed
there is something very silly and broken I just introduced into the disable
codepath

On Thu, 2018-04-05 at 16:36 -0400, Lyude Paul wrote:
> When doing a modeset where the sink is transitioning from D3 to D0 , it
> would sometimes be possible for the initial power_up_phy() to start
> timing out. This would only be observed in the last action before the
> sink went into D3 mode was intel_dp_sink_dpms(DRM_MODE_DPMS_OFF). We
> originally thought this might be an issue with us accidentally shutting
> off the aux block when putting the sink into D3, but since the DP spec
> mandates that sinks must wake up within 1ms while we have 100ms to
> respond to an ESI irq, this didn't really add up. Turns out that the
> problem is more subtle then that:
> 
> It turns out that the timeout is from us not enabling DPMS on the MST
> hub before actually trying to initiate sideband communications. This
> would cause the first sideband communication (power_up_phy()), to start
> timing out because the sink wasn't ready to respond. Afterwards, we
> would call intel_dp_sink_dpms(DRM_MODE_DPMS_ON) in
> intel_ddi_pre_enable_dp(), which would actually result in waking up the
> sink so that sideband requests would work again.
> 
> Since DPMS is what lets us actually bring the hub up into a state where
> sideband communications become functional again, we just need to make
> sure to enable DPMS on the display before attempting to perform sideband
> communications.
> 
> Changes since v1:
> - Remove comment above if (!intel_dp->is_mst) - vsryjala
> - Move intel_dp_sink_dpms() for MST into intel_dp_post_disable_mst() to
>   keep enable/disable paths symmetrical
> - Improve commit message - dhnkrn
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST
> hub.")
> ---
> This email should hopefully actually be picked up by patchwork this
> time, hooray!
> 
>  drivers/gpu/drm/i915/intel_ddi.c    | 6 ++++--
>  drivers/gpu/drm/i915/intel_dp_mst.c | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_ddi.c
> b/drivers/gpu/drm/i915/intel_ddi.c
> index a6672a9abd85..c0bf7419e1c1 100644
> --- a/drivers/gpu/drm/i915/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/intel_ddi.c
> @@ -2324,7 +2324,8 @@ static void intel_ddi_pre_enable_dp(struct
> intel_encoder *encoder,
>  		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
>  
>  	intel_ddi_init_dp_buf_reg(encoder);
> -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> +	if (!intel_dp->is_mst)
> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
>  	intel_dp_start_link_train(intel_dp);
>  	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
>  		intel_dp_stop_link_train(intel_dp);
> @@ -2427,7 +2428,8 @@ static void intel_ddi_post_disable_dp(struct
> intel_encoder *encoder,
>  	 * Power down sink before disabling the port, otherwise we end
>  	 * up getting interrupts from the sink on detecting link loss.
>  	 */
> -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
> +	if (!intel_dp->is_mst)
> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
>  
>  	intel_disable_ddi_buf(encoder);
>  
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> b/drivers/gpu/drm/i915/intel_dp_mst.c
> index c3de0918ee13..2493bd1e0e59 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -176,6 +176,7 @@ static void intel_mst_post_disable_dp(struct
> intel_encoder *encoder,
>  	 */
>  	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port,
>  				     false);
> +	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
>  
>  	intel_dp->active_mst_links--;
>  
> @@ -223,6 +224,7 @@ static void intel_mst_pre_enable_dp(struct intel_encoder
> *encoder,
>  
>  	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
>  
> +	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
>  	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port,
> true);
>  	if (intel_dp->active_mst_links == 0)
>  		intel_dig_port->base.pre_enable(&intel_dig_port->base,
-- 
Cheers,
	Lyude Paul
