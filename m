Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IIjlLZiiHltiUAAAmS7hNA
	; Mon, 11 Jun 2018 16:26:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AC8E3607A4; Mon, 11 Jun 2018 16:26:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 28F34601C3;
	Mon, 11 Jun 2018 16:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28F34601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbeFKQZ6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:25:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:47868 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeFKQZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:25:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 09:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400";
   d="scan'208";a="66100254"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 11 Jun 2018 09:25:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 11 Jun 2018 19:25:52 +0300
Date: Mon, 11 Jun 2018 19:25:52 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Colin King <colin.king@canonical.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915/guc: remove redundant GEM_BUG_ON
 check
Message-ID: <20180611162552.GY23723@intel.com>
References: <20180611160037.23402-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180611160037.23402-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 05:00:37PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check for level being less than zero is redundant as level
> is an unsigned u32 and hence will never be less than zero.
> Remove this redundant check.
> 
> Detected by CoverityScan, CID#1468363 ("Macro compares unsigned to 0")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/intel_guc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_guc.c b/drivers/gpu/drm/i915/intel_guc.c
> index 116f4ccf1bbd..a2f782a4f97d 100644
> --- a/drivers/gpu/drm/i915/intel_guc.c
> +++ b/drivers/gpu/drm/i915/intel_guc.c
> @@ -208,8 +208,6 @@ static u32 get_log_control_flags(void)
>  	u32 level = i915_modparams.guc_log_level;
>  	u32 flags = 0;
>  
> -	GEM_BUG_ON(level < 0);

i915_modparams.guc_log_level is a signed int. So s/u32/int would seem
like a better fix.

> -
>  	if (!GUC_LOG_LEVEL_IS_ENABLED(level))
>  		flags |= GUC_LOG_DEFAULT_DISABLED;
>  
> -- 
> 2.17.0
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
