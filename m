Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B0DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488DA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EAkHPJsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488DA20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754137AbeFTKKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:10:11 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39088 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753972AbeFTKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:10:08 -0400
Received: by mail-io0-f193.google.com with SMTP id f1-v6so2957340ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eImglvRiF9FnFfZHyh7laSkmOW27GU6cieP26Ftz27o=;
        b=EAkHPJsSNq1Or7pBHbcLmG35m6PRrjaQs0AxZuWjJRmC8MGRMhk2flUgMDnO6hIQbU
         wCiZGui0Nd0lS/y4xdA0kAE+A+L1WstM4ZxkWPlNh1uevCeyca4ngCJbJWy9eq9cbLM/
         RlmLgMAmfroovy3e1SsJVQzwaYBy9qnF2DsfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eImglvRiF9FnFfZHyh7laSkmOW27GU6cieP26Ftz27o=;
        b=bZDkUziN93aOX/L2hrh9hKr9on48fWF8YR3SYVgQIHXS8wmgpjEzMakopgqXkYmZwd
         V0kCMJMbj5a5b1PhZ1Jb3WV83Ne8v3B5Ps6vkRh+TVH6/wl2Jz3ieQV3l/FkiYYpZYhg
         mBJ1yv/ADdJeagw7lPyQ5/UO0bzbslyBWsfWnO65/E7mCBnynLMlosMNFo9z31cA/+gr
         v5aBoCaQz37pmRqPJXZTQ3xDia5cWtLtBvv1M4RlR/A4C+xgUPp9TusMKR62PrsfcmqA
         LGXYcpcTclNuFkjh+n0F8m6vxS8pwGVDLfMNY7pYhMhKTKKH24GMVy+mqZIQtp/A8uwL
         ZClQ==
X-Gm-Message-State: APt69E2sRIAgbHfwQ+kn1PIOMDWNaafXHuOXx8D4BVLIGxQXjUTLTg5F
        oTAjyPOgTTi+PzoE0XTE6t10B7hxaLuqLM+Fft50Kg==
X-Google-Smtp-Source: ADUXVKLTtbqPLns/dfTIVqaeg5TEo7Bo7EBArxyEK8pJwTpnCtoNTwE61jpqOsSlcl/mo1+G0r1cxu2qveXud9KhHqk=
X-Received: by 2002:a6b:30c9:: with SMTP id w192-v6mr17789394iow.291.1529489407671;
 Wed, 20 Jun 2018 03:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e48b:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 03:10:07
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:9802:bb08:74d1:12e1]
In-Reply-To: <20180620093321.GL17671@n2100.armlinux.org.uk>
References: <20180526155623.12610-1-digetx@gmail.com> <20180526155623.12610-2-digetx@gmail.com>
 <20180528131501.GK23723@intel.com> <efba1801-5b00-1fa1-45df-a5d3a2e3d63a@gmail.com>
 <20180529071103.GL23723@intel.com> <20180619174011.GJ17671@n2100.armlinux.org.uk>
 <20180620091750.GD7186@phenom.ffwll.local> <20180620093321.GL17671@n2100.armlinux.org.uk>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 20 Jun 2018 12:10:07 +0200
X-Google-Sender-Auth: paeeMDB2-qB_Mcm1i0wDltspjG8
Message-ID: <CAKMK7uGMKs2GgP+nrxDV4LbbmrqcHApLsz9pTc=mQojHtSVaUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] drm: Add generic colorkey properties
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:33 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jun 20, 2018 at 11:17:50AM +0200, Daniel Vetter wrote:
>> Yes -modesetting (or whichever other driver) would need to set up the
>> properties correctly for Xvideo color keying. Since default assumption for
>> all other (generic) compositors is that planes won't do any color keying
>> in the boot-up state.
>
> Thanks, is that documented anywhere?

With the standardization of properties I'm also trying to get these
expectations better documented, e.g.

https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-properties

But I think we're not doing a good job yet documenting default
expectations. But the above would be a good place to get that fixed -
this patch here should do that, at least for color keying.
-Daniel

>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
