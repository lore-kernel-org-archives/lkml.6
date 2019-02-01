Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFF521726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d0Rqitjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfBAPv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:51:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37127 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfBAPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:51:55 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so10402370iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QFjyQzPSYzw+9+y4qZ/LyQWmOtJ5IEIvYW5d38ofMs=;
        b=d0RqitjpPh0bfgADVQiUErX7Oq0fAVi7hGNyJginAoNMR5mUyrf68ASSNQN7udEOib
         18vCmO/si2kLX3HGaP2XijLSJqdQ1pQgDLrgZdme0pTfQK7zQ60IJ2FzUDEr/voEEOzC
         E/HGtJelMdNvHlcqBENqfoRogdUp9lQzIKh3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QFjyQzPSYzw+9+y4qZ/LyQWmOtJ5IEIvYW5d38ofMs=;
        b=k52/4cVuljxqW8gNL7iZLjtDKa2QHwsKmG5BPJUb9oJBeAYTykKxcgSOc04ap5cyr8
         77L8R2SZAaTLQmmZFKlTw2uMlYTLn7i55mgDaoqxi07efBC1J1fRFRn01ZzukcICpU9W
         8V/lpSBZvZkQVGCsuQ3HrjGElevu3ElmjzSkRZDYy0xc0Ba0IyUPCfyx0Cnkev6krjTY
         ek9eOLOrTFpBNrtC4wylbS2CYdTPgnd7sYj0GcQ+IbCf23mSJlqVRRcHhBhEOSJWPxxu
         tPsPSn/5SQbY7awkpoqwOYhh37XLCxKikdRkE6SsbQ0SPIKodzWHdjyqp1jOIPG6icMm
         givw==
X-Gm-Message-State: AHQUAuag5D0BM3lzR1UyQ487UPy/wbQ8Zl5Y89YbGJcxNVM+cq8S3rrL
        vxerctVJ5UtTj0aZeqrX/aLDtiwvb4VVUg6Fwj1Fsw==
X-Google-Smtp-Source: AHgI3Iax7m0R3CTnvGhVwQ5NsgaAl+q8ict/I+2M4JaBHhb2jqQQ/mfTJSZi2Vq4cox+x8pAU/3DB/2MXwmBw3pKong=
X-Received: by 2002:a24:385:: with SMTP id e127mr1748296ite.32.1549036314638;
 Fri, 01 Feb 2019 07:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20190201154232.10505-1-jagan@amarulasolutions.com> <20190201154858.z6xqdaxccxya2wqr@flea>
In-Reply-To: <20190201154858.z6xqdaxccxya2wqr@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 1 Feb 2019 21:21:43 +0530
Message-ID: <CAMty3ZABvrb+Eu8D7uiGvBALRetnphsRg-RennRSNH5-_q-9bw@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 9:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Feb 01, 2019 at 09:12:09PM +0530, Jagan Teki wrote:
> > Here is next version changes for Allwinner A64 MIPI-DSI support
> >
> > This series grouped the changes like previous version[1] with different
> > sets to support three different panels types that can fit into the DSI
> > controller.
> >
> > set:1, for 4-lane, burst mode support
> > - patch 0001: 0009, DSI controller changes that support burst mode.
> >
> > set:2, for A64 DSI support
> > - patch 0010: tcon dclk divider computation based on A64 BSP.
> > - patch 0011: 0017, Allwinner A64 DSI controller changes.
> >
> > set:3, enable 4-lane burst mode panel:
> > - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
> >   burst mode panel on Pine64-LTS
> >
> > set:4, enable 4-lane video mode panel:
> > - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> > - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211
> >   panel on Bananapi M64
> >
> > set:5, enable 2-lane video mode panel:
> > - patch 0021, 0022: DSI hfp and hbp timings fixes
> > - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic
>
> You do realise that pushing through a series while the previous
> version's discussion hasn't settled yet will not get you anywhere,
> right?

Except the clock, I made few changes with your previous comments. Yes
we can still under clock discussion page, no issues on that. just to
group the remaining patches to finalize if any issues on those.
