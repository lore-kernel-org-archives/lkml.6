Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF2EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CFF206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393924AbfAPPL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:11:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41371 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbfAPPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:11:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so7450660qtf.8;
        Wed, 16 Jan 2019 07:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IMG7jlqdMP9fj1j/3+ne8Scrl1K/KH+xgzb4mZhEV0=;
        b=bI6MPAHStDomHprgy4bg/elQD7wrj0PVr1DflLLR8dDwTD7OiExB4yhWuwC+9mWVKu
         9cjzfWE58QLsF7kkGchP+8euOpyZQoiVUXjyQqAa4WeZ2mrhGaFutbkOxf5QdVc2PFUq
         kkaafPShNhNCrF2HTnKAJt9OTDkg3vrPG8Hqz9jatoU/2OLaHrd4kBjtGxy97bEV8Hlv
         A8u4zR9MTcup0F1OI2EyMAiYVaf49st+yV2LX02OM8XnoXlezp6qe3+Oehsxmqbj+5uo
         ETL4EFoskdfU2foBNFjy+2H+RaqTwydSw+CJxQp+IS96aixbRxes91PIfQ1vAn0uZvF8
         oRGw==
X-Gm-Message-State: AJcUukc7c7O+QZch7LeWvDE++f8J4xE3esXE83OxjyGFNt1wswrucNTF
        yfrWYw/VQ4hSSdDvMymiGufccqWcsQrSwF1so3s=
X-Google-Smtp-Source: ALg8bN4MHIpOwtix2a/9wSEs3En9UrRmeCKYXHdJzIxZZCLyKqC9gqX6rkyLnf9nTjE5CgELUF2MJJxfv35dxC2atSk=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7088485qtm.96.1547651485740;
 Wed, 16 Jan 2019 07:11:25 -0800 (PST)
MIME-Version: 1.0
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com> <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
 <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
In-Reply-To: <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 16:11:08 +0100
Message-ID: <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 3:10 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 1/16/19 1:14 PM, Arnd Bergmann wrote:
> > (sorry for the late reply, I just realized that I had never sent out the
> > mail after Lee asked me for a review last year and I had drafted
> > my reply).
>
> Hi Arnd,
>
> Many thanks for reviewing, no worries :-)
>
> >
> > On Wed, Dec 12, 2018 at 9:48 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>
> >> Some system control registers need to be clocked, so the registers can
> >> be accessed. Add an optional clock and attach it to regmap.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >
> > This looks ok to me in principle, but I have one question: When we
> > do a clk_get() and clk_prepare() as part of regmap_mmio_attach_clk(),
> > does that change the behavior of syscon nodes that are otherwise
> > unused?
>
> I'm not sure I correctly understand this question. I don't think it will
> change the behavior for "unused" nodes. These should remain unused with
> this patch.

What I mean is that nodes that listed as 'compatible="syscon"' get
probed by the syscon driver even when no other driver references
them, and that in turn would acquire the clock, right?

> > I think we have a bunch of devices that started out as a syscon but
> > then we added a proper driver for them, which would handle the
> > clocks explicitly. Is it guaranteed that this will keep working (including
> > shutting down the clocks when they are unused) if we have two drivers
> > that call clk_get() on the same device node?
>
> I'd expect nothing wrong happens when two drivers call clk_get() for the
> same clock.
> Are there some case where two drivers are bind (e.g. syscon driver +
> another driver) for the same piece of hardware ?

You won't actually have two drivers binding to the same device, but you
could have a driver and a syscon user that does relies on the
syscon_regmap_lookup_by_*() functions.

I think we've had a couple of cases where we started out representing
a device as syscon, and then later decided that a high-level abstraction
would be needed because syscon didn't quite support all the needed
features.

Since each syscon node should also have a more specific
compatible value, you can then have another driver that binds
to that compatible string.

      Arnd
