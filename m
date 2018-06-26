Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112FD2683E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112FD2683E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965560AbeFZN2t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:28:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:4117 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965544AbeFZN2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:28:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 06:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="53003094"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 26 Jun 2018 06:28:28 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 26 Jun 2018 16:28:28 +0300
Date:   Tue, 26 Jun 2018 16:28:28 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Stone <daniels@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/gma500: Fix compile warning
Message-ID: <20180626132828.GY20518@intel.com>
References: <20180625123355.GA16757@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180625123355.GA16757@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 07:33:55AM -0500, Gustavo A. R. Silva wrote:
> Fix the following compile warning:
> 
> warning: unused variable ‘psbfb’ [-Wunused-variable]
>   struct psb_framebuffer *psbfb = to_psb_fb(fb);
> 
> Fixes: c7cbed560ce2 ("drm/gma500: Fix Medfield for drm_framebuffer move")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I sent the same patch a few days ago. Instead of hunting for an r-b
I just went ahead and pushed your version. Thanks for the patch.

> ---
>  drivers/gpu/drm/gma500/mdfld_intel_display.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> index 881d613..2b9fa01 100644
> --- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
> +++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> @@ -167,7 +167,6 @@ static int mdfld__intel_pipe_set_base(struct drm_crtc *crtc, int x, int y,
>  	struct drm_psb_private *dev_priv = dev->dev_private;
>  	struct drm_framebuffer *fb = crtc->primary->fb;
>  	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> -	struct psb_framebuffer *psbfb = to_psb_fb(fb);
>  	int pipe = gma_crtc->pipe;
>  	const struct psb_offset *map = &dev_priv->regmap[pipe];
>  	unsigned long start, offset;
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
