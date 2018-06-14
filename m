Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 626F3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192B4208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pR4lKoIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192B4208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbeFNHMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:12:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40243 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754674AbeFNHMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:12:42 -0400
Received: by mail-io0-f195.google.com with SMTP id g22-v6so6132489iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GpF4fYi88ZP3aXRc6rjr85Ee9bH67mLxvIRPPlX3D98=;
        b=pR4lKoIUMKqAEYHkqTmY9hMis1jHNtxbQ79tGD0tZo3n+WrvEZd319JmOngwwHTgKG
         HRLLT3xUejZ1FplVFLxyP207sE2tI+dOft7MZpe57yrsVRF/Lm/PbwU8FAMoEOfUIT/w
         5Fa/k7vMRGDkTWCr8Lurz/Id9lpzKAOvFMLSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GpF4fYi88ZP3aXRc6rjr85Ee9bH67mLxvIRPPlX3D98=;
        b=MIkS06XydhQ7TLpI+jcAsrWKoev4n+CVd/z50vstbxZONft9alOd/HCJ4FuLWfunRw
         exGnODH/yk0MujtrGuQjJx/EaM1rjpI+IazVpKmrgtJ79usyhMVeBz4TS0iDCZkNRFhu
         kOvDDMJdh1Q/LJ27b+jnfA5P8PT14OrNnzovjgjn7fh73Nfyt/5IWUUoirW+5Y4/G9mD
         juL1IssPzSeNXmpbsriIIMzC+zU1DOuyuHzWl8WnUM+HKsxbw5L3dA47TWVxHJBukvc4
         XpCTW0zSMuoFhd0JGvNzjx/iapjoZpzthbmme9iwoa8fQVicSopSo1FxaGXYzUc7AIp4
         ZfOg==
X-Gm-Message-State: APt69E24ssPNezBGSUP7/RSMIns9I87sRF2JxNWbOA9/P9oldhPcGQTQ
        IDQF4cvwdmZqIOxygcDKmGactcUzuFA+dc6LKAydVA==
X-Google-Smtp-Source: ADUXVKLk19HQP3WYTCW+jIBl4UAS+AuR+a+Ijm2Xah1UAVVFgrx5AZc8J17UAwPhjZ6JTc/JlrblnZaM/rAzC41v+T0=
X-Received: by 2002:a6b:91c5:: with SMTP id t188-v6mr1246201iod.114.1528960361643;
 Thu, 14 Jun 2018 00:12:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:89ca:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:12:41
 -0700 (PDT)
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 14 Jun 2018 12:42:41 +0530
Message-ID: <CAMty3ZC-Edg5XJQpqEuwLbSFzmam3zP3zUPak4K7ypyT2+arAg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 00/27] Add support for R40 HDMI pipeline
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 1:30 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> This series adds support for R40 HDMI pipeline. It is a bit special
> than other already supported pipelines because it has additional unit
> called TCON TOP responsible for relationship configuration between
> mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> and TV TCONs, TV encoder clock settings and pin muxing between LCD
> and TV encoders.
>
> However, it seems that TCON TOP will become a norm, since newer
> Allwinner SoCs like H6 also have this unit.
>
> I tested different possible configurations:
> - mixer0 <> TCON-TV0 <> HDMI
> - mixer0 <> TCON-TV1 <> HDMI
> - mixer1 <> TCON-TV0 <> HDMI
> - mixer1 <> TCON-TV1 <> HDMI
>
> Please review.
>
> Best regards,
> Jernej
>
> Changes from v1:
> - Split DT bindings patch and updated description
> - Split HDMI PHY patch
> - Move header file from TCON TOP patch to dt bindings patch
> - Added Rob reviewed-by tag
> - Used clk_hw_register_gate() instead of custom gate registration code
> - Reworked TCON TOP to be part of of-graph. Because of that, a lot of
>   new patches were added.
> - Droped mixer index quirk patch
> - Reworked TCON support for TCON TOP
> - Updated commit messages
>
> Jernej Skrabec (27):
>   clk: sunxi-ng: r40: Add minimal rate for video PLLs
>   clk: sunxi-ng: r40: Allow setting parent rate to display related
>     clocks
>   clk: sunxi-ng: r40: Export video PLLs
>   dt-bindings: display: sunxi-drm: Add TCON TOP description
>   drm/sun4i: Add TCON TOP driver
>   drm/sun4i: Fix releasing node when enumerating enpoints
>   drm/sun4i: Split out code for enumerating endpoints in output port
>   drm/sun4i: Add support for traversing graph with TCON TOP
>   drm/sun4i: Don't skip TCONs if they don't have channel 0
>   dt-bindings: display: sun4i-drm: Add R40 TV TCON description
>   drm/sun4i: tcon: Add support for tcon-top gate
>   drm/sun4i: tcon: Generalize engine search algorithm
>   drm/sun4i: Don't check for LVDS and RGB when TCON has only ch1
>   drm/sun4i: Don't check for panel or bridge on TV TCONs
>   drm/sun4i: Add support for R40 TV TCON
>   dt-bindings: display: sun4i-drm: Add R40 mixer compatibles
>   drm/sun4i: Add support for R40 mixers
>   dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY
>   drm/sun4i: Enable DW HDMI PHY clock
>   drm/sun4i: Don't change clock bits in DW HDMI PHY driver
>   drm/sun4i: DW HDMI PHY: Add support for second PLL
>   drm/sun4i: Add support for second clock parent to DW HDMI PHY clk
>     driver
>   drm/sun4i: Add support for A64 HDMI PHY
>   drm: of: Export drm_crtc_port_mask()
>   drm/sun4i: DW HDMI: Expand algorithm for possible crtcs
>   ARM: dts: sun8i: r40: Add HDMI pipeline
>   ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra

Tested whole series on top of linux-next.

Tested-by: Jagan Teki <jagan@amarulasolutions.com>
