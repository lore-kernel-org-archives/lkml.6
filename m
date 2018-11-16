Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67366C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D0020858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DOW2X040"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D0020858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbeKQDwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:52:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42379 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeKQDwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:52:41 -0500
Received: by mail-io1-f68.google.com with SMTP id h19-v6so17649625iog.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 09:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmPpK2D6N8MQ/pvjFtCGTT0PeJ0h32hFzTtesZGJZmM=;
        b=DOW2X040UHBUVDo/EtUB9HLM6pwacy0muJ2npQkEw4SQNAVCoGN0L9i1vkKw0r0cTo
         ryfQ0bnmj0DGNf02lqWjhotfj//AmFZpfb9A/2l0HpQx/rehafGi8I0P3Ewm8dLfIbtU
         Rjcaz9kGJJLRnC398ogrdQ1z9/5Iq38Rzv6sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmPpK2D6N8MQ/pvjFtCGTT0PeJ0h32hFzTtesZGJZmM=;
        b=bj6ARCAG8MzSp4hJY2EH/fGuYMsqtHZ1KUi9XcgqpuDxsGIN93firrVDq9uEy6CXhi
         qnbzBtHr3nKc4QRemlTI16x8hKWMImsEZ/LS4U2z9ccD9iPDGoUHuMZUmawprYdehHU3
         43bwVeNPqPqOTYMehdTHBPYoavIexSLB8o3dJhF/BCifzo/2BOdBPzRce5xugDPexYrB
         NmME3F7o9N/ptLndKjTwBfYuZbqSZIh7xpe5yhE3k0ZkQdmO7GzfBU72mj7COGyo5OXF
         izdM5kqsChkH1j0J31vlRFhn7n2Uel/muAc6o0PRGS4mFjCQMFIUIi8bgTM1tcuni975
         4lSQ==
X-Gm-Message-State: AA+aEWYFdMOolkMllLN+sATG0iaAKkDSOOPUlHD2TQqp27aGRqCN0Sta
        cgM0PDODru3lPjXc4ZagPQVJljrl5sIzpkNvEUkMTg==
X-Google-Smtp-Source: AFSGD/WwRCXot27xdi3zTHh7O/FBRKWRFPGL3DubX+8tp4kRMurY/jqQ2tubyTOm4NlVs0nkt0/XaoU1pJpzHXKJ3Vw=
X-Received: by 2002:a6b:be02:: with SMTP id o2-v6mr8702994iof.41.1542389961863;
 Fri, 16 Nov 2018 09:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20181116051719.23376-1-dbasehore@chromium.org> <CAD=FV=W7sYY5n609erPpTxux+0Efad_0YpPkoVZB14Kqm=baXA@mail.gmail.com>
In-Reply-To: <CAD=FV=W7sYY5n609erPpTxux+0Efad_0YpPkoVZB14Kqm=baXA@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Fri, 16 Nov 2018 09:39:09 -0800
Message-ID: <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
To:     Doug Anderson <dianders@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        =?UTF-8?B?6LCi5L+u6ZGr?= <tony.xie@rock-chips.com>,
        Chris Zhong <zyw@rock-chips.com>, ayaka@soulik.info,
        "nickey.yang" <nickey.yang@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        klaus.goger@theobroma-systems.com,
        Brian Norris <briannorris@chromium.org>,
        enric.balletbo@collabora.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 8:01 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.org> wrote:
> >
> > This adds the xin32k clock to the RK3399 CPU. Even though it's not
> > directly used, muxes will end up traversing the entire clk tree on
> > calls to determine_rate if it doesn't exist.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
>
> nit: I would have expected ${SUBJECT} to have v2 in it somewhere.
>
>
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index 99e7f65c1779..3d09472978f8 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>
> Aww crud.  I was at the airport yesterday and so I didn't notice that
> you were touching rk3399, not rk3399-gru.  This belongs in the gru
> device tree file, not in the top level rk3399.  As you have written
> this it will break rk3399 boards that have an rk808 on them, AKA:

Should this be moved to the rk3399.dtsi file? The RK3399 assumes that
this clk exists (same as the 24MHz clk which is in rk3399.dtsi). While
it can function without it defined, it really shouldn't. We can just
assign the existing labels in the dts files you pointed out.

>
> arch/arm64/boot/dts/rockchip/rk3399-ficus.dts:
> arch/arm64/boot/dts/rockchip/rk3399-firefly.dts:
> arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi:
> arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi:
>
> -Doug
