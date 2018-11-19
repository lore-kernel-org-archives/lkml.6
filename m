Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19ABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF73920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XyPog7HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF73920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeKSVV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:21:58 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55896 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbeKSVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:21:58 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so7526146itg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 02:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWnJ2es7v/q6n5xjHMAW7DryAYiKrsddj0tysly+Byk=;
        b=XyPog7HVq0a5uWgJzQwZmJfREvs3ESmh8Et+DUav4mzPSqZ1Z+wP/SI6SlnvniowwH
         pFvGptUws/YbYnl363yqkXExDdWuoitFYw9VyHuIFCw1dolP9h8Pcm1oaTNUzCEQhYuE
         Y1SYnqpkq1Yk1of3VIe+u3/A1DwfAGy2TKDDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWnJ2es7v/q6n5xjHMAW7DryAYiKrsddj0tysly+Byk=;
        b=JF+4xv+u0jr5/XDyX/0riT4XmVtnKAYxkFOWZrgA9YmhM/SgL72lIWPUu9KpC3GvAc
         L+pDB8qC/OPzBZkTl1121MmRWPjydeHddJLTDozB7cmghZAzfQITG6N1+MhyXDlFtdKA
         i3UgrfEOh3VjndnelIYrTSHFizOGw7hPKnPDSvCZYEmGxNnRFsDG1Os938e3UKLnbaEJ
         9lgZ+uGPYm5zDtA5zyoSOO/A0vwtSHH2AYFeMWPAyziX/8E9jAb+FcoqNQm+Ii4rKWw7
         ceaB2V0aW8Dz/KXkkyD5B4em1UvT3q36dJCLVStY90ZsyBPOQ1hf3dovs9tyb1jDIWGO
         Xnwg==
X-Gm-Message-State: AGRZ1gJ28dqFSaAzjiMY9CaYHJklzV3Rs5I10iD4zA6kXyMCSsNmSaws
        51DO5yZmZI2UdEg7CMSpMIk5efnPA6sUz1wiONt4DA==
X-Google-Smtp-Source: AJdET5drqsNMqWG9QQyuhMU50aYIvirlwZc+bjcTh4HufDtIZcLa7Ku1vs3bCfOYoEVCL0Z8AInFOBoOJuxVpWExAcg=
X-Received: by 2002:a02:94d:: with SMTP id f74-v6mr19878001jad.85.1542625121800;
 Mon, 19 Nov 2018 02:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-2-jagan@amarulasolutions.com> <20181119082707.kbsw2gyntxxbh6no@flea>
In-Reply-To: <20181119082707.kbsw2gyntxxbh6no@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 19 Nov 2018 16:28:29 +0530
Message-ID: <CAMty3ZBDa2wjjCh8NtrbKNYz=mr1xhZKv9JfnmDPDBQRO+CkYw@mail.gmail.com>
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

On Mon, Nov 19, 2018 at 1:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Nov 16, 2018 at 10:09:05PM +0530, Jagan Teki wrote:
> > Loop N1 instruction delay for burst mode lcd panel are
> > computed as per BSP code.
> >
> > Reference code is available in BSP (from linux-sunxi
> > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> >
> > dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> > (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> > => (((mode->htotal - mode->hdisplay) * 150) /
> >      ((mode->clock / 1000) * 8)) - 50;
> >
> > So use the similar computation for loop N1 delay.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> *why* are you doing this? What is it fixing? on which devices?

You mentioned the separate function to compute the delay for all modes
[1], ie what I did. did I missing anything?

[1] https://patchwork.kernel.org/patch/10666599/
