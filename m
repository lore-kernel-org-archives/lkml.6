Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E82C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1820836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ua9dCtse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeFTMUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:20:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44407 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFTMUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:20:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id p23-v6so4614108lfh.11;
        Wed, 20 Jun 2018 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VNfEmlr8gw404MskQ/ykKdZEdT2E2YqzsyHRLVizSFk=;
        b=ua9dCtseo+3GSUTvLOEwgqSd17XJeCj1Wf1htItlYn70OGPFezobio6ePmyLi61MpC
         t/rgW1A12QDvgb8ZAE+wKeurx6T31DmQmJ1iRzfFfksxMH3vmc3bElgK80H3+3K4QjI3
         rCPX6lN/Y9iWagx5FGe6SObSCw8awNF74jSZZrU3XomtHmaF8slV5beGG31EmKttLPW2
         mCqbS6MC/XPiPHD+P2PTi1k3RNsoMMvJAwoo+Axs9JAAo7Oe+SUBKiZQPtnB+0eK1ivc
         yobAqCm1aCmw8FzcQD2Z6NiqbPyn25iPZCh+xxvfnFhYOJvEv2NSwDPZQqWTWy5aXK/E
         GoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNfEmlr8gw404MskQ/ykKdZEdT2E2YqzsyHRLVizSFk=;
        b=PieAnoBLl5jos5L+0BVNW9PxncraROq8IC2fePuX5TDsA7vPChIifZI/NZHN/W/g2v
         RLUZZ7EtyI1YRHJAkK/gpjtMzdh62mIP042FeWWKKvKffB6eC1zzI6eYM0YsmtpfSLEx
         78awl+p00oBLj9z5fYpy6WB9tehtFFN2CZQwxGrtL4sFdDweTLXxkOu01qoM3pDKJXNC
         6qSq/OyJkIfXbCafekjDwPUX0wX5XbWayshxl4h+wmvxSm4xZrLIQG6RYQ/jKhJXGQYr
         lc4Y0YNvkrT7tRMIFXGiaVclsEoz5NDBBh6Rwc6BFbj/resYddDaCDkJbvoWjaIhMh4o
         dvgQ==
X-Gm-Message-State: APt69E1G4flQcE/q6FGrzSp1QQKOd+DETcq9Mp+Vwyvh1d9qsQVPpmQC
        41sLgqA67qd1um0eagfdyJROgNQ8
X-Google-Smtp-Source: ADUXVKJ/rEZRNudVPtwo+L0PO2d9LX9uC6FPEEDfL/5X7UCB8enPe6HcUZl+ZiCptXCVMl184ZS3eQ==
X-Received: by 2002:a2e:5453:: with SMTP id y19-v6mr13116945ljd.11.1529497229341;
        Wed, 20 Jun 2018 05:20:29 -0700 (PDT)
Received: from dimapc.localnet ([109.252.91.84])
        by smtp.gmail.com with ESMTPSA id y82-v6sm392291lfd.81.2018.06.20.05.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 05:20:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] drm: Add generic colorkey properties
Date:   Wed, 20 Jun 2018 15:20:26 +0300
Message-ID: <16624973.kIn7evqk0T@dimapc>
In-Reply-To: <20180619174011.GJ17671@n2100.armlinux.org.uk>
References: <20180526155623.12610-1-digetx@gmail.com> <20180529071103.GL23723@intel.com> <20180619174011.GJ17671@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 19 June 2018 20:40:12 MSK Russell King - ARM Linux wrote:
> On Tue, May 29, 2018 at 10:11:03AM +0300, Ville Syrj=E4l=E4 wrote:
> > On Tue, May 29, 2018 at 02:48:22AM +0300, Dmitry Osipenko wrote:
> > > Though maybe "color components replacement" and "replacement with a
> > > complete transparency" could be factored out into a specific color
> > > keying modes.>=20
> > Yes. I've never seen those in any hardware. In fact I'm wondering where
> > is the userspace for all these complex modes? Ie. should we even bother
> > with them at this time?
>=20
> Such hardware does exist - here's what Armada 510 supports (and is
> supported via armada-drm):

It shouldn't be a problem to extend the list of common color keying modes w=
ith=20
a mode that is supported only by a particular HW. The only requirement for=
=20
adding a new mode is that this mode must be utilized by opensource userspac=
e=20
software.


