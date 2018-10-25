Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E45C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4012083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QB78xZ2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4012083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJZAZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:25:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47024 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeJZAZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:25:05 -0400
Received: by mail-io1-f67.google.com with SMTP id y22-v6so5777317ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNmH501pJq1L03TsrJKzjfnFGZDsR7D9AJlY6ypvFOY=;
        b=QB78xZ2jZIwNX941jFVipaYSs4p95eF2ZXnQi/KyoFfO9ldUmoOjJHyTwUmtoIMXNY
         R09cgr2I0C5eXF0Cl6KK7ev0sIw793k1sIPQ3HeHY12njC/gHbIBAm/eN0zvtSh2WO1h
         WDttybFuFXvA86/guu5Ug/YMfZ0TtIcVrrIO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNmH501pJq1L03TsrJKzjfnFGZDsR7D9AJlY6ypvFOY=;
        b=OJxdn3t50fec/mUxEFs1cPbpzYn+R6BbpHaRyUEx8Y3Xtbq8wYYAx75XlxO4G5vqG9
         TBs5PZo39dU7VnvJPHuu2H3ToBHkBT5RQsytAsFEo0mXNfFG3IzRdRy312B03s1nYqZr
         Y4Qs9Igxueo1r2Jw/FUj4ocSfNO21uX5Nj13NthgxanWUYYUvrJdzviAiIW0m0YoWheX
         GgHgmsqEndhdRjPkrcS9UHGSWcljDOcbvwfFaDsg8/Rs5DAPHGRZmENVuyuRjAfTJVn2
         SEG7q3++FhCcee//wWYVkzb4n8FyA2VHKqqyyrNTmdbdzNqU41C+SR9o8IfUp0R/3cDo
         xaIQ==
X-Gm-Message-State: AGRZ1gKRnmULPtHRuS8jR6fi2RwWlj4zo8PIY5EnEGEOVjyc/SCJHyqK
        jczNkSHQVrOwuntUL4rx6Tc8Y+pU8iaCFE/6Gl8pkg==
X-Google-Smtp-Source: AJdET5eAx1uIy0TMAVygYVHRGVT4I0bhge06fCM87pUSXAEDFGsdMkXgYnIpNlhnK3oEZknximYYUQXtFSIpwVG0WlU=
X-Received: by 2002:a6b:3e57:: with SMTP id l84-v6mr1354460ioa.252.1540482703243;
 Thu, 25 Oct 2018 08:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-13-jagan@amarulasolutions.com> <20181024181334.lul7ta7ijluwfb7v@flea>
In-Reply-To: <20181024181334.lul7ta7ijluwfb7v@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 25 Oct 2018 21:21:31 +0530
Message-ID: <CAMty3ZBJcH1fz5FyhT1rk9qiJ-aWoQYiH7P1ZyQPLKmVWOCkdA@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:43 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Tue, Oct 23, 2018 at 09:20:32PM +0530, Jagan Teki wrote:
> > A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
> > using minimum 500MHz can't release the clock and which
> > is not working.
> >
> > So use working minimum rate as 300MHz which is tested on
> > Bananapi DSI panel.
>
> I'm not quite sure what you mean by that. What do you mean by "500MHz
> can't release the clock"? Why would 300MHz work better then? Should be
> avoid reaching 500MHz if it's a frequency in the valid range?

PLL_MIPI can't be work with existing nkm where rate set to 270MHz
(from PLL_VIDEO)
/*** round rate call in ccu_nkm.c */
[    2.408356] round: rate = 118800000
[    2.408359] round: parent_rate = 158740688
[    2.408417] round: rate = 148500000
[    2.408420] round: parent_rate = 158740688
[    2.408439] round: rate = 178200000
[    2.408441] round: parent_rate = 158740688
[    2.408460] round: rate = 205615384
[    2.408462] round: parent_rate = 158740688
[    2.408481] round: rate = 237600000
[    2.408483] round: parent_rate = 158740688
[    2.408502] round: rate = 270000000
[    2.408504] round: parent_rate = 158740688
[    2.408523] round: rate = 118800000
[    2.408525] round: parent_rate = 158740560
[    2.408544] round: rate = 148500000
[    2.408546] round: parent_rate = 158740560
[    2.408565] round: rate = 178200000
[    2.408567] round: parent_rate = 158740560
[    2.408586] round: rate = 205615384
[    2.408588] round: parent_rate = 158740560
[    2.408607] round: rate = 237600000
[    2.408609] round: parent_rate = 158740560
[    2.408627] round: rate = 270000000
[    2.408630] round: parent_rate = 158740560
[    2.408648] round: rate = 270000000
[    2.408651] round: parent_rate = 158740640
[    2.408670] round: rate = 270000000
[    2.408672] round: parent_rate = 158740704

