Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66DBECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4AC20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LFbEHTVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4AC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeGUVgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:36:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54171 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeGUVgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:36:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so12422737wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1uF4Lq8InIUbEBCHSkHR1rtTrPFYzpu3wVtuSEdMAg=;
        b=LFbEHTVIF9WfMp8NC+zWv9bDXfU5zY7ygObJ6IWTZ0BPJKE3BnA1hqDIfBkrQZeLK4
         JeHOsFDXDas3D4SCAegxTHbIgLUupjSbHvuIfm00cW7Q+BkEW4dErUCKr0RZ3fCJz+Gk
         ksSMvKud4JB2MtIOyEE6tiGq3QoTQ7qQVDBuKw/fBYM1ZSne2/0chHX5x+jtultCd/gU
         XwY25WnaL3W79A3TSwWNpDx+yiSqNbb65O5Xld71jOcYBZw2oKYGNtQhRHrIQH46Ir2N
         Ay2biTT+e84RmSjUGYDj0qFO91aQPjZIOnEBdR7weP7EwJp9WvDy2wwIO9hUvGnkuJlp
         DW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1uF4Lq8InIUbEBCHSkHR1rtTrPFYzpu3wVtuSEdMAg=;
        b=n1FeypwntEK9gevX50QFi4fd4aeTkiCz49bF+Yg+dAit8REggeFPLB8iwXiWG08HDn
         HZCUCEVxn77f3+6vJpkWSgkydXZRAWAjZDul1LsaBOMIpT5jz8NT31FYnPB5KVtYwTEI
         kBCtgAkavaPKR7efxJuZjwf5vSr1ZCJef68WO2ynWig6Hs5jnZQuqXfKUJeLEhjcRpA0
         t3/9pLVcS5SDbBBB/THM9/CoVTgoJJwT9yyqaGuipDS9h7S+R/NAIyDUDchq2ewHleVw
         uuhwjQWweHtbdxoW0zPLPPNbUAm+mTQ4OqLqh4HuBuKAILsbl1x9IDooacMycOD2MFAb
         l1rQ==
X-Gm-Message-State: AOUpUlGT/vivgWOAN0EC4yNT5X1nzUedMIA4O/D8HxyZKL3eHWU6Oc/S
        ZJ0AvcqszQrws4e/Al3kBnd74g==
X-Google-Smtp-Source: AAOMgpdMNnLw0NHpy/oTNM6s7MWg18YUIXpY+6+c/wGYp4X3XbNnsEDZGrSekR+HkpogjudfLWJ/bQ==
X-Received: by 2002:a1c:b45:: with SMTP id 66-v6mr4150507wml.45.1532205748136;
        Sat, 21 Jul 2018 13:42:28 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id z62-v6sm4342313wmc.10.2018.07.21.13.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 13:42:27 -0700 (PDT)
Message-ID: <1532205745.26720.81.camel@baylibre.com>
Subject: Re: [PATCH 2/3] clk: meson: clk-pll: remove od parameters
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Date:   Sat, 21 Jul 2018 22:42:25 +0200
In-Reply-To: <CAFBinCAcqwhJUoLF3XkhOR2gnNk3cjEgh=ChTDybeRPLHgzeSg@mail.gmail.com>
References: <20180717095617.12240-1-jbrunet@baylibre.com>
         <20180717095617.12240-3-jbrunet@baylibre.com>
         <CAFBinCAcqwhJUoLF3XkhOR2gnNk3cjEgh=ChTDybeRPLHgzeSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-21 at 22:01 +0200, Martin Blumenstingl wrote:
> > +static struct clk_regmap gxbb_hdmi_pll_od = {
> > +       .data = &(struct clk_regmap_div_data){
> > +               .offset = HHI_HDMI_PLL_CNTL2,
> > +               .shift = 16,
> > +               .width = 2,
> > +               .flags = CLK_DIVIDER_POWER_OF_TWO,
> > +       },
> > +       .hw.init = &(struct clk_init_data){
> > +               .name = "hdmi_pll_od",
> > +               .ops = &clk_regmap_divider_ro_ops,
> > +               .parent_names = (const char *[]){ "hdmi_pll_dco" },
> > +               .num_parents = 1,
> > +               .flags = CLK_GET_RATE_NOCACHE,
> 
> why do we need CLK_GET_RATE_NOCACHE here?
> also, shouldn't all _od clocks use CLK_SET_RATE_PARENT?
> (this applies to all new _od clocks, not just this one)

The goal was to retain the original behavior of the clock.
The pll has CLK_GET_RATE_NOCACHE, which is why I put it again in the od
dividers. Same goes for ro_ops

For the particular case of the HDMI PLL, the display driver still set the pll
parameters m, n and ods directly which justify CLK_GET_RATE_NOCACHE for now.
Of course, the goal is to remove this flag someday. I think there has been some
good progress in the DRM driver to reach this goal.

If we think the use CLK_GET_RATE_NOCACHE is not justified for some other plls, I
would prefer if it was addressed in another patchset.

Regarding SET_RATE_PARENT, with the pll set with ro_ops, it does not change
anything but, I agree, it would be better to set flag for the future.

Cheers
Jerome
