Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73511C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF7F208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kj9ZttUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF7F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeKUCtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:49:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38293 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeKUCtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:49:53 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so4385550ith.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIcMlO7uz+W0h9L7KRQcroQP6P30CmSof6JAhzvLurk=;
        b=kj9ZttUiL/qU9oDcv4Tn2RxDuGiPqrOI8/9ZrR/T2tilLctYxMorKdr2P1sWEo+oI/
         4wc95GQWpRqd/0FaZUKT3xzbtri1fdt1KQNO0RlF3lYq4RzE3jECLUVPKv97CXRf6QAz
         e1p7JtLYmr1JRUhH3Cs14Up5MMseS/3HkQjLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIcMlO7uz+W0h9L7KRQcroQP6P30CmSof6JAhzvLurk=;
        b=Q3msD5c54LQfvwNfWi4YUN2FPIChumjLevgpPWbKvdHjFdpkbO6+iWzty9/rPqWuA7
         q0rVZrc3eS68X4N19z9pF/pEq+uTz3CA++h4DcETeOuQ5Eut09MGp8juYt+Djiwgioa1
         hIGgrHXgrIBUuZxVVuW3Nt/oj1RTenJFaBj2bGjv9YVqqkbMgTSHD7BU89tUOyRBGXCW
         +bLwjEJ/59hH8HXjgznDMgspLOpp+S5zO+Ru834c/0bB+WOn6aH5qxKrJM4wdTje5pZ9
         DZ3fzCWIF9K8WFcaM3BpWUAXQ7TVILWTiXi1LRq7zSGaACrWtstaFvLebVcVRp/Iws+D
         Kg7A==
X-Gm-Message-State: AGRZ1gIcs78YwRlDc/ZUSznVNBL5GNdF9coMUJG4KWtir/3ZHmY8oQSq
        sORev97dStnlZy/rOIMX+KYd9WSY+2LxtwZg9lJB3A==
X-Google-Smtp-Source: AJdET5dO8oJmNfDKNe5zSSdFUxLrRvmEo5CpSJcGnf6jpf6RV+ap/2zPfXplBqnxRmNeOypHGRm4ZtRbOuoYhlHl3RQ=
X-Received: by 2002:a02:94d:: with SMTP id f74-v6mr2398608jad.85.1542730797107;
 Tue, 20 Nov 2018 08:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-2-jagan@amarulasolutions.com> <20181119082707.kbsw2gyntxxbh6no@flea>
 <CAMty3ZBDa2wjjCh8NtrbKNYz=mr1xhZKv9JfnmDPDBQRO+CkYw@mail.gmail.com>
 <20181120132357.xge6gkurjjjvwi2i@flea> <CAMty3ZDex+UQcZdp2nr3Bd=_PVZH-pAU=GBmLL6sdrfA-dZoVQ@mail.gmail.com>
 <20181120155826.j5rja22jnxpkmjrs@flea>
In-Reply-To: <20181120155826.j5rja22jnxpkmjrs@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 20 Nov 2018 21:49:45 +0530
Message-ID: <CAMty3ZDnMwtd1Q3ab518=PsCo2FGCjuvqV2t5SQE=F-6AejCcA@mail.gmail.com>
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

On Tue, Nov 20, 2018 at 9:29 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
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

This change is specific for burst mode instruction delay. for
non-burst it is 50 - 1 and for burst mode it is computed as mentioned
in commit message. Both things are available in BSP code. and without
this burst mode panels not working with existing (50 - 1)
