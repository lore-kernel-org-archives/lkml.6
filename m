Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2139197-1523044120-2-10251838703988056924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523044119; b=nmMIbbB+xQ1F9msuBpq/CEFWEl9XTpx+CxLRk0RFLLkcNxWeYt
    vHt5OxQZthLi1GlaidSfYxnQRZMaIu32kNqEzu+fG6C1tLbTvoQtL0z/n2ZUAdBJ
    V4JIqDdfnylhcrAmJ8X2L2DDWLvzsG2N9WzKgzRxmlaHqxvkwXmcm6gk2+n6cOoU
    V7/E4RtFbWupGvuNWunXf+hwATWf46jcWpEtEgrK5lsOMu1VFENCPUbjZkdCE4xU
    kR/takfSUKL7IRd35AOjAALTkkiky1a9ALD/zwME5vD8Vge4B66rAa/dQEuCdANQ
    GGtB26v5tgAZEt3gBOQgvqzIy7Nq9uJXaIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523044119;
    bh=T6Pvtkav3hm9ohQ7fnq8knWkkx9RwQA57bf7V8QLLBU=; b=t33Nt/z1+7uQ
    P8CZj4Byas8FDUf7hZKSixu4nn3GyMYTiLnX00IJUMRAGFF0jyhrj2xsJqJSPqha
    fdAKgGB3ILVdyykmxeZtItPY/mUrVok0fm2+UKJwmo6IOa+RwjzDYp0Vfrhtzn8A
    q5ujSaGoweNyHBUk8KooP0YB7To6aAbFFErriqhkT62Hc9FrTxvX9JVLdo1E5KHF
    MfR+LZyQk6xEY6xLa+NXXzarXiLBD/fSqetd27uWRWt4ZoV1hjeCu66c3KAAZey2
    r7vAwp9ApqQBwYhtl9KrQmaUScvqrhUHX88/UQOfQN1HzR6KQQZ5gltlGcH9q7vI
    ubQwxSV15w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b/Q5sM+l;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b/Q5sM+l;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJIav4cXK3v5oGxG5JacdqOR1ziWTTmfDNbnEltpXOQXTrXmZMDhhtI6fJKWfzA14R49l3NcfTeh1RuUrai6M+2M+rCAakRK4QH8UCgJygPOhytRSBB1
    JJSIV4u0I2eqT3KifaZBPDva1aIPjN4MmfmH8eS4IIieIr6U9pDH7l8XFV8tG8Vb/UbHqX+Xbc3gV7UNZtj7IU8Ya+1J/Q/+/jHlroyURrwgemepm1Umpe3g
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=rNOAPQ8WUYQvsxLIZAkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeDFTsh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 15:48:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45380 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeDFTsh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 15:48:37 -0400
X-Google-Smtp-Source: AIpwx4/qcjXOFDf4egJniTyDWH75C8e18m5LLi+EGsOhPs/iGsD1EI490IyU2WP7EN2r48rZGbpkTQ==
Subject: Re: [PATCH v4] drm/i915/dp: Send DPCD ON for MST before phy_up
To: Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180406185249.22952-1-lyude@redhat.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <9705da91-6db6-a18b-993a-5676913eaeb8@redhat.com>
Date: Fri, 6 Apr 2018 12:48:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406185249.22952-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/06/2018 11:52 AM, Lyude Paul wrote:
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
>    keep enable/disable paths symmetrical
> - Improve commit message - dhnkrn
> Changes since v2:
> - Only send DPMS off when we're disabling the last sink, and only send
>    DPMS on when we're enabling the first sink - dhnkrn
> Changes since v3:
> - Check against is_mst, not intel_dp->is_mst - dhnkrn/vsyrjala
> 

For the booting docked with lid down case:

Tested-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
> ---
>   drivers/gpu/drm/i915/intel_ddi.c    | 8 ++++++--
>   drivers/gpu/drm/i915/intel_dp_mst.c | 8 +++++++-
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
> index a6672a9abd85..92cb26b18a9b 100644
> --- a/drivers/gpu/drm/i915/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/intel_ddi.c
> @@ -2324,7 +2324,8 @@ static void intel_ddi_pre_enable_dp(struct intel_encoder *encoder,
>   		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
>   
>   	intel_ddi_init_dp_buf_reg(encoder);
> -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> +	if (!is_mst)
> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
>   	intel_dp_start_link_train(intel_dp);
>   	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
>   		intel_dp_stop_link_train(intel_dp);
> @@ -2422,12 +2423,15 @@ static void intel_ddi_post_disable_dp(struct intel_encoder *encoder,
>   	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>   	struct intel_digital_port *dig_port = enc_to_dig_port(&encoder->base);
>   	struct intel_dp *intel_dp = &dig_port->dp;
> +	bool is_mst = intel_crtc_has_type(old_crtc_state,
> +					  INTEL_OUTPUT_DP_MST);
>   
>   	/*
>   	 * Power down sink before disabling the port, otherwise we end
>   	 * up getting interrupts from the sink on detecting link loss.
>   	 */
> -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
> +	if (!is_mst)
> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
>   
>   	intel_disable_ddi_buf(encoder);
>   
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index c3de0918ee13..9e6956c08688 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -180,9 +180,11 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
>   	intel_dp->active_mst_links--;
>   
>   	intel_mst->connector = NULL;
> -	if (intel_dp->active_mst_links == 0)
> +	if (intel_dp->active_mst_links == 0) {
> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
>   		intel_dig_port->base.post_disable(&intel_dig_port->base,
>   						  old_crtc_state, NULL);
> +	}
>   
>   	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
>   }
> @@ -223,7 +225,11 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
>   
>   	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
>   
> +	if (intel_dp->active_mst_links == 0)
> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> +
>   	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port, true);
> +
>   	if (intel_dp->active_mst_links == 0)
>   		intel_dig_port->base.pre_enable(&intel_dig_port->base,
>   						pipe_config, NULL);
> 
