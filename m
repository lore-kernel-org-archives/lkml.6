Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002B120861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtUVyeTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002B120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIFD0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:26:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34482 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeIFD0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:26:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so16985927ois.1;
        Wed, 05 Sep 2018 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=70QrxoRLGvGZLz/wz5dR2kuRzdJP5UKKTrRYM5MaT68=;
        b=QtUVyeTgCoI/xgahIZ4SEkKOYV5a9QgIucWZFNZ42O0oHS0h0wx/tXLnS1ZO+nhBIL
         eUxhjETLAdEk7A2bHl+eHHTWipbjiTNm3jDJFQ+Z0z4Q/KEFAgW/jJXyoC9qB2sH+PYK
         EVTsNGc0BA7/SRO5KgJlQl0lA9Gw8bbzpno/q5Y0pPU7I2m2wiNC/BwIJ+XCNQ9p4fmg
         aIOQxjSM1TWGz2iG6ra/SIYiZpHB8D56jr+Htt3I38YX+7tTYVqEDEPkH8P+WuPnwNl8
         8j/zk5XOYg2FH3kT0Em1/M6AIQXyxoPZFT1riex+r4f1a2PyJAaAzVtP2wWN7TFGMFiX
         ykKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=70QrxoRLGvGZLz/wz5dR2kuRzdJP5UKKTrRYM5MaT68=;
        b=bjyhLdQJbxniS0kpEY74013qhl3emfw2aLzYeECLQ7QDXkwMvlTPShDBRUgIynvDK1
         QGOr34rt5FJQDu0z939Xm3W4k/z7i1dmmPhzJKS82usvFdPnV6XC+LT69I/qM6igJwQP
         FdkKLRhsgC9Jjt/V2bMm4sAmprT1O2VGLwK34mf9/FXWUoj7tfvm3rm55EQRbM6A+y/K
         lpc+DuFfmLgLbRskbztzesX5xnmGbEwNitNHLoA3JjZt/PGED5aHHIdXPM1RBX0zQOFb
         jvx7NBCpSrZ2PTt5cYZK7xodVbUer5Yz6MJMUBELziknl5dmOdb4JDYPmxd8ugE024Ok
         OcMw==
X-Gm-Message-State: APzg51DSQd96CzJkERfvXL1W+UKxmYT3My5VYuelxjbtfar2rt70JZq2
        VmPsIxEKynGywGLkW6eNOcxHg81iYwwKIYsgSls=
X-Google-Smtp-Source: ANB0Vdba5wdMaf4DnbVIBhYnUroLjlDqftS8Us6rcv22OxWxg8M9216+A8fnHKQekbHyvMmpmDU543ertp8/m0qS7+s=
X-Received: by 2002:aca:4ec6:: with SMTP id c189-v6mr34130778oib.186.1536188023923;
 Wed, 05 Sep 2018 15:53:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2e30:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 15:53:23 -0700 (PDT)
In-Reply-To: <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180904044053.15425-12-icenowy@aosc.io>
 <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com>
 <20180905075136.chumwosx76o2n66l@flea> <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 5 Sep 2018 15:53:23 -0700
Message-ID: <CA+E=qVdWXWztLj3989X+U+=4P5FpM4hs+6ByVmq8bf7mPeiWsA@mail.gmail.com>
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

I can test it tonight.

On Wed, Sep 5, 2018 at 12:57 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> On Wed, Sep 5, 2018 at 1:21 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>> On Wed, Sep 05, 2018 at 12:56:03PM +0530, Jagan Teki wrote:
>>> On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>> > From: Jagan Teki <jagan@amarulasolutions.com>
>>> >
>>> > Enable all necessary device tree nodes and add connector node to device
>>> > trees for all supported A64 boards with HDMI.
>>> >
>>> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> > [Icenowy: squash all board patches altogether and change supply name]
>>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> > ---
>>> > Changes in v4:
>>> > - Rebase some device trees.
>>> > Changes in v3,1:
>>> > - Squash all enablement patches altogether.
>>> > - Change supply name to match DT binding & driver change.
>>> > Changes for v3:
>>> > - Enable all pipeline components
>>> > Changes for v2:
>>> > - none
>>> >
>>> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
>>> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
>>> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
>>> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
>>> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
>>> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
>>> >  6 files changed, 204 insertions(+)
>>>
>>> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
>>> A64-Olinuxino, NPI-A64
>>>
>>> Pine64 boards look unable by saying
>>> [drm] Cannot find any crtc or sizes
>>>
>>> May be someone can confirm, it.
>>
>> Then we should drop the pine64 additions until someone figures it out,
>> as it has been already discussed.
>
> That is fine, but If anyone have pine64 can confirm this.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
