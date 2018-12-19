Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED41C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F48C2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeLSNIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:08:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:18441 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeLSNIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:08:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 05:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="131255378"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2018 05:08:17 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/7] drm: i915: Delete base.id prints
In-Reply-To: <20181218133821.sykwt6wdeo7uf6o7@smtp.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181218133821.sykwt6wdeo7uf6o7@smtp.gmail.com>
Date:   Wed, 19 Dec 2018 15:09:45 +0200
Message-ID: <87tvj9vf1i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Shayenne Moura <shayenneluzmoura@gmail.com> wrote:
> This patch removes base.id prints from drm_display_mode                         
> objects in i915 files. It removes dependency from drm_mode_object.

As said, this could expand on the *why*. With that fixed,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

as well as acked for merging via drm-misc.

>
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 7f455bca528e..61dd7bb3fa85 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -2948,8 +2948,8 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
>  	for (i = 0; i < tabs; i++)
>  		seq_putc(m, '\t');
>  
> -	seq_printf(m, "id %d:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> -		   mode->base.id, mode->name,
> +	seq_printf(m, "name:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> +		   mode->name,
>  		   mode->vrefresh, mode->clock,
>  		   mode->hdisplay, mode->hsync_start,
>  		   mode->hsync_end, mode->htotal,

-- 
Jani Nikula, Intel Open Source Graphics Center
