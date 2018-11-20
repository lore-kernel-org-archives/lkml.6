Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328CBC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DE206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oI1WhoQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8DE206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeKUAFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:05:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55021 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKUAFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:05:55 -0500
Received: by mail-it1-f195.google.com with SMTP id a205-v6so3304444itd.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huVADLdRz+K/JYsvc899bdEesh4x2ds2+lnd2AKdBVs=;
        b=oI1WhoQmfOz4iCSIyGJa9GrzS6shRXnObas7b1ZqaqxCj4OjGrdpYLUs6Smf9UK7W9
         RWp/g/0QRib1IwaLpaITveHyeO1X+Mo3M33XBAKHcYVuXmNKsGmBDcZVLO2/pPSDhjan
         T8CDkxZndFXGUMPzpjW5OCMX7lz4R8Hwm/Ask=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huVADLdRz+K/JYsvc899bdEesh4x2ds2+lnd2AKdBVs=;
        b=VHdaDy4s36m3pz9u5zk+iIwIoHejMxpLMDjtHsiDwmuyR7kBN+WsfQ3cbE5sPLoBRq
         lv4o2sVAnU152MzdihJD2BbO5S7nXV8JCLCaGdjwHAF6g4YfLhBKrtW8BiIRVhJIQVkH
         9rtPJGY6bx/oL7eSbot7TqwSXAEPPUn6FXyZH/GTKhuM/HUjsWz2rYd+xQeJArabprK4
         KX5l4QQ2eXgWvBc13G+rHVkM8Sk7tAlrBwPb4Ywa0mgQ5Znb675dh8aAZlJdnN14iZ4j
         8FAnVo4gX7btMl80OPf6eADA6tB0MKNhhtsAp8H8xQObRq18V0+Yq5cwYOuMYPUABNdf
         kelg==
X-Gm-Message-State: AGRZ1gLWZvIkSlZC/uWJm3hKiTJH/vav6Y+SU2VDovWiNDO9N2UpIePo
        bKiyiLBwGndsqcTALGz7YSCPC2tq2UoplJ/cN1pgOw==
X-Google-Smtp-Source: AJdET5c/L8ZwiAYeBEGlCu8EgW9eTklbk9vrk9kENmN9HA3XPuViEpe73vej7A8rpR/4PU4GDUf9ZZefGCQF3nSqnTs=
X-Received: by 2002:a24:2710:: with SMTP id g16-v6mr2185376ita.107.1542721002992;
 Tue, 20 Nov 2018 05:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-2-jagan@amarulasolutions.com> <20181119082707.kbsw2gyntxxbh6no@flea>
 <CAMty3ZBDa2wjjCh8NtrbKNYz=mr1xhZKv9JfnmDPDBQRO+CkYw@mail.gmail.com> <20181120132357.xge6gkurjjjvwi2i@flea>
In-Reply-To: <20181120132357.xge6gkurjjjvwi2i@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 20 Nov 2018 19:06:30 +0530
Message-ID: <CAMty3ZDex+UQcZdp2nr3Bd=_PVZH-pAU=GBmLL6sdrfA-dZoVQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] drm/sun4i: sun6i_mipi_dsi: Compute burst mode
 loop N1 instruction delay
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

On Tue, Nov 20, 2018 at 6:53 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Nov 19, 2018 at 04:28:29PM +0530, Jagan Teki wrote:
> > On Mon, Nov 19, 2018 at 1:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Nov 16, 2018 at 10:09:05PM +0530, Jagan Teki wrote:
> > > > Loop N1 instruction delay for burst mode lcd panel are
> > > > computed as per BSP code.
> > > >
> > > > Reference code is available in BSP (from linux-sunxi
> > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > >
> > > > dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> > > > (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> > > > => (((mode->htotal - mode->hdisplay) * 150) /
> > > >      ((mode->clock / 1000) * 8)) - 50;
> > > >
> > > > So use the similar computation for loop N1 delay.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > *why* are you doing this? What is it fixing? on which devices?
> >
> > You mentioned the separate function to compute the delay for all modes
> > [1], ie what I did. did I missing anything?
>
> You're missing that you are never explaining why that patch is needed
> in the first place. Or answering the question I asked a couple of
> lines above.

OK.

The instruction delay varies between video and burst mode. for burst
mode panels it is computed based on the panel clock along with
horizontal sync+porch timings.

Got it, the same I need to update on commit, since you asked about
separate delay route I thought you get the proper details.
