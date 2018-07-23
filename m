Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17732ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C196120856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vWFDx1En"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C196120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbeGWPNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:13:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54723 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:13:50 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so1676458itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=1G7ddxHJ8/PU4LOWyN+LeWSOpqoudJeOD+wXTglXgoo=;
        b=vWFDx1En8I14s9ZmQGmKKKJr6cW3WgqCu9x4taMcFxMpU3RLi104DKlyovB7Iv5NPJ
         rJfH5SU5+r272zhO0B53Ir8WRMYoGsDq22SmTVtuZsVN47B2OukzR8dK/8jt19wojaVx
         CWYhX4dRoDviVxfxS2xcM6HfnzUaHO4FTWFUqx24pqLVx1PphtcPYTK9sl1WaIMvFjEz
         NvmyQeZCnjJrg0cnjHI1ZgtOMI9IuksEaA2KPqSBN2Z5AxcyiVKSbfouw2kEIyieb2Hn
         HVYI5EmcMspl1uWncTGMrPpaOYpgzYIiZAxPh2U0B1PPCp9mXrDff369k6s0Xsng0V2u
         //Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1G7ddxHJ8/PU4LOWyN+LeWSOpqoudJeOD+wXTglXgoo=;
        b=rYOjEeTiyglf0e37yU9kttaIRH4AFVbym91aLPv2FRQETTuboU58uSiwRR/Q2ED1yJ
         euEevG/DkSWY7OYrC8HUI6ujGh3X1HEl6/OQ1h+MGn6Y6i0xwsFgiZnfY1wiqY0q8/GQ
         JAndYp+zdhQTevOXiYzknCzdm2jH+ZYdpit+XTE7rnZwHsr4NYlnRGoleC7+oopV9Lou
         pJ6vJ0mrOaTqILYAeKpqX6ER3oe+HjkNCdWhQZnPced7xRT7PNszuUhdVcWjgigzA4Lp
         gml8ynQiDNm+osKsU5HcsLOT0ulvKMieG8Kn/kepvU1CnXTykQ9rqlYzUpyTAPUEBzCE
         jwag==
X-Gm-Message-State: AOUpUlE1fMjXhyFF7LAkhqKA9A47CEzc2KSV1p6G9xy7a1tPokZSt+wG
        4SFA+VDJQdv2lp0DHJz9fHMfsA==
X-Google-Smtp-Source: AAOMgpesJdLJLukgBb+yidcbBiduDky7g+/nG0th2Cfh/UthBTk1VKbGTcx0iGK1QlifUk4IZSmRjg==
X-Received: by 2002:a24:1a43:: with SMTP id 64-v6mr10117658iti.131.1532355143110;
        Mon, 23 Jul 2018 07:12:23 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id t64-v6sm7102670ita.13.2018.07.23.07.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 07:12:22 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock controller
Organization: BayLibre
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
        <20180710163658.6175-2-yixun.lan@amlogic.com>
        <20180711194346.GA32414@rob-hp-laptop>
        <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
        <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com>
        <5442a2e8-eb49-2aa8-e53e-8db88cd0bd58@amlogic.com>
        <CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA@mail.gmail.com>
        <8bf565d3-dbfd-e06d-7076-ba78d7a2e766@amlogic.com>
Date:   Mon, 23 Jul 2018 09:12:21 -0500
In-Reply-To: <8bf565d3-dbfd-e06d-7076-ba78d7a2e766@amlogic.com> (Yixun Lan's
        message of "Fri, 13 Jul 2018 09:55:32 +0800")
Message-ID: <7hbmay3ut6.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

[...]

>> 
>>> Second, we might like to convert eMMC driver to also use mmc-clkc model.
>> 
>> IMO, this should be done as part of merging this series. Otherwise, we
>> have duplicated code for the same thing.
>
> IMO, I'd leave this out of this series, since this patch series is quite
> complete as itself. Although, the downside is code duplication.
>
> Still, I need to hear Jerome, or Kevin's option, to see if or how we
> should proceed the eMMC's clock conversion.
>
> I could think of three option myself
> 1) don't do the conversion, downside is code duplication, upside is NO
> DT change, no compatibility issue
> 2) add a syscon node into eMMC DT node, then only convert clock part
> into this mmc-clkc model, while still leave other eMMC register access
> as the usual iomap way (still no race condition)
> 3) convert all eMMC register access by using regmap interface.
>
> both 2) and 3) need to update the DT.
>
> and probably 2) is a compromise way, and 1) is also OK, 3) is probably
> the worst way due to dramatically change (I think this was already
> rejected in the previous discussion)

Because the devices (NAND and eMMC_C) are mutually exclusive, taking the
step-by-step approach is fine (and preferred) by me.

Phase 1:
- add new mmc-clk provider
- add NAND driver using new mmc-clk provider
- boards using NAND should ensure emmc_c is disabled in DT

This allows us to not touch the MMC driver or existing upstream
bindings.  Yes, this means there is duplicate code in the MMC driver and
the new mmc-clk provider, but that can be removed in the next phase.

Phase 2:
- convert MMC driver to use new mmc-clk provider
- update MMC users in DT and bindings

Kevin




