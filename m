Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5711C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F25206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruSpzSdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F25206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeKUCbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:31:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36692 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeKUCbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:31:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so1909401oix.3;
        Tue, 20 Nov 2018 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iI6RXIMRQ3dFyUUWGMSzmCu2tl+r+Is4dIP9GbMdwN8=;
        b=ruSpzSdDqSksVVzdDPZMhBHIyOV1goZnGX4j2+HF500QA/XI+AhkR/fJypWKJZqqYb
         XEI3x95QK+ZVcqiNEgWhtZuT3vqJxqzlscEPXW0nzgB8kRnLQkX9BCM3xmx237/QCvt4
         zgSEx04D/PINIlnHqSC0oSi6HJDjDZ5DsZzSMn77w5jrWqJxR/g2D6XdNj7xljc4ODj0
         AQD99mkr7zDMOsJupdqUSjdmUGuF76me7h35qO4e/1c1hUrC6YTRp7zt8XTC6+C+zMGB
         w93QGmdY1NGkIYyDkFTygrPMQ1YtmKZPxGp76NmcES06xXnMBJgBO3iq4CRJ50gSgyOb
         V7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iI6RXIMRQ3dFyUUWGMSzmCu2tl+r+Is4dIP9GbMdwN8=;
        b=jPxV54NADAAj77Ig1O898bJ+Tt1nVEmXmb7slL44C4oyaV+KmJ4qgdQRLt5tIbwfnF
         prtGl3zJuD/GDT0/2Ihc7KSPDFPiUEXFPnowXylBdN2hJiL9/Kr3eMNxHTPrhF+Ht1jq
         J1SwqARLrK0LPJvufZvClpH1yNZVxw6y2H8EhkcSPwMr2TUkC6/ODZ03JOg8DfBjhhC5
         PYICVjapSLlxFXhhrUcSsFMGPzHhFhq7bEz/NlEOmA+ozEn4zpq4yhnWcKF6kauQMc3V
         8MA4/+9wizDbCLizTk7tua25zIeQZnZ/D2e5FlP5/hD8uxHScJ55VRWGApMo4bhKrcKQ
         ydMA==
X-Gm-Message-State: AGRZ1gJGK8oqbJOC+rwkSSB1wyvrd/SViISjitZB1kiczmDgK+VKXDRg
        QnFRUFcSuForDgJTBSFUZib76yqPhmrazFn1wZI=
X-Google-Smtp-Source: AJdET5er6qZnfWWHToyMY9Qvx5hJfD+suz8dr18xOeXVt7ZaAXUPTT55ysigU8uFSuM760uy8BluW7W5W6s0jxBm7HE=
X-Received: by 2002:aca:c142:: with SMTP id r63mr1446243oif.98.1542729722126;
 Tue, 20 Nov 2018 08:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-2-jagan@amarulasolutions.com> <20181119082707.kbsw2gyntxxbh6no@flea>
 <CAMty3ZBDa2wjjCh8NtrbKNYz=mr1xhZKv9JfnmDPDBQRO+CkYw@mail.gmail.com>
 <20181120132357.xge6gkurjjjvwi2i@flea> <CAMty3ZDex+UQcZdp2nr3Bd=_PVZH-pAU=GBmLL6sdrfA-dZoVQ@mail.gmail.com>
 <20181120155826.j5rja22jnxpkmjrs@flea>
In-Reply-To: <20181120155826.j5rja22jnxpkmjrs@flea>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 20 Nov 2018 08:01:36 -0800
Message-ID: <CA+E=qVc8c4u6yMw0Gtq41_vbV-zy7B8CLV0WadFCqRfSR2LPgQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] drm/sun4i: sun6i_mipi_dsi: Compute burst mode
 loop N1 instruction delay
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        thierry.reding@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 7:59 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Nov 20, 2018 at 07:06:30PM +0530, Jagan Teki wrote:
> > On Tue, Nov 20, 2018 at 6:53 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Nov 19, 2018 at 04:28:29PM +0530, Jagan Teki wrote:
> > > > On Mon, Nov 19, 2018 at 1:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Fri, Nov 16, 2018 at 10:09:05PM +0530, Jagan Teki wrote:
> > > > > > Loop N1 instruction delay for burst mode lcd panel are
> > > > > > computed as per BSP code.
> > > > > >
> > > > > > Reference code is available in BSP (from linux-sunxi
> > > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > >
> > > > > > dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> > > > > > (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> > > > > > => (((mode->htotal - mode->hdisplay) * 150) /
> > > > > >      ((mode->clock / 1000) * 8)) - 50;
> > > > > >
> > > > > > So use the similar computation for loop N1 delay.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > >
> > > > > *why* are you doing this? What is it fixing? on which devices?
> > > >
> > > > You mentioned the separate function to compute the delay for all modes
> > > > [1], ie what I did. did I missing anything?
> > >
> > > You're missing that you are never explaining why that patch is needed
> > > in the first place. Or answering the question I asked a couple of
> > > lines above.
> >
> > OK.
> >
> > The instruction delay varies between video and burst mode. for burst
> > mode panels it is computed based on the panel clock along with
> > horizontal sync+porch timings.
>
> You're still stating a fact. What issue, that you experienced, are you
> trying to solve here?

IIRC that's what BSP driver does. Otherwise panels that use burst mode
just don't work.

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
