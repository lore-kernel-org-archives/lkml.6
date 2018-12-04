Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3732BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC26220672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC26220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeLDRvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:51:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeLDRvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:51:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B554915BE;
        Tue,  4 Dec 2018 09:51:00 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85ED73F59C;
        Tue,  4 Dec 2018 09:51:00 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id E52916801C3; Tue,  4 Dec 2018 17:50:58 +0000 (GMT)
Date:   Tue, 4 Dec 2018 17:50:58 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC AFBC 09/12] drm/arm/malidp:- Writeback framebuffer does not
 support any modifiers
Message-ID: <20181204175058.GQ988@e110455-lin.cambridge.arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-10-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543836703-8491-10-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:32:03AM +0000, Ayan Halder wrote:
> In malidp, the writeback pipeline does not support writing crtc output
> to a framebuffer with modifiers ie the memory writeback content is
> devoid of any compression or tiling, etc.
> So we have added a commit check in memory writeback encoder helper function
> to validate if the framebuffer has any modifier and if so, return EINVAL.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  drivers/gpu/drm/arm/malidp_mw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 0484744..90c964a 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -141,6 +141,11 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *encoder,
>  		return -EINVAL;
>  	}
>  
> +	if (fb->modifier) {
> +		DRM_DEBUG_KMS("Writeback framebuffer does not support modifiers\n");
> +		return -EINVAL;
> +	}
> +
>  	mw_state->format =
>  		malidp_hw_get_format_id(&malidp->dev->hw->map, SE_MEMWRITE,
>  					fb->format->format, !!fb->modifier);
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
