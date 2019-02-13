Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC5DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9D821901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550050292;
	bh=hROEDQG8ARxsbwstQQkJX9EsHFv+SGQlprvkeYTaWyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y+Cx4I90Zwn+Y4A/3k8dvjrcKvxQIR7oaPgf1KFING4RArqBZRIt8/+/1y3e1u14v
	 k8CNIhNVcjSg7bGTgChUIMcdUPNlw7sVpwwAyuJNCzQpKcODs9BNxrTgG702YdCO7d
	 W0sbLkTbCv/4njefzQrWzKzpXLLOP2XQrDtIhCXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfBMJbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:31:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46065 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfBMJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:31:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id h10so1005472lfc.12;
        Wed, 13 Feb 2019 01:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+iFjGEOpJX/4J59kOCjMN5B4RIy1M2e/xU0fsMpcDg=;
        b=eRvHOkP7a6/6hT06OjQcY1qrmsDYhhYO4BUQjJ8TUAzVLDemf2WE+G/E0Rb1pZoQCL
         OI+NNM5jgu0QLohoplmHXJAN8EVJ1wWf0x9iRGQtFBFbGK/XnOZ2lOeooP4JiaIkBAE+
         YILBTbv11iiQx6ETCLQ0umr9Bev8fChbFLnC9D+nsvfjK1i0+/dxju152W0lY71DcLsp
         poEd2A/r21Uj4CRaAqG5ZN+sNINBXy3gf8VAS3VR/B/C7I/LjMmt8UsE0CVxrYk0Sjm+
         T48EYV2QBFek01IdeCTtCBCl1skNRMRiDiX+GFBKkT6iQmecA17+kxpsNI+dCBm5X6yo
         LTsA==
X-Gm-Message-State: AHQUAuangEK/nxm1l6OTEHwkPHKpzpTnaYBvsolH/PvGYIbiuZyYWwQj
        6OgzR4a1u9SC8cub5AbOwYw=
X-Google-Smtp-Source: AHgI3IYdDfwOBMB6kntmuxcjS1c3Mj/Iga23L5r99s7UHsstnAmeyLNY/KB0Fe+7KlwsYdOt+2cTWA==
X-Received: by 2002:ac2:53b7:: with SMTP id j23mr5078139lfh.109.1550050288363;
        Wed, 13 Feb 2019 01:31:28 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z2-v6sm3326542ljk.50.2019.02.13.01.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 01:31:27 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtqsz-0007i1-3y; Wed, 13 Feb 2019 10:31:21 +0100
Date:   Wed, 13 Feb 2019 10:31:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190213093121.GG28278@localhost>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
 <20190130155016.GA26536@bogus>
 <20190211092251.GV4686@localhost>
 <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJPhuDDsEMvpVizewTuehOZTc84d+8Hq7o8C+O4UrBjYw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:18:46PM -0600, Rob Herring wrote:
> On Mon, Feb 11, 2019 at 3:23 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> > > On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> > > > Add binding for Mediatek-based GNSS receivers.
> > > >
> > > > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

> > > > +- gtop,fix-gpios   : GPIO used to determine device position fix state
> > > > +                     (pin name: FIX, 3D_FIX)
> >
> > I'm thinking we might need a standard name for fix-gpios as well. This
> > isn't a feature that is globaltop (or mediatek) specific, and other
> > manufacturers provide similar functionality through pins named UI_FIX,
> > or even LCKIND (lock indicator).
> >
> > The pin is typically used to drive an indicator LED AFAIU, but the
> > characteristics of the signal varies from device to device (fw to fw),
> > for example, pulse when no lock and low otherwise, or pulse when a 2d or
> > 3d-fix is acquired, etc.
> >
> > I'm not sure how useful the pulsing would be for software, but someone
> > might find a use for it in some form.
> >
> > Rob, is this something we want to keep in the binding, and if so, how
> > about using a generic name such as "gnss-fix-gpios"?
> 
> Sure. As long as details like being a pulse and when the pulse occurs
> are implied by compatible string. So we don't get an endless addition
> of properties to describe those.

Agreed, thanks.

Johan
