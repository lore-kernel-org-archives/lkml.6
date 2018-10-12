Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3163BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50452086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50452086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeJLRfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:35:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44290 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJLRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:35:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so10950409edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 03:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LimTocGO5sVT2/+vmJHXJCtOqCYpqt3ojHzj32GViWw=;
        b=q1xEcz/UzyGBIX71OOK8lLwPps+R+MxeA2zmpyn6uaoEVxL1Iv962bvLjfmz1DWAXM
         BSiRgJBSbfene9q2/r5cJT6d8uV0rjHqAwMmaPLY3GtGvqToU3Q7buCQ25NqAWb8X1ng
         HQVEbj+cU7JUHyt+gSwvz8xzwO7lOy2pylOoFwrqhBFWNmvlZiUu4NpTWW2Wjp5XorvS
         5qHGoQ1t1OrlhYi3emmnUBQ92pLpTs585/0QqILsT0Zr+u3w9P0+SsXaA9aJeSzxODI8
         2ltthl6V6zJprSKFI/AGOkYrPtEr7WIvl2jDx0/nG0b6THXp/Aze8tzDTLaI3QtneJ5i
         xbTw==
X-Gm-Message-State: ABuFfojUeagyDSAOidY4n4YiyO6/O2njQIVf1hPiomN9fZLyVXFlTlS8
        K3t/hMUucYU3vgx1+Byrln8bBQtsDxI=
X-Google-Smtp-Source: ACcGV60dx1lYdsguxtPgcqXro4XQWfnQETZ+4DsO2ZkVOBBx0AeotoWi23p8SsTBlVKFJESo6lBUgg==
X-Received: by 2002:a50:852b:: with SMTP id 40-v6mr7789623edr.177.1539338636844;
        Fri, 12 Oct 2018 03:03:56 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id r55-v6sm561121edd.80.2018.10.12.03.03.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 03:03:56 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 193-v6so12304996wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 03:03:56 -0700 (PDT)
X-Received: by 2002:a1c:e717:: with SMTP id e23-v6mr4700629wmh.145.1539338635750;
 Fri, 12 Oct 2018 03:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181004195605.txvbkshvxklyzxyb@flea> <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
 <20181005215951.99003-2-giulio.benetti@micronovasrl.com> <20181008092111.qcufr4o7cy3nnj4b@flea>
In-Reply-To: <20181008092111.qcufr4o7cy3nnj4b@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 12 Oct 2018 18:03:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v66FVixU-Ax=KkH5J-ivQ146RUK2DWDwBqDRYqHtpOod9w@mail.gmail.com>
Message-ID: <CAGb2v66FVixU-Ax=KkH5J-ivQ146RUK2DWDwBqDRYqHtpOod9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:21 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> > If tcon->panel pointer is NULL, trying to dereference from it
> > (i.e. tcon->panel->connector) will cause a null pointer dereference.
> >
> > Add tcon->panel null pointer check before calling
> > sun4i_tcon0_mode_set_dithering().
> >
> > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
> >                       RGB565/RGB666 LCD panels")
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied both, thanks!

I think this one could have been applied to drm-misc-next-fixes,
as the bug was only recently introduced.

We'll have to make sure it gets backported somehow.

ChenYu
