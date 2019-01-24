Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875BFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59991218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548348585;
	bh=euAT9CB/Jdcpg0WuU2GpjY2q9AlvQzDaF+N18wlJhoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YVeXenQ3b8QUZBP/kwQywx6sqSNGw1RxUv+C+xGDjADD/Rkjgpz/TVHxRw5CkqIMd
	 D3tfhjOaXbFg9pWXuX4OI5YM0X5uRGVzfBtAK/gbK/IV8QjviSvl2M0lhC1LHDod9I
	 kshc6pvGPBgLTzuN3Xvd5PSKsSCuidVl2HG0JwJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfAXQtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAXQtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:49:43 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323EA218CD;
        Thu, 24 Jan 2019 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548348582;
        bh=euAT9CB/Jdcpg0WuU2GpjY2q9AlvQzDaF+N18wlJhoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CXPqDrDAEdHKYPZ0e0HEGObhHTh89VEsu8gMhmKqbkxi2F1Ob9TftcMuklwMarhAI
         HREhfOGxqHkqYLjRCK/ZvJSh4pESwyWucddWdBKwnx2JPZT2y/uqGuXHPuB4KSybij
         XqaaR6GPMUKLz1p0drCko7t5aED8EbpwwbGJvwQM=
Received: by mail-qt1-f170.google.com with SMTP id r14so7408614qtp.1;
        Thu, 24 Jan 2019 08:49:42 -0800 (PST)
X-Gm-Message-State: AJcUukcw5+EP2Fj/71NgXU2Qf3JLzoLmq3c84w9iez7Vg0HP8JsgMeeZ
        wkFGwfIHl85gB2pKMlEC6KVJVRoOJA95ZI/X1Q==
X-Google-Smtp-Source: ALg8bN7DMKRMSNuqqnBARNM7y3WTRvbM7dqCswmp/jMCw+JeOX3Hg6Q3URy4O5KzqZiNUfr6YwN9MzWjq+BfUHTBIdQ=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr6945862qvl.77.1548348581340;
 Thu, 24 Jan 2019 08:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-7-manivannan.sadhasivam@linaro.org> <20181221023708.GC3233@Mani-XPS-13-9360>
 <9f4f05cb-f326-a4e3-e306-cfbf64b629b4@xilinx.com>
In-Reply-To: <9f4f05cb-f326-a4e3-e306-cfbf64b629b4@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 24 Jan 2019 10:49:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zfV66EZHX7psh2=r-=wDrmLLcr5PWtSzuKRNOdMR-Dw@mail.gmail.com>
Message-ID: <CAL_Jsq+zfV66EZHX7psh2=r-=wDrmLLcr5PWtSzuKRNOdMR-Dw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: xilinx: ultra96: Standardize LED
 labels and triggers
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, koen.kooi@linaro.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:51 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 21. 12. 18 3:37, Manivannan Sadhasivam wrote:
> > On Mon, Oct 29, 2018 at 03:12:44PM +0530, Manivannan Sadhasivam wrote:
> >> For all 96Boards, the following standard is used for onboard LEDs.
> >>
> >> green:user1  default-trigger: heartbeat
> >> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> >> green:user3  default-trigger: mmc1 (SD-card)
> >> green:user4  default-trigger: none, panic-indicator
> >> yellow:wlan  default-trigger: phy0tx
> >> blue:bt      default-trigger: hci0-power
> >>
> >> So lets adopt the same for Ultra96, which is one of the 96Boards
> >> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
> >> consolidate only User LEDs.
> >>
> >
> > Hello,
> >
> > Any update on this patch?
>
> I am still waiting for reaction from Rob.
> We are keep trying to keep backward compatibility and this patch is
> breaking it that's why I want to know DT guys reaction on this change.

dts changes and backwards compatibility are ultimately up to the
platform maintainers. Your users can yell at you if they care. I only
ask that changes that break compatibility are documented as doing so.

Personally, I'm in favor of this change. I'd rather seem uniformity
across boards and this is just a dev board and LED functions won't
affect booting.

Rob
