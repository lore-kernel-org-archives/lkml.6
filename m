Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE5C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52DD20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52DD20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeFTTAD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:00:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:28836 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932365AbeFTTAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:00:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 11:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,248,1526367600"; 
   d="scan'208";a="50920813"
Received: from rdvivi-vienna.jf.intel.com (HELO intel.com) ([10.7.196.88])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2018 11:59:59 -0700
Date:   Wed, 20 Jun 2018 11:59:56 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/psr: fix copy-paste error with setting of
 tp2_wakeup_time_us
Message-ID: <20180620185956.GB8258@intel.com>
References: <20180620132543.28092-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620132543.28092-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 02:25:43PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently for the psr_table->tp2_tp3_wakeup_time case 3 there appears
> to be a copy-paste error from the previous switch statement where
> dev_priv->vbt.psr.tp1_wakeup_time_us is being assigned and I believe
> it should be dev_priv->vbt.psr.tp2_tp3_wakeup_time_us that should be
> assigned instead.
> 
> Detected by CoverityScan, CID#1470105 ("Copy-paste error")
> 
> Fixes: 77312ae8f071 ("drm/i915/psr: vbt change for psr")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

pushing to dinq now. thanks for the patch.

> ---
>  drivers/gpu/drm/i915/intel_bios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_bios.c b/drivers/gpu/drm/i915/intel_bios.c
> index 03f04b472394..e0a14be1080a 100644
> --- a/drivers/gpu/drm/i915/intel_bios.c
> +++ b/drivers/gpu/drm/i915/intel_bios.c
> @@ -740,7 +740,7 @@ parse_psr(struct drm_i915_private *dev_priv, const struct bdb_header *bdb)
>  			dev_priv->vbt.psr.tp2_tp3_wakeup_time_us = 100;
>  			break;
>  		case 3:
> -			dev_priv->vbt.psr.tp1_wakeup_time_us = 0;
> +			dev_priv->vbt.psr.tp2_tp3_wakeup_time_us = 0;
>  			break;
>  		default:
>  			DRM_DEBUG_KMS("VBT tp2_tp3 wakeup time value %d is outside range[0-3], defaulting to max value 2500us\n",
> -- 
> 2.17.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
