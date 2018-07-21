Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0220856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F0D9U6W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB0220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeGUWcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:32:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37228 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeGUWcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:32:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so27174536oib.4;
        Sat, 21 Jul 2018 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QutLOpSvVW0B4onrIv8a7AA0QY5Ps0W9TgW9mp2EHpQ=;
        b=F0D9U6W5im4p2SHgxoMl0FA+QbBGtaQO1QiXEeOLdOHM41a03fbcSU8yTDqioW+Kg1
         44Q5TpgqJeFrwfK1pPfoJhbVrhtM2lWhnDEQQFYtipV13Vf99pEJg+LFQz8HUkPQfQFe
         ewKBRWLzp13hGmOQsfd4lpaLVo+Bp7Bj3IY6MFDOO6wQlddTpB7EBqbaTMepYLJu4whJ
         oj5+T2l9gxC8vNqvphnorXRfa981LCCCSM7aYsvvcSVG3vUiAzEq8ExdyI8tdla6/aes
         12cEkoDAGBkNo+fkNU/c/oJ6bK26He/ysm49LKMHPHLpYq2hgjAVcXduIGHo+7hr2ArX
         y/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QutLOpSvVW0B4onrIv8a7AA0QY5Ps0W9TgW9mp2EHpQ=;
        b=ZnwsCXuAOsHQ6C3QiZPKTmWE+juVz0K19H7wNyNA4zPeGIWypvIQwggKSPdNO42tMu
         6ah1KD53V03rnuaZHeWzv4VLRQ9hCuEvWGowkkTEI1zX0gYX8FPKR3TayOqGxu9EvWnd
         WHpVeKXICk9Yfhuq4EangSHxhbyaZ2WDHtBZN9SekEST50T8tMbiEQoO0rya8550LBsr
         1HrDU8tgTsyyvsj+ko8FAq4Jk3tLGQPg1VofiqvU7BBbrSr8yI9Gkt0gU9cPl7AhmbsY
         vOZxFQx+AoQTjB1ZyOThFH2/UdEHzE8tPZctTRRKXFHOSDzIrESNHVckrD+Tkd3+HWGw
         DZCQ==
X-Gm-Message-State: AOUpUlFCtIgqsgMhOVPR+E8MMQI0BIOxpT+gMKinzEScOo+JDi2gkR9S
        xgGO85npXKS4rKBXAp4kMiyNt+KD42bRzk+ZZfY=
X-Google-Smtp-Source: AAOMgpe8XBcUu9u/yaTS/OsDm2e3htX8CbVGCVRA3iaN+GIRvJ9qzKskYAlzSMGNpfDQHDJmM+ZgW0hJFXitRsLilqI=
X-Received: by 2002:aca:c70f:: with SMTP id x15-v6mr3309135oif.97.1532209085796;
 Sat, 21 Jul 2018 14:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180717095617.12240-1-jbrunet@baylibre.com> <20180717095617.12240-3-jbrunet@baylibre.com>
 <CAFBinCAcqwhJUoLF3XkhOR2gnNk3cjEgh=ChTDybeRPLHgzeSg@mail.gmail.com> <1532205745.26720.81.camel@baylibre.com>
In-Reply-To: <1532205745.26720.81.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 21 Jul 2018 23:37:54 +0200
Message-ID: <CAFBinCAOssTAfearSER=95siRem-ZP8yU48xgoG4epRN76fgAA@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: meson: clk-pll: remove od parameters
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Sat, Jul 21, 2018 at 10:42 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat, 2018-07-21 at 22:01 +0200, Martin Blumenstingl wrote:
> > > +static struct clk_regmap gxbb_hdmi_pll_od = {
> > > +       .data = &(struct clk_regmap_div_data){
> > > +               .offset = HHI_HDMI_PLL_CNTL2,
> > > +               .shift = 16,
> > > +               .width = 2,
> > > +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> > > +       },
> > > +       .hw.init = &(struct clk_init_data){
> > > +               .name = "hdmi_pll_od",
> > > +               .ops = &clk_regmap_divider_ro_ops,
> > > +               .parent_names = (const char *[]){ "hdmi_pll_dco" },
> > > +               .num_parents = 1,
> > > +               .flags = CLK_GET_RATE_NOCACHE,
> >
> > why do we need CLK_GET_RATE_NOCACHE here?
> > also, shouldn't all _od clocks use CLK_SET_RATE_PARENT?
> > (this applies to all new _od clocks, not just this one)
>
> The goal was to retain the original behavior of the clock.
> The pll has CLK_GET_RATE_NOCACHE, which is why I put it again in the od
> dividers. Same goes for ro_ops
I missed that - thanks for the explanation!

> For the particular case of the HDMI PLL, the display driver still set the pll
> parameters m, n and ods directly which justify CLK_GET_RATE_NOCACHE for now.
> Of course, the goal is to remove this flag someday. I think there has been some
> good progress in the DRM driver to reach this goal.
>
> If we think the use CLK_GET_RATE_NOCACHE is not justified for some other plls, I
> would prefer if it was addressed in another patchset.
now that the reason is clear to me: I fully agree!

> Regarding SET_RATE_PARENT, with the pll set with ro_ops, it does not change
> anything but, I agree, it would be better to set flag for the future.
I see
adding SET_RATE_PARENT will probably save a bit of headache later on
when enabling the write operation of the PLL and then wondering why
the frequency is not changed


Regards
Martin
