Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2EC2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="H762xqNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2EC2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeLNLFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:05:24 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54798 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:05:24 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so8328668ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cR96VzeuN4rR8v4u6PfTnlPa4PIqhZ3R3Gftq0PxSTQ=;
        b=H762xqNAtiHMFNpm8VTG+35lKhBIV9b7giISjUlCZgdACtPHYJLIKoqC2ZTo7Qk7bj
         w9FqBl3ArCU3cLWBv1PH379abPxOJr4HQ5CO9qYfbxA2uccKEK7iY3Ng72Wku8QLYzEC
         NbJ4n6C8r5OcdAGQxd7EQCK1wVEiR7j++Y6lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cR96VzeuN4rR8v4u6PfTnlPa4PIqhZ3R3Gftq0PxSTQ=;
        b=TUngOprhr3QPAp/+XkqonOvtHe/ReO75lWJCWmDEtw81DAtDmc9zEeOmDBOidXZ2fX
         ma4c2AvLawCDPAfOvpkiX7R2yjKjnncYXsWcx4Zfkq1AAhdPjf6SpUZclkUzSFdci2Zo
         qGWR+kOPngdwSsFeDWoTC8HsqB2ikxBD6fL48Nb1FpV3bTIz+FHW9/IYp0NDf8a2gpmc
         pPV/JlMbYK6pKNugncLB1Ctu2YiHxRwHs7kYp+sSKiU7RI6Fbcl6HG7CN8wJo+pN5mMH
         mh0lQ/8aXW68/T3CEO0Xn0G18s1gCeC2LucS6YB3VX6O6deRN/iy7jy94Xbwh4dx90i+
         DMEQ==
X-Gm-Message-State: AA+aEWZYrrImJbpUQ3fSdU9e1WYZcH+U7RMihNbhHqoV9x0z4hz0p77i
        W2QwG4DcRgoEKRKq+yX0LEi5HFzCsNyzfxnWJGmcaw==
X-Google-Smtp-Source: AFSGD/Wv/fLca5wnq91Ll6scd3pFAXJrzw20BhF5GCBFoMH5xu4QSuDaVblAn+Sj2D0/MvH+kcjF5/fKo9nBubwrjAs=
X-Received: by 2002:a02:104a:: with SMTP id 71mr1975084jay.103.1544785522760;
 Fri, 14 Dec 2018 03:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-12-jagan@amarulasolutions.com> <20181213150736.GL154160@art_vandelay>
 <CAMty3ZAv1dHCRCShXYbxqMm4wV9WGDpAKPji+3G21eWq34ODaA@mail.gmail.com> <20181213194804.GM154160@art_vandelay>
In-Reply-To: <20181213194804.GM154160@art_vandelay>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 14 Dec 2018 16:35:11 +0530
Message-ID: <CAMty3ZCkGudTL9NLnWjTPD8+xqEzY2d0oLN9x=64Hk8MzKTM5g@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Sean Paul <sean@poorly.run>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 1:25 AM Sean Paul <sean@poorly.run> wrote:
>
> On Fri, Dec 14, 2018 at 12:56:03AM +0530, Jagan Teki wrote:
> > On Thu, Dec 13, 2018 at 8:37 PM Sean Paul <sean@poorly.run> wrote:
> > >
> > > On Fri, Nov 16, 2018 at 10:09:15PM +0530, Jagan Teki wrote:
> > > > Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
> > > >
> > > > Add panel driver for it.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  MAINTAINERS                                   |   6 +
> > > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > > >  .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
> > > >  4 files changed, 302 insertions(+)
> > > >  create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > >
>
> /snip
>
> > > > diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> > > > new file mode 100644
> > > > index 000000000000..a4b46bd8fdbe
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
>
> /snip
>
> > > > +static int feiyang_prepare(struct drm_panel *panel)
> > > > +{
> > > > +     struct feiyang *ctx = panel_to_feiyang(panel);
> > > > +     struct mipi_dsi_device *dsi = ctx->dsi;
> > > > +     unsigned int i;
> > > > +     int ret;
> > > > +
> > > > +     ret = regulator_enable(ctx->dvdd);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     msleep(100);
> > >
> > > nit: You should do your best to correlate the sleeps with the timing parameters
> > > from the datasheet with a comment.
> > >
> > > ie:
> > >         /* T1: > 100ms */
> > >         msleep(100);
> >
> > Sorry, what does this mean?
>
> On page 9 of the datasheet you sent me [1], it has the delays required to safely
> power up the panel. This delay is the time between dvdd going high and avdd
> going high. On the figure in the datasheet, this would be T2 (T1 is dvdd rise

time between dvdd going high and avdd going high is T1 + T3 right?

T2 > 0ms
T3 > 20ms

In this case the delay can be msleep(20) ?

> time and should be handled in the regulator subsystem (iirc)). Also according to
> the datasheet, T2 just needs to be > 0, so you don't even need this delay. You
> could replace this with a comment like:
>
>         /* T1 (dvdd rise time) + T2 (dvdd->avdd) > 0 */
>
> So for all of the msleeps below you should get the delays from the datasheet and
> add a comment referencing them.

T5 and T6 are delay between avdd to reset enable it can be 10 + 10
=&gt; 20ms and finally T12 which is 200 after reset.

What about the delay between resets, I need to understand it a bit.
