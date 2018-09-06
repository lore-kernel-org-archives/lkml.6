Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BBCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C132075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfumzHnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C132075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeIFIqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:46:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44284 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeIFIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:46:49 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so17963161oih.11;
        Wed, 05 Sep 2018 21:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w9EMJ5hlB0tQE4aTxBuQ7ct0sXdpup49OSdil/i1Dpw=;
        b=gfumzHnnqMYWCGCvcHTBlWOOCjWXMUTXN9SbA6Ndwmvk7z4SZrT0bkacrHgm8SB/QZ
         94aCsdr1AbmYrhzAx1oZhOQLKDOsZhFPWlor+troEFXBo7limkg5s76+wLvkkoWksHKt
         5+gMdk0wd+oCktya4FGYMm82c7U1fxDqMpFHOEhqnZPLj9tqa0Fu5hJZttLVK0FrRoXc
         w9WYsVXNMrBykBP2aBDJL+S/we3F8PvWrqWrw/oEy+kvkIzrt9uzKy68XlktneFPeKb2
         XdYMIbmEe6kuCZhDqeDqx7w6LL8mw43Yk4oLXg2UJRFF/c3Tz8zzP2o9aVOm7VdiorFK
         SPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w9EMJ5hlB0tQE4aTxBuQ7ct0sXdpup49OSdil/i1Dpw=;
        b=n/UgO3BMzKhpjlDJM40S8k/bIcck7xbIEPF3nV1B4tNgU6YHr6Kift98Ww1fQwoRaE
         J0eLDO+JU2WWEy5h0JwWxKw4raVx9H8Ya3bmWt06pnSBbR3kpTai/GyzdracXm48MWCI
         mc+rES6hbpKPi1IplCUJXAnB4DB7UozF70pLQ0iJXkFx9c4y+d4UjyDJCc0diSURIXQs
         4UlvQ3/cD9GNBz++9LAlSq3qYFOjC0jXhvlnBXAYicfPre/TdHnhjUXaIQP53vP4jZr2
         E27L2Ru45tLCv+bQXQrtbp4HJ/jhJXDcc2AoRSpfZ0A2+CI08bHEojdObYDg4f8Mr34G
         RQYg==
X-Gm-Message-State: APzg51DgHGISOp5zg0T5Mqj9V9NIcaLT0KGQj4kEZLn5f8dLdbilpoTT
        JvA1dwJ+q6CdRGZObFl+02sgSyPhdTDd0KFF5SA=
X-Google-Smtp-Source: ANB0VdaZUJgq3YwTGx/xbTLwkOSxG6xMbqj6iCkMT0cFZlm2SknezD8bPhvJUy7kGh/gSIl/C0KTEY/L2C845ZxTJCw=
X-Received: by 2002:aca:494b:: with SMTP id w72-v6mr933162oia.293.1536207201750;
 Wed, 05 Sep 2018 21:13:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2e30:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 21:12:51 -0700 (PDT)
In-Reply-To: <CA+E=qVdWXWztLj3989X+U+=4P5FpM4hs+6ByVmq8bf7mPeiWsA@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180904044053.15425-12-icenowy@aosc.io>
 <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com>
 <20180905075136.chumwosx76o2n66l@flea> <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
 <CA+E=qVdWXWztLj3989X+U+=4P5FpM4hs+6ByVmq8bf7mPeiWsA@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 5 Sep 2018 21:12:51 -0700
Message-ID: <CA+E=qVd4siJReWxbEeQ1DjFrTnewSGW=UJitduLT=52YfB-rag@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64: Enable
 HDMI output on A64 boards w/ HDMI
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 3:53 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> I can test it tonight.

It works fine for me on pine64-lts with HDMI monitor:

[    1.969772] sun4i-drm display-engine: bound 1100000.mixer (ops
sun8i_mixer_ops)
[    1.979302] sun4i-drm display-engine: bound 1200000.mixer (ops
sun8i_mixer_ops)
[    1.979738] sun4i-drm display-engine: No panel or bridge found...
RGB output disabled
[    1.979755] sun4i-drm display-engine: bound 1c0c000.lcd-controller
(ops sun4i_tcon_ops)
[    1.979935] sun4i-drm display-engine: bound 1c0d000.lcd-controller
(ops sun4i_tcon_ops)
[    1.980017] sun4i-drm display-engine: failed to bind 1ee0000.hdmi
(ops sun8i_dw_hdmi_ops): -517
[    1.980306] sun4i-drm display-engine: Couldn't bind all pipelines components
[    1.980446] sun4i-drm display-engine: master bind failed: -517
[    4.230997] sun4i-drm display-engine: bound 1100000.mixer (ops
sun8i_mixer_ops)
[    4.247886] sun4i-drm display-engine: bound 1200000.mixer (ops
sun8i_mixer_ops)
[    4.255639] sun4i-drm display-engine: No panel or bridge found...
RGB output disabled
[    4.263482] sun4i-drm display-engine: bound 1c0c000.lcd-controller
(ops sun4i_tcon_ops)
[    4.283255] sun4i-drm display-engine: bound 1c0d000.lcd-controller
(ops sun4i_tcon_ops)
[    4.322055] sun4i-drm display-engine: bound 1ee0000.hdmi (ops
sun8i_dw_hdmi_ops)
[    4.342115] fb: switching to sun4i-drm-fb from simple
[    5.001434] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
[    5.008933] [drm] Initialized sun4i-drm 1.0.0 20150629 for
display-engine on minor 0

I tested non-applied patches from this series on top of
git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
sunxi/for-next

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

>
> On Wed, Sep 5, 2018 at 12:57 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>> On Wed, Sep 5, 2018 at 1:21 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>> On Wed, Sep 05, 2018 at 12:56:03PM +0530, Jagan Teki wrote:
>>>> On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>>> > From: Jagan Teki <jagan@amarulasolutions.com>
>>>> >
>>>> > Enable all necessary device tree nodes and add connector node to device
>>>> > trees for all supported A64 boards with HDMI.
>>>> >
>>>> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> > [Icenowy: squash all board patches altogether and change supply name]
>>>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> > ---
>>>> > Changes in v4:
>>>> > - Rebase some device trees.
>>>> > Changes in v3,1:
>>>> > - Squash all enablement patches altogether.
>>>> > - Change supply name to match DT binding & driver change.
>>>> > Changes for v3:
>>>> > - Enable all pipeline components
>>>> > Changes for v2:
>>>> > - none
>>>> >
>>>> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
>>>> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
>>>> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
>>>> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
>>>> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
>>>> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
>>>> >  6 files changed, 204 insertions(+)
>>>>
>>>> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
>>>> A64-Olinuxino, NPI-A64
>>>>
>>>> Pine64 boards look unable by saying
>>>> [drm] Cannot find any crtc or sizes
>>>>
>>>> May be someone can confirm, it.
>>>
>>> Then we should drop the pine64 additions until someone figures it out,
>>> as it has been already discussed.
>>
>> That is fine, but If anyone have pine64 can confirm this.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
