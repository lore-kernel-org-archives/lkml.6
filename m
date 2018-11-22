Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729AE20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GtzWVemh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729AE20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407486AbeKWIKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:10:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44289 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbeKWIKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:10:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so7493005otl.11;
        Thu, 22 Nov 2018 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ha7qZov1GAIxKR5+NArEJ5S+4Vwlc5PDn3a+s53NtfM=;
        b=GtzWVemh8gnOdY0YsZXrMeBIsSSTa9fzcAsG+zbJXqMMdh7oYQRn6JSW6q+WMgXIog
         VbasCy2bq12nsanF3bm2lXeOiem/ss0edM2UmW7OqiU47zvV6rIpyWct1v8b2hISeqzG
         9/xOSBXAMJhHJyeiqhPGUTZ/bO8t+ijgHI0J+J8w5cggamEl/LtAdDcxdkNInu4LNcCn
         GtmZaCkRSA4CUDj1vXstevm6pP1/iqezqVCyqvDOYXHM2ImeOal7Q8Ut602v5uDGodfV
         oUQKSBvbicBghW/JSFoMpaUDo66+fDS2QTZ17vq6qglJt3dvncRnlL4KcXjq585dT7P7
         ratg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ha7qZov1GAIxKR5+NArEJ5S+4Vwlc5PDn3a+s53NtfM=;
        b=kBXx2g+0MJqOnCI7YWMRT0lGrGDRaXWTOg2qGFDEsvJ5b13rkHCioKqlgDzBD4lZuZ
         sYIdfPOak4ED17s8fYtBuvHqMPtMiViSXlFwvoHMyA3GXv0XRzac/VG/GLarT1DdDrhq
         vrlGlK78Gqq+bQnOz7DprDjldUefomjWXq3ymFjzVYg9n8C68JG0OwC2OwKrai4Z81Jx
         lJwpz8mcQuDkofAbrrpEiioHgHUwkZBdfuOMmTgLIvh90+DrVmisJBlhM3AUs0VrwBwz
         vOnWsbWypVAXqbu9iVHEZGlsK9zohqpgK1Ls5QE592l4Ss5Nqe/4IiudptbNVn/6G+h6
         77Fw==
X-Gm-Message-State: AA+aEWa8/Q5x0IyFn6w01GM/GNaLavMI8sXB70S97Qv6HKyZi96yRUgD
        /Uvxwo2cMtK6f4EEHIQcdRsDLtLiA59PuLRhQVo=
X-Google-Smtp-Source: AFSGD/VODV73mmeyKQi8Vh2ui0ye4ne2KgYevQjkSKXTEIsuDse+uQ3PX1EN7qPH53AHLijip8akTpFcp6Bqx1kGGZ8=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr6976911otq.348.1542922166228;
 Thu, 22 Nov 2018 13:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20181116205303.6354-1-martin.blumenstingl@googlemail.com> <59801d61ba4e5d5fc8f0df1adffad1f9c7afb45c.camel@baylibre.com>
In-Reply-To: <59801d61ba4e5d5fc8f0df1adffad1f9c7afb45c.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 22 Nov 2018 22:29:15 +0100
Message-ID: <CAFBinCAgJTRgF-YX2Yt84c57URvV6Tr_R7=s1tjFPyzeWmup-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Meson8b: add the CPU clock post-dividers
To:     jbrunet@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Nov 22, 2018 at 10:05 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Fri, 2018-11-16 at 21:53 +0100, Martin Blumenstingl wrote:
> > This is the successor to my previous series "meson8b: add the CPU_DIV16
> > clock for the ARM TWD" from [0]. I decided to not send this as v2 of
> > the original series because the PERIPH clock is not the CPU_DIV16 clock.
> > It's not clear whether a CPU_DIV16 clock exists.
> >
> > With this series we get all the CPU_CLK post-dividers as listed in the
> > public S805 datasheet [1] on pages 31 and 32:
> > - ABP
> > - PERIPH (used as input for the ARM global timer and ARM TWD timer)
> > - AXI
> > - L2 DRAM
> >
> > Each of these clocks has a register called "..._CLK_DIS" which is
> > documented as a "just in case" bit:
> > "Set to 1 to manually disable the [...] clock when changing the mux
> > selection. Typically this bit is set to 0 since the clock muxes can
> > switch without glitches."
> > Since we're not supposed to touch that register we're setting
> > CLK_IS_CRITICAL for these clocks in the driver.
>
> If we are not supposed to touch the register, I'd prefer if you used RO ops
> instead of using CLK_IS_CRITICAL.
that makes sense as other "read-only" clocks are using RO ops as well.
I'll add a new patch which introduces clk_regmap_gate_ro_ops as we
don't have that yet

> >
> > The result of this is that we can use the PERIPH clock which clocks
> > the ARM TWD timer. I will send a separate series to add the TWD timer.
> >
> >
> > [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
> > [1]
> > https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
> >
> > Martin Blumenstingl (3):
> >   dt-bindings: clock: meson8b: export the CPU post dividers
> >   clk: meson: meson8b: rename cpu_div2/cpu_div3 to
> >     cpu_in_div2/cpu_in_div3
> >   clk: meson: meson8b: add the CPU clock post divider clocks
> >
> >  drivers/clk/meson/meson8b.c              | 268 ++++++++++++++++++++++-
> >  drivers/clk/meson/meson8b.h              |  17 +-
> >  include/dt-bindings/clock/meson8b-clkc.h |   4 +
> >  3 files changed, 276 insertions(+), 13 deletions(-)
> >
>
> With CLK_IS_CRITICAL removed, looks good to me:
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
thanks for reviewing this!


Regards
Martin
