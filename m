Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D27C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83C52077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UWsHU2/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83C52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIEM0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:26:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36648 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeIEM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:26:53 -0400
Received: by mail-it0-f65.google.com with SMTP id u13-v6so8351807iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v11/Z7Ne63G0BjDigZ5+ybxykhE2gXlU/DhHQEscZgo=;
        b=UWsHU2/Aq9syyqXHpD4uQVI3kFWO48RmgCw3zoXdGu8H8KSqnmP6bzpl2tAr4LvF+N
         qypT7/B4cx/c70NLD76wd69HL/6Y9C+QUZqxok0S7GfRRpqCJEaTzHOR6XYyb4QVu1mh
         WLDjyXg+zPEWRoU9UoxyURIGIPRm53HAidaKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v11/Z7Ne63G0BjDigZ5+ybxykhE2gXlU/DhHQEscZgo=;
        b=UVECOJsEHky+w0mTs4fQPt6XZ2lYMB1sCCXhhiOqnrH/dFWOJGHqX7kD1CHGzBINgF
         wBazKpCv5r9Kb42JVc7xvI7nF3XQk8iLiv8QEIDU1MGJ+V34vglYXaNZdvuOKupKB3QQ
         ZB3KB9wr3qs3h9Vh5fwJ7CoPqi33UoDHQ+xbZeX6tdA8OzpLa8GoWta/PfJ7Q5uEvZ2J
         ofc9rAPxbd8Xjl2Yr1yUMAgtSSohY4YewL7T5LThpvjrazWTfZmtv/4sBvzBUjy5iT1N
         tSd2S2MSCImIocMG5zUKufsc1Md6hNuRS97iYpBubSwhBq217MLrFMHiOuuvEG7pma99
         eKlQ==
X-Gm-Message-State: APzg51B5+AThm2m1HStWuCnUgtvffTaumzR4tqkUPJfQMIv5Kmzgd7LX
        XU3/bXSNvNhpaU12X/o3fbFzg/ODnbCOptSts+5+QQ==
X-Google-Smtp-Source: ANB0VdaUv3aotp4z9n83mZqFSQRoUokHMW7vevWJAmEpBGRk4X3w35KEr5xG3S4BN0n1SUATxHkpWcvxyh8R+KE1dvo=
X-Received: by 2002:a24:21d6:: with SMTP id e205-v6mr3313521ita.52.1536134274651;
 Wed, 05 Sep 2018 00:57:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 00:57:54 -0700 (PDT)
In-Reply-To: <20180905075136.chumwosx76o2n66l@flea>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180904044053.15425-12-icenowy@aosc.io>
 <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com> <20180905075136.chumwosx76o2n66l@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Sep 2018 13:27:54 +0530
Message-ID: <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64: Enable
 HDMI output on A64 boards w/ HDMI
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 1:21 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Wed, Sep 05, 2018 at 12:56:03PM +0530, Jagan Teki wrote:
>> On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> > From: Jagan Teki <jagan@amarulasolutions.com>
>> >
>> > Enable all necessary device tree nodes and add connector node to device
>> > trees for all supported A64 boards with HDMI.
>> >
>> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> > [Icenowy: squash all board patches altogether and change supply name]
>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > ---
>> > Changes in v4:
>> > - Rebase some device trees.
>> > Changes in v3,1:
>> > - Squash all enablement patches altogether.
>> > - Change supply name to match DT binding & driver change.
>> > Changes for v3:
>> > - Enable all pipeline components
>> > Changes for v2:
>> > - none
>> >
>> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
>> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
>> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
>> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
>> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
>> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
>> >  6 files changed, 204 insertions(+)
>>
>> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
>> A64-Olinuxino, NPI-A64
>>
>> Pine64 boards look unable by saying
>> [drm] Cannot find any crtc or sizes
>>
>> May be someone can confirm, it.
>
> Then we should drop the pine64 additions until someone figures it out,
> as it has been already discussed.

That is fine, but If anyone have pine64 can confirm this.
