Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EFECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1273C2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="HL41PSwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1273C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJZXYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:24:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45065 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeJZXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:24:20 -0400
Received: by mail-yw1-f68.google.com with SMTP id i185-v6so542886ywa.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmNteBCoamHKPfHPNSPqdrktMJJ4qjx0P6Lg+kXFgfI=;
        b=HL41PSwLYTfRzr3NmosMLbkCSHCK+XVtm+HHdtdcBll0KOXdBH7B27eztyzvJDNNOd
         zBdhAV+thEqg4630jFiWaTVRWvqYO8fmX9gn44+KdVhc78a9xp7oJEUi0XddEDyJ8ZjJ
         9S8vSCK5gefs1t1VZT0oAktveRLd7Soa69yH6NFygTFKXYqjhmeYFRX3r18RJsXDVNnq
         ogeh0/mQXR/PjZ1N20TrDZ/MdSyJN4o2GVFDjw/qPRUOYNFLheeezqpoRWAbB3dDH8Qg
         kSi6RbE+yXjWFBnA+MF7ADvI3gx3U5or10pVX1elh5ZtcdjLrQWx3ejEcUnf2/Sa4cNa
         eRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmNteBCoamHKPfHPNSPqdrktMJJ4qjx0P6Lg+kXFgfI=;
        b=KLrgZsoh+XRkySUNs40kgwceYIf4VhuHGOJFf8Cdt9Wo3tN0XmWaOZr14n0UhM60Oe
         SG6ve02batK576oMdp3H+w5Rd55h50E7aNzcKQWtDV5YplSYN7hXK/8aE/MARmG5DY+4
         smxaQ9hOBxE/bpFQHpjWoOcEsg5WaKXM8d0i7wVmsE13VtYXwm9Eg6Q8SVu8mSvDlB+d
         B46TbpXprvol2HH4/3n3q5iOe1UsicC5WqvPqHl4YLtOM25obW8v8ivUHjLoTN3qRURO
         rzSWK805VL08dBqT6JwfVDdIZ62ckoASV7EOGdg2VUM832AvVRd1K+6zWtF2zJrEnyNm
         myuw==
X-Gm-Message-State: AGRZ1gKfaHds5G1f3gNMI5ZZ4nRswGS6FyIHvUdkuBHTKNL4UtiZjavM
        uZqpbJorAIlCF/ollGKxc4EHPQ==
X-Google-Smtp-Source: AJdET5enY4g5BMhIBHytrY6mNubkHrEF2T9aXnyeF6i+5Cpx17ne0/AnpwNxpe4UqmW92YPqbStT7w==
X-Received: by 2002:a81:a846:: with SMTP id f67-v6mr3727501ywh.495.1540565218842;
        Fri, 26 Oct 2018 07:46:58 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id x3-v6sm2375239ywc.56.2018.10.26.07.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 07:46:58 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:46:57 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: drm/panel: simple: Innolux TV123WAM
 is actually P120ZDG-BF1
Message-ID: <20181026144657.GU154160@art_vandelay>
References: <20181025222134.174583-1-dianders@chromium.org>
 <20181025222134.174583-5-dianders@chromium.org>
 <20181026144356.GS154160@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026144356.GS154160@art_vandelay>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:43:56AM -0400, Sean Paul wrote:
> On Thu, Oct 25, 2018 at 03:21:33PM -0700, Douglas Anderson wrote:
> > As far as I can tell the bindings that were added in commit
> > 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel
> > bindings") weren't actually for Innolux TV123WAM but were actually for
> > Innolux P120ZDG-BF1.
> > 
> > As far as I can tell the Innolux TV123WAM isn't a real panel and but
> > it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> > Let's unmosh.
> > 
> > Here's my evidence:
> > 
> > * Searching for TV123WAM on the Internet turns up a TI panel.  While
> >   it's possible that an Innolux panel has the same model number as the
> >   TI Panel, it seems a little doubtful.  Looking up the datasheet from
> >   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
> > 
> > * As far as I know, the patch adding the Innolux Panel was supposed to
> >   be for the board that's sitting in front of me as I type this
> >   (support for that board is not yet upstream).  On the back of that
> >   panel I see Innolux P120ZDZ-EZ1 rev B1.
> > 
> > * Someone pointed me at a datasheet that's supposed to be for the
> >   panel in front of me (sorry, I can't share the datasheet).  That
> >   datasheet has the string "p120zdg-bf1"
> > 
> > * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
> >   that are 2160x1440.  They don't have datasheets, but the fact that
> >   the resolution matches is a good sign.
> > 
> > While we doing the rename, also mention that no-hpd can be used with
> > this panel.  See the previous patch in this series ("drm/panel:
> > simple: Add "no-hpd" delay for Innolux TV123WAM").
> > 
> > Fixes: 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel bindings")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I didn't see your v2 when I replied to the v1 patch, so for the record,
> 
> Reviewed-by: Sean Paul <sean@poorly.run>
> 
> Also note to whoever applies this to -misc, v1 also had
> 
> Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>

And I just realized that patches 5 & 6 were swapped in v2. So nevermind this,
Doug's v2 tags are correct.

Dear coffee, please kick in soon.

Sean


> 
> 
> Sean
> 
> > Cc: Sandeep Panda <spanda@codeaurora.org>
> > ---
> > 
> > Changes in v2: None
> > 
> >  .../{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt}     | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >  rename Documentation/devicetree/bindings/display/panel/{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt} (70%)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
> > similarity index 70%
> > rename from Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt
> > rename to Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
> > index a9b35265fa13..513f03466aba 100644
> > --- a/Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
> > @@ -1,20 +1,22 @@
> > -Innolux TV123WAM 12.3 inch eDP 2K display panel
> > +Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
> >  
> >  This binding is compatible with the simple-panel binding, which is specified
> >  in simple-panel.txt in this directory.
> >  
> >  Required properties:
> > -- compatible: should be "innolux,tv123wam"
> > +- compatible: should be "innolux,p120zdg-bf1"
> >  - power-supply: regulator to provide the supply voltage
> >  
> >  Optional properties:
> >  - enable-gpios: GPIO pin to enable or disable the panel
> >  - backlight: phandle of the backlight device attached to the panel
> > +- no-hpd: If HPD isn't hooked up; add this property.
> >  
> >  Example:
> >  	panel_edp: panel-edp {
> > -		compatible = "innolux,tv123wam";
> > +		compatible = "innolux,p120zdg-bf1";
> >  		enable-gpios = <&msmgpio 31 GPIO_ACTIVE_LOW>;
> >  		power-supply = <&pm8916_l2>;
> >  		backlight = <&backlight>;
> > +		no-hpd;
> >  	};
> > -- 
> > 2.19.1.568.g152ad8e336-goog
> > 
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS

-- 
Sean Paul, Software Engineer, Google / Chromium OS
