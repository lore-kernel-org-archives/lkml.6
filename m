Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A03C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A8C21907
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JNQuNJqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbeLTU4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:56:30 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37639 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389683AbeLTU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:56:24 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so3737121iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efF2qmFwsJ1axs0m1B4BUuW+RUh8a4wq2pjaccVYe9c=;
        b=JNQuNJqZv35yGcoTQlpjyNDO1LK/icLfT60oa8Oe1zdECcpIoOi/jLh7f+N+AXGbr4
         b6Yp3533F2UND8fzsMoBSLPV3qQcXdZ8jBlLxTJ7daT78hXkveFq6xwdbd2Mugz8vO5e
         tfkhEYtNZnFFapSAFdmYjwAin4vKTOu2ST8Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efF2qmFwsJ1axs0m1B4BUuW+RUh8a4wq2pjaccVYe9c=;
        b=p9hseObV+lU+hS2+3AWumJx2bs3RXFAmXvnJSh2h9E7EltOH8fzNeGBzipg590InjG
         QEijyouVvk9RE73ug1lpSLKXZdmcjHWOx6lQ9iQTO8YTmrt9YmWEmweodcdgnSOevvhB
         4HUx5np/avXJjUeH3xxeE18vsRT15fHhvzSgVrZ386L6x5RHpEy10+wndVMiZxtavL8H
         s1DlXUblxbfqpeh90HzkMLiDMsztR3DpS2vgW3QAJIAZXQRAZcBCpB+8FzRsDyU8WRsv
         X+URQ2k02deZU0xxBS4oT2ejFY+SQpkCAt21nEdOHBWF8kzUVZFIGvovTW0xYNr/edCQ
         Xbaw==
X-Gm-Message-State: AA+aEWYQrC0t40Wn/LPa+eaqc0OLvoIo3zmgovpOmhtP9iW07rt01/+O
        aU9F1TTNC0naSB4mOfCSRzJ0xPhn3+evbTVV1EYaGclr0zzDoA==
X-Google-Smtp-Source: ALg8bN6rfXd4idarU47KMo5Mow2yJjrhhdUXYqRqjjZX8AY37yXXMGazvLIMeKxtXulHnZixSS1jALfRLmJ1Sme/Y88=
X-Received: by 2002:a24:5411:: with SMTP id t17mr207706ita.32.1545339383319;
 Thu, 20 Dec 2018 12:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com> <20181211164900.wfmkmbrbj3nmlb3h@flea>
In-Reply-To: <20181211164900.wfmkmbrbj3nmlb3h@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 21 Dec 2018 02:26:11 +0530
Message-ID: <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > Video start delay can be computed by subtracting total vertical
> > timing with front porch timing and with adding 1 delay line for TCON.
> >
> > BSP code form BPI-M64-bsp is computing video start delay as
> > (from linux-sunxi/
> > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> >
> > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> >    - panel->lcd_y - (panel->lcd_vbp)
> > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> >                            - panel->lcd_y - panel->lcd_vbp
> > => timmings->ver_front_porch
> >
> > So, update the start delay computation accordingly.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Even though it's a bit better now on my A33 board and I don't have the
> white stripes on the bottom of the display, there's still some
> flickering with your patches applied.
>
> Bisecting it seems to point at that patch, but reverting it doesn't
> make the issue go away, so it's not really clear which one exactly is
> at fault.

Is reverting this patch, work fine or not?

This patch is trying to make use of front porch instead of existing
back porch to compute the delay. Since we revert the VBP fix patch[1]
to assume VBP as VFP value look like your setup would also require to
revert this change. But as per BSP or drm_mode details all of my
displays even work with and w/o reverting these two.

I'm thinking your display should work in the same behavior since the
dsi controller making this route.

[1] https://patchwork.kernel.org/patch/10680309/
