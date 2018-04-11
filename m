Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2024893-1523438672-2-2798378671840410365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523438671; b=h/p3g1jA0P7wqSWiRaxb1kSEk9UsjhKaapbaRnnLQJzyBacWqu
    Te5/CYnum7ly39+tXUQFDYy6sPSUrMJeOFZRjwF21Tdlp8dKFp34yxLMiJEZka53
    T79bzEx/P3kdzz60ZDYWy3DfQ+iJkTZHOnOD+4bauBRXVHq10mT+VXE2beyo7T2s
    5IwFRndqIj2vxoYbs4ioWW7weIZ4vS+NiHkPWm0itmRC/U7o0u4eQ8rTy/i8tCzR
    t6DR02fsd9ShP8Bn+ocQo+lyjCYOVThYuzSea6PleWlmQvDNS0/rF1CKlJwDee+x
    8PBfv6CMJgzEGXX3mPI+ac7sYJP78s8dI7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1523438671; bh=uEPDFvt0EKM5+3BLQ86zxnjX9FG6CEBxEfYeb3sOeO
    Y=; b=Qw2olIcLKbAbTURg/GDAWvdBj+gaMrDttMYh4H002/F1fOzUxm7M+JRKwM
    L1HdxoWcqxBPoRSu0Bfyqcr2dyY71gxUNxhT/WNMRuGCXu4IMpriabwc6+024iVU
    0VzUj7utXyV2K6IcIDMEphWXiSzQ2NX889qcuQW++sspdvlQ9JRnJvhnauz1ikQg
    HSkZnUHAl/tEAYsRTeY0dKkNDhOWxWakwk3Qu40xMOD/BMSDWmC4i6Fb22c1AC6X
    4XomFzluEK+DF5havnx70nwq7nMtMRxUaOav9D9jiMoupTZJi88I5p+lVfJmxSuH
    p/xC2M3ZZrQITDn93oGCOr6fey2A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCtQcDkjfDcL+C1ESSxsVoDoSG3AHH/YRGGTDQqQzc+W+iRZ7M+2UHD9pswBiOgS1vTvBVnzuqbr1qKYLtgESjsT2y+snCVJwUFD8pZ4JGeiTSVm0SrD
    DfhVZ/I2kULZEQo2lkTYvQiJrRStm6vBPeODC+di3CWWnP128tysn1sJbXw1eQpNuarleS7BIuo7DQ6OXrS0LvSF4iinFr2dLq/7SCSwIMssNdgEq2vOvp2f
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=i3X5FwGiAAAA:8 a=VwQbUJbxAAAA:8 a=hGnnzVL0lhYG6LtXMeIA:9
    a=mmqRlSCDY2ywfjPLJ4af:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeDKJYO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 05:24:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:62826 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbeDKJYK (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 11 Apr 2018 05:24:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="46010131"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: ianwmorrison@gmail.com, rodrigo.vivi@intel.com,
        anusha.srivatsa@intel.com, michal.wajdeczko@intel.com,
        gregkh@linuxfoundation.org, airlied@linux.ie,
        joonas.lahtinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        ianwmorrison@gmail.com
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
In-Reply-To: <20180411044213.383-1-ianwmorrison@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180411044213.383-1-ianwmorrison@gmail.com>
Date: Wed, 11 Apr 2018 12:24:55 +0300
Message-ID: <871sfmhz88.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 11 Apr 2018, ianwmorrison@gmail.com wrote:
> From: Ian W MORRISON <ianwmorrison@gmail.com>
>
> As the Geminilake firmware is now merged to linux-firmware.git
> use MODUE_FIRMWARE to load the firmware.
>
> This removes the error message in the dmesg log: 
>
>     i915 0000:00:02.0: Direct firmware load for 
>         i915/glk_dmc_ver1_04.bin failed with error -2
>     i915 0000:00:02.0: Failed to load DMC firmware 
>         i915/glk_dmc_ver1_04.bin. Disabling runtime power management.
>     i915 0000:00:02.0: DMC firmware homepage:
>         https://01.org/linuxgraphics/downloads/firmware
>
> and now shows that the firmware has correctly loaded:
>
>     [drm] Finished loading DMC firmware i915/glk_dmc_ver1_04.bin (v1.4)
>
> Cc: stable@vger.kernel.org

NAK on indiscriminate Cc: stable. There are zero guarantees that older
kernels will work with whatever firmware you throw at them.

Anusha, Rodrigo, are we even ready to do this in our -next?


BR,
Jani.

PS. How is this a "RESEND"? I haven't seen this before.


> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
>  drivers/gpu/drm/i915/intel_csr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/intel_csr.c b/drivers/gpu/drm/i915/intel_csr.c
> index 41e6c75a7f3c..f9550ea46c26 100644
> --- a/drivers/gpu/drm/i915/intel_csr.c
> +++ b/drivers/gpu/drm/i915/intel_csr.c
> @@ -35,6 +35,7 @@
>   */
>  
>  #define I915_CSR_GLK "i915/glk_dmc_ver1_04.bin"
> +MODULE_FIRMWARE(I915_CSR_GLK);
>  #define GLK_CSR_VERSION_REQUIRED	CSR_VERSION(1, 4)
>  
>  #define I915_CSR_CNL "i915/cnl_dmc_ver1_07.bin"

-- 
Jani Nikula, Intel Open Source Technology Center
