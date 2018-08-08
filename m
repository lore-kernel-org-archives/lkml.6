Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB6A216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AC7DJvXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB6A216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHHKfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:35:10 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33954 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RdCHlGPZL4kSLu/ZOMZI2g6RaVKVoGfzQSTNBag2rl0=; b=AC7DJvXdQSO9SVFAhfLyuvgKa
        Da0jQIWH5U6jYyblkKL+gE01F+mHpzI70h08Ir9MMCtOS+0ELkoIT7mz4o/hYlYeWNLfR5Uj/BbLX
        9nPs8o0aWjWYSAWYXYUPBO4LqaiyzrULgP4yBX4wRl74DVBFnCq/Wz9/8Bqd57ZsMhWp0=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:58466)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fnJdh-0003B8-S8; Wed, 08 Aug 2018 09:16:18 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fnJdc-00080k-Cj; Wed, 08 Aug 2018 09:16:13 +0100
Date:   Wed, 8 Aug 2018 09:16:09 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] drm: Add generic colorkey properties for
 display planes
Message-ID: <20180808081608.GK30658@n2100.armlinux.org.uk>
References: <20180807172202.1961-1-digetx@gmail.com>
 <20180807172202.1961-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172202.1961-2-digetx@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:22:01PM +0300, Dmitry Osipenko wrote:
> + * Glossary:
> + *
> + * Destination plane:
> + *	Plane to which color keying properties are applied, this planes takes
> + *	the effect of color keying operation. The effect is determined by a
> + *	given color keying mode.
> + *
> + * Source plane:
> + *	Pixels of this plane are the source for color key matching operation.
...
> +	/**
> +	 * @DRM_PLANE_COLORKEY_MODE_TRANSPARENT:
> +	 *
> +	 * Destination plane pixels are completely transparent in areas
> +	 * where pixels of a source plane are matching a given color key
> +	 * range, in other cases pixels of a destination plane are unaffected.
> +	 * In areas where two or more source planes overlap, the topmost
> +	 * plane takes precedence.
> +	 */

This seems confusing to me.

What you seem to be saying is that the "destination" plane would be the
one which is (eg0 the graphic plane, and the "source" plane would be the
the plane containing (eg) the video.  You seem to be saying that the
colorkey matches the video and determines whether the pixels in the
graphic plane are opaque or transparent.

Surely that is the wrong way round - in video overlay, you want to
colorkey match the contents of the graphic plane to determine which
pixels from the video plane to overlay.

If it's the other way around (source is the graphic, destination is the
video) it makes less sense to use the "source" and "destination" terms,
I can't see how you could describe a plane that is being overlaid on
top of another plane as a "destination".

I guess the terminology has come from a thought about using a GPU to
physically do the colorkeying when combining two planes - if the GPU
were to write to the "destination" plane, then this would be the wrong
way around.  For starters, taking the above example, the video plane
may well be smaller than the graphic plane.  If it's the other way
around, that has other problems, like destroying the colorkey in the
graphic plane when writing the video plane's contents to it.

So, in summary, I don't think "destination" and "source" are
particularly good terms to describe the operation, and I think you have
them swapped in your description of
"DRM_PLANE_COLORKEY_MODE_TRANSPARENT".

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
