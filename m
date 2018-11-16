Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78737C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F2D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EHA1zp59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F2D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbeKPP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:28:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33696 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeKPP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:28:20 -0500
Received: by mail-io1-f67.google.com with SMTP id f12-v6so16258710iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 21:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAxVsiSFq92VQEKTqjavP3tOvFFxpkKBGuWYD7oXRwM=;
        b=EHA1zp59VDC7n124NonEDDrxYlBvMF3xmxKhG5+5jrm24ANuDtH+4AaUbesROBRtGd
         9bWCv1w7E+VFBI38NtDicalJReamHj4AsGdewm5JvIFfEIv4YIeAZI4FFrSLmH0Nf8GB
         ritKPX+Da9H03Q6nHU2h63rXkHfryiiSf4Nps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAxVsiSFq92VQEKTqjavP3tOvFFxpkKBGuWYD7oXRwM=;
        b=tjVJ2kmMPfdyhaVG/IBBBVGX1MeHoy9PvrpmWW+Ano9oxo9V8jsivGFWpzbRsFgrVM
         kamd5iiljJc4sIOnt8SAVwROERublSXkopaNNOrkGBmqDePA9/rKh8jFjIXXEU6U+/qO
         nfKf//m4vywWmWgVdPwMLLCQfFYKjSn9Dbo+h42UBCjrPcSL0EgHXLlvPqPMD4MM4LI8
         hFCbvFUgKPlxlCBu0rG5kpqL8HYKGKWtJ/rhhxt+Dnikwg9VpfFScbkFRBOswFQcJ5Gj
         o0cssXjR2lXscYMvnU4Xcm/6pKzZWiMtcw6wuDvDqrpP1pnMAKBbFofGHRb5G51oU+dE
         jJDg==
X-Gm-Message-State: AA+aEWbulqMuUGzWj2jkOku/hZBeyiLDS8scCRIPJiiPSBjqtGaKrfgF
        qpqJJEBYn4tM4Fgq/cmQR6hYq4j+F0Q5QkTUZ8UpHw==
X-Google-Smtp-Source: AFSGD/VNiYd8sEFV+O1ji+Ycu4Pb0FZ9PAH0xarUsjbeLmTui02O/8H9s4+v8EWRvznO7RzOxxyyqjErw+wcOXfjIhw=
X-Received: by 2002:a6b:be02:: with SMTP id o2-v6mr6919027iof.41.1542345447219;
 Thu, 15 Nov 2018 21:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20181116004247.172977-1-dbasehore@chromium.org> <CAD=FV=VjN3J66wv2LGhQYD+-_W1q+KCzvo3V_1F9ktAb-T-i4A@mail.gmail.com>
In-Reply-To: <CAD=FV=VjN3J66wv2LGhQYD+-_W1q+KCzvo3V_1F9ktAb-T-i4A@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Thu, 15 Nov 2018 21:17:15 -0800
Message-ID: <CAGAzgsroEhcohssW8YUw_6otaLhUznXAE4P7jkd2HBA_W+V9_g@mail.gmail.com>
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

On Thu, Nov 15, 2018 at 9:03 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 15, 2018 at 4:42 PM Derek Basehore <dbasehore@chromium.org> wrote:
> >
> > This adds the xin32k clock to the RK3399 CPU. Even though it's not
> > directly used, muxes will end up traversing the entire clk tree on
> > calls to determine_rate if it doesn't exist.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index 99e7f65c1779..6a32293982d0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -191,6 +191,13 @@
> >                 #clock-cells = <0>;
> >         };
> >
> > +       xin32k: xin32k {
>
> nit: xin32k is the name of the clock that rk3399 consumes.  It seems a
> little weird to name this node with that name.  Can you call this:
>
> ap_rtc_clk: ap-rtc-clk
>
> ...after the gru schematic?  You wouldn't change the
> clock-output-names, just the node name / label.
>
>
> > +               compatible = "fixed-clock";
> > +               clock-frequency = <32000>;
>
> I checked the datasheet for the 32K clock and it shows that this is a
> 32768 Hz clock, not a 32000 Hz one.  I also checked the rk808 clock
> driver (which is supposed to be compatible with rk3399) and it
> produces a 32768 clock.

Ok, sending out an updated patch that addresses these concerns.
