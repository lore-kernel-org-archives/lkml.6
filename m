Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F41FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F552089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="JcKi6OzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F552089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeIZO27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:28:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41012 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:28:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so10447304ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uBGQXOGojHHwKoMRwZdZjiFpvz9OVMQYIma4ZdH920Q=;
        b=JcKi6OzEKF2Pv7pyfSOPtDFYJsCJC3rspcLk3Vy4tZqwfY0DVd2HfFY+93eHSQPKQ3
         MgYkvuCDgrA+f4IYW9WdYqi7X1VQ5yz/lyPXkT/bJDVNfgy4AqtEOv2RArQJBlxqIhyb
         HLGgYUuvfOCdp0fSpoza6h9ty7R4xM/Jl2eM8rfqHfcuABcodM+VSv/RDI/1UIgTZcGR
         YgP8MlRSEA+XW1zYftNoah1/PEJ7UIlaec7nRfQu+H4rhBOjmySSTERu46wJIKFvNXeA
         Kvnww77VK8ygRTSTaUyMsqPQtFayVEUVXMQwTzdo9iS0HZYuFAPbFRo45PAm+h/bEGT4
         OroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uBGQXOGojHHwKoMRwZdZjiFpvz9OVMQYIma4ZdH920Q=;
        b=i+PobjL1Etx61iPqv2fQDu4WogLSfTPlz96pz+hnFw8OGrhZ4vEIiKq9IMG5qua5E5
         K+KzvIgWLryWyVNMITpxLaNUMdZFWAPuCDm8iEy3teWf31ANEc9gpZ+qu741QqbjANaQ
         45wpWCHWt3j44cFMdooyfeotnxbCm8LqxAsgVVGxo9x88VsTCxbnbKnRCPKjMmhK/RYn
         K96TSNQqTcXQ+oQ+chT8xvsuK6R8Q2IELEx++FfQ0+kX1flYEtM6pU/LY9varPBXXwnH
         0KHO8gQtsFkYnhAhfUvp/0qQBJgdswdbTHtKSeaH2y4ZfF1hOThWuUXfB3Oz0gTteNZb
         /WqA==
X-Gm-Message-State: ABuFfoheNd2iPe80Bww6I6jB67HjivmUg8f2HSqV2Nkk/dX3HKz2iFgA
        +RsoUWD0ai/amiygyilHykX2ZA==
X-Google-Smtp-Source: ACcGV63+fi6NQyq5EgWKHFLgwLCoYYRTWMp6ZtaMtBWnzZPyr9lHOx7MND9zdVV8iff1zLS2M7Qc+w==
X-Received: by 2002:a0d:fd45:: with SMTP id n66-v6mr2348319ywf.414.1537949834518;
        Wed, 26 Sep 2018 01:17:14 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id 128-v6sm1717881ywl.60.2018.09.26.01.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 01:17:14 -0700 (PDT)
Date:   Wed, 26 Sep 2018 04:17:13 -0400
From:   Sean Paul <sean@poorly.run>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Sean Paul <sean@poorly.run>, Marek Vasut <marex@denx.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Move mxsfb drm driver to drm-misc tree
Message-ID: <20180926081713.GP72545@art_vandelay>
References: <20180919204026.3217-1-sean@poorly.run>
 <20180919204026.3217-2-sean@poorly.run>
 <072931e0b649c4e3da8d187f3acd3a2e@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072931e0b649c4e3da8d187f3acd3a2e@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:28:31PM +0200, Stefan Agner wrote:
> On 19.09.2018 22:39, Sean Paul wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> > 
> > Another "small driver" moving into drm-misc. Stefan has also offered to
> > co-maintain it.
> > 
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> 
> Marek, I guess Sean needs your ack here.
> 
> Are you fine with this?

I spoke with Marek on IRC before spinning this, so they're aware and approve of
this. Since we haven't had any responses to this or patches on the list, I've
pushed the change to drm-misc. Stefan is going to push the pm_runtime set.

Sean

> 
> --
> Stefan
> 
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ba1dbb8735b8..7184d53dcbd8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9891,9 +9891,12 @@ F:	drivers/media/tuners/mxl5007t.*
> >  
> >  MXSFB DRM DRIVER
> >  M:	Marek Vasut <marex@denx.de>
> > +M:	Stefan Agner <stefan@agner.ch>
> > +L:	dri-devel@lists.freedesktop.org
> >  S:	Supported
> >  F:	drivers/gpu/drm/mxsfb/
> >  F:	Documentation/devicetree/bindings/display/mxsfb.txt
> > +T:	git git://anongit.freedesktop.org/drm/drm-misc
> >  
> >  MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
> >  M:	Chris Lee <christopher.lee@cspi.com>

-- 
Sean Paul, Software Engineer, Google / Chromium OS
