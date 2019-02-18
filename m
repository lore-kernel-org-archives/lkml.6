Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628C421736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRy0rm0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbfBRSBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:01:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37549 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbfBRSBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:01:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so14550177edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdhUKM9cypIGog8jEzUXz1e1x2xmD4IZm1X+zR7m2Yw=;
        b=MRy0rm0YCXB2LBAtHyRvqd8D0pIJtueeIH0wI7bbOOmgrPBDR3hY1S9TjBtEZZwxlx
         1dcuESB7JZCUNmWKjpD+yziNxLdIZkL9fzhfoZmH/oOZb4KGbjaXcnMrjM+Kfb/lI/9H
         1Gk46kdbc/Cqcmvfk9bxmIthVjXMQzqEWowzB2/OsPl6hMF4bxN1NbEJ6IyujFH7EUp+
         pE6T4XBjmMXz69e17es7RJAUGJUAm7/nriST6SmLmeZsBthPov5s6mrEvnEohm1Y8LSA
         j4yPxgGbfmcfkthfTZagps09Hs27LB3Xc0RxampKyT1PhsXla+SApucbQ3uRO4Jsd8of
         OOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdhUKM9cypIGog8jEzUXz1e1x2xmD4IZm1X+zR7m2Yw=;
        b=RjUCpIA8NfcZ3hrLsqMuQ8hdE92Wabf54T2S2a0xcbi95reeuuSMFa5SNDsZrwg+9B
         RohaEFkeRl4rc49g6+Fn2jy6cFAJwIrLvgFoZo7nkyLbZDcXF90xihquQDJaXb8uNEy2
         AyTarF3nuCVPEZfraw+Evk4jBM8pP6NqAr3B7JlmWpZUAt4/7/aXxyYeBXuxdxhMwmZT
         SsB127jTyfN4B53CHEHenWqii0NkLWPxj29FDGsbMwLW/flACgg3sBBgD1nF6yalNQvu
         Uqk4x9uHjc/qRRJMGRZUFCpey0pHLfuhx0jzFINhj+dC1hxR5m5HTbDncvEl1yS4iG+G
         WAyw==
X-Gm-Message-State: AHQUAuZAnTTEYGlj2UCtgqlK5X1rd97dpyp+v4NpM0GQ93NWv8t8VdFG
        nlWMwukPyCAyl7+cEe11fO2B8A79hVhPY9N4e04=
X-Google-Smtp-Source: AHgI3IaYAPMjfXDZzvEKkKEWZAP9/ktmoDM+6F0K1y2kI6lgsLWDxaiohgVHA0QwwCwn6t5svkxw8Wymhg/QNHpZeIQ=
X-Received: by 2002:a17:906:6992:: with SMTP id i18mr17318710ejr.74.1550512860542;
 Mon, 18 Feb 2019 10:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20190216100927.10017-1-daniel.baluta@nxp.com> <87pnrp52jl.wl-kuninori.morimoto.gx@renesas.com>
 <87lg2d51lv.wl-kuninori.morimoto.gx@renesas.com> <b4bee8ff1307004ec9d1122f70ab2cb0d636ea4a.camel@nxp.com>
 <s5hpnrp8ret.wl-tiwai@suse.de> <20190218175010.GB10794@sirena.org.uk>
In-Reply-To: <20190218175010.GB10794@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 18 Feb 2019 20:00:48 +0200
Message-ID: <CAEnQRZCLE7DHumOCDSXxaKEgpukDgP5EtH=j7xMwTBJcTWQTZw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: simple-card: Fix refcount underflow
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "vicencb@gmail.com" <vicencb@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 7:50 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Feb 18, 2019 at 08:52:26AM +0100, Takashi Iwai wrote:
> > Daniel Baluta wrote:
>
> > > > Fixes: commit da215354eb55c ("ASoC: simple-card: merge simple-scu-
> > > > card")
>
> > > Thanks! I thought about adding this but the current patch will not
> > > cleanly apply because of:
>
> > > 2d01a84605a55c ("ASoC: simple-card: reduce naming prefix")
>
> That doesn't matter for fixes tags.  However...
>
> > Yeah, it's a bit tricky because of the code change at this time.
>
> > At best, send two patches, once for 5.0 and once for 5.1, and let Mark
> > apply both of them and do the empty merge from 5.0 to 5.1, or let him
> > resolve the merge conflict by applying manually the 5.1 patch.
>
> ...since this is something that needs to be fixed for v5.0 we need a
> patch that can be applied on v5.0 (and has been tested by someone who
> sees the issue there).  Takashi's plan seems like a good way to do that,
> if you could send a patch against my for-5.0 branch (or just Linus'
> tree) that'd be great.

for-5.0 branch Kuninori's patch works fine:

https://patchwork.kernel.org/patch/10814255/

for-5.1 branch and later my patch works fine:

https://patchwork.kernel.org/patch/10817449/

Would you want me to change the patch for 5.0 to have an identical commit
message as the one for 5.1?