/** set rate call in ccu_nkm **/
[    2.408685] set: rate = 270000000
[    2.408688] set: parent_rate = 297000000

By using min and max rate as per A64 manual page 94 range of PLL can
be 500MHz~1.4GHz getting 1,2,1 nkm dividers which can't be work.
[    2.423589] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.423643] ideal = 220000000, rounded = 0
[    2.423647] ideal = 275000000, rounded = 0
[    2.423651] ideal = 330000000, rounded = 0
[    2.423692] ideal = 385000000, rounded = 384000000
[    2.423732] ideal = 440000000, rounded = 440000000
[    2.423736] sun4i_dclk_round_rate: div = 8 rate = 55000000
[    2.423740] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.423744] ideal = 220000000, rounded = 0
[    2.423748] ideal = 275000000, rounded = 0
[    2.423751] ideal = 330000000, rounded = 0
[    2.423791] ideal = 385000000, rounded = 384000000
[    2.423831] ideal = 440000000, rounded = 440000000
[    2.423834] sun4i_dclk_round_rate: div = 8 rate = 55000000
[    2.423957] sun4i_dclk_recalc_rate: val = 1, rate = 440000000
[    2.423961] sun4i_dclk_recalc_rate: val = 1, rate = 440000000
[    2.424378] ccu_nkm_set_rate: rate = 440000000, parent_rate = 220000000
[    2.424381] ccu_nkm_set_rate: _nkm.n = 1
[    2.424383] ccu_nkm_set_rate: _nkm.k = 2
[    2.424385] ccu_nkm_set_rate: _nkm.m = 1
[    2.424725] sun4i_dclk_set_rate div 8
[    2.424732] sun4i_dclk_recalc_rate: val = 8, rate = 55000000
[    2.561271] usb 3-1: new high-speed USB device number 2 using ehci-platform
[    2.718486] hub 3-1:1.0: USB hub found
[    2.718606] hub 3-1:1.0: 4 ports detected
[    3.437263] ------------[ cut here ]------------
[    3.437270] [CRTC:36:crtc-0] vblank wait timed out

So, lowering the min rate by 300MHz seems working with bounded nkm
dividers 5, 2, 9. Tested on two different panels.

[    2.415773] [drm] No driver support for vblank timestamp query.
[    2.424116] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.424172] ideal = 220000000, rounded = 0
[    2.424176] ideal = 275000000, rounded = 0
[    2.424194] ccu_nkm_round_rate: rate = 330000000
[    2.424197] ideal = 330000000, rounded = 330000000
[    2.424201] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    2.424205] sun4i_dclk_round_rate: min_div = 4 max_div = 127, rate = 55000000
[    2.424209] ideal = 220000000, rounded = 0
[    2.424213] ideal = 275000000, rounded = 0
[    2.424230] ccu_nkm_round_rate: rate = 330000000
[    2.424233] ideal = 330000000, rounded = 330000000
[    2.424236] sun4i_dclk_round_rate: div = 6 rate = 55000000
[    2.424253] ccu_nkm_round_rate: rate = 330000000
[    2.424270] ccu_nkm_round_rate: rate = 330000000
[    2.424278] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    2.424281] sun4i_dclk_recalc_rate: val = 1, rate = 330000000
[    2.424306] ccu_nkm_set_rate: rate = 330000000, parent_rate = 297000000
[    2.424309] ccu_nkm_set_rate: _nkm.n = 5
[    2.424311] ccu_nkm_set_rate: _nkm.k = 2
[    2.424313] ccu_nkm_set_rate: _nkm.m = 9
[    2.424661] sun4i_dclk_set_rate div 6
[    2.424668] sun4i_dclk_recalc_rate: val = 6, rate = 55000000

Note: BPI-M64-bsp is setting the rate directly to 180MHz with 297MHz
parent with resulting dividers as 1, 2, 5. ans we can't produce this
180MHz rate with dclk_round_rate and ccu_nkm.
