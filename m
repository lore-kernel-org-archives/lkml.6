Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AC8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3072080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xx7LyAx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3072080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbeKTMcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:32:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33379 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeKTMcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:32:45 -0500
Received: by mail-io1-f68.google.com with SMTP id f12-v6so262026iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 18:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IG5Qf9Om5lyBX8x5TfYN5tQLYBYr+qM5ZFTescYcivY=;
        b=Xx7LyAx2hYN1cmw9At510fquTP0xGLYTFmdy3Qbr7WdTM3AOPc2Ja+dofmkLf1qgEX
         hwFgnUiuqMM4VGrJem29ZlzWX3yseksFRWpvtK6I/4ygr/6lGAa77CLARAyx3HET+1jE
         Uyt3dSujEI1+4NxcxYkHpSmRIpUfBOMympcb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IG5Qf9Om5lyBX8x5TfYN5tQLYBYr+qM5ZFTescYcivY=;
        b=jV9tByuis29EH2rEKnozX+fXMbu61tPHTdA3PSFWJwTgtHfY7Sn9l6S8l5oC1rKhMg
         Z1Jedg4EHIxYCkUc52h0fPDC4tumAz8a4iESCPgTTNcnYlmTr6Vjdm80zBPwE5woabJw
         BHy2nExooGsdoNtVPLZ3SOGS2oOAR8+q3U1IMYv+sU1HTd5CXhMIMAleEw714tjdLt4E
         jragI/vjccjv9gwaMtQNf10v/GVyiGf2qPz6vM9Vf8qrQyq2hsTFWDMa5TxTBBfoGJj7
         PklX/VCcSF2O7kUaLB0ORD0O/sV9+R0DxYo8+DIo56UHC6GqkLrFK2FyoUVai7e6jpa6
         33uQ==
X-Gm-Message-State: AA+aEWbewCVyyJ8Vw1pYp9D8J/BtatcSKaxD4uS0X+WKwGY/7hB5fR6W
        mIaW5u+ACxeTFXnHwuaT28Q9wRR7xKR0TXLtn9pM0w==
X-Google-Smtp-Source: AFSGD/WiKnVJwOLgCVy4i7/uxzGn4WyaztBM7FuH8icTkPTJnQ0PJQQsHIP/7dD9Oz4LQenL5Cqx47QtQJMlhGSa4ZM=
X-Received: by 2002:a6b:b496:: with SMTP id d144mr93978iof.180.1542679565166;
 Mon, 19 Nov 2018 18:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20181116051719.23376-1-dbasehore@chromium.org>
 <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
 <CAD=FV=XVDAjLt+VtxedHEma1FRrG0LuFZ2c7L5-MsdCZkgEcsw@mail.gmail.com> <11718017.ngvMPIPJQJ@diego>
In-Reply-To: <11718017.ngvMPIPJQJ@diego>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Mon, 19 Nov 2018 18:05:52 -0800
Message-ID: <CAGAzgsrWCo97un9WT2DvkHV5ga7rpg05sxd5PsbEN8_w2Dh3rQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        =?UTF-8?B?6LCi5L+u6ZGr?= <tony.xie@rock-chips.com>,
        Chris Zhong <zyw@rock-chips.com>, ayaka@soulik.info,
        "nickey.yang" <nickey.yang@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        klaus.goger@theobroma-systems.com,
        Brian Norris <briannorris@chromium.org>,
        enric.balletbo@collabora.com, Mark Rutland <mark.rutland@arm.com>,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 1:41 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Freitag, 16. November 2018, 19:23:59 CET schrieb Doug Anderson:
> > Hi,
> >
> > On Fri, Nov 16, 2018 at 9:39 AM dbasehore . <dbasehore@chromium.org> wr=
ote:
> > > On Fri, Nov 16, 2018 at 8:01 AM Doug Anderson <dianders@chromium.org>
> wrote:
> > > > Hi,
> > > >
> > > > On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.=
org>
> wrote:
> > > > > This adds the xin32k clock to the RK3399 CPU. Even though it's no=
t
> > > > > directly used, muxes will end up traversing the entire clk tree o=
n
> > > > > calls to determine_rate if it doesn't exist.
> > > > >
> > > > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > > > ---
> > > > >
> > > > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > >
> > > > nit: I would have expected ${SUBJECT} to have v2 in it somewhere.
> > > >
> > > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index
> > > > > 99e7f65c1779..3d09472978f8 100644
> > > > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > >
> > > > Aww crud.  I was at the airport yesterday and so I didn't notice th=
at
> > > > you were touching rk3399, not rk3399-gru.  This belongs in the gru
> > > > device tree file, not in the top level rk3399.  As you have written
> > >
> > > > this it will break rk3399 boards that have an rk808 on them, AKA:
> > > Should this be moved to the rk3399.dtsi file? The RK3399 assumes that
> > > this clk exists (same as the 24MHz clk which is in rk3399.dtsi). Whil=
e
> > > it can function without it defined, it really shouldn't. We can just
> > > assign the existing labels in the dts files you pointed out.
> >
> > No, it should be in the board files.  Each board may produce the 32k
> > clock through a different component.  On gru-based devices we produce
> > the 32k clock through a silego part.
>
> That would also be a great part of the commit message, like
> "...on Gru boards the 32kHz clock gets produced by a Silego oscillator"
> or so when you move it over to rk3399-gru.dtsi .
>
>
> > Technically you could say that we don't _truly_ need to model this
> > clock and we could have just inserted a dummy/fixed 32k clock in the
> > clk-rk3399.c file.  ...but we did model it so that means we should
> > probably model it semi-properly.
> >
> > If a given board forgets to provide a 32k clock then that's a bug for
> > them like it was for us.
>
> Yep and as I said in my other mail, on these pmic generated clocks
> the clock generation often even is configurable (rate, on/off), so it
> should really be a real clock not some hack ;-) .
>

Ok, I'll make that change in about a week after I get back from
vacation in about a week.

>
> Heiko
>
>
