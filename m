Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-237308-1522721712-2-13812920124459552894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522721711; b=W0zokX2F4yD+R4QmfBfLVevmjzwAwUD1HGUy3HLeF2pYPom1c1
    MMFJFBqY+BC6TOPKebYcPW0FC6DE2sBIsFk2W8GqMiUK46gK3AFQBaC1Y9CPIneM
    XKu9nNFeDgA4SH8PlJBQ0RTAg3EejLmZaV9ZAjXoQUNCe4fsFAzls5RXTIW9ZWuz
    X/39+V6Dw4AvYGfACKUuJeyZtnqxQ5Y7JFxEUpRhpWQmb5NI3Wa25sdJOW/Tq3K7
    G7Ihr1DWBUVFX9KtK9/hY2dZBbFqsTvZUwW/TVb+BAj9YmGD9WVMbpmY74agB+m4
    pZOkCBFRNYp2TE5CaBKomzOwfPBHUJ02vn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522721711;
    bh=ix/sI/P5C9a9b85In63xD34z8y3xvr8w5b4yPRg97Og=; b=YAGQmuJv8rr5
    6EfHNgmu9KOc9fTvh9B0pUxeqZFWgBd6Jeh/aW6hAZjbkBp/XDG1K3mSCE0bILlI
    jG1I66Xh7uaeKs072L0dFXc33pCEqErI+AMazFHQsQDF8J9qKK63cwIYznsAf5i1
    PPL7oXuSaAQ3OTg4SfP3all6iB79Mm7xpVSh0wW/DRD1ZXoJfhMD1hC+hRBAD7X+
    w7xWZm8gwTFrx8zXs7Y7lES592B09GDcCcdtw2Y50RA7abfEQC2pDP+WRNAlnobm
    JQCFbh6qQOhXTQEcpq/EMkeIhxIxp29fYGqZoR4Y1oGZKVmsUgKUFeQT7srDFBFT
    ZJszbgeDpA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J0VhNIj1;
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
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J0VhNIj1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGd5Nlm/q/JLWsXkEjYqIAmtQmTv61AhMrMH7EK7MDmXmjhg6ElvnkqZdT9u04pIiM8x2W5sQFU15JAnuQRScpY6INKy21tg6L9K5ZYS4ytsicnntVLE
    d8dP6EpGg5hl5QpozpBAnikC50UZ1fHIIHk8uhKYEBBVTc9lskaFI1VGSD355NHcxVYgfnP+zWRAVt8O7bL5fWuBlqpXGIYhXJMTbGNdJXwigyYJewfljz/3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=CHO7OG3I3ADhSFNjfKcA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754724AbeDCCPH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 22:15:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41418 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbeDCCPH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Apr 2018 22:15:07 -0400
X-Google-Smtp-Source: AIpwx4+SKXFQ7aQdVDa7FFIYJj1pTEfneXVZ+GupfZ9+Oj9mUEM2Uy3zjt7DOy1cQKybIIObLYRhXA==
Subject: Re: [PATCH v2] drm/i915: Keep AUX block running when disabling DPMS
 for MST
To: Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180402212142.19841-1-lyude@redhat.com>
 <20180402212617.21247-1-lyude@redhat.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <89a025ea-b7a2-81f0-7277-341d3c96ebe1@redhat.com>
Date: Mon, 2 Apr 2018 19:15:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402212617.21247-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/02/2018 02:26 PM, Lyude Paul wrote:
> While enabling/disabling DPMS before link training with MST hubs is
> perfectly valid; unfortunately disabling DPMS results in some devices
> disabling their AUX CH block as well. For SST this isn't as much of a
> problem, but for MST we need to be able to continue handling aux
> transactions even when none of the sinks are turned on since it's
> possible for us to have a single atomic commit which results in
> disabling each downstream sink, followed by subsequently re-enabling
> each sink.
> 
> If we don't do this, we'll end up stalling any pending ESI interrupts
> from the sink for up to 1ms. Unfortunately, dropping ESIs during this
> timespan makes it so that link fallback retraining for MST (which I will
> be submitting to the ML shortly) fails due to the channel EQ failure
> interrupts potentially getting dropped. Additionally, when performing a
> modeset that brings the hub status's link status from bad -> good having
> ESIs disabled for that long causes us to miss the hub's response to us
> trying to start link training as well.
> 
> Since any sink with MST is going to support DisplayPort 1.2 anyway, save
> us the hassle of trying to wait until the sink comes back up and just
> never shut the aux block down.
> 
> Changes since v2:
>   - Fix patch name, no functional changes
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: stable@vger.kernel.org
> Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")

Still able to boot docked and lid closed so

Tested-by: Laura Abbott <labbott@redhat.com>

> ---
>   drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index 62f82c4298ac..0479c377981b 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>   		return;
>   
>   	if (mode != DRM_MODE_DPMS_ON) {
> +		unsigned char data = intel_dp->is_mst ?
> +			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;
> +
>   		if (downstream_hpd_needs_d0(intel_dp))
>   			return;
>   
> -		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER,
> -					 DP_SET_POWER_D3);
> +		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER, data);
>   	} else {
>   		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
>   
> 
