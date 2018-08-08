Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F022C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3839219F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am/VICEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3839219F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeHHQur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:50:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47037 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeHHQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:50:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id l16-v6so1710345lfc.13;
        Wed, 08 Aug 2018 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9cGw5VhLltx71dinLb+dB0SLiZTfZ0ccbTfNZjHgp0=;
        b=am/VICEbmJZIC7Zvq/a0k3GwC1PqyFA3F2Yknfew5bDGfsXp2Up7cPVSwBYB0pZp6U
         bXszKoBopqbDNdUe/49dM6/A5W68QaTOMht4FHspO1SVWiyvXAMPwnUYhIMHHHWMvEkl
         +AvbjDw+VXk/yccGTSZE1SlBWR9I7z2ErbToKK9fV1++WS5JGmyUqgED0Edk9XiibUb6
         Sl5BS+7FKaXY1ELrp2H7c1j3ClZXjZg3lAd4Mmqyvjaj1a6ul6vs5eXRX+dMYvRwmtEL
         Q1UuETmJC6LSYdbrW3ugEAo3A8uTWGxIGR4iorj51kDGAsrkaISeIg4RagDv/yJZlXNx
         7BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9cGw5VhLltx71dinLb+dB0SLiZTfZ0ccbTfNZjHgp0=;
        b=GPXAsCX//2iJLiFxoHK/Ua36Z2TGuhjFm7yVmzNgNfO6B/040t8lJL1iZXD8ILnKpY
         TcIEJe+5JXzp+OqjGWAKJu8PNxr/t7V1RtUh0qMG5hAoL0kIPsqdvFUiybJF1uPFh9or
         Zi7LN+hJu66xkqymRPB1eS2an6MGnGOnkSJx7+/jGSczJKfo/DEK/M2N/5XGSYHPcn9v
         2Hapn7GIDKGXDx9+KVrDdZiu2frbyJ0i5Qz5W7n8j/jz03dOI0WaB+2Qq/HeZb5Nxhwm
         2/JdT9JR767vZa0O5xtBbzXMlT18JY8Lk4IL1er3/rnDyDFXLFD4hwWBPJSJYJdabUH/
         hLiA==
X-Gm-Message-State: AOUpUlGAaqvq1pQz8d2GUiLa8sylPrAgmbEL1Qx9WNGx48Yd2TyZKCfu
        1/a3oikJOhhS5XMGXgP2uQQ=
X-Google-Smtp-Source: AA+uWPz8zxjQDsD328yO4wJJgsQoHAHhaB3nTW8RBKa5mvVxDhYPoUkXFfRCxqdB+VqKaLK/goUlBw==
X-Received: by 2002:a19:7403:: with SMTP id v3-v6mr616432lfe.97.1533738648696;
        Wed, 08 Aug 2018 07:30:48 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id k68-v6sm849929lfg.22.2018.08.08.07.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 07:30:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] drm: Add generic colorkey properties for display planes
Date:   Wed, 08 Aug 2018 17:30:45 +0300
Message-ID: <2089566.PDTrKWWE8Q@dimapc>
In-Reply-To: <20180808081608.GK30658@n2100.armlinux.org.uk>
References: <20180807172202.1961-1-digetx@gmail.com> <20180807172202.1961-2-digetx@gmail.com> <20180808081608.GK30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 8 August 2018 11:16:09 MSK Russell King - ARM Linux wrote:
> On Tue, Aug 07, 2018 at 08:22:01PM +0300, Dmitry Osipenko wrote:
> > + * Glossary:
> > + *
> > + * Destination plane:
> > + *	Plane to which color keying properties are applied, this planes takes
> > + *	the effect of color keying operation. The effect is determined by a
> > + *	given color keying mode.
> > + *
> > + * Source plane:
> > + *	Pixels of this plane are the source for color key matching operation.
> 
> ...
> 
> > +	/**
> > +	 * @DRM_PLANE_COLORKEY_MODE_TRANSPARENT:
> > +	 *
> > +	 * Destination plane pixels are completely transparent in areas
> > +	 * where pixels of a source plane are matching a given color key
> > +	 * range, in other cases pixels of a destination plane are 
unaffected.
> > +	 * In areas where two or more source planes overlap, the topmost
> > +	 * plane takes precedence.
> > +	 */
> 
> This seems confusing to me.
> 
> What you seem to be saying is that the "destination" plane would be the
> one which is (eg0 the graphic plane, and the "source" plane would be the
> the plane containing (eg) the video.  You seem to be saying that the
> colorkey matches the video and determines whether the pixels in the
> graphic plane are opaque or transparent.

Your example is correct.

With the "plane_mask" property we can specify any plane as the "source" for 
color key, so it can been either a video plane or graphic plane and even both 
at the same time.

> Surely that is the wrong way round - in video overlay, you want to
> colorkey match the contents of the graphic plane to determine which
> pixels from the video plane to overlay.

The "transparent" mode makes the color-matched pixels to become transparent, 
you want the inversion effect and hence that should be called something like a 
"transparent-inverted" mode. Maarten Lankhorst was asking for that mode in his 
comment to v3, I'm leaving for somebody else to add that mode later since 
there is no real use for it on Tegra right now.

So in your case the graphic plane will be the "source" plane (specified via 
the colorkey.plane_mask property), video plane will be the "destination" plane 
(plane to which the colorkey properties are applied) and the colorkey.mode 
will be "transparent-inverted". Pixels of the "source" plane are being matched 
and "destination" plane takes the effect of color keying operation, i.e. the 
color-matched pixels of graphic plane leave the video plane pixels unaffected 
and the unmatched pixels make the video plane pixels transparent.

> If it's the other way around (source is the graphic, destination is the
> video) it makes less sense to use the "source" and "destination" terms,
> I can't see how you could describe a plane that is being overlaid on
> top of another plane as a "destination".

Tegra has a bit annoying limitations in regard to a reduced plane blending 
functionality when color keying is enabled. I found that the best variant to 
work around the limitations is to move the graphic plane on top of the video 
plane and to make the graphic plane to match itself. I.e. the matched pixels 
of graphic plane become transparent and hence poked by video plane.

> I guess the terminology has come from a thought about using a GPU to
> physically do the colorkeying when combining two planes - if the GPU
> were to write to the "destination" plane, then this would be the wrong
> way around.  For starters, taking the above example, the video plane
> may well be smaller than the graphic plane.  If it's the other way
> around, that has other problems, like destroying the colorkey in the
> graphic plane when writing the video plane's contents to it.

It all depends on a use-case scenario. It won't be easy for userspace to 
generalize the usage of color keying, at best the color keying interface could 
be generalized and then userspace may choose the best fitting variant based on 
available HW capabilities.

> So, in summary, I don't think "destination" and "source" are
> particularly good terms to describe the operation, and I think you have
> them swapped in your description of
> "DRM_PLANE_COLORKEY_MODE_TRANSPARENT".

Maybe the DRM_PLANE_COLORKEY_MODE_TRANSPARENT should become 
DRM_PLANE_COLORKEY_MODE_TRANSPARENT_INVERTED? 

Any more opinions?



