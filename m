Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796BD205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S0fUIO0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796BD205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966752AbeFSP3S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:29:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36734 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966641AbeFSP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:29:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so107759wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvAZA/UmVY1ldsJkl46fpogJzoSBcrGqFPWsQ3V7DrU=;
        b=S0fUIO0YMT3mT0WxEewxLrDCQAJSR8KTE0ovmcn4nGNs/Vkt7sAYVjLu5cP4dPFm7E
         +3KPPgNN+Xvye19EVTJMvrHbw5oHGv60SLmdwNALoSezz0fADS6+Jpj76Bbgo4Wd8n11
         N6mI7an0bcagyaV6Wy6Shi26UKWXmQBS7r91K1WqdDASfkmmCEO2JQD6srdPCHJSI7fA
         Gu+ZuaQkE/sYApu/uBIMi8I6LKEjEhNaLu+o6JyAt4U9ahEGNSG7zkrOvniJBiYBfBvG
         YWZKR04H1xswsKA6j239U4Fj7MwYzcIuzWE9iDV1enK07GfyaTIyQxXIhtTCaCTLYvLv
         +gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvAZA/UmVY1ldsJkl46fpogJzoSBcrGqFPWsQ3V7DrU=;
        b=WmGbT7GJdgci1gbssA6Qh/Xao9E+v40P69WqpbKZKaGAn6Hw0U7eOHzncGVF2GTak6
         B2WVXhNuVd+hZe5csnMdak/rmfJL01+Eb1f0LSKWbcjCjcOBSlZYygmgGtey8KduElNo
         l3X0hdFpOWctL+4pMAa+TobbJ03JhBvmi5p69GK0AzkchzgpLTrB8izOiLiO2vOi2u68
         BW4xL7QSs3SUp6PnNTFs1HIGK2jh7iOUwvUxdFiTRdasyeVm+8Kb4qjpttB0l4mtQI2B
         UDEOo5NMOneUEn8nzn4oV1v4yvEvkes98kGzYYNoLUU3D/g/qOUG7b14hCKZ0e5XYnH7
         +mQA==
X-Gm-Message-State: APt69E3V9dxDGcE9hRq5UzPOH+Ntp5VD82afwiCdmBrX4+3vEMYz97wd
        wPqva6myOh+MyycJTmTfHpY1Qg==
X-Google-Smtp-Source: ADUXVKIaLR4DcCRSsDms6RW4tuTWgf5XZVoHvyUqPAmLUPt0JT79QhtoirHXuXrMtKWSBrdnRCMaUg==
X-Received: by 2002:adf:8610:: with SMTP id 16-v6mr14270850wrv.255.1529422154362;
        Tue, 19 Jun 2018 08:29:14 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b74-v6sm544481wmi.13.2018.06.19.08.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 08:29:13 -0700 (PDT)
Message-ID: <1529422152.28510.24.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, sboyd@kernel.org,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jun 2018 17:29:12 +0200
In-Reply-To: <1528892771.2292.2.camel@baylibre.com>
References: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
         <1528892771.2292.2.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 14:26 +0200, Jerome Brunet wrote:
> On Wed, 2018-06-13 at 14:20 +0200, Neil Armstrong wrote:
> > On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
> > seems to be dependent on the FCLK_DIV2 to be operationnal.
> > 
> > The issue occured since v4.17-rc1 by freezing the kernel boot when
> > the 'schedutil' cpufreq governor was selected as default :
> > 
> >    [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
> >    domain-0 init dvfs: 4
> >    [   12.087757] hctosys: unable to open rtc device (rtc0)
> >    [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> >    [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > 
> > But when disabling the MMC driver, the boot finished but cpufreq failed to
> > change the CPU frequency :
> > 
> >    [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5
> > 
> > A bisect between v4.16 and v4.16-rc1 gave the 05f814402d61 commit to be
> > the first bad commit.
> > This commit added support for the missing clock gates before the fixed PLL
> > fixed dividers (FCLK_DIVx) and the clock framework basically disabled
> > all the unused fixed dividers, thus disabled a critical clock path for
> > the SCPI Co-Processor.
> > 
> > This patch simply sets the FCLK_DIV2 gate as critical to ensure
> > nobody can disable it.
> > 
> > Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Good catch !
> We'll probably have to check the axg family as well

SCPI is not enabled on AXG at this time. We'll deal with it when the time comes.

patch applied.
Thx
