Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D3E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfAOCwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:52:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33242 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfAOCwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:52:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so1396215eds.0;
        Mon, 14 Jan 2019 18:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QYlvmXDylvUtOb39tKDxn82P1fbLoRwSF1u234njv4=;
        b=NkqzFKH8z05aAnQBquU/wKYJk8FMMOjOM8oEtQdXq85QQib41UFz9OVVTxmtxDnh5o
         0DIWw93V8/SJVLcdK/waQ4bJpUUjVJO2SAKZiRGhpuPsX3ZIpLULOh3qrFHkFKGBUrZd
         VieQBd8CbrfY38b2bNXwI3J+vZO9mOq/r814/o3fCp9cFYHRF8UFtGX/PPbdxAdrTjA/
         XyhjyIIp6bg38q4Y90gdEOuprfyAIJYY7tIegMHjMSgT0gwQeDnnspxNt1+suQm/j8/G
         V95peOoF+mz/yrT54AP+o65I/C+VGoXuJ0J3Veb80fJId1sOe/UybvDBwTvKEivxXUuG
         UzDQ==
X-Gm-Message-State: AJcUukcIqblQBm2fDBhCP+84wAWR/lkteA6N0PhUQOTHmjJpcgqNP0vS
        ljE/IqcnhQQJ1YZQIsYKtsc8dKvqif8=
X-Google-Smtp-Source: ALg8bN6LuUKmPirs+YVlod6n+8Amd4D73wTR5McLjOCkGDgRQNQwVqu5Or6KLpVx+UfAPCg9V2Q04g==
X-Received: by 2002:a05:6402:13d6:: with SMTP id a22mr1530590edx.39.1547520742353;
        Mon, 14 Jan 2019 18:52:22 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id n10sm4504351edq.33.2019.01.14.18.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:52:22 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id 96so1270989wrb.2;
        Mon, 14 Jan 2019 18:52:21 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr1028067wrv.87.1547520741332;
 Mon, 14 Jan 2019 18:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20190113021719.46457-1-samuel@sholland.org> <9738319a-4154-62be-2325-2873dfb326dc@linaro.org>
In-Reply-To: <9738319a-4154-62be-2325-2873dfb326dc@linaro.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 15 Jan 2019 10:52:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Hmn2QBN++X8h94E_Vwe1uZ67zz5TTGiwUJJe4nCWgXQ@mail.gmail.com>
Message-ID: <CAGb2v66Hmn2QBN++X8h94E_Vwe1uZ67zz5TTGiwUJJe4nCWgXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Allwinner A64 timer workaround
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 8:57 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/01/2019 03:17, Samuel Holland wrote:
> > This is the third version of a patch series to fix system clock jumps
> > and other timer instability on the Allwinner A64 SoC. It has now been
> > tested for a week, and I've received no reports of date jumps with this
> > version. So this is, as far as I can tell, a complete workaround.
> >
> > See the commit messages for a detailed description of the issue, but the
> > summary is that, when a high counter bit rolls over, indeterminance in
> > the low bits causes CNTPCT/CNTVCT and their respective TVAL registers to
> > jump forward or backward. Backward jumps (or the next read after forward
> > jumps) are sometimes seen by the kernel and interpreted as the timer
> > wrapping around after 2^56 cycles. This causes the system clock to jump
> > forward approximately 91 years.
> >
> > changes since v2;
> > - Reduced workaround threshold from 11 to 10 bits based on reports from
> >   other hardare and the U-Boot version of this workaround
> > - Added TVAL handling based on Marc's suggestion
> > - Added erratum documentation and renamed symbols to match
> > - Added Maxime's Acked-by
> >
> > changes since v1:
> > - Add an iteration limit like most other arch timer workarounds
> > - Added Andre's Tested-by
> >
> > Samuel Holland (2):
> >   arm64: arch_timer: Workaround for Allwinner A64 timer instability
> >   arm64: dts: allwinner: a64: Enable A64 timer workaround
> >
> >  Documentation/arm64/silicon-errata.txt        |  2 +
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
> >  drivers/clocksource/Kconfig                   | 10 ++++
> >  drivers/clocksource/arm_arch_timer.c          | 55 +++++++++++++++++++
> >  4 files changed, 68 insertions(+)
> >
>
> Applied. Took the opportunity to add the stable@ tag.

Not seeing it in tip just yet. Was it applied for -rc or -next?
Need to know which branch to apply the device tree patch to.

Thanks
ChenYu
