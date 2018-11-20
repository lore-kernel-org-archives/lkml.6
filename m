Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FDBC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E78B204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="esKtd24p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E78B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeKUCwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:52:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35955 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKUCwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:52:31 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so1807087ioh.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goJdZYQ3RgdZt0XFLN5cT/iZ7j6oRCv+YWPzhLPhMnQ=;
        b=esKtd24pR5zpYMaXFCIAFG+St9DsxDS8JWmqZTrRiioeLAge2XsapuzVzSaM/2GZ9w
         +2ZCIhlvumGrGOu+DR38bQWogaaJQLrf6HC9V1L3hS+hxBehZmFmE2HunobFu8YHKCLq
         zKCeBPXPrdk0Rnbv5BFAUKUglFUBL1V4/uFfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goJdZYQ3RgdZt0XFLN5cT/iZ7j6oRCv+YWPzhLPhMnQ=;
        b=PSjAKT2duUMuz/mCAEsabsGsao1MBOunAoYvpYCh3Y0q6YCRBGJWR5sd58Z2wZ1oM2
         YpTmG01zJrhdtmq8YaDzijJhaSlkhuHc4+vJ7MGNdY4pCpvDnyH1kiiyvT2D6ckVKdem
         7bFFu4G+pbmWTIdkCEMPO3h+Z/gWhgasGJWJgO8SXUhVOdagkv56mss7AXV7tt0JBNTF
         gC+2XnBzx4Z/+5dio7vkvMyIOsdEmb/g1Z9MQy6ZGMi932KTCkSZUSIpbWk2YY9J9Nw3
         br+LH6Uj4+IafvTGrcNTFhQxuwWrMI0uw68aox6uPbWsolvTO4+vGtX5WQZyoc+RiSVJ
         iRuw==
X-Gm-Message-State: AA+aEWb928ioY5271mtq9qba/X8zy7bYKAApPgwp6gEu1o7w6bIUbgyO
        cktV3jElJFYHZjuGTdaAj1p7Is3R+VvNNtdLqSvdQA==
X-Google-Smtp-Source: AFSGD/X0scBNc8DCEPs8hc5pVCrxlQyqkuZymWC1TRFZhNmmyZUvofIvVdbjjcxMM38cccA1vImwtS+8qVosL7nLd7s=
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr1920026ioc.114.1542730954857;
 Tue, 20 Nov 2018 08:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com> <20181119083036.riydru5xefao3xte@flea>
 <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com> <20181120154532.mykbbrc3homwf2fi@flea>
In-Reply-To: <20181120154532.mykbbrc3homwf2fi@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 20 Nov 2018 21:52:23 +0530
Message-ID: <CAMty3ZCZtTa=YYxVnqvOHSGxA4vkXf6iinhoKfVN7B6CHFg_xQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 9:15 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Nov 19, 2018 at 04:30:37PM +0530, Jagan Teki wrote:
> > On Mon, Nov 19, 2018 at 2:00 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> > > > Burst mode display timings are different from convectional
> > > > video mode so update the horizontal and vertical timings.
> > > >
> > > > Reference code taken from BSP (from linux-sunxi/
> > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > >
> > > > dsi_hsa  = 0;
> > > > dsi_hbp  = 0;
> > > > dsi_hact = x*dsi_pixel_bits[format]/8;
> > > > dsi_hblk = dsi_hact;
> > > > dsi_hfp  = 0;
> > > > dsi_vblk = 0;
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > How is that matching the code you have in the rest of your patch?
> >
> > +       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> > +               timings.hblk = (mode->hdisplay * Bpp);
> > +       else
> > +               sun6i_dsi_get_timings(dsi, mode, &timings);
> >
> > It's again your request to "keep the couple of function to make more
> > readable"
>
> That function in particular doesn't make it much more readable, but
> more importantly, your commit log doesn't match what you code does.

May be I can update the commit message if the function is OK. for
burst most of the timings are 0 so I used structure with memset to
keep not assigning 0's explicitly. otherwise do you have any
suggestions, please let me know.
